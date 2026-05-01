import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import FlaCoreUI

// 导航视图组件：支持三种显示模式（Open/Compact/Minimal）
// 使用 items 和 footerItems 属性配置导航项
Item {
    id: control

    enum NavViewType {
        Open = 0,
        Compact = 1,
        Minimal = 2,
        Auto = 4
    }

    property Objects items
    property Objects footerItems
    property color primaryColor: Theme.PrimaryColor
    property int displayMode: FlaNavigationView.NavViewType.Auto
    property int navCompactWidth: 40
    property int itemHeight: 38
    property int sidebarWidth: 200
    property color textcolor: Theme.Textcolor
    property font textfont: Qt.font({ family: Theme.defaultFontFamily, pixelSize: 13, weight: Font.Normal })
    property color hoverColor: Theme.isDark ? Qt.rgba(1, 1, 1, 0.05) : Qt.rgba(0, 0, 0, 0.05)
    property color selectedColor: Theme.setColorAlpha(Theme.PrimaryColor, 100)

    signal itemclicked(string title)

    QtObject {
        id: d

        property int iconsize: control.itemHeight * 0.45
        property int displayMode: control.displayMode
        property bool enableNavigationPanel: false
        property string isPage: ""
        property bool isCompactAndNotPanel: d.displayMode
                                            === FlaNavigationView.NavViewType.Compact && !d.enableNavigationPanel

        property var _itemsCache: []
        property var _footerCache: []

        // 通用遍历函数：收集可见子项
        function collectVisible(container, processChildren) {
            var data = [], idx = 0
            if (!container) return data
            for (var i = 0; i < container.children.length; i++) {
                var item = container.children[i]
                if (item.visible !== true) continue
                item._idx = idx++
                data.push(item)
                if (processChildren) idx = processChildren(item, data, idx)
            }
            return data
        }

        // 刷新主导航列表缓存
        function refreshItems() {
            _itemsCache = collectVisible(items, function(expander, data, idx) {
                if (!(expander instanceof PaneItemExpander)) return idx
                for (var j = 0; j < expander.children.length; j++) {
                    var child = expander.children[j]
                    if (child.visible !== true) continue
                    child._parent = expander
                    child._idx = idx++
                    data.push(child)
                }
                return idx
            })
        }

        // 刷新页脚列表缓存
        function refreshFooterItems() {
            _footerCache = collectVisible(footerItems, null)
        }

        function go(page) {
            if (d.isPage !== page) {
                d.isPage = page
                stack.replace(page)
            }
        }

        // 折叠时：如果当前选中项属于此 expander，回退选中到 expander 自身
        function collapseCheck(expanderItem) {
            if (nav_list.currentIndex < 0) return
            var curData = nav_list.model
            if (nav_list.currentIndex < curData.length) {
                var curItem = curData[nav_list.currentIndex]
                if (curItem && curItem._parent === expanderItem)
                    nav_list.currentIndex = expanderItem._idx
            }
        }
    }

    Component.onCompleted: {
        d.displayMode = Qt.binding(function () {
            if (control.displayMode !== FlaNavigationView.NavViewType.Auto)
                return control.displayMode
            if (control.width <= 700) return FlaNavigationView.NavViewType.Minimal
            if (control.width <= 900) return FlaNavigationView.NavViewType.Compact
            return FlaNavigationView.NavViewType.Open
        })
        d.refreshItems()
        d.refreshFooterItems()
    }

    Connections {
        target: d
        function onDisplayModeChanged() {
            if (d.displayMode === FlaNavigationView.NavViewType.Compact)
                isExpand(false)
            d.enableNavigationPanel = false
            control_popup.close()
        }
    }

    // === 分隔线组件 ===
    Component {
        id: com_panel_item_separator
        Rectangle {
            x: model.xoffset
            anchors.leftMargin: 10
            width: layout_list.width - (model.xoffset * 2)
            height: 1
            color: model.dividercolor
        }
    }

    // 页脚项委托
    Component {
        id: com_panel_item_header
        FlaNavItemBase {
            itemModel: model
            width: layout_list.width
            isSelected: layout_footer.currentIndex === itemModel._idx
            isCompactMode: d.isCompactAndNotPanel
            itemHeight: control.itemHeight
            iconSize: d.iconsize
            leftMargin: navIndicator.indicatorX + navIndicator.width
            textFont: control.textfont
            primaryColor: control.primaryColor
            textColor: control.textcolor
            selectedBgColor: control.selectedColor
            hoverBgColor: control.hoverColor
            enablePressedState: true
            onClicked: {
                layout_footer.currentIndex = itemModel._idx
                nav_list.currentIndex = -1
                control.itemclicked(itemModel.title)
            }
        }
    }

    // 普通导航项委托
    Component {
        id: com_panel_item
        FlaNavItemBase {
            itemModel: model
            width: layout_list.width
            isSelected: nav_list.currentIndex === itemModel._idx
            isChildItem: itemModel._parent !== undefined
            isCompactMode: d.isCompactAndNotPanel
            itemHeight: (itemModel && itemModel._parent && !itemModel._parent.isExpand) ? 0 : control.itemHeight
            visible: itemHeight > 0
            opacity: Math.min(1, itemHeight / control.itemHeight * 2)
            iconSize: d.iconsize
            leftMargin: itemModel._parent !== undefined
                ? navIndicator.indicatorX + navIndicator.width + navIndicator.levelIndent
                : navIndicator.indicatorX + navIndicator.width
            textFont: control.textfont
            primaryColor: control.primaryColor
            textColor: control.textcolor
            selectedBgColor: control.selectedColor
            hoverBgColor: control.hoverColor
            Behavior on itemHeight {
                NumberAnimation { duration: 250; easing.type: Easing.OutCubic }
            }
            onClicked: {
                nav_list.currentIndex = itemModel._idx
                layout_footer.currentIndex = -1
                control.itemclicked(itemModel.title)
                if (itemModel.page) d.go(itemModel.page)
            }
        }
    }

    // 可展开分组项委托
    Component {
        id: com_panel_item_expander
        FlaNavItemBase {
            itemModel: model
            width: layout_list.width
            isSelected: nav_list.currentIndex === itemModel._idx
            isCompactMode: d.isCompactAndNotPanel
            showExpandArrow: true
            itemHeight: control.itemHeight
            iconSize: d.iconsize
            leftMargin: navIndicator.indicatorX + navIndicator.width
            textFont: control.textfont
            primaryColor: control.primaryColor
            textColor: control.textcolor
            selectedBgColor: control.selectedColor
            hoverBgColor: control.hoverColor
            onClicked: {
                if (d.isCompactAndNotPanel && itemModel.children.length > 0) {
                    nav_list.currentIndex = itemModel._idx
                    var h = control.itemHeight * Math.min(Math.max(itemModel.children.length, 1), 8)
                    var p = mapToItem(control, 0, 0)
                    var y = p.y
                    if (h + y > control.height) y = control.height - h
                    control_popup.showPopup(Qt.point(control.navCompactWidth, y), h, itemModel.children)
                    return
                }
                nav_list.currentIndex = itemModel._idx
                layout_footer.currentIndex = -1
                if (!d.isCompactAndNotPanel) {
                    var wasExpand = itemModel.isExpand
                    itemModel.isExpand = !itemModel.isExpand
                    if (wasExpand) d.collapseCheck(itemModel)
                }
                control.itemclicked(itemModel.title)
            }
        }
    }

    // Compact 模式弹出菜单：显示 expander 子项列表
    Popup {
        id: control_popup
        property var childModel
        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside
        padding: 2

        enter: Transition {
            NumberAnimation {
                property: "scale"; from: 0.8; to: 1.0
                duration: 200; easing.type: Easing.OutBack
            }
        }
        exit: Transition {
            NumberAnimation {
                property: "scale"; from: 1.0; to: 0.8
                duration: 200; easing.type: Easing.InBack
            }
        }

        background: Rectangle {
            implicitWidth: 130
            color: Theme.FillBackgroundColor
            border.color: Theme.FillBorderColor
            border.width: 1
            radius: 5
        }

        contentItem: ListView {
            model: control_popup.childModel
            currentIndex: -1
            reuseItems: true
            clip: true
            cacheBuffer: control.itemHeight * 2
            delegate: Item {
                id: popup_item
                width: parent.width
                height: 38
                Rectangle {
                    anchors.fill: parent
                    anchors.margins: 2
                    radius: 5
                    color: {
                        if (popup_mouse.containsMouse && nav_list.currentIndex !== model._idx)
                            return Theme.setColorAlpha(Theme.isDark ? Qt.darker(control.primaryColor, 1.2)
                                                                      : Qt.lighter(control.primaryColor, 1.2), 100)
                        if (nav_list.currentIndex === model._idx)
                            return Theme.setColorAlpha(control.primaryColor, 200)
                        return "transparent"
                    }
                    Behavior on color { ColorAnimation { duration: 150 } }
                    Row {
                        anchors.fill: parent
                        anchors.leftMargin: 10
                        anchors.rightMargin: 10
                        spacing: 10
                        FlaImage {
                            anchors.verticalCenter: parent.verticalCenter
                            iconsource: model && model.icon ? model.icon : ""
                            iconsize: d.iconsize
                            iconbold: true
                        }
                        Text {
                            anchors.verticalCenter: parent.verticalCenter
                            text: model.title
                            color: nav_list.currentIndex === model._idx ? "white" : control.textcolor
                            elide: Text.ElideRight
                            font: control.textfont
                            verticalAlignment: Text.AlignVCenter
                        }
                    }
                    MouseArea {
                        id: popup_mouse
                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            if (model.page) d.go(model.page)
                            control_popup.close()
                        }
                    }
                }
            }
        }

        function showPopup(pos, height, model) {
            background.implicitHeight = height
            control_popup.x = pos.x + 4
            control_popup.y = pos.y
            control_popup.childModel = model
            control_popup.open()
        }
    }

    // 侧边栏区域
    Item {
        id: layout_list
        property real indicatorRightX: navIndicator.x + navIndicator.width
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.leftMargin: d.displayMode === FlaNavigationView.NavViewType.Minimal && !d.enableNavigationPanel ? -width : 0
        width: d.enableNavigationPanel
               ? control.sidebarWidth
               : (d.displayMode === FlaNavigationView.NavViewType.Compact
                  ? control.navCompactWidth
                  : (d.displayMode === FlaNavigationView.NavViewType.Minimal ? 0 : control.sidebarWidth))
        visible: width > 0
        Behavior on width {
            NumberAnimation {
                id: widthAnim
                duration: 250
                onFinished: {
                    if (width > 0 && nav_list.currentIndex >= 0) {
                        navIndicator.topPos = navIndicator.targetTop
                        navIndicator.bottomPos = navIndicator.targetBottom
                    }
                }
            }
        }
        Behavior on anchors.leftMargin { NumberAnimation { duration: 250 } }
        onWidthChanged: {
            if (width > 0) {
                navIndicator.lastIndex = -1
            }
        }
        onVisibleChanged: {
            if (!visible) {
                navIndicator.topPos = 0
                navIndicator.bottomPos = navIndicator.highlightSize
                navIndicator.lastIndex = -1
                navIndicator.state = "normal"
            }
        }

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 0
            spacing: 0

            // 主导航列表
            Item {
                Layout.fillWidth: true
                Layout.fillHeight: true
                clip: true

                ListView {
                    id: nav_list
                    anchors.fill: parent
                    boundsBehavior: Flickable.StopAtBounds
                    clip: true
                    model: d._itemsCache
                    reuseItems: true
                    interactive: false
                    cacheBuffer: control.itemHeight * 2
                    currentIndex: -1
                    spacing: 0
                    delegate: Loader {
                        property var model: modelData
                        property var _idx: index
                        property int type: 0
                        sourceComponent: {
                            if (!model) return undefined
                            if (model instanceof PaneItem) return com_panel_item
                            if (model instanceof PaneItemSeparator) return com_panel_item_separator
                            if (model instanceof PaneItemExpander) return com_panel_item_expander
                            return undefined
                        }
                    }
                }

                // 导航指示器
                Rectangle {
                    id: navIndicator
                    property var targetListView: nav_list
                    property color indicatorColor: control.primaryColor
                    property int highlightSize: 20
                    property int indicatorX: 0
                    property int levelIndent: 14

                    property real topPos: 0
                    property real bottomPos: highlightSize
                    property real oldTopPos: 0
                    property int lastIndex: -1

                    property int itemDepth: {
                        if (!targetListView || targetListView.currentIndex < 0) return 0
                        var m = targetListView.model
                        if (!m || targetListView.currentIndex >= m.length) return 0
                        return getItemDepth(m[targetListView.currentIndex])
                    }

                    property real targetTop: {
                        if (!targetListView || targetListView.currentIndex < 0) return 0
                        if (targetListView.currentItem)
                            return targetListView.currentItem.y - targetListView.contentY
                                    + (targetListView.currentItem.height - highlightSize) / 2
                        return targetListView.currentIndex * control.itemHeight + (control.itemHeight - highlightSize) / 2
                    }
                    property real targetBottom: {
                        if (!targetListView || targetListView.currentIndex < 0) return highlightSize
                        if (targetListView.currentItem)
                            return targetListView.currentItem.y - targetListView.contentY
                                    + (targetListView.currentItem.height + highlightSize) / 2
                        return targetListView.currentIndex * control.itemHeight + (control.itemHeight + highlightSize) / 2
                    }

                    z: 1
                    width: 3
                    radius: 1.5
                    color: indicatorColor
                    x: indicatorX + (itemDepth * levelIndent)
                    y: topPos
                    height: bottomPos - topPos
                    visible: layout_list.visible && targetListView && targetListView.currentIndex >= 0 && d.displayMode === FlaNavigationView.NavViewType.Open

                    state: "normal"

                    function getItemDepth(item) {
                        if (!item || item._parent === undefined) return 0
                        return 1 + getItemDepth(item._parent)
                    }

                    Connections {
                        target: nav_list
                        function onCurrentIndexChanged() {
                            if (nav_list.currentIndex < 0) return
                            var dir = nav_list.currentIndex - navIndicator.lastIndex
                            if (dir > 0 && navIndicator.lastIndex >= 0 && !trans_enter.running) {
                                navIndicator.oldTopPos = navIndicator.topPos
                                navIndicator.state = "startEnter"
                                navIndicator.state = "normal"
                            } else if (dir < 0 && navIndicator.lastIndex >= 0 && !trans_enter.running) {
                                navIndicator.oldTopPos = navIndicator.topPos
                                navIndicator.state = "endEnter"
                                navIndicator.state = "normal"
                            } else {
                                navIndicator.state = "normal"
                            }
                            navIndicator.lastIndex = nav_list.currentIndex
                        }
                    }

                    states: [
                        State {
                            name: "endEnter"
                            PropertyChanges {
                                target: navIndicator
                                topPos: navIndicator.targetTop
                                bottomPos: navIndicator.oldTopPos + navIndicator.highlightSize
                            }
                        },
                        State {
                            name: "startEnter"
                            PropertyChanges {
                                target: navIndicator
                                topPos: navIndicator.oldTopPos
                                bottomPos: navIndicator.targetBottom
                            }
                        },
                        State {
                            name: "normal"
                            PropertyChanges {
                                target: navIndicator
                                topPos: navIndicator.targetTop
                                bottomPos: navIndicator.targetBottom
                            }
                        }
                    ]

                    transitions: [
                        Transition {
                            id: trans_enter
                            to: "normal"
                            SequentialAnimation {
                                PauseAnimation { duration: 80 }
                                PropertyAnimation {
                                    target: navIndicator
                                    properties: "topPos,bottomPos"
                                    duration: 200
                                    easing.type: Easing.OutCubic
                                }
                            }
                        }
                    ]

                    Behavior on topPos {
                        enabled: !trans_enter.running
                        NumberAnimation { duration: 250; easing.type: Easing.OutCubic }
                    }
                    Behavior on bottomPos {
                        enabled: !trans_enter.running
                        NumberAnimation { duration: 250; easing.type: Easing.OutCubic }
                    }
                }
            }

            // 页脚列表区域
            ListView {
                id: layout_footer
                Layout.fillWidth: true
                Layout.preferredHeight: childrenRect.height
                model: d._footerCache
                currentIndex: -1
                reuseItems: true
                interactive: false
                spacing: 0
                delegate: Loader {
                    property var model: modelData
                    property var _idx: index
                    property int type: 1
                    sourceComponent: {
                        if (model instanceof PaneItemHeader) return com_panel_item_header
                        if (model instanceof PaneItemSeparator) return com_panel_item_separator
                        return undefined
                    }
                }
            }
        }
    }

    // 内容区域
    StackView {
        id: stack
        anchors.left: layout_list.right
        anchors.leftMargin: 1
        anchors.right: control.right
        anchors.top: control.top
        anchors.bottom: control.bottom
        clip: true
    }

    // 展开/折叠所有分组
    function isExpand(isexpand) {
        var model = nav_list.model
        for (var i = 0; i < model.length; i++) {
            var item = model[i]
            if (item instanceof PaneItemExpander)
                item.isExpand = isexpand
        }
    }
}
