import QtQuick
import QtQuick.Controls
import Qt5Compat.GraphicalEffects
import FlaCoreUI
Rectangle {
    id: carousel
    color: Theme.setColorAlpha(Theme.FillCardColor,150)
    border.width: 1
    border.color: Theme.FillBorderColor
    radius: 6
    // ========== 对外公开属性 ==========
    property var slidesModel: [
        {
            imageSource: "https://picsum.photos/seed/ghibli-meadow/800/500.jpg",
            title: '草原上的旅人',
            tag: '奇幻 · 自然'
        },
        {
            imageSource: "https://picsum.photos/seed/ghibli-sky/800/500.jpg",
            title: '天空之城的黎明',
            tag: '飞行 · 城市'
        },
        {
            imageSource: "https://picsum.photos/seed/ghibli-cat/800/500.jpg",
            title: '橘猫与石径',
            tag: '动物 · 田园'
        },
        {
            imageSource: "https://picsum.photos/seed/ghibli-forest/800/500.jpg",
            title: '幽深的古木林',
            tag: '森林 · 秘境'
        },
        {
            imageSource: "https://picsum.photos/seed/ghibli-ocean/800/500.jpg",
            title: "远航灯塔",
            tag: "海洋 · 守望"
        }
    ]

    property int intervalTime: 3000
    property bool isPlaying: true
    property int centerImageWidth: 450
    property int centerImageHeight: 250
    property int imageRadius: 10

    // ========== 内部私有成员 ==========
    QtObject {
        id: internal
        property real hoverScale: 1.05          // 悬停放大比例
        property real clickScale: 0.95          // 点击缩小比例
        property int clickAnimationDuration: 150 // 点击动画持续时间(ms)
        property real shadowOpacity: 0.7         // 阴影不透明度
        property real shadowHoverOpacity: 1.0    // 悬停时阴影不透明度
        property int currentIndex: 0
        property int totalCount: carousel.slidesModel.length
        property bool isTransitioning: false
        property real carouselW: Math.min(carousel.centerImageWidth, carousel.parent ? carousel.parent.width * 0.7 : carousel.centerImageWidth)
        property real carouselH: Math.min(carousel.centerImageHeight, carousel.parent ? carousel.parent.height * 0.7 : carousel.centerImageHeight)
        property real sideOffset: carouselW * 0.45
        property real gap: carouselW * 0.074
        property real sideScale: 0.75
        property real farScale: 0.6
        property real centerImageX: (viewport.width - carouselW) / 2
        property real centerImageTop: (viewport.height - carouselH) / 2
        property bool isHovering: false      // 鼠标悬停状态

        // ========== 内部方法 ==========
        function getOffset(slideIdx, activeIdx) {
            var diff = slideIdx - activeIdx
            var half = Math.floor(totalCount / 2)
            if (diff > half) diff -= totalCount
            if (diff < -half) diff += totalCount
            return diff
        }

        function getPositionType(offset) {
            if (offset === 0) return "center"
            if (offset === 1) return "right"
            if (offset === -1) return "left"
            if (offset === 2) return "farRight"
            if (offset === -2) return "farLeft"
            return "hidden"
        }

        function updatePositions() {
            for (var i = 0; i < repeater.count; i++) {
                var item = repeater.itemAt(i)
                if (item !== null) {
                    var offset = internal.getOffset(i, internal.currentIndex)
                    var posType = internal.getPositionType(offset)
                    item.setPosition(posType)
                    // 非中心卡片时重置悬停状态
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

        function updateDots() {
            for (var i = 0; i < dotRepeater.count; i++) {
                var dot = dotRepeater.itemAt(i)
                if (dot !== null) {
                    dot.active = (i === internal.currentIndex)
                }
            }
        }

        function resetAutoPlay() {
            // 只有在非悬停状态且播放开关打开时才重启定时器
            if (carousel.isPlaying && !internal.isHovering) {
                autoPlayTimer.restart()
            }
        }

        function goTo(index) {
            if (internal.isTransitioning || index === internal.currentIndex) return
            internal.isTransitioning = true
            internal.currentIndex = (index % internal.totalCount + internal.totalCount) % internal.totalCount
            internal.updatePositions()
            internal.resetAutoPlay()
            transitionTimer.start()
        }

        function next() {
            var newIndex = (internal.currentIndex + 1) % internal.totalCount
            internal.goTo(newIndex)
        }

        function prev() {
            var newIndex = (internal.currentIndex - 1 + internal.totalCount) % internal.totalCount
            internal.goTo(newIndex)
        }

        // 处理鼠标进入
        function handleMouseEnter() {
            internal.isHovering = true
            autoPlayTimer.stop()
        }

        // 处理鼠标离开
        function handleMouseExit() {
            internal.isHovering = false
            if (carousel.isPlaying && !internal.isTransitioning) {
                autoPlayTimer.restart()
            }
        }

        function tryResumeAutoPlay() {
            if (carousel.isPlaying && !internal.isHovering) {
                autoPlayTimer.restart()
            }
        }

        // 根据视口内的鼠标位置检测是否悬停在中心卡片上
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
            // 过渡完成后，如果鼠标仍在视口内，立即刷新悬停视觉
            if (internal.isHovering) {
                internal.handleHoverPosition(viewportMA.mouseX, viewportMA.mouseY)
            }
        }
    }

    // ========== UI 元素 ==========

    // 轮播视口 - 添加鼠标区域检测悬停
    Item {
        id: viewport
        anchors.centerIn: parent
        width: internal.carouselW + internal.sideOffset * 2 + internal.gap * 2
        height: internal.carouselH
        z: 5
        // 整个视口的鼠标检测区域（统一管理悬停和自动播放）
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
        // 幻灯片列表
        Repeater {
            id: repeater
            model: carousel.slidesModel
            Item {
                id: slideItem
                width: internal.carouselW
                height: internal.carouselH
                opacity: 0
                visible: false
                z: 100 - Math.abs(internal.getOffset(index, internal.currentIndex))
                property real targetX: 0
                property real targetScale: 1
                property bool isHovered: false       // 当前卡片是否被悬停
                property bool isClicked: false       // 当前卡片是否被点击
                // 悬停放大效果 - 通过额外的缩放因子
                property real hoverScaleFactor: 1.0
                property real clickScaleFactor: 1.0
                x: targetX
                y: (viewport.height - height) / 2
                // 实际显示的缩放 = 位置缩放 * 悬停缩放 * 点击缩放
                scale: targetScale * hoverScaleFactor * clickScaleFactor
                // 基础位置动画
                Behavior on x {
                    NumberAnimation { duration: 500; easing.type: Easing.InOutCubic }
                }

                Behavior on targetScale {
                    NumberAnimation { duration: 500; easing.type: Easing.InOutCubic }
                }

                Behavior on opacity {
                    NumberAnimation { duration: 400; easing.type: Easing.InOutCubic }
                }

                // 悬停缩放动画 - 使用弹簧效果
                Behavior on hoverScaleFactor {
                    SpringAnimation {
                        spring: 2
                        damping: 0.3
                        epsilon: 0.05
                    }
                }

                // 点击缩放动画
                Behavior on clickScaleFactor {
                    NumberAnimation {
                        duration: internal.clickAnimationDuration
                        easing.type: Easing.InOutQuad
                    }
                }

                // 阴影层（先渲染，叠在 visualContent 下方）
                RectangularGlow {
                    id: glow
                    anchors.fill: parent
                    glowRadius: 8
                    spread: 0.2
                    color: Theme.isDark ? "#80000000" : "#40000000"
                    cornerRadius: carousel.imageRadius
                    visible: slideItem.opacity > 0
                    opacity: slideItem.isHovered ? internal.shadowHoverOpacity : internal.shadowOpacity
                    Behavior on opacity {
                        NumberAnimation { duration: 200; easing.type: Easing.OutCubic }
                    }
                }

                // ===== 视觉内容容器（使用 layer 统一裁剪圆角） =====
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

                    Image {
                        id: img
                        anchors.fill: parent
                        source: modelData.imageSource
                        fillMode: Image.PreserveAspectCrop
                        asynchronous: true
                        smooth: true
                    }

                    Rectangle {
                        anchors.bottom: parent.bottom
                        anchors.left: parent.left
                        anchors.right: parent.right
                        height: parent.height * 0.45
                        radius: carousel.imageRadius
                        gradient: Gradient {
                            GradientStop { position: 0; color: "transparent" }
                            GradientStop { position: 1; color: Qt.rgba(0, 0, 0, 0.5) }
                        }
                    }

                    Column {
                        anchors.bottom: parent.bottom
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.margins: 24
                        spacing: 4

                        Text {
                            text: modelData.title
                            font.family: "Microsoft YaHei"
                            font.pixelSize: 20
                            font.weight: Font.Bold
                            color: "#ffffff"
                            style: Text.Outline
                            styleColor: Qt.rgba(0, 0, 0, 0.3)
                        }
                        Text {
                            text: modelData.tag
                            font.family: "Microsoft YaHei"
                            font.pixelSize: 12
                            color: Qt.rgba(255, 255, 255, 0.85)
                        }
                    }
                }

                // 卡片级别的鼠标区域（仅处理点击，悬停由 viewportMA 统一管理）
                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    // 点击处理
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
                            // 点击非中心卡片时切换到该卡片
                            internal.goTo(index)
                        } else if (index === internal.currentIndex) {
                            // 点击中心卡片可以添加自定义逻辑
                            console.log("Center slide clicked:", modelData.title)
                        }
                    }

                    onCanceled: {
                        // 当鼠标被其他元素捕获时，恢复缩放
                        slideItem.clickScaleFactor = 1.0
                        slideItem.isClicked = false
                        slideItem.isHovered = false
                        slideItem.hoverScaleFactor = 1.0
                    }
                }

                // 设置卡片位置的函数
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
                        targetX = centerX - internal.sideOffset * 1.8 - internal.gap
                        targetScale = internal.farScale
                        slideItem.z = 10
                    } else if (posType === "farRight") {
                        targetX = centerX + internal.sideOffset * 1.8 + internal.gap
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

        // 圆点指示器 - 叠在视图底部
        Item {
            id: dotsContainer
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 5
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
                        width: active ? 28 : 8
                        height: 8
                        radius: active ? 12 : 4
                        color: active ? "#2c2c2c" : "#c7c7c7"
                        property bool active: index === internal.currentIndex

                        Behavior on width {
                            NumberAnimation { duration: 350; easing.type: Easing.InOutCubic }
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
    implicitHeight: internal.carouselH +dotsContainer.height
    // ========== 初始化 ==========
    Component.onCompleted: {
        internal.updatePositions()
        if (carousel.isPlaying && !internal.isHovering) {
            autoPlayTimer.start()
        }
    }
}