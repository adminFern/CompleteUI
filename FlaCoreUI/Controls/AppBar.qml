import QtQuick
import QtQuick.Layouts
import FlaCoreUI
// 窗口标题栏组件：包含窗口图标、标题、最小化/最大化/关闭按钮
Rectangle {
    id: control

    property Component action                // 自定义操作区域组件
    property bool fixSize: false
    property bool showClose: true            // 显示关闭按钮
    property bool showMinimize: true         // 显示最小化按钮
    property bool showMaximize: true         // 显示最大化按钮
    property alias buttonClose: btn_close
    property alias buttonMaximized: btn_maximized
    property alias buttonMinimized: btn_minimized
    property string title                    // 窗口标题
    property string icon                  // 窗口图标路径

    implicitHeight: 28
    implicitWidth: parent ? parent.width : 0
    color: "transparent"

    // 窗口图标组件
    Component {
        id: comp_window_icon
        Image {
            width: 20
            height: 20
            source: control.icon
            smooth: true
            mipmap: true
            fillMode: Image.PreserveAspectFit
        }
    }

    // 内部状态
    Item {
        id: d
        property int buttonWidth: 40
        property bool isRestore: Window.Maximized === Window.visibility || Window.FullScreen === Window.visibility

        // 设置窗口控件可点击区域（用于无边框窗口拖拽）
        function setHitTestVisible(id) {
            if (Window.window && Window.window instanceof FlaWindow) {
                Window.window.setHitTestVisible(id)
            }
        }
    }

    Item {
        anchors.fill: parent

        // 标题区域：图标 + 标题文字
        Row {
            id: layout_title
            spacing: 3
            anchors {
                left: parent.left
                right: layout_win_controls.left
                horizontalCenter: undefined
                top: parent.top
                bottom: parent.bottom
                leftMargin: 10
            }

            Loader {
                id: loader_window_icon
                active: control.winIcon !== ""
                visible: active
                sourceComponent: comp_window_icon
                anchors.verticalCenter: parent.verticalCenter
            }

            Text {
                text: control.title
                elide: Qt.ElideRight
                font: Qt.font({ family: Theme.defaultFontFamily, pixelSize: 14, weight: Font.Normal })
                anchors.verticalCenter: parent.verticalCenter
                color: Theme.isDark ? "white" : "black"
            }
        }

        // 窗口控制按钮区域
        RowLayout {
            id: layout_win_controls
            spacing: 0
            anchors.right: parent.right
            height: parent.height

            // 自定义操作区域
            Loader {
                id: loader_action
                Layout.fillHeight: true
                sourceComponent: control.action
            }

            // 最小化按钮
            FlaIconButton {
                id: btn_minimized
                Layout.preferredWidth: d.buttonWidth
                Layout.preferredHeight: parent.height
                iconsize: 12
                radius: 0
                visible: showMinimize
                iconsource: FluentIcon.ico_ChromeMinimize
                onClicked: {
                    Window.window.showMinimized()
                }
            }

            // 最大化/还原按钮
            FlaIconButton {
                property bool hover
                id: btn_maximized
                Layout.preferredWidth: d.buttonWidth
                Layout.preferredHeight: parent.height
                iconsize: 12
                radius: 0
                visible: showMaximize
                enabled: fixSize
                iconsource: d.isRestore ? FluentIcon.ico_ChromeMaximize : FluentIcon.ico_ChromeRestore
                iconColor: !fixSize? "darkgray":"black"
                color: {
                    if (!enabled) {
                        console.log("xxxxxxxxxxx")
                        return Theme.DisabledColor
                    }
                    if (btn_maximized.down) {
                        return Theme.isDark ? Qt.rgba(1, 1, 1, 0.03) : Qt.rgba(0, 0, 0, 0.03)
                    }
                    return btn_maximized.hover && !fixSize? Theme.isDark ? Qt.rgba(1, 1, 1, 0.05) : Qt.rgba(0, 0, 0, 0.05) : "transparent"
                }
                onClicked: {
                    if (d.isRestore) {
                        Window.window.showNormal()
                    } else {
                        Window.window.showMaximized()
                    }
                }
            }

            // 关闭按钮
            FlaIconButton {
                id: btn_close
                Layout.preferredWidth: d.buttonWidth
                Layout.preferredHeight: parent.height
                iconsize: 12
                radius: 0
                visible: showClose
                iconsource: FluentIcon.ico_ChromeClose
                pressedColor: Qt.rgba(185 / 255, 13 / 255, 28 / 255, 1)
                hoverColor: Qt.rgba(236 / 255, 64 / 255, 79 / 255, 1)
                iconColor: hovered ? "white" : Theme.isDark ? "white" : "black"
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
