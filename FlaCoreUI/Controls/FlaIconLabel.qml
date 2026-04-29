import QtQuick
import QtQuick.Layouts
import FlaCoreUI
// 图标+标签组件：支持多种布局方式（图标在左/右/上/下）
Item {
    id: control
    property int alignment: Qt.AlignVCenter | Qt.AlignHCenter
    property int display: DisplayType.TextOnly       // 显示模式
    property string text                             // 文本内容
    property string iconsource: ""                   // 图标源
    property int iconsize: 20                        // 图标大小
    property bool iconbold: false                    // 图标加粗
    property font font: Qt.font({ family: Theme.defaultFontFamily, pixelSize: 13, weight: Font.Normal })
    property color color: !enabled ? Theme.DisabledTextColor : Theme.isDark ? "white" : "black"
    property color icocolor: control.color
    property real topPadding: 0
    property real leftPadding: 0
    property real rightPadding: 0
    property real bottomPadding: 0
    property int spacing: 4          // 图标与文本间距

    implicitWidth: loader.width
    implicitHeight: loader.height

    // 图标组件
    Component {
        id: comp_icon
        FlaImage {
            iconsource: control.iconsource
            iconsize: control.iconsize
            icocolor: control.icocolor
            iconbold: control.iconbold
            visible: control.display !== DisplayType.TextOnly
        }
    }

    // 水平布局：图标在左/右
    Component {
        id: comp_row
        Item {
            width: childrenRect.width + control.leftPadding + control.rightPadding
            height: childrenRect.height + control.topPadding + control.bottomPadding
            x: control.leftPadding
            y: control.topPadding

            Row {
                // 根据显示模式设置布局方向
                layoutDirection: control.display === DisplayType.IconBesideText ? Qt.LeftToRight : Qt.RightToLeft
                spacing: control.text === "" ? 0 : control.spacing

                Loader {
                    sourceComponent: comp_icon
                    active: control.display !== DisplayType.TextOnly && iconsource !== ""
                    visible: active
                    anchors.verticalCenter: parent.verticalCenter
                }

                Text {
                    id: label_text
                    text: control.text
                    font: control.font
                    color: control.color
                    visible: control.display !== DisplayType.IconOnly
                    anchors.verticalCenter: parent.verticalCenter
                }
            }
        }
    }

    // 垂直布局：图标在上/下
    Component {
        id: comp_column
        Item {
            width: childrenRect.width + control.leftPadding + control.rightPadding
            height: childrenRect.height + control.topPadding + control.bottomPadding
            x: control.leftPadding
            y: control.topPadding

            Column {
                spacing: control.text === "" ? 0 : control.spacing

                Loader {
                    sourceComponent: comp_icon
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Text {
                    id: label_text
                    text: control.text
                    font: control.font
                    color: control.color
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }
        }
    }

    // 根据显示模式加载对应布局
    Loader {
        id: loader
        anchors {
            verticalCenter: (control.alignment & Qt.AlignVCenter) ? control.verticalCenter : undefined
            horizontalCenter: (control.alignment & Qt.AlignHCenter) ? control.horizontalCenter : undefined
        }
        sourceComponent: {
            if (display === DisplayType.TextUnderIcon) return comp_column
            return comp_row
        }
    }
}
