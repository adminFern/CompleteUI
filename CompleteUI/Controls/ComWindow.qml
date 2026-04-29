import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import CompleteUI

// 窗口组件：集成标题栏、无边框窗口特效、StackView 页面容器
Window {
    id: control

    property string initialItem          // 初始加载页面
    property string winIcon              // 窗口图标
    property bool topmost: false         // 置顶
    property bool fixSize: false         // 固定尺寸（禁用最大化）
    property int margins: 0              // 内边距

    color: "transparent"

    // 窗口标题栏
    property ComAppBar appBar: ComAppBar {
        showMaximize: !control.fixSize
        title: control.title
        winIcon: control.winIcon
    }

    Component.onCompleted: {
        if (appBar && Number(appBar.width) === 0) {
            appBar.width = Qt.binding(function () { return control.width })
        }
    }

    Component.onDestruction: {
        frameless.onDestruction()
    }

    // 背景矩形
    Rectangle {
        z: 0
        anchors.fill: parent
        color: Theme.backgroundColor
    }

    // 无边框窗口处理器（DWM 特效、拖拽缩放）
    Frameless {
        id: frameless
        appbar: control.appBar
        maximizeButton: appBar.buttonMaximized
        isDarkMode: Theme.isDark
        topmost: topmost
        fixSize: fixSize
        effect: Theme.SpecialEffect
    }

    // 内容容器
    Item {
        id: layout_container
        anchors.fill: parent

        // 页面加载器
        Loader {
            id: loader_container
            anchors.margins: control.margins
            anchors {
                fill: parent
                topMargin: layout_appbar.height
            }
            source: {
                if (control.initialItem) {
                    return control.initialItem
                }
                return ""
            }
        }

        // 标题栏区域
        Item {
            id: layout_appbar
            data: [appBar]
            width: parent.width
            height: childrenRect.height
            visible: !frameless.disabled
        }
    }

    // 设置窗口控件可点击区域
    function setHitTestVisible(id) {
        frameless.setHitTestVisible(id)
    }
}
