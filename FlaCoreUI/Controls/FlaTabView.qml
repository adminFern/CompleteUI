import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import FlaCoreUI

Item {
    id: control

    // ── 枚举 ──────────────────────────────────────────
    enum TabWidthBehavior { Equal = 0, SizeToContent = 1, Compact = 2 }
    enum CloseButtonVisibility { Never = 0, Always = 1, OnHover = 2 }

    // ── 公开属性 ──────────────────────────────────────
    property int tabWidthBehavior: FlaTabView.TabWidthBehavior.Equal
    property int closeButtonVisibility: FlaTabView.CloseButtonVisibility.OnHover
    property int itemWidth: 146
    property bool addButtonVisibility: true
    property alias count: tab_model.count
    property alias currentIndex: tab_bar.currentIndex

    // ── 信号 ──────────────────────────────────────────
    signal newPressed
    signal tabClosed(int index)

    implicitHeight: 200
    implicitWidth: 400

    // ── 内部状态 ──────────────────────────────────────
    QtObject {
        id: d
        property int maxEqualWidth: 240
        property int tabBarHeight: 36
        property int tabSpacing: 0
        property int tabRadius: 7
        property int closeSize: 20
        property int iconSize: 14
        property int addSize: 28
        property int concaveRadius: 4
    }

    // ── 数据模型 ──────────────────────────────────────
    ListModel {
        id: tab_model
    }

    // ── 顶部栏：选项卡 + 新增按钮 ────────────────────
    RowLayout {
        id: tab_header
        spacing: 0
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
        }
        height: d.tabBarHeight

        // 选项卡列表
        ListView {
            id: tab_bar
            Layout.fillWidth: true
            Layout.fillHeight: true
            orientation: ListView.Horizontal
            interactive: contentWidth > width
            clip: true
            model: tab_model
            spacing: d.tabSpacing
            leftMargin: 8

            // 滚动条（隐藏但可用鼠标滚轮触发）
            ScrollBar.horizontal: ScrollBar {
                id: scroll_bar
                policy: ScrollBar.AlwaysOff
            }

            // 选中项变化时确保可见
            onCurrentItemChanged: {
                if (currentItem) positionViewAtIndex(currentIndex, ListView.Contain)
            }

            // 拖拽排序过渡动画
            move: Transition {
                NumberAnimation { property: "x"; duration: 150; easing.type: Easing.OutCubic }
            }
            moveDisplaced: Transition {
                NumberAnimation { property: "x"; duration: 200; easing.type: Easing.OutCubic }
            }

            delegate: Item {
                id: tab_delegate
                width: tab_item.width
                height: tab_item.height

                // ── 拖放区域 ─────────────────────────
                DropArea {
                    anchors.fill: parent
                    onEntered: (drag) => {
                        if (drag.source.visualIndex !== undefined) {
                            tab_model.move(drag.source.visualIndex, tab_item.visualIndex, 1)
                        }
                    }
                }

                // ── 选项卡主体 ───────────────────────
                Rectangle {
                    id: tab_item

                    property int visualIndex: model.index
                    readonly property bool isCurrent: model.index === tab_bar.currentIndex
                    readonly property bool isPrevious: model.index + 1 === tab_bar.currentIndex
                    readonly property bool isNext: model.index - 1 === tab_bar.currentIndex

                    width: {
                        var minW = d.iconSize + 8 + d.closeSize + 20 // icon + gap + close + margins
                        if (tabWidthBehavior === FlaTabView.TabWidthBehavior.Equal) {
                            var equalW = Math.min(d.maxEqualWidth, tab_bar.width / Math.max(1, tab_bar.count))
                            return Math.max(equalW, minW)
                        }
                        if (tabWidthBehavior === FlaTabView.TabWidthBehavior.SizeToContent) {
                            return Math.max(itemWidth, minW)
                        }
                        if (tabWidthBehavior === FlaTabView.TabWidthBehavior.Compact) {
                            var expanded = hover_handler.hovered || btn_close.hovered || isCurrent
                            return expanded ? Math.max(itemWidth, minW) : minW
                        }
                        return Math.max(Math.min(d.maxEqualWidth, tab_bar.width / Math.max(1, tab_bar.count)), minW)
                    }
                    height: d.tabBarHeight

                    // 拖拽
                    Drag.active: mouse_area.drag.active
                    Drag.source: tab_item
                    Drag.hotSpot.x: width / 2
                    Drag.hotSpot.y: height / 2

                    readonly property bool isActive: isCurrent || hover_handler.hovered

                    // 圆角：选中或悬停时仅顶部圆角
                    radius: d.tabRadius
                    bottomLeftRadius: isActive ? 0 : d.tabRadius
                    bottomRightRadius: isActive ? 0 : d.tabRadius

                    // 背景：选中 vs 悬停 vs 未选中
                    color: {
                        if (!enabled) return Theme.isDark ? Qt.rgba(1, 1, 1, 0.04) : Qt.rgba(0, 0, 0, 0.04)
                        if (isCurrent) return Theme.isDark ? Qt.rgba(1, 1, 1, 0.06) : Qt.rgba(255, 255, 255, 1)
                        if (hover_handler.hovered) return Theme.isDark ? Qt.rgba(1, 1, 1, 0.04) : Qt.rgba(0, 0, 0, 0.04)
                        return "transparent"
                    }

                    // 选中/悬停态底部边框遮盖（与内容区无缝衔接）
                    Rectangle {
                        visible: tab_item.isActive
                        anchors {
                            bottom: parent.bottom
                            left: parent.left
                            right: parent.right
                        }
                        height: parent.radius
                        color: parent.color
                    }

                    // 选中/悬停态边框（Canvas 绘制带底部圆弧的轮廓）
                    Canvas {
                        visible: tab_item.isActive
                        anchors.fill: parent
                        z: 2

                        readonly property real cr: d.concaveRadius
                        readonly property real r: d.tabRadius
                        readonly property color strokeColor: Theme.isDark ? Qt.rgba(1, 1, 1, 0.08) : Qt.rgba(0, 0, 0, 0.08)

                        onPaint: {
                            var ctx = getContext('2d')
                            ctx.clearRect(0, 0, width, height)
                            ctx.strokeStyle = strokeColor
                            ctx.lineWidth = 1

                            var r2 = r
                            var cr2 = cr
                            var w = width
                            var h = height

                            ctx.beginPath()
                            // 左边上 → 左下（到底部圆弧起点）
                            ctx.moveTo(0, r2)
                            ctx.arcTo(0, 0, r2, 0, r2)          // 左上圆角
                            ctx.lineTo(w - r2, 0)
                            ctx.arcTo(w, 0, w, r2, r2)           // 右上圆角
                            ctx.lineTo(w, h)                       // 右边到底部
                            // 右下圆弧（凹进）
                            ctx.arc(w, h, cr2, Math.PI, Math.PI * 1.5, false)
                            // 底边
                            ctx.lineTo(cr2, h + cr2)
                            // 左下圆弧（凹进）
                            ctx.arc(0, h, cr2, Math.PI * 1.5, Math.PI * 2, false)

                            ctx.stroke()
                        }

                        // 底部边框遮盖（让底部边框不画在内容区连接处）
                        Rectangle {
                            visible: tab_item.isCurrent
                            anchors {
                                bottom: parent.bottom
                                left: parent.left
                                right: parent.right
                            }
                            height: 2
                            color: tab_item.color
                        }
                    }

                    // 分隔线（非激活且非相邻选中/悬停）
                    Rectangle {
                        visible: !tab_item.isActive && !tab_item.isPrevious
                        width: 1
                        height: 14
                        anchors {
                            right: parent.right
                            verticalCenter: parent.verticalCenter
                        }
                        color: Theme.isDark ? Qt.rgba(1, 1, 1, 0.06) : Qt.rgba(0, 0, 0, 0.06)
                    }

                    // ── 内容：图标 + 文字 + 关闭按钮 ────
                    RowLayout {
                        id: tab_content
                        anchors.fill: parent
                        anchors.leftMargin: 10
                        anchors.rightMargin: 4
                        spacing: 6

                        // 图标
                        Image {
                            source: model.icon || ""
                            Layout.preferredWidth: model.icon ? d.iconSize : 0
                            Layout.preferredHeight: model.icon ? d.iconSize : 0
                            Layout.alignment: Qt.AlignVCenter
                            visible: model.icon
                        }

                        // 标题
                        Label {
                            id: tab_label
                            text: model.text
                            Layout.fillWidth: true
                            Layout.alignment: Qt.AlignVCenter
                            elide: Text.ElideRight
                            font: Qt.font({ family: Theme.defaultFontFamily, pixelSize: 12, weight: Font.Normal })
                            color: {
                                if (!enabled) return Theme.isDark ? Qt.rgba(1, 1, 1, 0.3) : Qt.rgba(0, 0, 0, 0.3)
                                if (tab_item.isCurrent) return Theme.isDark ? "white" : "black"
                                return Theme.isDark ? Qt.rgba(1, 1, 1, 0.7) : Qt.rgba(0, 0, 0, 0.7)
                            }
                            visible: {
                                if (tabWidthBehavior === FlaTabView.TabWidthBehavior.Compact) {
                                    return hover_handler.hovered || btn_close.hovered || tab_item.isCurrent
                                }
                                return true
                            }
                        }

                        // 关闭按钮
                        Rectangle {
                            id: btn_close
                            Layout.preferredWidth: visible ? d.closeSize : 0
                            Layout.preferredHeight: visible ? d.closeSize : 0
                            Layout.alignment: Qt.AlignVCenter
                            radius: 3
                            color: {
                                var pc = Theme.PrimaryColor
                                if (close_mouse.pressed)
                                    return Qt.rgba(pc.r, pc.g, pc.b, Theme.isDark ? 0.2 : 0.12)
                                if (close_hover.hovered)
                                    return Qt.rgba(pc.r, pc.g, pc.b, Theme.isDark ? 0.12 : 0.08)
                                return "transparent"
                            }
                            visible: {
                                if (closeButtonVisibility === FlaTabView.CloseButtonVisibility.Never)
                                    return false
                                if (closeButtonVisibility === FlaTabView.CloseButtonVisibility.OnHover)
                                    return hover_handler.hovered || close_hover.hovered || tab_item.isCurrent
                                return true
                            }

                            FlaImage {
                                anchors.centerIn: parent
                                iconsource: FluentIcon.ico_ChromeClose
                                iconsize: 10
                                icocolor: Theme.isDark ? Qt.rgba(1, 1, 1, 0.7) : Qt.rgba(0, 0, 0, 0.7)
                            }

                            HoverHandler {
                                id: close_hover
                            }

                            MouseArea {
                                id: close_mouse
                                anchors.fill: parent
                                hoverEnabled: true
                                onClicked: {
                                    var idx = model.index
                                    tab_model.remove(idx)
                                    control.tabClosed(idx)
                                }
                            }
                        }
                    }

                    // 悬停检测
                    HoverHandler {
                        id: hover_handler
                    }

                    // 鼠标交互（点击 + 拖拽）
                    MouseArea {
                        id: mouse_area
                        anchors.fill: parent
                        drag.target: tab_item
                        drag.axis: Drag.XAxis
                        onPressed: (mouse) => {
                            tab_bar.currentIndex = model.index
                        }
                    }

                    // 拖拽状态：提升到 ListView 层级
                    states: State {
                        when: mouse_area.drag.active
                        ParentChange { target: tab_item; parent: tab_bar }
                        AnchorChanges {
                            target: tab_item
                            anchors {
                                horizontalCenter: undefined
                                verticalCenter: undefined
                            }
                        }
                        PropertyChanges {
                            target: tab_item
                            opacity: 0.85
                            z: 100
                        }
                    }
                }
            }

            // 鼠标滚轮滚动
            WheelHandler {
                onWheel: (wheel) => {
                    if (wheel.angleDelta.y > 0) scroll_bar.decrease()
                    else scroll_bar.increase()
                }
            }
        }

        // 新增按钮
        FlaIconButton {
            id: btn_add
            visible: addButtonVisibility
            Layout.preferredWidth: d.addSize
            Layout.preferredHeight: d.addSize
            Layout.alignment: Qt.AlignVCenter
            Layout.rightMargin: 4
            iconsource: FluentIcon.ico_Add
            iconsize: 12
            radius: 4
            hoverColor: Qt.rgba(Theme.PrimaryColor.r, Theme.PrimaryColor.g, Theme.PrimaryColor.b, Theme.isDark ? 0.12 : 0.08)
            pressedColor: Qt.rgba(Theme.PrimaryColor.r, Theme.PrimaryColor.g, Theme.PrimaryColor.b, Theme.isDark ? 0.2 : 0.12)
            onClicked: control.newPressed()
        }
    }

    // ── 内容区域底部分割线 ────────────────────────────
    Item {
        id: separator_area
        anchors {
            top: tab_header.bottom
            left: parent.left
            right: parent.right
        }
        height: d.concaveRadius

        // 1px 实际分割线
        Rectangle {
            id: separator_line
            anchors {
                top: parent.top
                left: parent.left
                right: parent.right
            }
            height: 1
            color: Theme.isDark ? Qt.rgba(1, 1, 1, 0.08) : Qt.rgba(0, 0, 0, 0.08)
        }

        // 辅助属性：获取选中选项卡位置
        property real tabX: {
            var item = tab_bar.currentItem
            return item ? item.x + tab_bar.x + tab_header.x : -1
        }
        property real tabW: {
            var item = tab_bar.currentItem
            return item ? item.width : 0
        }
        property color tabColor: {
            var item = tab_bar.currentItem
            var tabItem = item ? item.children[0] : null
            return tabItem && tabItem.isCurrent ? tabItem.color : "transparent"
        }

        // 选中选项卡下方不显示分割线（无缝衔接）
        Rectangle {
            x: separator_area.tabX
            width: separator_area.tabW
            height: parent.height
            color: separator_area.tabColor
        }

        // 左下圆弧填充（耳形）
        Rectangle {
            visible: separator_area.tabColor !== "transparent"
            x: separator_area.tabX - d.concaveRadius
            y: 0
            width: d.concaveRadius
            height: d.concaveRadius
            bottomLeftRadius: d.concaveRadius
            color: separator_area.tabColor
        }

        // 右下圆弧填充（耳形）
        Rectangle {
            visible: separator_area.tabColor !== "transparent"
            x: separator_area.tabX + separator_area.tabW
            y: 0
            width: d.concaveRadius
            height: d.concaveRadius
            bottomRightRadius: d.concaveRadius
            color: separator_area.tabColor
        }

        // 左下圆弧边框线
        Canvas {
            visible: separator_area.tabColor !== "transparent"
            x: separator_area.tabX - d.concaveRadius
            y: 0
            width: d.concaveRadius
            height: d.concaveRadius
            onPaint: {
                var ctx = getContext('2d')
                ctx.clearRect(0, 0, width, height)
                ctx.strokeStyle = Theme.isDark ? Qt.rgba(1, 1, 1, 0.08) : Qt.rgba(0, 0, 0, 0.08)
                ctx.lineWidth = 1
                ctx.beginPath()
                ctx.arc(width, 0, width, Math.PI, Math.PI * 1.5, false)
                ctx.stroke()
            }
        }

        // 右下圆弧边框线
        Canvas {
            visible: separator_area.tabColor !== "transparent"
            x: separator_area.tabX + separator_area.tabW
            y: 0
            width: d.concaveRadius
            height: d.concaveRadius
            onPaint: {
                var ctx = getContext('2d')
                ctx.clearRect(0, 0, width, height)
                ctx.strokeStyle = Theme.isDark ? Qt.rgba(1, 1, 1, 0.08) : Qt.rgba(0, 0, 0, 0.08)
                ctx.lineWidth = 1
                ctx.beginPath()
                ctx.arc(0, 0, width, Math.PI * 1.5, Math.PI * 2, false)
                ctx.stroke()
            }
        }
    }

    // ── 内容区域 ──────────────────────────────────────
    Item {
        id: container
        anchors {
            top: separator_area.bottom
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
        clip: true

        Repeater {
            model: tab_model
            Loader {
                property var argument: model.argument
                anchors.fill: parent
                sourceComponent: model.page
                visible: tab_bar.currentIndex === index
                active: visible
            }
        }
    }

    // ── 公开方法 ──────────────────────────────────────
    function createTab(icon, text, page, argument) {
        return { icon: icon || "", text: text, page: page, argument: argument || {} }
    }

    function appendTab(icon, text, page, argument) {
        tab_model.append(createTab(icon, text, page, argument))
    }

    function setTabList(list) {
        tab_model.clear()
        tab_model.append(list)
    }

    function removeTab(index) {
        if (index >= 0 && index < tab_model.count) {
            tab_model.remove(index)
            control.tabClosed(index)
        }
    }
}
