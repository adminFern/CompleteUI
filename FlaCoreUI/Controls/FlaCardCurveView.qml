import QtQuick
import Qt5Compat.GraphicalEffects
import FlaCoreUI

Item {
    id: control

    enum LayoutType {
        Horizontal = 0,
        Vertical = 1
    }

    // 公开属性：继承 FlaCard 功能
    property Objects items
    property int layout: FlaCardCurveView.LayoutType.Horizontal
    property int spacing: 18
    property real curveAmplitude: 30       // 波浪线振幅
    property real curveFrequency: 0.8      // 波浪线频率系数
    property real curveOverlap: 70         // 波浪模式下最大重叠量(px)
    property int curveDuration: 600        // 波浪↔排列切换动画时长(ms)
    property int restoreDelay: 3000        // 鼠标离开后恢复波浪延迟(ms)

    // 边框属性
    property color borderColor: Theme.FillBorderColor
    property real borderWidth: 1
    property bool borderVisible: true

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

        // 重叠因子：首尾小，中间大，形成首尾可见、中间深重叠
        function overlapFactor(i, total) {
            if (total <= 2) return 0.4
            return 0.12 + 0.88 * Math.sin(Math.PI * i / (total - 2))
        }

        // 计算卡片在排列方向上的位置（x 水平 / y 垂直）
        function cardPosition(idx) {
            var itemList = handleItems()
            var pos = 0
            for (var i = 0; i < idx; i++) {
                var cardSize = control.layout === FlaCardCurveView.LayoutType.Horizontal
                               ? itemList[i].cardWidth : itemList[i].cardHeight
                if (d.isExpanded) {
                    pos += cardSize + control.spacing
                } else {
                    pos += cardSize - control.curveOverlap * overlapFactor(i, itemList.length)
                }
            }
            return pos
        }

        // 计算布局总尺寸
        function totalLayoutSize() {
            var itemList = handleItems()
            var n = itemList.length
            if (n === 0) return 0
            var lastIdx = n - 1
            var pos = cardPosition(lastIdx)
            var lastSize = control.layout === FlaCardCurveView.LayoutType.Horizontal
                           ? itemList[lastIdx].cardWidth : itemList[lastIdx].cardHeight
            return pos + lastSize
        }

        // 容器偏移：波浪模式居中，展开模式靠左/上留 padding
        function containerOffset() {
            if (d.isExpanded) return flickable._glowPadding
            var size = totalLayoutSize()
            if (control.layout === FlaCardCurveView.LayoutType.Horizontal) {
                return Math.max(flickable._glowPadding, (flickable.width - size) / 2)
            } else {
                return Math.max(flickable._glowPadding, (flickable.height - size) / 2)
            }
        }
    }

    // 外框容器
    Rectangle {
        id: outerFrame
        anchors.fill: parent
        radius: 12
        color: "transparent"
        border.color: borderVisible ? borderColor : "transparent"
        border.width: borderVisible ? borderWidth : 0

        Flickable {
            id: flickable
            anchors.fill: parent
            anchors.margins: 2
            clip: true

            property real _glowPadding: 24
            contentWidth: control.layout === FlaCardCurveView.LayoutType.Horizontal
                           ? Math.max(flickable.width, d.containerOffset() + d.totalLayoutSize() + _glowPadding)
                           : flickable.width
            contentHeight: control.layout === FlaCardCurveView.LayoutType.Vertical
                            ? Math.max(flickable.height, d.containerOffset() + d.totalLayoutSize() + _glowPadding)
                            : flickable.height

            flickableDirection: control.layout === FlaCardCurveView.LayoutType.Horizontal
                                ? Flickable.HorizontalFlick : Flickable.VerticalFlick

            // 卡片容器
            Item {
                id: cardsContainer
                // 尺寸
                width: control.layout === FlaCardCurveView.LayoutType.Horizontal
                       ? d.totalLayoutSize() : flickable.width
                height: control.layout === FlaCardCurveView.LayoutType.Vertical
                        ? d.totalLayoutSize() : flickable.height

                // 定位：水平模式控制 x，垂直模式控制 y
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
    }

    // 恢复波浪线的定时器
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

            // 排列方向位置（x 水平 / y 垂直）
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

            // 波浪偏移量：展开时为 0，波浪时按正弦偏移
            property real curveOffset: d.isExpanded ? 0 :
                control.curveAmplitude * Math.sin(index * control.curveFrequency)

            // 堆叠旋转：波浪模式下轻微旋转制造堆叠感
            property real stackRotation: d.isExpanded ? 0 : (index % 2 === 0 ? 2.5 : -2.5)

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

                // 堆叠旋转动画
                rotation: cardRect.stackRotation
                Behavior on rotation {
                    NumberAnimation { duration: control.curveDuration; easing.type: Easing.OutCubic }
                }

                // z-order：悬停卡片提升到最前
                z: cardRect.isHovered ? 100 : index

                Rectangle {
                    id: cardBackground
                    anchors.rightMargin: 8
                    z: 3
                    width: modelData.cardWidth
                    height: modelData.cardHeight
                    color: modelData.cardColor
                    radius: modelData.radius
                    border.color: borderVisible ? borderColor : "transparent"
                    border.width: borderVisible ? borderWidth : 0

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
