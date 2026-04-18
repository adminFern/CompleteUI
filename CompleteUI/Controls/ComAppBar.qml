import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import CompleteUI
Rectangle {
    id: control
    property Component action
    property bool showClose: true
    property bool showMinimize: true
    property bool showMaximize: true
    property alias buttonClose: btn_close
    property alias buttonMaximized: btn_maximized
    property alias buttonMinimized: btn_minimized
    property string title
    property string winIcon
    implicitHeight: 30
    implicitWidth: parent ? parent.width : 0
    color: "transparent"
    Component{
        id: comp_window_icon
        Image{
            width: 20
            height: 20
            source: control.winIcon
            smooth: true
            mipmap: true
            fillMode: Image.PreserveAspectFit
        }
    }
    Item{
        id: d
        property int buttonWidth : 40
        property bool isRestore: Window.Maximized === Window.visibility || Window.FullScreen === Window.visibility
        function setHitTestVisible(id){
            if(Window.window && Window.window instanceof ComWindow){
                Window.window.setHitTestVisible(id)
            }
        }
    }
    Item{
        anchors.fill: parent
        Row{
            id: layout_title
            spacing: 3
            anchors{
                left: parent.left
                right: layout_win_controls.left
                horizontalCenter: undefined
                top: parent.top
                bottom: parent.bottom
                leftMargin: 10
            }
            Loader{
                id: loader_window_icon
                active: control.winIcon!==""
                visible: active
                sourceComponent: comp_window_icon
                anchors.verticalCenter: parent.verticalCenter
            }
            Label{
                text: control.title
                elide: Qt.ElideRight
                font:Qt.font({family:Theme.defaultFontFamily, pixelSize : 14, weight: Font.Normal/*,letterSpacing:1*/})
                anchors.verticalCenter: parent.verticalCenter
                // 根据主题设置文本颜色
                color: Theme.isDark?"white":"black"
            }

        }
        RowLayout{
            id: layout_win_controls
            spacing: 0
            anchors.right: parent.right
            height: parent.height
           Loader{
                id: loader_action
                Layout.fillHeight: true
                sourceComponent: control.action
            }
            ComIconButton{
                id:btn_minimized
                Layout.preferredWidth:  d.buttonWidth
                Layout.preferredHeight: parent.height
                iconsize: 12
                radius: 0
                visible: showMinimize
                iconsource: FluentIcon.ico_ChromeMinimize
                onClicked: {
                    Window.window.showMinimized()
                }
            }
            ComIconButton{
                property bool hover
                id:btn_maximized
                Layout.preferredWidth: d.buttonWidth
                Layout.preferredHeight: parent.height
                iconsize: 12
                radius: 0
                visible: showMaximize
                iconsource: d.isRestore  ? FluentIcon.ico_ChromeMaximize : FluentIcon.ico_ChromeRestore
                color: {

                    if(btn_maximized.down){
                        return Theme.isDark?Qt.rgba(1,1,1,0.03): Qt.rgba(0,0,0,0.03)
                    }
                    return btn_maximized.hover ? Theme.isDark? Qt.rgba(1,1,1,0.05): Qt.rgba(0,0,0,0.05) : "transparent"
                }
                onClicked: {
                    if(d.isRestore){
                        Window.window.showNormal()
                    }else{
                        Window.window.showMaximized()
                    }
                }
            }
            ComIconButton{
                id:btn_close
                Layout.preferredWidth: d.buttonWidth
                Layout.preferredHeight: parent.height
                iconsize: 12
                radius: 0
                visible: showClose
                iconsource:FluentIcon.ico_ChromeClose
                pressedColor:Qt.rgba(185/255,13/255,28/255,1)
                hoverColor:Qt.rgba(236/255,64/255,79/255,1)
                iconColor:hovered?"white":Theme.isDark?"white":"black"
                onClicked: {
                    Window.window.close()
                }
            }
            Component.onCompleted: {
                d.setHitTestVisible(this)
            }
        }

    }
}
