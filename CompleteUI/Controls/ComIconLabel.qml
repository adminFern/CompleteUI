import QtQuick
import QtQuick.Layouts
import CompleteUI
Item {
    id: control
    property int alignment: Qt.AlignVCenter | Qt.AlignHCenter
    property int display:DisplayType.TextOnly
    property string text
    property string iconsource:""
    property int iconsize: 20
    property bool iconbold: false
    property font font:Qt.font({family:Theme.defaultFontFamily,pixelSize : 13, weight: Font.Normal})
    property color color:!enabled? Theme.DisabledTextColor: Theme.isDark ? "white" : "black"
    property color icocolor:control.color
    property real topPadding: 0
    property real leftPadding: 0
    property real rightPadding: 0
    property real bottomPadding: 0
    property int spacing:4
    implicitWidth: loader.width
    implicitHeight: loader.height
    Component {
        id: comp_icon
        ComImage{
            iconsource:control.iconsource
            iconsize: control.iconsize
            icocolor: control.icocolor
            iconbold: control.iconbold
            visible: display!==DisplayType.TextOnly //！只显示文本
        }
    }
    //图标在左边文本在右边
    Component{
        id: comp_row
        Item{
            width: childrenRect.width + control.leftPadding + control.rightPadding
            height: childrenRect.height + control.topPadding + control.bottomPadding
            x: control.leftPadding
            y: control.topPadding
            Row{

                //布局方向
                layoutDirection: control.display === DisplayType.IconBesideText
                                 ? Qt.LeftToRight
                                 : Qt.RightToLeft
                spacing: control.text === ""  ? 0 : control.spacing
                Loader{
                    sourceComponent: comp_icon
                    active: control.display !== DisplayType.TextOnly && iconsource!==""
                    visible: active
                    anchors.verticalCenter: parent.verticalCenter
                }
                Text{
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
    //图标在上方文本在下方
    Component{
        id: comp_column
        Item{
            width: childrenRect.width + control.leftPadding + control.rightPadding
            height: childrenRect.height + control.topPadding + control.bottomPadding
            x: control.leftPadding
            y: control.topPadding
            Column{
                spacing: control.text === ""  ? 0 : control.spacing
                Loader{
                    sourceComponent: comp_icon
                    anchors{
                        horizontalCenter: parent.horizontalCenter
                    }
                }
                Text{
                    id: label_text
                    text: control.text
                    font: control.font
                    color: control.color
                    anchors.horizontalCenter: parent.horizontalCenter
                }

            }
        }
    }
    //加载组件
    Loader{
        id: loader
        anchors{
            verticalCenter: (control.alignment & Qt.AlignVCenter) ? control.verticalCenter : undefined
            horizontalCenter: (control.alignment & Qt.AlignHCenter) ? control.horizontalCenter : undefined
        }
        sourceComponent: {
            if(display === DisplayType.TextUnderIcon)   return comp_column
            return comp_row
        }
    }
}

