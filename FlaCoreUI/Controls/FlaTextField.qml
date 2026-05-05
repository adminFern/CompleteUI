import QtQuick
import QtQuick.Controls.impl
import QtQuick.Templates as T
import QtQuick.Controls
import FlaCoreUI

T.TextField {
    id: control
    font: Qt.font({ family: Theme.defaultFontFamily, pixelSize: 14, weight: Font.Normal })
    readonly property bool active: hovered || activeFocus
    property int radius:4
    property string ico:""
    property color primarycolor:Theme.PrimaryColor
    property color cursorcolor: primarycolor
    property int display: DisplayType.TextBesideIcon
    property bool enabledMenu: true
    property int maxLength: -1
    property int inputType:InputType.Text
    color:{

        if(!enabled){
            return Theme.DisabledTextColor
        }
         return Theme.Textcolor
    }

    renderType: TextInput.QtRendering
    hoverEnabled :enabled
    padding: 4
    clip: true
    leftPadding: padding+ loader_leading.width + loader_leading.anchors.leftMargin
    rightPadding: padding + loader_trailing.width + loader_trailing.anchors.rightMargin
    implicitWidth: implicitBackgroundWidth + leftInset + rightInset
                   || Math.max(contentWidth, placeholder.implicitWidth) + leftPadding + rightPadding
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             contentHeight + topPadding + bottomPadding,
                             placeholder.implicitHeight + topPadding + bottomPadding)

    signal indicatorClicked

    Component{
        id:_Menu
        Menu{
            id: contextMenu
            width: 85
            background: Rectangle{
                anchors.fill: parent
                radius: 4
                color: Theme.isDark? Qt.rgba(0.18,0.18,0.18,0.95):Qt.rgba(0.98,0.98,0.98,0.95)
                border.width: 1
                border.color: Theme.ButtonNormalColor
                Shadow{
                    radius: 6
                }
            }
            MenuItem {
                padding: 0
                text: "复制"
                onTriggered: control.copy()
                contentItem: FlaIconLabel {
                    spacing: 8
                    text: parent.text
                    display: DisplayType.TextBesideIcon
                    iconsource: "\ue8c8"
                    iconsize: 18
                    icocolor: {
                        if(!enabled){
                            return Theme.DisabledTextColor
                        }
                        return Theme.Textcolor
                    }
                }
                background: Rectangle {
                    color: parent.highlighted ? Theme.setColorAlpha(primarycolor,150) : "transparent"
                    radius: 4
                }
                enabled:control.selectedText.length > 0
            }
            MenuItem {
                padding: 0
                text: "粘贴"
                onTriggered:  control.paste()
                contentItem: FlaIconLabel {
                    spacing: 8
                    text: parent.text
                    display:  DisplayType.TextBesideIcon
                    iconsource:  "\uf000"
                    iconsize: 18
                    icocolor: {
                        if(!enabled){
                            return Theme.DisabledTextColor
                        }
                        return Theme.Textcolor
                    }

                }
                background: Rectangle {
                    color: parent.highlighted ? Theme.setColorAlpha(primarycolor,150) : "transparent"
                    radius: 4
                }
            }
            MenuItem {
                padding: 0
                text: "剪切"
                onTriggered:control.cut()
                contentItem: FlaIconLabel {
                    spacing: 8
                    text: parent.text
                    display: DisplayType.TextBesideIcon
                    iconsource:  "\ue8c6"
                    iconsize: 18
                    icocolor: {
                        if(!enabled){
                            return Theme.DisabledTextColor
                        }
                        return Theme.TextColor
                    }
                }
                background: Rectangle {
                    color: parent.highlighted ? Theme.setColorAlpha(primarycolor,150) : "transparent"
                    radius: 4
                }

                enabled:control.selectedText.length > 0
            }
            MenuSeparator {}
            MenuItem {
                padding: 0
                text: "清空"
                onTriggered:control.clear()
                contentItem: FlaIconLabel {
                    spacing: 8
                    text: parent.text
                    display: DisplayType.TextBesideIcon
                    iconsource:  "\ued62"
                    iconsize: 18
                    icocolor: {
                        if(!enabled){
                            return Theme.DisabledTextColor
                        }
                        return Theme.TextColor
                    }
                }
                background: Rectangle {

                    color: parent.highlighted ? Theme.setColorAlpha(primarycolor,150) : "transparent"
                    radius: 4
                }
                enabled: control.text !== ""
            }
        }
    }

    Component{
        id:comp_icon
        FlaIconButton{
            iconsource: control.ico
            iconsize: control.height*0.6
            iconbold:true
            handCursor: true
            enabled: control.enabled
            onClicked: {
              control.indicatorClicked()

            }

        }
    }
    selectionColor: Theme.setColorAlpha(control.primarycolor,200)    // 高亮背景色
    selectedTextColor: "white"      // 高亮文字色
    cursorVisible: true
    //focus: true
    cursorDelegate:Rectangle {
        id: cursorRect
        width: 1                        // 光标粗细
        radius: 1
        height: control.cursorRectangle.height
        color: control.cursorcolor          // 光标颜色
        visible: control.active
        // 一亮一灭循环
        SequentialAnimation {
            loops: Animation.Infinite
            running: control.active   // 有焦点才闪
            PauseAnimation { duration: 700 }   // 灭 500 ms
            PropertyAction { target: cursorRect; property: "visible"; value: true }
            PauseAnimation { duration: 700 }   // 亮 500 ms
            PropertyAction { target: cursorRect; property: "visible"; value: false }
        }
    }
    
    PlaceholderText {
        id: placeholder
        x: control.leftPadding
        y: control.topPadding
        width: control.width - (control.leftPadding + control.rightPadding)
        height: control.height - (control.topPadding + control.bottomPadding)
        text: control.placeholderText
        font: control.font
        color: control.placeholderTextColor
        verticalAlignment: control.verticalAlignment
        visible: !control.length && !control.preeditText && (!control.activeFocus || control.horizontalAlignment !== Qt.AlignHCenter)
        elide: Text.ElideRight
        renderType: control.renderType
    }
    
    background:Rectangle{
        implicitWidth: 120
        id:bgk_
        color:{
            if(!enabled) return Theme.DisabledColor
            return Theme.FillBackgroundColor
        }
        border.color: {
            if(!enabled) return Theme.DisabledBorderColor
            if(control.active) return Theme.ButtonHoverColor
            return Theme.ButtonNormalColor
        }
        border.width: 1
        radius: control.radius
    }
    
    Loader{
        id: loader_leading
        active: ico!=="" && control.display===DisplayType.TextBesideIcon
        visible: loader_leading.active
        sourceComponent: comp_icon
        anchors{
            verticalCenter: parent.verticalCenter
            left:  parent.left
            leftMargin:control.ico!=""?4:0
        }
    }
    
    Loader{
        id: loader_trailing
        active: ico!=="" && control.display===DisplayType.TextBesideIcon
        visible: loader_trailing.active
        sourceComponent: comp_icon
        anchors{
            verticalCenter: parent.verticalCenter
            right:  parent.right
            rightMargin:control.ico!=""?4:0
        }
    }

    Loader{
        id: menuLoader
        active:control.enabledMenu
        visible: active
        sourceComponent:_Menu
    }
    TapHandler{
        acceptedButtons: Qt.RightButton
        enabled: !(control.echoMode === TextInput.Password || control.echoMode === TextInput.PasswordEchoOnEdit)
        onTapped: {
            if(control.enabledMenu){
                menuLoader.item.popup()
            }
        }
    }
    
    

    // 添加输入验证逻辑
    onTextEdited: {
        // 长度验证
        if (maxLength > 0 && text.length > maxLength) {
            // 截断超出长度的部分
            text = text.substring(0, maxLength)
            return
        }
        // 类型验证
        _validateInput()
    }
    
    // 输入验证函数
    function _validateInput() {
        var originalText = text
        switch(inputType) {
            case InputType.Number:
                // 只允许数字
                text = text.replace(/[^0-9]/g, '')
                break
            case InputType.Decimal:
                // 只允许数字和小数点，且只能有一个小数点
                text = text.replace(/[^0-9.]/g, '')
                // 确保小数点不重复
                var dotIndex = text.indexOf('.')
                if (dotIndex !== -1) {
                    text = text.substring(0, dotIndex + 1) + text.substring(dotIndex + 1).replace(/\./g, '')
                }
                break
            case InputType.Letters:
                // 只允许英文字母（不区分大小写）
                text = text.replace(/[^a-zA-Z]/g, '')
                break
            default:
                // Text类型和其他类型不做特殊处理
                break
        }
    }
}
