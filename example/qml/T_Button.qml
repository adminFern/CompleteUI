import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import CompleteUI

Item {
    id: root

    ScrollView {
        anchors.fill: parent
        ColumnLayout{
            anchors.fill: parent
            anchors.margins: 10
            spacing: 10
            Item {
                Layout.fillWidth: true
                Layout.preferredHeight: 85
                ComGroupBox{
                    id:bsicBox
                    anchors.fill: parent
                    padding: 8
                    title: "基础按钮"
                    RowLayout{
                        anchors.fill: parent
                        Column{
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            spacing: 4
                            ComButton {
                                text: "基础按钮"
                                height: 30
                                anchors.horizontalCenter: parent.horizontalCenter
                                display: DisplayType.TextOnly

                            }
                            Text {
                                anchors.horizontalCenter: parent.horizontalCenter
                                color: Theme.isDark? "dimgray":"gray"
                                font.pixelSize: 11
                                text: qsTr("TextOnly模式")
                            }
                        }
                        Column{
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            spacing: 4
                            ComButton {
                                height: 30
                                display: DisplayType.IconBesideText
                                anchors.horizontalCenter: parent.horizontalCenter
                                iconsource: FluentIcon.ico_Connect
                                text: "图标按钮"
                            }
                            Text {
                                anchors.horizontalCenter: parent.horizontalCenter
                                color: Theme.isDark? "dimgray":"gray"
                                font.pixelSize: 11
                                text: qsTr("IconBesideText模式")
                            }
                        }
                        Column{
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            spacing: 4
                            ComButton {
                                height: 30
                                display: DisplayType.TextBesideIcon
                                anchors.horizontalCenter: parent.horizontalCenter
                                iconsource: FluentIcon.ico_Connect
                                text: "图标按钮"
                            }
                            Text {
                                anchors.horizontalCenter: parent.horizontalCenter
                                color: Theme.isDark? "dimgray":"gray"
                                font.pixelSize: 11
                                text: qsTr("TextBesideIcon模式")
                            }
                        }
                        Column{
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            spacing: 4
                            ComButton {
                                height: 30
                                width: 30
                                display: DisplayType.IconOnly
                                iconsource: "📉"
                                anchors.horizontalCenter: parent.horizontalCenter
                                text: "颜色按钮"
                            }
                            Text {
                                anchors.horizontalCenter: parent.horizontalCenter
                                color: Theme.isDark? "dimgray":"gray"
                                font.pixelSize: 11
                                text: qsTr("IconOnly模式")
                            }
                        }
                        Column{
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            spacing: 4
                            ComButton {
                                height: 30
                                width: 30
                                display: DisplayType.IconOnly
                                iconsource: FluentIcon.ico_QuickNote
                                anchors.horizontalCenter: parent.horizontalCenter
                                text: "颜色按钮"
                            }
                            Text {
                                anchors.horizontalCenter: parent.horizontalCenter
                                color: Theme.isDark? "dimgray":"gray"
                                font.pixelSize: 11
                                text: qsTr("IconOnly模式")
                            }
                        }

                    }
                }

            }//基础案例ComGroupBox

            Item {
                Layout.fillWidth: true
                Layout.preferredHeight: 80
                ComGroupBox{
                    id:colorBox
                    anchors.fill: parent
                    padding: 8
                    title: "颜色按钮"
                    RowLayout{
                        anchors.fill: parent
                        Column{
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            spacing: 4
                            ComButton {
                                text: "默认颜色按钮"
                                height: 30
                                highlighted: true
                                anchors.horizontalCenter: parent.horizontalCenter
                                display: DisplayType.TextOnly
                                flat: true
                            }
                            Text {
                                anchors.horizontalCenter: parent.horizontalCenter
                                color: Theme.isDark? "dimgray":"gray"
                                font.pixelSize: 11
                                text: qsTr("默认颜色按钮")

                            }
                        }
                        Column{
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            spacing: 4
                            ComButton {
                                display: DisplayType.TextBesideIcon
                               // anchors.horizontalCenter: parent.horizontalCenter
                                iconsource: FluentIcon.ico_Connect
                                text: "绿色颜色按钮"
                                height: 30
                                highlighted: true
                                highlightedcolor: "#008F40"
                                anchors.horizontalCenter: parent.horizontalCenter
                               // display: DisplayType.TextOnly

                            }
                            Text {
                                anchors.horizontalCenter: parent.horizontalCenter
                                color: Theme.isDark? "dimgray":"gray"
                                font.pixelSize: 11
                                text: qsTr("绿色颜色按钮")
                            }
                        }
                        Column{
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            spacing: 4
                            ComButton {
                                text: "红色颜色按钮"
                                height: 30
                                highlighted: true
                                highlightedcolor: "#E60013"
                                anchors.horizontalCenter: parent.horizontalCenter
                                display: DisplayType.TextOnly

                            }
                            Text {
                                anchors.horizontalCenter: parent.horizontalCenter
                                color: Theme.isDark? "dimgray":"gray"
                                font.pixelSize: 11
                                text: qsTr("红色颜色按钮")
                            }
                        }
                        Column{
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            spacing: 4
                            ComButton {
                                text: "紫色颜色按钮"
                                height: 30
                                highlighted: true
                                highlightedcolor: "#B85489"
                                anchors.horizontalCenter: parent.horizontalCenter
                                display: DisplayType.TextOnly

                            }
                            Text {
                                anchors.horizontalCenter: parent.horizontalCenter
                                color: Theme.isDark? "dimgray":"gray"
                                font.pixelSize: 11
                                text: qsTr("紫色颜色按钮")
                            }
                        }
                        Column{
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            spacing: 4
                            ComButton {
                                text: "藏青颜色按钮"
                                height: 30
                                highlighted: true
                                highlightedcolor: "#209195"
                                anchors.horizontalCenter: parent.horizontalCenter
                                display: DisplayType.TextOnly

                            }
                            Text {
                                anchors.horizontalCenter: parent.horizontalCenter
                                color: Theme.isDark? "dimgray":"gray"
                                font.pixelSize: 11
                                text: qsTr("藏青颜色按钮")
                            }
                        }
                    }
                }
            }
            Item {
                Layout.fillWidth: true
                Layout.preferredHeight: 220
                ComGroupBox{
                    anchors.fill: parent
                    padding: 8
                    title: "悬浮按钮"
                    ColumnLayout{
                        anchors.fill: parent
                        spacing: 16
                        RowLayout{
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            spacing: 40
                            Column{
                                Layout.fillHeight: true
                                spacing: 4
                                ComFloatButton{
                                    id: floatBtn1
                                    direction: ComFloatButton.Direction.Up
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    actions: [
                                        { icon: FluentIcon.ico_Edit, enabled: true },
                                        { icon: FluentIcon.ico_Delete, enabled: true },
                                        { icon: FluentIcon.ico_Share, enabled: true }
                                    ]
                                    onSubClicked: (index)=> {
                                        if(index === 0) floatLabel.text = "向上弹出 - 点击了: 编辑"
                                        else if(index === 1) floatLabel.text = "向上弹出 - 点击了: 删除"
                                        else floatLabel.text = "向上弹出 - 点击了: 分享"
                                    }
                                }
                                Text{
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    color: Theme.isDark? "dimgray":"gray"
                                    font.pixelSize: 11
                                    text: qsTr("向上弹出")
                                }
                            }
                            Column{
                                Layout.fillHeight: true
                                spacing: 4
                                ComFloatButton{
                                    id: floatBtn2
                                    direction: ComFloatButton.Direction.Down
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    actions: [
                                        { icon: FluentIcon.ico_Copy, enabled: true },
                                        { icon: FluentIcon.ico_Save, enabled: true },
                                        { icon: FluentIcon.ico_Print, enabled: true }
                                    ]
                                    onSubClicked: (index)=> {
                                        if(index === 0) floatLabel.text = "向下弹出 - 点击了: 复制"
                                        else if(index === 1) floatLabel.text = "向下弹出 - 点击了: 保存"
                                        else floatLabel.text = "向下弹出 - 点击了: 打印"
                                    }
                                }
                                Text{
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    color: Theme.isDark? "dimgray":"gray"
                                    font.pixelSize: 11
                                    text: qsTr("向下弹出")
                                }
                            }
                            Column{
                                Layout.fillHeight: true
                                spacing: 4
                                ComFloatButton{
                                    id: floatBtn3
                                    direction: ComFloatButton.Direction.Left
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    actions: [
                                        { icon: FluentIcon.ico_Search, enabled: true },
                                        { icon: FluentIcon.ico_Filter, enabled: true },
                                        { icon: FluentIcon.ico_Settings, enabled: true }
                                    ]
                                    onSubClicked: (index)=> {
                                        if(index === 0) floatLabel.text = "向左弹出 - 点击了: 搜索"
                                        else if(index === 1) floatLabel.text = "向左弹出 - 点击了: 筛选"
                                        else floatLabel.text = "向左弹出 - 点击了: 设置"
                                    }
                                }
                                Text{
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    color: Theme.isDark? "dimgray":"gray"
                                    font.pixelSize: 11
                                    text: qsTr("向左弹出")
                                }
                            }
                            Column{
                                Layout.fillHeight: true
                                spacing: 4
                                ComFloatButton{
                                    id: floatBtn4
                                    direction: ComFloatButton.Direction.Right
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    accentColor: "#E60013"
                                    actions: [
                                        { icon: FluentIcon.ico_Mail, enabled: true },
                                        { icon: FluentIcon.ico_FavoriteStarFill, enabled: true },
                                        { icon: FluentIcon.ico_Send, enabled: true }
                                    ]
                                    onSubClicked: (index)=> {
                                        if(index === 0) floatLabel.text = "向右弹出(红色) - 点击了: 邮件"
                                        else if(index === 1) floatLabel.text = "向右弹出(红色) - 点击了: 收藏"
                                        else floatLabel.text = "向右弹出(红色) - 点击了: 发送"
                                    }
                                }
                                Text{
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    color: Theme.isDark? "dimgray":"gray"
                                    font.pixelSize: 11
                                    text: qsTr("向右弹出(红色)")
                                }
                            }
                        }
                        Text{
                            id: floatLabel
                            color: Theme.isDark? "dimgray":"gray"
                            font.pixelSize: 12
                            text: qsTr("点击子按钮查看效果")
                        }
                    }
                }
            }
            Item {
                Layout.fillWidth: true
                Layout.preferredHeight: 80
                ComGroupBox{
                    anchors.fill: parent
                    padding: 8
                    title: "延时按钮"
                    RowLayout{
                        anchors.fill: parent

                        ComDelayButton{
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            delay: 3000
                            text: "延时3000ms"
                        }
                        ComDelayButton{
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            delay: 500
                            text: "延时500ms"
                            progressbarcolor: Theme.setColorAlpha("#8DC500",150)
                            primarycolor: "#8DC500"
                        }
                        ComDelayButton{
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            progressbarcolor: Theme.setColorAlpha("#E50162",150)
                            primarycolor: "#E50162"
                            text: "延时1000ms"
                            delay: 1000
                            display: DisplayType.TextBesideIcon
                            iconsource: FluentIcon.ico_Pin
                        }
                        ComDelayButton{
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            progressbarcolor: Theme.setColorAlpha("#209195",150)
                            primarycolor: "#209195"
                            text: "延时1000ms"
                            delay: 1000
                            display: DisplayType.IconBesideText
                            iconsource: FluentIcon.ico_Link

                        }
                    }
                }
            }
            Item {
                Layout.fillWidth: true
                Layout.fillHeight: true
            }


        }//ColumnLayout
    }
}
/* Column{
     Layout.fillWidth: true
     Layout.fillHeight: true
     spacing: 4
     ComButton {
         display: DisplayType.TextUnderIcon
         anchors.horizontalCenter: parent.horizontalCenter
         iconsource: FluentIcon.ico_MapPin
         text: "图标按钮"
     }
     Text {
         anchors.horizontalCenter: parent.horizontalCenter
         color: Theme.isDark? "dimgray":"gray"
         font.pixelSize: 11
         text: qsTr("TextUnderIcon模式")
     }
 }
 Column{
     Layout.fillWidth: true
     Layout.fillHeight: true
     spacing:4
     ComButton {
         height: 30
         display: DisplayType.IconBesideText
         anchors.horizontalCenter: parent.horizontalCenter
         iconsource: "📉"
         text: "Emoji图标按钮"
     }
     Text {
         anchors.horizontalCenter: parent.horizontalCenter
         color: Theme.isDark? "dimgray":"gray"
         font.pixelSize: 11
         text: qsTr("Emoji模式")
     }
 }
 Column{
     Layout.fillWidth: true
     Layout.fillHeight: true
     spacing: 4
     ComButton {
         height: 30
         display: DisplayType.TextBesideIcon
         anchors.horizontalCenter: parent.horizontalCenter
         iconsource: "📉"
         text: "Emoji图标按钮"
     }
     Text {
         anchors.horizontalCenter: parent.horizontalCenter
         color: Theme.isDark? "dimgray":"gray"
         font.pixelSize: 11
         text: qsTr("Emoji模式")
     }
 }
 Column{
     Layout.fillWidth: true
     Layout.fillHeight: true
     spacing:4
     ComButton {
         height: 30
         highlighted: true
         display: DisplayType.TextOnly
         anchors.horizontalCenter: parent.horizontalCenter
         text: "颜色按钮"
     }
     Text {
         anchors.horizontalCenter: parent.horizontalCenter
         color: Theme.isDark? "dimgray":"gray"
         font.pixelSize: 11
         text: qsTr("highlighted模式")
     }
 }

 Column{
     Layout.fillWidth: true
     Layout.fillHeight: true
     spacing: 4
     ComButton {
         height: 30
         width: 30
         //   highlighted: true
         display: DisplayType.IconOnly
         iconsource: FluentIcon.ico_QuickNote
         anchors.horizontalCenter: parent.horizontalCenter
         text: "颜色按钮"
     }
     Text {
         anchors.horizontalCenter: parent.horizontalCenter
         color: Theme.isDark? "dimgray":"gray"
         font.pixelSize: 11
         text: qsTr("IconOnly模式")
     }
 }*/
