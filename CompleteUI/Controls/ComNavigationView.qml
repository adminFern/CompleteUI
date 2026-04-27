import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Basic
import CompleteUI

Item {
    id: control
    enum NavViewType {
        Open = 0,
        Compact = 1,
        Minimal = 2,
        Auto = 4
    }

    property Objects items          // 主导航项容器
    property Objects footerItems   // 页脚项容器
    property color primaryColor:Theme.PrimaryColor
    property int displayMode:ComNavigationView.NavViewType.Auto //NavigationViewType.Auto
    property int navCompactWidth: 40
    property int itemHeight: 38
    property int sidebarWidth: 200
    property color textcolor: Theme.Textcolor
    property font textfont:Qt.font({family:Theme.defaultFontFamily,pixelSize : 13, weight: Font.Normal})
    signal itemclicked(string title)

    QtObject{
        id:d
        property int iconsize: control.itemHeight*0.45
        property int displayMode: control.displayMode
        property bool enableNavigationPanel: false
        property string isPage: ""
        // 判断当前是否为 Compact 模式（且未展开）
        property bool isCompactAndNotPanel: d.displayMode
                                            === ComNavigationView.NavViewType.Compact && !d.enableNavigationPanel
        //文本禁止颜色
        property color disabledtextcolor: Theme.isDark?"#9CA3AF":"#6B7280"
        property color disabledcolor: Theme.isDark?"#2A2E37":" #F4F5F7"
        //加载头部，返回一个数组
        function handleItems(){
            var _idx = 0
            var data = []
            //items为链表数组
            if (items){
                for (var i = 0; i < items.children.length; i++){
                    var item = items.children[i]//获取子对象
                    if (item.visible !== true) continue//如果子对象visible假返回这个对象
                    //设置这个对象id序号并且添加数组中
                    item._idx = _idx
                    data.push(item)
                    _idx++
                    // 如果是可展开分组，遍历其子项
                    if (item instanceof PaneItemExpander){
                        for (var j = 0; j < item.children.length; j++){
                            var itemChild = item.children[j]
                            if (itemChild.visible !== true) continue
                            itemChild._parent = item//等于上层的对象为父
                            itemChild._idx = _idx
                            data.push(itemChild)
                            _idx++
                        }
                    }
                }
            }
            return data
        }
        // 仅处理页脚项（用于底部 ListView）
        function handleFooterItems() {
            var data = []
            if (footerItems) {
                for (var i = 0; i < footerItems.children.length; i++) {
                    var item = footerItems.children[i]
                    if (item.visible !== true) continue
                    item._idx = i
                    data.push(item)
                }
            }
            return data
        }
        function go(page){
            if ( d.isPage !== page){
                d.isPage=page
               // console.log("切换",page)
                stack.replace(page)
            }
        }
        // 当 expander 折叠时，如果当前选中项是其子项，则回退选中到 expander 自身
        function collapseCheck(expanderItem){
            if(nav_list.currentIndex < 0) return
            var curData = nav_list.model
            if(nav_list.currentIndex < curData.length){
                var curItem = curData[nav_list.currentIndex]
                if(curItem && curItem._parent === expanderItem){
                    nav_list.currentIndex = expanderItem._idx
                }
            }
        }

    }
    Component.onCompleted: {
        d.displayMode = Qt.binding(function () {
            if (control.displayMode !== ComNavigationView.NavViewType.Auto) {
                return control.displayMode
            }
            if (control.width <= 700) {
                return ComNavigationView.NavViewType.Minimal
            } else if (control.width <= 900) {
                return ComNavigationView.NavViewType.Compact
            } else {
                return ComNavigationView.NavViewType.Open
            }

        })
    }
    Connections{
        target: d
        function onDisplayModeChanged(){
            if(d.displayMode === ComNavigationView.NavViewType.Compact){
                isExpand(false)
            }
            d.enableNavigationPanel = false
        }
    }
    // === 分隔线组件 ===
    Component {
        id: com_panel_item_separator
        Rectangle {
            x:model.xoffset
            anchors.leftMargin: 10
            width: layout_list.width-(model.xoffset*2)
            height: 1
            color:model.dividercolor
        }
    }
    //底部的代理UI
    Component{
        id:com_panel_item_header
        Item{
            height:  control.itemHeight
            width: layout_list.width
            Rectangle{
                anchors.fill: parent
                anchors.margins: 1
                radius: 4
                Row{
                    anchors.fill: parent
                    anchors.leftMargin: 8
                    spacing: 20
                    anchors.verticalCenter: !d.isCompactAndNotPanel ?parent.verticalCenter:undefined
                    anchors.centerIn:d.isCompactAndNotPanel ? parent:undefined
                    Loader{
                        id: header_com_icon
                        active: model && model.icon
                        visible: active
                        sourceComponent: ComImage{
                            iconsource:model && model.icon ? model.icon : ""
                            iconsize:  d.iconsize
                            iconbold: true
                        }
                    }
                    Loader{
                        id: header_com_text
                        active:!d.isCompactAndNotPanel && model && model.title!==""
                        visible: active
                        sourceComponent:Text{
                            text:model.title
                            color:{
                                if(model.disabled){
                                    return Theme.DisabledTextColor
                                }
                                return layout_footer.currentIndex === model._idx?  "white": control.textcolor
                            }
                            elide: Text.ElideRight
                            font: control.textfont
                            verticalAlignment: Text.AlignVCenter  // 垂直居中
                            horizontalAlignment: Text.AlignHCenter // 水平居中（可选）
                        }
                    }
                }
                //选中颜色
                color: {
                    if (headerMouse.pressed){
                        return Theme.setColorAlpha(Theme.isDark? Qt.darker(control.primaryColor,1.5):
                                                                 Qt.lighter(control.primaryColor,1.5)  ,150)
                    }
                    if (headerMouse.containsMouse){
                        return Theme.setColorAlpha(Theme.isDark? Qt.darker(control.primaryColor,1.2):
                                                                 Qt.lighter(control.primaryColor,1.2)  ,100)
                    }
                    if (layout_footer.currentIndex === model._idx) return Theme.setColorAlpha(control.primaryColor,200)
                    return "transparent"
                }
                Behavior on color { ColorAnimation { duration: 200 }}
                MouseArea{
                    id:headerMouse
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onPressedChanged: {
                        headerMouse.forceActiveFocus()
                    }
                    onClicked: {
                        layout_footer.currentIndex = model._idx    //  nav_list.currentIndex
                        nav_list.currentIndex = -1
                        control.itemclicked(model.title)
                    }
                }
            }
        }
    }
    //普通导航
    Component{
        id: com_panel_item
        Item{
            height:{
                if (model && model._parent) return model._parent.isExpand ? control.itemHeight : 0
                return control.itemHeight
            }
            visible: height === control.itemHeight  //如果高度不等于0
            opacity: visible
            width: layout_list.width
            Behavior on height {
                NumberAnimation {
                    duration: 250
                    easing.type: Easing.OutCubic
                }
            }

            Behavior on opacity {
                NumberAnimation {
                    duration: 200
                    easing.type: Easing.OutCubic
                }
            }


            //绘制背景
            Rectangle{
                id: item_panel
                enabled: !model.disabled
                anchors.fill: parent
                anchors.leftMargin: model._parent !== undefined ? 15 : 1
                anchors.rightMargin: 1
                anchors.topMargin: 1
                anchors.bottomMargin: 1
                radius: 4
                color: {
                    if (!item_panel.enabled) return Theme.DisabledColor //禁止颜色
                    if (nav_list.currentIndex === model._idx) return Theme.setColorAlpha(control.primaryColor,200) //选中颜色

                    if (item_mouse.containsMouse){
                        return Theme.setColorAlpha(Theme.isDark? Qt.darker(control.primaryColor,1.2):
                                                                 Qt.lighter(control.primaryColor,1.2)  ,100)
                    }
                    return "transparent"
                }
                Behavior on color { ColorAnimation { duration: 200 } }

                Loader{
                    id: com_icon
                    anchors.left: parent.left
                    anchors.leftMargin: {
                        if(model._parent!==undefined) return 16
                        if(!d.isCompactAndNotPanel) return 8
                        return undefined
                    }
                    anchors.verticalCenter: !d.isCompactAndNotPanel ?parent.verticalCenter:undefined
                    anchors.centerIn:d.isCompactAndNotPanel ? parent:undefined
                    active: model && model.icon
                    visible: active
                    sourceComponent: ComImage{
                        iconsource:model && model.icon ? model.icon : ""
                        iconsize: d.iconsize
                        iconbold: true
                        icocolor: {
                            if (!item_panel.enabled) return Theme.DisabledTextColor //禁止颜色
                            return  nav_list.currentIndex === model._idx?  "white": control.textcolor
                        }
                    }
                }
                Loader{
                    id: com_text
                    anchors.left: com_icon.right
                    anchors.leftMargin:10
                    anchors.verticalCenter: parent.verticalCenter
                    active:  !d.isCompactAndNotPanel && model && model.title!==""
                    sourceComponent:Text{
                        text:model.title
                        color:{
                            if (!item_panel.enabled) return Theme.DisabledTextColor //禁止颜色
                            return  nav_list.currentIndex === model._idx?  "white": control.textcolor
                        }
                        elide: Text.ElideRight
                        font: control.textfont
                        verticalAlignment: Text.AlignVCenter  // 垂直居中
                        horizontalAlignment: Text.AlignHCenter // 水平居中（可选）
                    }
                }
                //事件
                MouseArea{
                    id:item_mouse
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onClicked: {
                        nav_list.currentIndex = model._idx
                        layout_footer.currentIndex = -1
                        control.itemclicked(model.title)
                        if(model.page){
                           // console.log(model.page,model.title)
                          d.go(model.page)
                            //stack.push(model.page)
                        }
                    }
                }
            }
        }
    }
    //子节点展开代理

    Component{
        id: com_panel_item_expander
        Item{
            height: control.itemHeight
            width: layout_list.width
            Rectangle{
                id: item_expander
                enabled: !model.disabled
                anchors.fill: parent
                anchors.margins:1
                radius: 4
                color: {
                    if (!item_expander.enabled) return  Theme.DisabledColor
                    if (nav_list.currentIndex === model._idx) return Theme.setColorAlpha(control.primaryColor,200)
                    if (item_expander_mouse.containsMouse){
                        return Theme.setColorAlpha(Theme.isDark? Qt.darker(control.primaryColor,1.2):
                                                             Qt.lighter(control.primaryColor,1.2)  ,100)
                    }
                    return "transparent"
                }
                Behavior on color { ColorAnimation { duration: 200 } }
                Loader{
                    id: expander_com_icon
                    anchors.left: parent.left
                    anchors.leftMargin: !d.isCompactAndNotPanel ? 8: undefined
                    anchors.verticalCenter: !d.isCompactAndNotPanel ?parent.verticalCenter:undefined
                    anchors.centerIn:d.isCompactAndNotPanel ? parent:undefined
                    active: model && model.icon
                    visible: active
                    sourceComponent: ComImage{
                        iconsource:model && model.icon ? model.icon : ""
                        iconsize: d.iconsize
                        iconbold: true
                    }
                }
                Loader{
                    id: expander_com_text
                    anchors.left: expander_com_icon.right
                    anchors.leftMargin: 10
                    anchors.verticalCenter: parent.verticalCenter
                    active:  !d.isCompactAndNotPanel && model && model.title!==""
                    sourceComponent:Text{
                        text:model.title
                        color:{
                            if (!item_expander.enabled) return Theme.DisabledTextColor//Theme.disabledText //禁止颜色
                            return  nav_list.currentIndex === model._idx?  "white":control.textcolor //Theme.TextColor
                        }
                        elide: Text.ElideRight
                        font: control.textfont
                        verticalAlignment: Text.AlignVCenter  // 垂直居中
                        horizontalAlignment: Text.AlignHCenter // 水平居中（可选）

                    }
                }
                ComImage{
                    id: item_icon_expand
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right
                    anchors.rightMargin: 10
                    rotation: model && model.isExpand ? 0 : 180
                    iconsource:FluentIcon.ico_ChevronDown
                    iconsize: 15
                    visible: !d.isCompactAndNotPanel
                    icocolor:{
                        if (!item_expander.enabled) return d.disabledtextcolor//.DisabledText //禁止颜色
                        return control.textcolor
                    }
                    Behavior on rotation {
                        NumberAnimation { duration: 200; easing.type: Easing.OutCubic }
                    }

                }

                MouseArea{
                    id:item_expander_mouse
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onClicked:{
                        if(d.isCompactAndNotPanel && model.children.length > 0){
                            let h = 38*Math.min(Math.max(model.children.length,1),8)
                            let y = mapToItem(control,0,0).y
                            if(h+y>control.height){
                                y = control.height - h
                            }
                            //control_popup.showPopup(Qt.point(control.navCompactWidth,y),h,model.children)
                            return
                        }

                        nav_list.currentIndex = model._idx
                        layout_footer.currentIndex = -1
                        if(!d.isCompactAndNotPanel){
                            var wasExpand = model.isExpand
                            model.isExpand = !model.isExpand
                            // 折叠时：如果当前选中子项属于此 expander，回退选中到 expander
                            if(wasExpand){
                                d.collapseCheck(model)
                            }
                        }
                        control.itemclicked(model.title)
                    }
                }
            }
        }
    }




    //内容区域
    Item {
        id: layout_list
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.leftMargin: d.displayMode === ComNavigationView.NavViewType.Minimal && !d.enableNavigationPanel ? -width : 0
        // 宽度动画：Compact/Open 模式切换
        width: d.displayMode === ComNavigationView.NavViewType.Compact && !d.enableNavigationPanel
               ? control.navCompactWidth
               : (d.displayMode === ComNavigationView.NavViewType.Minimal ? 0 : control.sidebarWidth)
        visible: width > 0
        // 宽度变化动画
        Behavior on width { NumberAnimation { duration: 250 } }
        // Minimal 模式滑入滑出动画
        Behavior on anchors.leftMargin { NumberAnimation { duration: 250 } }
        ColumnLayout{
            anchors.fill: parent
            anchors.margins: 0
            spacing: 0
            // 主导航列表 - 填充剩余空间
            Item{
                Layout.fillWidth: true
                Layout.fillHeight: true
                clip: true

                ListView{
                    id: nav_list
                    anchors.fill: parent
                    boundsBehavior: Flickable.StopAtBounds
                    clip: true
                    model: d.handleItems()//添加列表数据
                    reuseItems: true
                    interactive: false
                    cacheBuffer: control.itemHeight * 2
                    currentIndex: -1
                    spacing:0
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

                // 导航指示器（使用封装的 ComNavIndicator 组件）
                ComNavIndicator {
                    targetListView: nav_list
                    indicatorColor: control.primaryColor
                    highlightSize: 20
                    indicatorX: 4
                }
            }
            // 页脚列表区域 - 高度自适应内容
            ListView {
                id: layout_footer
                Layout.fillWidth: true
                Layout.preferredHeight: childrenRect.height
                model: d.handleFooterItems()
                currentIndex: -1
                reuseItems: true
                interactive: false
                spacing:0
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
    }//Item {

    // === 内容区：StackView放在layout_list外部 ===
    StackView{
        id: stack
        anchors.left: layout_list.right
        anchors.leftMargin: 1
        anchors.right: control.right
        anchors.top: control.top
        anchors.bottom: control.bottom
        clip: true
    }

    function isExpand(isexpand){
        for(var i=0;i<nav_list.model.length;i++){
            var item = nav_list.model[i]
            if(item instanceof PaneItemExpander){
                item.isExpand = isexpand
            }
        }
    }

}


