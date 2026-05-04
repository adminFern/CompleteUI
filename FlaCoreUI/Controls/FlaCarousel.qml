import QtQuick
import QtQuick.Controls
import Qt5Compat.GraphicalEffects
import FlaCoreUI

Item {
    id: carousel

    // ========== 对外公开属性 ==========
    property Objects items                    // 轮播项容器
    property int intervalTime: 3000           // 自动切换间隔(ms)
    property bool isPlaying: true             // 是否自动播放
    property int centerImageWidth: 450        // 中心卡片宽度
    property int centerImageHeight: 250       // 中心卡片高度
    property int imageRadius: 10              // 卡片圆角半径

    // ========== 内部私有成员 ==========
    QtObject {
        id: internal
        property real hoverScale: 1.05               // 悬停放大系数
        property real clickScale: 0.95               // 点击缩小系数
        property int clickAnimationDuration: 150     // 点击动画时长(ms)
        property real shadowOpacity: 0.7             // 阴影透明度
        property real shadowHoverOpacity: 1.0        // 悬停时阴影透明度
        property int currentIndex: 0                 // 当前激活索引
        property int totalCount: items ? items.children.length : 0  // 总数量
        property bool isTransitioning: false         // 过渡动画进行中标志
        property real carouselW: Math.min(carousel.centerImageWidth, carousel.parent ? carousel.parent.width * 0.7 : carousel.centerImageWidth)
        property real carouselH: Math.min(carousel.centerImageHeight, carousel.parent ? carousel.parent.height * 0.7 : carousel.centerImageHeight)
        property real sideOffset: carouselW * 0.30   // 侧边偏移量
        property real gap: carouselW * 0.074         // 卡片间距
        property real sideScale: 0.75                // 侧边卡片缩放
        property real farScale: 0.6                  // 远端卡片缩放
        property real centerImageX: (viewport.width - carouselW) / 2
        property real centerImageTop: (viewport.height - carouselH) / 2
        property bool isHovering: false              // 鼠标悬停标志

        // 获取所有轮播项
        function getItem() {
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

        // 计算环形偏移量（处理首尾衔接）
        function getOffset(slideIdx, activeIdx) {
            var diff = slideIdx - activeIdx
            var half = Math.floor(totalCount / 2)
            if (diff > half) diff -= totalCount
            if (diff < -half) diff += totalCount
            return diff
        }

        // 根据偏移量获取位置类型
        function getPositionType(offset) {
            if (offset === 0) return "center"
            if (offset === 1) return "right"
            if (offset === -1) return "left"
            if (offset === 2) return "farRight"
            if (offset === -2) return "farLeft"
            return "hidden"
        }

        // 更新所有卡片位置和状态
        function updatePositions() {
            for (var i = 0; i < repeater.count; i++) {
                var item = repeater.itemAt(i)
                if (item !== null) {
                    var offset = internal.getOffset(i, internal.currentIndex)
                    var posType = internal.getPositionType(offset)
                    item.setPosition(posType)

                    if (posType !== "center") {
                        item.isHovered = false
                        item.hoverScaleFactor = 1.0
                    }

                    if (posType === "center") {
                        item.opacity = 1
                        item.visible = true
                    } else if (posType === "left" || posType === "right") {
                        item.opacity = 0.65
                        item.visible = true
                    } else {
                        item.opacity = 0
                        item.visible = false
                    }
                }
            }
            internal.updateDots()
        }

        // 更新指示点状态
        function updateDots() {
            for (var i = 0; i < dotRepeater.count; i++) {
                var dot = dotRepeater.itemAt(i)
                if (dot !== null) {
                    dot.active = (i === internal.currentIndex)
                }
            }
        }

        // 重启自动播放定时器
        function resetAutoPlay() {
            if (carousel.isPlaying && !internal.isHovering) {
                autoPlayTimer.restart()
            }
        }

        // 切换到指定索引
        function goTo(index) {
            if (internal.isTransitioning || index === internal.currentIndex) return
            internal.isTransitioning = true
            internal.currentIndex = (index % internal.totalCount + internal.totalCount) % internal.totalCount
            internal.updatePositions()
            internal.resetAutoPlay()
            transitionTimer.start()
        }

        // 下一张
        function next() {
            var newIndex = (internal.currentIndex + 1) % internal.totalCount
            internal.goTo(newIndex)
        }

        // 上一张
        function prev() {
            var newIndex = (internal.currentIndex - 1 + internal.totalCount) % internal.totalCount
            internal.goTo(newIndex)
        }

        // 鼠标进入视口处理
        function handleMouseEnter() {
            internal.isHovering = true
            autoPlayTimer.stop()
        }

        // 鼠标离开视口处理
        function handleMouseExit() {
            internal.isHovering = false
            if (carousel.isPlaying && !internal.isTransitioning) {
                autoPlayTimer.restart()
            }
        }

        // 尝试恢复自动播放
        function tryResumeAutoPlay() {
            if (carousel.isPlaying && !internal.isHovering) {
                autoPlayTimer.restart()
            }
        }

        // 检测中心卡片的鼠标悬停
        function handleHoverPosition(mx, my) {
            if (internal.isTransitioning) return
            var centerItem = repeater.itemAt(internal.currentIndex)
            if (centerItem === null) return

            var cardX = centerItem.x
            var cardY = (viewport.height - internal.carouselH) / 2
            var cardW = internal.carouselW
            var cardH = internal.carouselH

            var inside = mx >= cardX && mx <= cardX + cardW
                    && my >= cardY && my <= cardY + cardH

            if (inside) {
                if (!centerItem.isHovered) {
                    centerItem.isHovered = true
                    centerItem.hoverScaleFactor = internal.hoverScale
                }
            } else {
                if (centerItem.isHovered) {
                    centerItem.isHovered = false
                    centerItem.hoverScaleFactor = 1.0
                }
            }
        }
    }

    // ========== 对外公开方法 ==========
    function goTo(index) {
        internal.goTo(index)
    }

    function next() {
        internal.next()
    }

    function prev() {
        internal.prev()
    }

    // ========== 定时器 ==========
    Timer {
        id: autoPlayTimer
        interval: carousel.intervalTime
        repeat: true
        onTriggered: {
            if (carousel.isPlaying && !internal.isTransitioning && !internal.isHovering) {
                internal.next()
            }
        }
    }

    Timer {
        id: transitionTimer
        interval: 500
        onTriggered: {
            internal.isTransitioning = false
            internal.tryResumeAutoPlay()
            if (internal.isHovering) {
                internal.handleHoverPosition(viewportMA.mouseX, viewportMA.mouseY)
            }
        }
    }

    // ========== UI 元素 ==========
    Item {
        id: viewport
        anchors.centerIn: parent
        width: internal.carouselW + internal.sideOffset * 2 + internal.gap * 2
        height: internal.carouselH
        z: 5

        // 视口鼠标区域
        MouseArea {
            id: viewportMA
            anchors.fill: parent
            hoverEnabled: true
            onEntered: internal.handleMouseEnter()
            onExited: internal.handleMouseExit()
            onPositionChanged: function(mouse) {
                internal.handleHoverPosition(mouse.x, mouse.y)
            }
        }

        // 轮播卡片列表
        Repeater {
            id: repeater
            model: internal.getItem()
            Item {
                id: slideItem
                width: internal.carouselW
                height: internal.carouselH
                opacity: 0
                visible: false
                z: 100 - Math.abs(internal.getOffset(index, internal.currentIndex))

                property real targetX: 0
                property real targetScale: 1
                property bool isHovered: false
                property bool isClicked: false
                property real hoverScaleFactor: 1.0
                property real clickScaleFactor: 1.0

                x: targetX
                y: (viewport.height - height) / 2
                scale: targetScale * hoverScaleFactor * clickScaleFactor

                Behavior on x {
                    NumberAnimation { duration: 500; easing.type: Easing.InOutCubic }
                }
                Behavior on targetScale {
                    NumberAnimation { duration: 500; easing.type: Easing.InOutCubic }
                }
                Behavior on opacity {
                    NumberAnimation { duration: 400; easing.type: Easing.InOutCubic }
                }
                Behavior on hoverScaleFactor {
                    SpringAnimation {
                        spring: 2
                        damping: 0.3
                        epsilon: 0.05
                    }
                }
                Behavior on clickScaleFactor {
                    NumberAnimation {
                        duration: internal.clickAnimationDuration
                        easing.type: Easing.InOutQuad
                    }
                }

                // 图片内容组件
                Component {
                    id: _imageSlide
                    Image {
                        anchors.fill: parent
                        source: modelData.imagesource
                        fillMode: Image.PreserveAspectCrop
                        asynchronous: true
                        smooth: true
                    }
                }

                // 占位组件
                Component {
                    id: _placeholderSlide
                    Rectangle {
                        anchors.fill: parent
                        color: modelData.cardColor!==null && modelData.cardColor !== undefined ?modelData.cardColor: "#2a2a2a"
                    }
                }

                // 卡片视觉内容（带圆角裁剪）
                Item {
                    id: visualContent
                    anchors.fill: parent
                    visible: true
                    layer.enabled: true
                    layer.effect: OpacityMask {
                        maskSource: Rectangle {
                            width: visualContent.width
                            height: visualContent.height
                            radius: carousel.imageRadius
                        }
                    }
                    //矩形
                    Loader {
                        z:0
                        anchors.fill: parent
                        active: modelData.cardColor !==null && modelData.cardColor !== undefined
                                && modelData.visibleimage !== true
                        sourceComponent: _placeholderSlide
                    }
                    //图片
                    Loader {
                        z:0
                        anchors.fill: parent
                        active: modelData.visibleimage===true && modelData.imagesource!==""
                        sourceComponent: _imageSlide
                    }
                    //外部内容
                    Loader {
                        z:2
                        anchors.fill: parent
                        active: modelData.delegate !== null && modelData.delegate !== undefined
                        sourceComponent: modelData.delegate
                    }

                }

                RectangularGlow {
                    id: glow
                    z: 0
                    anchors.fill: visualContent
                    glowRadius: 8
                    spread: 0.25
                    color: Theme.isDark ? "#80000000" : "#40000000"
                    cornerRadius: carousel.imageRadius
                    visible: slideItem.opacity > 0
                    opacity: slideItem.isHovered ? internal.shadowHoverOpacity : internal.shadowOpacity
                    Behavior on opacity {
                        NumberAnimation { duration: 200; easing.type: Easing.OutCubic }
                    }
                }

                // 卡片鼠标区域（点击交互）
                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor

                    onPressed: {
                        if (index === internal.currentIndex && !internal.isTransitioning) {
                            slideItem.isClicked = true
                            slideItem.clickScaleFactor = internal.clickScale
                        }
                    }
                    onReleased: {
                        slideItem.clickScaleFactor = 1.0
                        slideItem.isClicked = false
                    }
                    onClicked: {
                        if (index !== internal.currentIndex && !internal.isTransitioning) {
                            internal.goTo(index)
                        } else if (index === internal.currentIndex) {
                            console.log("Center slide clicked:", modelData.imagesource)
                        }
                    }
                    onCanceled: {
                        slideItem.clickScaleFactor = 1.0
                        slideItem.isClicked = false
                        slideItem.isHovered = false
                        slideItem.hoverScaleFactor = 1.0
                    }
                }

                // 设置卡片位置
                function setPosition(posType) {
                    var centerX = (viewport.width - internal.carouselW) / 2

                    if (posType === "center") {
                        targetX = centerX
                        targetScale = 1
                        slideItem.z = 100
                    } else if (posType === "left") {
                        targetX = centerX - internal.sideOffset - internal.gap
                        targetScale = internal.sideScale
                        slideItem.z = 50
                    } else if (posType === "right") {
                        targetX = centerX + internal.sideOffset + internal.gap
                        targetScale = internal.sideScale
                        slideItem.z = 50
                    } else if (posType === "farLeft") {
                        targetX = centerX - internal.sideOffset * 2.0 - internal.gap
                        targetScale = internal.farScale
                        slideItem.z = 10
                    } else if (posType === "farRight") {
                        targetX = centerX + internal.sideOffset * 2.0 + internal.gap
                        targetScale = internal.farScale
                        slideItem.z = 10
                    } else {
                        targetX = centerX
                        targetScale = 0.5
                        slideItem.z = 0
                    }
                }
            }
        }

        // 指示点容器
        Item {
            id: dotsContainer
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            height: 20
            z: 200

            Row {
                id: dotsRow
                anchors.centerIn: parent
                spacing: 12

                Repeater {
                    id: dotRepeater
                    model: internal.totalCount

                    Rectangle {
                        width: active ? 20 : 6
                        height: 6
                        radius: active ? 12 : 6
                        color: active ? Qt.rgba(1,1,1,0.6) : Qt.rgba(1,1,1,0.1)
                        property bool active: index === internal.currentIndex

                        Behavior on width {
                            NumberAnimation { duration: 300; easing.type: Easing.OutCubic }
                        }
                        Behavior on radius {
                            NumberAnimation { duration: 300; easing.type: Easing.OutCubic }
                        }
                        Behavior on color {
                            ColorAnimation { duration: 300 }
                        }

                        MouseArea {
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor
                            onClicked: internal.goTo(index)
                        }
                    }
                }
            }
        }
    }

    implicitWidth: internal.carouselW + internal.sideOffset * 1.8 + internal.gap
    implicitHeight: internal.carouselH + dotsContainer.height + 4

    // ========== 初始化 ==========
    Component.onCompleted: {
        internal.updatePositions()
        if (carousel.isPlaying && !internal.isHovering) {
            autoPlayTimer.start()
        }
    }
}