/*  ScrollBar.vertical: ComScrollBar {
         id: verticalScrollBar
         anchors.top: parent.top
         anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.rightMargin: 8
         policy: ScrollBar.AsNeeded
         minimumSize: 0.1
         // anchors.rightMargin: 1
    }

    // ScrollBar.horizontal: ComScrollBar {
    //     enabled: false
    //     policy: ScrollBar.AlwaysOff
    // }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 20

        Text {
            text: "ComButton 组件示例"
            font.pixelSize: 20
            font.bold: true
            color: Theme.Textcolor
            Layout.fillWidth: true
        }

        Text {
            text: "基础用法"
            font.pixelSize: 16
            font.bold: true
            color: Theme.Textcolor
            Layout.fillWidth: true
        }

        RowLayout {
            Layout.fillWidth: true
            spacing: 20

            ComButton {
                text: "默认按钮"
            }

            ComButton {
                text: "禁用按钮"
                enabled: false
            }

            ComButton {
                text: "带图标"
                iconsource: FluentIcon.ico_Home
            }
        }

        Text {
            text: "显示模式 (display)"
            font.pixelSize: 16
            font.bold: true
            color: Theme.Textcolor
            Layout.fillWidth: true
        }

        RowLayout {
            Layout.fillWidth: true
            spacing: 20

            ColumnLayout {
                spacing: 5
                Text {
                    text: "仅文本"
                    color: Theme.Textcolor
                    font.pixelSize: 12
                }
                ComButton {
                    text: "TextOnly"
                    display: DisplayType.TextOnly
                }
            }

            ColumnLayout {
                spacing: 5
                Text {
                    text: "仅图标"
                    color: Theme.Textcolor
                    font.pixelSize: 12
                }
                ComButton {
                    iconsource: FluentIcon.ico_Search
                    display: DisplayType.IconOnly
                }
            }

            ColumnLayout {
                spacing: 5
                Text {
                    text: "图标在左"
                    color: Theme.Textcolor
                    font.pixelSize: 12
                }
                ComButton {
                    text: "IconBesideText"
                    iconsource: FluentIcon.ico_Bluetooth
                    display: DisplayType.IconBesideText
                }
            }

            ColumnLayout {
                spacing: 5
                Text {
                    text: "图标在右"
                    color: Theme.Textcolor
                    font.pixelSize: 12
                }
                ComButton {
                    text: "TextBesideIcon"
                    iconsource: FluentIcon.ico_Connect
                    display: DisplayType.TextBesideIcon
                }
            }

            ColumnLayout {
                spacing: 5
                Text {
                    text: "图标在上"
                    color: Theme.Textcolor
                    font.pixelSize: 12
                }
                ComButton {
                    text: "TextUnderIcon"
                    iconsource: FluentIcon.ico_VPN
                    display: DisplayType.TextUnderIcon
                }
            }
        }

        Text {
            text: "Emoji 图标按钮"
            font.pixelSize: 16
            font.bold: true
            color: Theme.Textcolor
            Layout.fillWidth: true
        }

        RowLayout {
            Layout.fillWidth: true
            spacing: 20

            ComButton {
                text: "微笑"
                iconsource: "\u263A"
                display: DisplayType.IconBesideText
            }

            ComButton {
                text: "点赞"
                iconsource: "\uD83D\uDC4D"
                display: DisplayType.IconBesideText
            }

            ComButton {
                text: "爱心"
                iconsource: "\u2764"
                display: DisplayType.IconBesideText
            }

            ComButton {
                iconsource: "\uD83D\uDE04"
                display: DisplayType.IconOnly
            }

            ComButton {
                iconsource: "\uD83D\uDC4D"
                display: DisplayType.IconOnly
            }

            ComButton {
                iconsource: "\u2764"
                display: DisplayType.IconOnly
            }

            ComButton {
                text: "表情"
                iconsource: FluentIcon.ico_Emoji
                display: DisplayType.IconBesideText
            }

            ComButton {
                text: "庆祝"
                iconsource: FluentIcon.ico_EmojiTabCelebrationObjects
                display: DisplayType.IconBesideText
            }
        }

        Text {
            text: "颜色自定义"
            font.pixelSize: 16
            font.bold: true
            color: Theme.Textcolor
            Layout.fillWidth: true
        }

        RowLayout {
            Layout.fillWidth: true
            spacing: 30

            ColumnLayout {
                spacing: 5
                Text {
                    text: "默认颜色"
                    color: Theme.Textcolor
                    font.pixelSize: 12
                }
                ComButton {
                    text: "默认"
                    width: 100
                }
            }

            ColumnLayout {
                spacing: 5
                Text {
                    text: "自定义颜色"
                    color: Theme.Textcolor
                    font.pixelSize: 12
                }
                ComButton {
                    text: "自定义"
                    width: 100
                    normalcolor: "#4CAF50"
                    hovercolor: "#66BB6A"
                    pressedcolor: "#388E3C"
                }
            }

            ColumnLayout {
                spacing: 5
                Text {
                    text: "主色高亮"
                    color: Theme.Textcolor
                    font.pixelSize: 12
                }
                ComButton {
                    text: "Primary"
                    width: 100
                    highlighted: true
                }
            }

            ColumnLayout {
                spacing: 5
                Text {
                    text: "粉红高亮"
                    color: Theme.Textcolor
                    font.pixelSize: 12
                }
                ComButton {
                    text: "Highlighted"
                    width: 100
                    highlighted: true
                    highlightedcolor: "hotpink"
                }
            }
        }

        Text {
            text: "圆角与边框"
            font.pixelSize: 16
            font.bold: true
            color: Theme.Textcolor
            Layout.fillWidth: true
        }

        RowLayout {
            Layout.fillWidth: true
            spacing: 20

            ComButton {
                text: "圆角 4"
                radius: 4
            }

            ComButton {
                text: "圆角 8"
                radius: 8
            }

            ComButton {
                text: "圆角 15"
                radius: 15
            }

            ComButton {
                text: "胶囊形"
                radius: height / 2
            }

            ComButton {
                text: "无边框"
                radius: 8
                bordercolor: "transparent"
            }
        }

        Text {
            text: "图标设置"
            font.pixelSize: 16
            font.bold: true
            color: Theme.Textcolor
            Layout.fillWidth: true
        }

        RowLayout {
            Layout.fillWidth: true
            spacing: 20

            ColumnLayout {
                spacing: 5
                Text {
                    text: "图标大小 16"
                    color: Theme.Textcolor
                    font.pixelSize: 12
                }
                ComButton {
                    text: "Small"
                    iconsource: FluentIcon.ico_Mail
                    iconsize: 16
                    display: DisplayType.IconBesideText
                }
            }

            ColumnLayout {
                spacing: 5
                Text {
                    text: "图标大小 24"
                    color: Theme.Textcolor
                    font.pixelSize: 12
                }
                ComButton {
                    text: "Medium"
                    iconsource: FluentIcon.ico_Mail
                    iconsize: 24
                    display: DisplayType.IconBesideText
                }
            }

            ColumnLayout {
                spacing: 5
                Text {
                    text: "图标大小 32"
                    color: Theme.Textcolor
                    font.pixelSize: 12
                }
                ComButton {
                    text: "Large"
                    iconsource: FluentIcon.ico_Mail
                    iconsize: 32
                    display: DisplayType.IconBesideText
                }
            }

            ColumnLayout {
                spacing: 5
                Text {
                    text: "图标颜色"
                    color: Theme.Textcolor
                    font.pixelSize: 12
                }
                ComButton {
                    text: "Colored"
                    iconsource: FluentIcon.ico_Home
                    display: DisplayType.IconBesideText
                    textcolor: "#FF5722"
                }
            }
        }

        Text {
            text: "光标与动画"
            font.pixelSize: 16
            font.bold: true
            color: Theme.Textcolor
            Layout.fillWidth: true
        }

        RowLayout {
            Layout.fillWidth: true
            spacing: 20

            ColumnLayout {
                spacing: 5
                Text {
                    text: "手型光标"
                    color: Theme.Textcolor
                    font.pixelSize: 12
                }
                ComButton {
                    text: "Hand Cursor"
                    handCursor: true
                }
            }

            ColumnLayout {
                spacing: 5
                Text {
                    text: "箭头光标"
                    color: Theme.Textcolor
                    font.pixelSize: 12
                }
                ComButton {
                    text: "Arrow Cursor"
                    handCursor: false
                }
            }

            ColumnLayout {
                spacing: 5
                Text {
                    text: "禁用动画"
                    color: Theme.Textcolor
                    font.pixelSize: 12
                }
                ComButton {
                    text: "No Animation"
                    enableAnimation: false
                }
            }

            ColumnLayout {
                spacing: 5
                Text {
                    text: "自定义缩放因子"
                    color: Theme.Textcolor
                    font.pixelSize: 12
                }
                ComButton {
                    text: "Scale 0.9"
                    scaleAnimationFactor: 0.9
                }
            }
        }

        Text {
            text: "字体设置"
            font.pixelSize: 16
            font.bold: true
            color: Theme.Textcolor
            Layout.fillWidth: true
        }

        RowLayout {
            Layout.fillWidth: true
            spacing: 20

            ComButton {
                text: "小字体"
                font.pixelSize: 12
            }

            ComButton {
                text: "中等字体"
                font.pixelSize: 16
            }

            ComButton {
                text: "大字体"
                font.pixelSize: 20
            }

            ComButton {
                text: "粗体"
                font.weight: Font.Bold
            }

            ComButton {
                text: "自定义颜色"
                font.pixelSize: 16
                textcolor: "#9C27B0"
            }
        }

        Text {
            text: "内边距与间距"
            font.pixelSize: 16
            font.bold: true
            color: Theme.Textcolor
            Layout.fillWidth: true
        }

        RowLayout {
            Layout.fillWidth: true
            spacing: 20

            ComButton {
                text: "紧凑"
                topPadding: 2
                bottomPadding: 2
                leftPadding: 4
                rightPadding: 4
                spacing: 2
            }

            ComButton {
                text: "默认"
            }

            ComButton {
                text: "宽松"
                topPadding: 12
                bottomPadding: 12
                leftPadding: 16
                rightPadding: 16
                spacing: 8
            }

            ComButton {
                text: "Tall"
                topPadding: 20
                bottomPadding: 20
            }
        }

        Text {
            text: "按钮组与交互"
            font.pixelSize: 16
            font.bold: true
            color: Theme.Textcolor
            Layout.fillWidth: true
        }

        ColumnLayout {
            Layout.fillWidth: true
            spacing: 10

            RowLayout {
                spacing: 10
                ComButton {
                    text: "按钮 A"
                    highlighted: true
                    onClicked: label.text = "点击了: 按钮 A"
                }
                ComButton {
                    text: "按钮 B"
                    onClicked: label.text = "点击了: 按钮 B"
                }
                ComButton {
                    text: "按钮 C"
                    onClicked: label.text = "点击了: 按钮 C"
                }
            }

            Text {
                id: label
                text: "请点击上面的按钮"
                color: Theme.Textcolor
            }
        }

        Text {
            text: "完整自定义示例"
            font.pixelSize: 16
            font.bold: true
            color: Theme.Textcolor
            Layout.fillWidth: true
        }

        RowLayout {
            Layout.fillWidth: true
            spacing: 20

            ComButton {
                text: "自定义样式"
                iconsource: FluentIcon.ico_Search
                display: DisplayType.IconBesideText
                iconsize: 20
                radius: 12
                normalcolor: "#2196F3"
                hovercolor: "#42A5F5"
                pressedcolor: "#1976D2"
                textcolor: "white"
                highlighted: false
                handCursor: true
                enableAnimation: true
                scaleAnimationFactor: 0.95
                font.pixelSize: 14
                topPadding: 10
                bottomPadding: 10
                leftPadding: 20
                rightPadding: 20
            }

            ComButton {
                text: "Success"
                iconsource: FluentIcon.ico_Accept
                display: DisplayType.IconBesideText
                radius: 8
                normalcolor: "#4CAF50"
                hovercolor: "#66BB6A"
                pressedcolor: "#388E3C"
                textcolor: "white"
            }

            ComButton {
                text: "Warning"
                iconsource: FluentIcon.ico_Warning
                display: DisplayType.IconBesideText
                radius: 8
                normalcolor: "#FF9800"
                hovercolor: "#FFA726"
                pressedcolor: "#F57C00"
                textcolor: "white"
            }

            ComButton {
                text: "Danger"
                iconsource: FluentIcon.ico_Cancel
                display: DisplayType.IconBesideText
                radius: 8
                normalcolor: "#F44336"
                hovercolor: "#EF5350"
                pressedcolor: "#E53935"
                textcolor: "white"
            }
        }

        Text {
            text: "ComDelayButton 延时按钮"
            font.pixelSize: 16
            font.bold: true
            color: Theme.Textcolor
            Layout.fillWidth: true
        }

        Text {
            text: "按住按钮不放，进度条走完才能触发点击事件"
            font.pixelSize: 12
            color: Theme.Textcolor
            Layout.fillWidth: true
        }

        RowLayout {
            Layout.fillWidth: true
            spacing: 20

            ColumnLayout {
                spacing: 5
                Text {
                    text: "默认 (500ms)"
                    color: Theme.Textcolor
                    font.pixelSize: 12
                }
                ComDelayButton {
                    text: "默认"
                    onClicked: delayLabel.text = "触发点击!"
                }
            }

            ColumnLayout {
                spacing: 5
                Text {
                    text: "快速 (200ms)"
                    color: Theme.Textcolor
                    font.pixelSize: 12
                }
                ComDelayButton {
                    text: "快速"
                    delay: 200
                    onClicked: delayLabel.text = "快速触发!"
                }
            }

            ColumnLayout {
                spacing: 5
                Text {
                    text: "慢速 (1500ms)"
                    color: Theme.Textcolor
                    font.pixelSize: 12
                }
                ComDelayButton {
                    text: "慢速"
                    delay: 1500
                    onClicked: delayLabel.text = "慢速触发!"
                }
            }

            ColumnLayout {
                spacing: 5
                Text {
                    text: "带图标"
                    color: Theme.Textcolor
                    font.pixelSize: 12
                }
                ComDelayButton {
                    text: "保存"
                    iconsource: FluentIcon.ico_Save
                    display: DisplayType.IconBesideText
                    onClicked: delayLabel.text = "保存成功!"
                }
            }

            ColumnLayout {
                spacing: 5
                Text {
                    text: "禁用"
                    color: Theme.Textcolor
                    font.pixelSize: 12
                }
                ComDelayButton {
                    text: "禁用"
                    enabled: false
                }
            }
        }

        Text {
            id: delayLabel
            text: "请点击上面的延时按钮"
            color: Theme.Textcolor
            font.pixelSize: 14
        }

        Text {
            text: "颜色自定义"
            font.pixelSize: 16
            font.bold: true
            color: Theme.Textcolor
            Layout.fillWidth: true
        }

        RowLayout {
            Layout.fillWidth: true
            spacing: 20

            ComDelayButton {
                text: "绿色"
                delay: 800
                progressbarcolor: "#4CAF50"
            }

            ComDelayButton {
                text: "红色"
                delay: 800
                progressbarcolor: "#F44336"
            }

            ComDelayButton {
                text: "蓝色"
                delay: 800
                progressbarcolor: "#2196F3"
            }

            ComDelayButton {
                text: "紫色"
                delay: 800
                progressbarcolor: "#9C27B0"
            }
        }

        Item {
            Layout.fillHeight: true
            Layout.minimumHeight: 50
        }
    }
}*/