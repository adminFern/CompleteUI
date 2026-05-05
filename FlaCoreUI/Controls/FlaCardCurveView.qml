import QtQuick
import Qt5Compat.GraphicalEffects
import FlaCoreUI

Item {
    id: control

    // 布局模式：Row=普通水平、Column=普通垂直、WaveHorizontal=波浪水平、WaveVertical=波浪垂直
    enum LayoutType {
        Row = 0,
        Column = 1,
        WaveHorizontal = 2,
        WaveVertical = 3
    }
    property Objects items                         // 卡片数据源
    property int layout: FlaCardCurveView.LayoutType.Row       // 布局模式
    property int spacing: 1                                   // 卡片间距（像素）
    property real curveAmplitude: 0.8       // 波浪弯曲幅度 0.0~1.0，越大波浪越明显
    property real cardDensity: 0.8         // 卡片密集度 0.0~1.0，越大卡片重叠越深
    property int curveDuration: 600                              // 波浪动画时长（毫秒）
    property int restoreDelay: 3000                              // 自动恢复折叠延迟（毫秒）
    signal clicked(int index, var item)
    QtObject {
        id: d
        property int hoveredIndex: -1          // 当前悬停卡片索引
        property var pressedItem: null         // 当前按下的卡片数据
        property bool isExpanded: false        // 波浪模式是否展开

        // 将 items.children 转为可遍历数组，为每项附加 _idx 索引
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
            return control.layout === FlaCardCurveView.LayoutType.WaveHorizontal
                   ? item.cardWidth : item.cardHeight
        }

        // 组件可用宽度（排列方向）
        function availableSize() {
            return control.layout === FlaCardCurveView.LayoutType.WaveHorizontal
                   ? control.width - 4
                   : control.height - 4
        }

        // 波浪模式步长：根据密集度自动计算
        // cardDensity: 0.0=最稀疏(无重叠), 1.0=最密集(深度重叠)
        function waveStep() {
            var itemList = handleItems()
            var n = itemList.length
            if (n <= 1) return 0
            var cardSize = cardAxisSize(itemList[0])
            var density = Math.max(0.0, Math.min(1.0, control.cardDensity))
            var overlap = density * 0.9
            return cardSize * (1.0 - overlap) + control.spacing
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

        // 发光 + hover 放大溢出余量（两侧各一份）
        property real _glowPadding: 24
        // 内容尺寸：按 5 种布局模式分别计算横向/纵向可滚动范围
        contentWidth: control.layout === FlaCardCurveView.LayoutType.WaveHorizontal
                       ? Math.max(flickable.width, d.totalLayoutSize() + _glowPadding * 2)  // 波浪水平：总布局尺寸 + 发光余量
                       : control.layout === FlaCardCurveView.LayoutType.Row
                         ? _glowPadding + rowLayout.implicitWidth + _glowPadding               // 普通水平：行隐式宽度 + 发光余量
                         : flickable.width                                                      // 其他：填满视口
        contentHeight: control.layout === FlaCardCurveView.LayoutType.WaveVertical
                        ? Math.max(flickable.height, d.totalLayoutSize() + _glowPadding * 2)  // 波浪垂直：总布局尺寸 + 发光余量
                        : control.layout === FlaCardCurveView.LayoutType.Column
                          ? _glowPadding + columnLayout.implicitHeight + _glowPadding           // 普通垂直：列隐式高度 + 发光余量
                           : flickable.height

        // 滚动方向：Row/WaveHorizontal 水平滚动，其余垂直滚动
        flickableDirection: control.layout === FlaCardCurveView.LayoutType.Row
                            || control.layout === FlaCardCurveView.LayoutType.WaveHorizontal
                            ? Flickable.HorizontalFlick
                            : Flickable.VerticalFlick

        // 波浪模式容器
        Item {
            id: cardsContainer
            visible: control.layout === FlaCardCurveView.LayoutType.WaveHorizontal
                     || control.layout === FlaCardCurveView.LayoutType.WaveVertical
            width: control.layout === FlaCardCurveView.LayoutType.WaveHorizontal
                   ? d.totalLayoutSize() : flickable.width
            height: control.layout === FlaCardCurveView.LayoutType.WaveVertical
                    ? d.totalLayoutSize() : flickable.height

            x: control.layout === FlaCardCurveView.LayoutType.WaveHorizontal
               ? d.containerOffset() : 0
            y: control.layout === FlaCardCurveView.LayoutType.WaveVertical
               ? d.containerOffset() : 0
            Behavior on x {
                NumberAnimation { duration: control.curveDuration; easing.type: Easing.OutCubic }
            }
            Behavior on y {
                NumberAnimation { duration: control.curveDuration; easing.type: Easing.OutCubic }
            }

            Repeater {
                model: d.handleItems()
                delegate: waveCardDelegate
            }
        }

        // 普通水平布局
        Row {
            id: rowLayout
            anchors.verticalCenter: parent.verticalCenter
            x: flickable._glowPadding
            spacing: control.spacing
            visible: control.layout === FlaCardCurveView.LayoutType.Row
            Repeater {
                model: d.handleItems()
                delegate: plainCardDelegate
            }
        }
        // 普通垂直布局
        Column {
            id: columnLayout
            y: flickable._glowPadding
            spacing: control.spacing
            visible: control.layout === FlaCardCurveView.LayoutType.Column
            Repeater {
                model: d.handleItems()
                delegate: plainCardDelegate
            }
        }
    }
    // 自动恢复折叠定时器：悬停离开后延迟恢复波浪折叠
    Timer {
        id: restoreTimer
        interval: control.restoreDelay
        repeat: false
        onTriggered: d.isExpanded = false
    }
    Component {
        id: cardVisualComponent
        Item {
            property var visualData: ({})
            property bool showGlow: true
            property bool isHovered: false
            property bool isPressed: false
            anchors.fill: parent
            Rectangle {
                id: cardBackground
                anchors.fill: parent
                color: visualData.cardColor
                radius: visualData.radius
                border.color: visualData.borderVisible ? visualData.borderColor : "transparent"
                border.width: visualData.borderVisible ? 1 : 0
            }
            Loader {
                anchors.fill: parent
                z: 4
                sourceComponent: visualData.delegate
            }
            RectangularGlow {
                id: glow
                anchors.fill: cardBackground
                glowRadius: 7
                spread: 0.3
                color: visualData.shadowColor
                cornerRadius: cardBackground.radius
                visible: showGlow
                opacity: (isHovered || isPressed) ? 1 : 0.6
                Behavior on opacity {
                    NumberAnimation { duration: 200; easing.type: Easing.OutCubic }
                }
            }
        }
    }
    Component {
        id: waveCardDelegate
        Item {
            id: cardRect
            width: modelData.cardWidth
            height: modelData.cardHeight
            property bool isHovered: false
            property bool isPressed: false

            property int totalCards: d.handleItems().length

            x: control.layout === FlaCardCurveView.LayoutType.WaveHorizontal
               ? d.cardPosition(index) : (cardsContainer.width - width) / 2
            y: control.layout === FlaCardCurveView.LayoutType.WaveVertical
               ? d.cardPosition(index) : (cardsContainer.height - height) / 2
            Behavior on x {
                NumberAnimation { duration: control.curveDuration; easing.type: Easing.OutCubic }
            }
            Behavior on y {
                NumberAnimation { duration: control.curveDuration; easing.type: Easing.OutCubic }
            }

            // 波浪偏移：展开时为 0，折叠时按正弦曲线偏移
            property real curveOffset: d.isExpanded ? 0 :
                control.curveAmplitude * 40 * Math.sin(index * 0.8)
            // 堆叠旋转：展开时为 0，折叠时奇偶交替 ±2.5°
            property real stackRotation: d.isExpanded ? 0 : (index % 2 === 0 ? 2.5 : -2.5)
            // z 序：展开时按索引递增，折叠时首尾最高中间最低
            property int baseZ: {
                if (d.isExpanded) return index
                if (totalCards <= 2) return index
                var edgeDist = Math.min(index, totalCards - 1 - index)
                return totalCards - edgeDist
            }

            // 卡片容器：负责悬停/按下缩放 + 波浪偏移 + 堆叠旋转
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
                    // 波浪偏移：波浪模式沿垂直/水平方向的正弦位移
                    Translate {
                        id: curveTranslate
                        y: control.layout === FlaCardCurveView.LayoutType.WaveHorizontal ? cardRect.curveOffset : 0
                        x: control.layout === FlaCardCurveView.LayoutType.WaveVertical ? cardRect.curveOffset : 0
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

                // 卡片背景外观
                Loader {
                    z: 3
                    anchors.fill: parent
                    anchors.leftMargin: 8
                    sourceComponent: cardVisualComponent
                    property bool showGlow: true
                    property bool isHovered: cardRect.isHovered
                    property bool isPressed: cardRect.isPressed
                    onItemChanged: {
                        if (item)
                            item.visualData = modelData
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    anchors.leftMargin: 8
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
        }
    }

    // 普通模式委托
    Component {
        id: plainCardDelegate
        Item {
            id: cardRect
            width: modelData.cardWidth
            height: modelData.cardHeight
            property bool isHovered: false
            property bool isPressed: false

            // 卡片容器：仅悬停/按下缩放（无波浪效果）
            Item {
                id: cardContainer
                anchors.fill: parent
                anchors.leftMargin: 8
                transform: Scale {
                    id: cardScale
                    origin.x: cardRect.width / 2
                    origin.y: cardRect.height / 2
                    xScale: cardRect.isPressed ? 0.95 : (cardRect.isHovered ? 1.05 : 1.0)
                    yScale: cardRect.isPressed ? 0.95 : (cardRect.isHovered ? 1.05 : 1.0)
                    Behavior on xScale {
                        NumberAnimation { duration: 200; easing.type: Easing.OutCubic }
                    }
                    Behavior on yScale {
                        NumberAnimation { duration: 200; easing.type: Easing.OutCubic }
                    }
                }

                Loader {
                    z: 3
                    anchors.fill: parent
                    anchors.leftMargin: 8
                    sourceComponent: cardVisualComponent
                    property bool showGlow: true
                    property bool isHovered: cardRect.isHovered
                    property bool isPressed: cardRect.isPressed
                    onItemChanged: {
                        if (item)
                            item.visualData = modelData
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    anchors.leftMargin: 8
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onEntered: cardRect.isHovered = true
                    onExited: {
                        cardRect.isHovered = false
                        cardRect.isPressed = false
                    }
                    onPressed: cardRect.isPressed = true
                    onReleased: cardRect.isPressed = false
                    onClicked: control.clicked(index, modelData)
                }
            }
        }
    }
}
