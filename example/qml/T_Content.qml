import QtQuick
import QtQuick.Layouts
import FlaCoreUI

Item {
    id: root
    FlaNavigationView{
        anchors.margins: 2
        anchors.fill: parent
        items: Objects{
            PaneItem{
                title: "首页"
                icon: FluentIcon.ico_Home
                page:"qrc:/qml/T_Home.qml"
            }
            PaneItemSeparator{}
            PaneItem{
                title: "卡片"
                icon: "📉"
                page:"qrc:/qml/T_Card.qml"
            }
           /* PaneItemSeparator{}
            PaneItemExpander{
                title: "基本组件"
                isExpand: true
                icon: "📊"
                PaneItem{
                    title: "按钮组件"
                    icon: "📉"
                    page:"qrc:/qml/T_Button.qml"

                }
                PaneItem{
                    title: "数字输入"
                    icon: "⏳"
                    page:"qrc:/qml/T_ProgressBar.qml"
                }

            }
            PaneItemExpander{
                title: "数据展示"
                isExpand: true
                icon: "📋"
                PaneItem{
                    title: "时间轴"
                    icon: "🕐"
                    page:"qrc:/qml/T_Timeline.qml"
                }
                PaneItem{
                    title: "表格组件"
                    icon: "📊"
                    page:"qrc:/qml/T_TableView.qml"
                }
            }*/
        }
    }
}



/*Column {⏳
    padding: 10
    spacing: 16
    anchors.fill: parent

    Row {
        spacing: 10
        ComButton {
            text: "基础案例"
        }
        ComButton {
            text: "图标按钮"
            display: DisplayType.IconBesideText
            iconsource: FluentIcon.ico_VPN
        }
        ComButton {
            text: "图标按钮"
            display: DisplayType.TextBesideIcon
            iconsource: FluentIcon.ico_VPN
        }
        ComButton {
            text: "颜色按钮"
            display: DisplayType.TextBesideIcon
            iconsource: FluentIcon.ico_VPN
            highlighted: true
        }
        ComButton {
            text: "颜色按钮"
            display: DisplayType.TextBesideIcon
            iconsource: FluentIcon.ico_VPN
            highlighted: true
            highlightedcolor: "#BB47F5"
            textcolor: "#F5F5F7"
        }
        ComDelayButton {
            text: "example文本"
        }
    }

    Text {
        text: "ComProgressBar 案例"
        font.pixelSize: 16
        font.bold: true
        color: Theme.Textcolor
    }

    ComProgressBar {
        width: 400
        value:0.1
    }

    ComProgressBar {
        width: 400
        value: 0.5
        progressColor: "#FF6B35"
    }

    ComProgressBar {
        width: 400
        value: 0.2
        progressColor: "#2ECC71"
    }

    ComProgressBar {
        width: 400
        value: 1.0
        progressColor: "#E74C3C"
    }

    ComProgressBar {
        width: 400
        value: 0.45
        progressColor: "#9B59B6"
    }

    ComProgressBar {
        width: 400
        value: 0.7
        progressColor: "#F39C12"
        showProgressText: false
        barHeight: 8
    }

    Row {
        spacing: 10
        property real progressValue: 0
        ComButton {
            text: "-"
            onClicked: parent.progressValue = Math.max(0, parent.progressValue - 0.1)
        }
        ComProgressBar {
            width: 300
            value: parent.progressValue
            progressColor: "#1ABC9C"
        }
        ComButton {
            text: "+"
            onClicked: parent.progressValue = Math.min(1, parent.progressValue + 0.1)
        }
    }

    Text {
        text: "ComCircularProgressBar 案例"
        font.pixelSize: 16
        font.bold: true
        color: Theme.Textcolor
    }

    Row {
        spacing: 20
        anchors.left: parent.left
        anchors.leftMargin: 10

        ComCircularProgressBar {
            value: 0.25
        }

        ComCircularProgressBar {
            value: 0.5
            progressColor: "#FF6B35"
        }

        ComCircularProgressBar {
            value: 0.75
            progressColor: "#2ECC71"
        }

        ComCircularProgressBar {
            value: 1.0
            progressColor: "#E74C3C"
        }

        ComCircularProgressBar {
            value: 0.6
            progressColor: "#9B59B6"
            strokeWidth: 30
            diameter:250
        }

        ComCircularProgressBar {
            value: 0.45
            progressColor: "#F39C12"
            showProgressText: false
            strokeWidth: 10
            diameter: 50
        }
    }

    Row {
        spacing: 10
        property real circularValue: 0
        anchors.left: parent.left
        anchors.leftMargin: 10

        ComButton {
            text: "-"
            onClicked: parent.circularValue = Math.max(0, parent.circularValue - 0.1)
        }
        ComCircularProgressBar {
            value: parent.circularValue
            progressColor: "#1ABC9C"
            diameter: 90
            strokeWidth:15
        }
        ComButton {
            text: "+"
            onClicked: parent.circularValue = Math.min(1, parent.circularValue + 0.05)
        }
    }
}*/