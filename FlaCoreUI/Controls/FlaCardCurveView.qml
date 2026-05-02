import QtQuick
import Qt5Compat.GraphicalEffects
import FlaCoreUI

Item {
    id: control

    enum LayoutType {
        Horizontal = 0,
        Vertical = 1
    }

    property Objects items
    property int layout: FlaCardCurveView.LayoutType.Horizontal
    property int spacing: 18
    property real curveAmplitude: 30
    property real curveFrequency: 0
    property real curveDensity: 0.85 // 波浪密集度 0.0~1.0，越大越密集重叠
     property real cardDensity: 0.35
    property int curveDuration: 600
    property int restoreDelay: 3000


    signal clicked(int index, var item)

    QtObject {
        id: d
        property int hoveredIndex: -1
        property var pressedItem: null
        property bool isExpanded: false

        function handleItems() {
            var data = []
            if (items) {
                for (var i = 0; i < items.children.length; i++) {
                    var item = items.children[i]
                    item._idx = i
                    data.push(item)
                }
            }
            return data
        }

        // 获取卡片在排列方向的尺寸
        function cardAxisSize(item) {
            return control.layout === FlaCardCurveView.LayoutType.Horizontal
                   ? item.cardWidth : item.cardHeight
        }

        // 组件可用宽度（排列方向）
        function availableSize() {
            return control.layout === FlaCardCurveView.LayoutType.Horizontal
                   ? control.width - 4
                   : control.height - 4
        }

        // 波浪模式步长：根据组件宽度和密集度自动计算
        // curveDensity: 0.0=最稀疏(无重叠), 1.0=最密集(深度重叠)
        function waveStep() {
            var itemList = handleItems()
            var n = itemList.length
            if (n <= 1) return 0
            var cardSize = cardAxisSize(itemList[0])
            // 稀疏步长：卡片之间无重叠
            var sparseStep = cardSize + control.spacing
            // 密集步长：卡片高度重叠，步长仅为卡片宽度
            var denseStep = cardSize * control.cardDensity
            // 按 curveDensity 在两个极端之间插值
            var density = Math.max(0.0, Math.min(1.0, control.curveDensity))
            return sparseStep + (denseStep - sparseStep) * density
        }

        // 计算卡片在排列方向的位置
        function cardPosition(idx) {
            var itemList = handleItems()
            if (idx < 0 || idx >= itemList.length) return 0
            if (d.isExpanded) {
                var pos = 0
                for (var i = 0; i < idx; i++) {
                    pos += cardAxisSize(itemList[i]) + control.spacing
                }
                return pos
            } else {
                return idx * waveStep()
            }
        }

        // 波浪模式总布局尺寸
        function waveTotalSize() {
            var itemList = handleItems()
            var n = itemList.length
            if (n === 0) return 0
            if (n === 1) return cardAxisSize(itemList[0])
            var step = waveStep()
            return (n - 1) * step + cardAxisSize(itemList[n - 1])
        }

        // 展开模式总布局尺寸
        function expandedTotalSize() {
            var itemList = handleItems()
            var n = itemList.length
            if (n === 0) return 0
            var total = 0
            for (var i = 0; i < n; i++) {
                total += cardAxisSize(itemList[i])
                if (i < n - 1) total += control.spacing
            }
            return total
        }

        // 当前总布局尺寸
        function totalLayoutSize() {
            return d.isExpanded ? expandedTotalSize() : waveTotalSize()
        }

        // 容器偏移：居中显示
        function containerOffset() {
            var size = totalLayoutSize()
            var avail = availableSize()
            if (size >= avail) return 2
            return (avail - size) / 2
        }
    }

    Flickable {
        id: flickable
        anchors.fill: parent
        clip: true

        property real _glowPadding: 24
        contentWidth: control.layout === FlaCardCurveView.LayoutType.Horizontal
                       ? Math.max(flickable.width, d.totalLayoutSize() + _glowPadding * 2)
                       : flickable.width
        contentHeight: control.layout === FlaCardCurveView.LayoutType.Vertical
                        ? Math.max(flickable.height, d.totalLayoutSize() + _glowPadding * 2)
                        : flickable.height

        flickableDirection: control.layout === FlaCardCurveView.LayoutType.Horizontal
                            ? Flickable.HorizontalFlick : Flickable.VerticalFlick

        Item {
            id: cardsContainer
            width: control.layout === FlaCardCurveView.LayoutType.Horizontal
                   ? d.totalLayoutSize() : flickable.width
            height: control.layout === FlaCardCurveView.LayoutType.Vertical
                    ? d.totalLayoutSize() : flickable.height

            x: control.layout === FlaCardCurveView.LayoutType.Horizontal
               ? d.containerOffset() : 0
            y: control.layout === FlaCardCurveView.LayoutType.Vertical
               ? d.containerOffset() : 0
            Behavior on x {
                NumberAnimation { duration: control.curveDuration; easing.type: Easing.OutCubic }
            }
            Behavior on y {
                NumberAnimation { duration: control.curveDuration; easing.type: Easing.OutCubic }
            }

            Repeater {
                model: d.handleItems()
                delegate: cardDelegate
            }
        }
    }

    Timer {
        id: restoreTimer
        interval: control.restoreDelay
        repeat: false
        onTriggered: d.isExpanded = false
    }

    Component {
        id: cardDelegate
        Item {
            id: cardRect
            width: modelData.cardWidth
            height: modelData.cardHeight
            property bool isHovered: false
            property bool isPressed: false

            property int totalCards: d.handleItems().length

            // 排列方向位置
            x: control.layout === FlaCardCurveView.LayoutType.Horizontal
               ? d.cardPosition(index) : (cardsContainer.width - width) / 2
            y: control.layout === FlaCardCurveView.LayoutType.Vertical
               ? d.cardPosition(index) : (cardsContainer.height - height) / 2
            Behavior on x {
                NumberAnimation { duration: control.curveDuration; easing.type: Easing.OutCubic }
            }
            Behavior on y {
                NumberAnimation { duration: control.curveDuration; easing.type: Easing.OutCubic }
            }

            // 波浪偏移
            property real curveOffset: d.isExpanded ? 0 :
                control.curveAmplitude * Math.sin(index * control.curveFrequency)

            // 堆叠旋转
            property real stackRotation: d.isExpanded ? 0 : (index % 2 === 0 ? 2.5 : -2.5)

            // z-order：波浪模式首尾在最顶层，中间递减；悬停卡片始终最前
            property int baseZ: {
                if (d.isExpanded) return index
                if (totalCards <= 2) return index
                // 首尾卡片 z 最高，中间最低
                var edgeDist = Math.min(index, totalCards - 1 - index)
                return totalCards - edgeDist
            }

            Item {
                id: cardContainer
                anchors.fill: parent
                anchors.leftMargin: 8
                transform: [
                    Scale {
                        id: cardScale
                        origin.x: cardRect.width / 2
                        origin.y: cardRect.height / 2
                        xScale: cardRect.isPressed ? 0.95 : (cardRect.isHovered ? 1.05 : 1.0)
                        yScale: cardRect.isPressed ? 0.95 : (cardRect.isHovered ? 1.05 : 1.0)
                        Behavior on xScale {
                            NumberAnimation { duration: control.curveDuration / 3; easing.type: Easing.OutCubic }
                        }
                        Behavior on yScale {
                            NumberAnimation { duration: control.curveDuration / 3; easing.type: Easing.OutCubic }
                        }
                    },
                    Translate {
                        id: curveTranslate
                        y: control.layout === FlaCardCurveView.LayoutType.Horizontal ? cardRect.curveOffset : 0
                        x: control.layout === FlaCardCurveView.LayoutType.Vertical ? cardRect.curveOffset : 0
                        Behavior on y {
                            NumberAnimation { duration: control.curveDuration; easing.type: Easing.OutCubic }
                        }
                        Behavior on x {
                            NumberAnimation { duration: control.curveDuration; easing.type: Easing.OutCubic }
                        }
                    }
                ]

                rotation: cardRect.stackRotation
                Behavior on rotation {
                    NumberAnimation { duration: control.curveDuration; easing.type: Easing.OutCubic }
                }

                z: cardRect.isHovered ? 200 : cardRect.baseZ

                Rectangle {
                    id: cardBackground
                    anchors.rightMargin: 8
                    z: 3
                    width: modelData.cardWidth
                    height: modelData.cardHeight
                    color: modelData.cardColor
                    radius: modelData.radius
                    border.color: modelData.borderVisible ? modelData.borderColor: "transparent"
                    border.width:  modelData.borderVisible ? 1 : 0

                    Loader {
                        z: 4
                        anchors.fill: parent
                        sourceComponent: modelData.delegate
                    }

                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor
                        onEntered: {
                            cardRect.isHovered = true
                            d.hoveredIndex = index
                            d.isExpanded = true
                            restoreTimer.stop()
                        }
                        onExited: {
                            cardRect.isHovered = false
                            cardRect.isPressed = false
                            d.hoveredIndex = -1
                            restoreTimer.restart()
                        }
                        onPressed: cardRect.isPressed = true
                        onReleased: cardRect.isPressed = false
                        onClicked: control.clicked(index, modelData)
                    }
                }

                RectangularGlow {
                    id: glow
                    z: 0
                    anchors.fill: cardBackground
                    glowRadius: 7
                    spread: 0.3
                    color: modelData.shadowColor
                    cornerRadius: cardBackground.radius
                    opacity: (cardRect.isHovered || cardRect.isPressed) ? 1 : 0.6
                    Behavior on opacity {
                        NumberAnimation { duration: 200; easing.type: Easing.OutCubic }
                    }
                }
            }
        }
    }
}
