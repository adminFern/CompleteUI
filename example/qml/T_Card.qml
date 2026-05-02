import QtQuick
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
import FlaCoreUI

Item {
    // 名片卡片内容：头像在左，信息在右
    component CardContent: Item {
        property string avatarSrc: ""
        property string nameText: ""
        property string positionText: ""
        property string companyText: ""
        property string phoneText: ""
        property string emailText: ""
        anchors.fill: parent

        Row {
            anchors.fill: parent
            anchors.margins: 14
            spacing: 14

            // 左侧：圆形头像
            Image {
                id: avatarImg
                width: 80
                height: 80
                anchors.verticalCenter: parent.verticalCenter
                source: avatarSrc
                fillMode: Image.PreserveAspectCrop
                layer.enabled: true
                layer.effect: OpacityMask {
                    maskSource: Rectangle {
                        width: 80
                        height: 80
                        radius: 40
                    }
                }
            }

            // 右侧：信息区
            Column {
                anchors.verticalCenter: parent.verticalCenter
                spacing: 4

                Text {
                    text: nameText
                    font.pixelSize: 15
                    font.bold: true
                    color: Theme.Textcolor
                }
                Text {
                    text: positionText
                    font.pixelSize: 12
                    color: Theme.DisabledTextColor
                }
                Text {
                    text: companyText
                    font.pixelSize: 12
                    color: Theme.DisabledTextColor
                }
                Row {
                    spacing: 4
                    Text {
                        text: FluentIcon.ico_Phone
                        font.family: FluentIcon.fontLoader.name
                        font.pixelSize: 11
                        color: Theme.DisabledTextColor
                    }
                    Text {
                        text: phoneText
                        font.pixelSize: 11
                        color: Theme.DisabledTextColor
                    }
                }
                Row {
                    spacing: 4
                    Text {
                        text: FluentIcon.ico_Mail
                        font.family: FluentIcon.fontLoader.name
                        font.pixelSize: 11
                        color: Theme.DisabledTextColor
                    }
                    Text {
                        text: emailText
                        font.pixelSize: 11
                        color: Theme.DisabledTextColor
                    }
                }
            }
        }
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 10
        // ========== 名片卡片区域 ==========
        Row {
            spacing: 10
            Layout.fillWidth: true
            Layout.preferredHeight: 18
            FlaImage {
                iconsource: FluentIcon.ico_Contact
            }
            Text {
                text: qsTr("名片卡片")
                font.pixelSize: 16
                font.bold: true
                color: Theme.Textcolor
            }
        }
        FlaCard {
            Layout.fillWidth: true
            Layout.preferredHeight: 160
            layout: FlaCard.LayoutType.Horizontal
          items: Objects {
                CardItemDelegate {
                    cardColor: Theme.FillCardColor
                    cardWidth: 250; cardHeight: 130; radius: 12
                    delegate: CardContent {
                        avatarSrc: "qrc:/svg/avatar_1.svg"
                        nameText: "周杰"; positionText: "技术总监"
                        companyText: "星辰科技"; phoneText: "138-0001-0001"
                        emailText: "zhoujie@flacore.com"
                    }
                }
                CardItemDelegate {
                    cardColor: Theme.FillCardColor
                    cardWidth: 250; cardHeight: 130; radius: 12
                    delegate: CardContent {
                        avatarSrc: "qrc:/svg/avatar_2.svg"
                        nameText: "李明"; positionText: "软件工程师"
                        companyText: "星辰科技"; phoneText: "139-0002-0002"
                        emailText: "liming@flacore.com"
                    }
                }
                CardItemDelegate {
                    cardColor: Theme.FillCardColor
                    cardWidth: 250; cardHeight: 130; radius: 12
                    delegate: CardContent {
                        avatarSrc: "qrc:/svg/avatar_3.svg"
                        nameText: "王芳"; positionText: "设计总监"
                        companyText: "创想设计"; phoneText: "137-0003-0003"
                        emailText: "wangfang@flacore.com"
                    }
                }
                CardItemDelegate {
                    cardColor: Theme.FillCardColor
                    cardWidth: 250; cardHeight: 130; radius: 12
                    delegate: CardContent {
                        avatarSrc: "qrc:/svg/avatar_4.svg"
                        nameText: "张伟"; positionText: "市场经理"
                        companyText: "博远传媒"; phoneText: "136-0004-0004"
                        emailText: "zhangwei@flacore.com"
                    }
                }
                CardItemDelegate {
                    cardColor: Theme.FillCardColor
                    cardWidth: 250; cardHeight: 130; radius: 12
                    delegate: CardContent {
                        avatarSrc: "qrc:/svg/avatar_5.svg"
                        nameText: "陈静"; positionText: "财务总监"
                        companyText: "星辰科技"; phoneText: "135-0005-0005"
                        emailText: "chenjing@flacore.com"
                    }
                }
                CardItemDelegate {
                    cardColor: Theme.FillCardColor
                    cardWidth: 250; cardHeight: 130; radius: 12
                    delegate: CardContent {
                        avatarSrc: "qrc:/svg/avatar_6.svg"
                        nameText: "刘洋"; positionText: "运营总监"
                        companyText: "云启网络"; phoneText: "134-0006-0006"
                        emailText: "liuyang@flacore.com"
                    }
                }
                CardItemDelegate {
                    cardColor: Theme.FillCardColor
                    cardWidth: 250; cardHeight: 130; radius: 12
                    delegate: CardContent {
                        avatarSrc: "qrc:/svg/avatar_7.svg"
                        nameText: "赵磊"; positionText: "产品总监"
                        companyText: "星辰科技"; phoneText: "133-0007-0007"
                        emailText: "zhaolei@flacore.com"
                    }
                }
                CardItemDelegate {
                    cardColor: Theme.FillCardColor
                    cardWidth: 250; cardHeight: 130; radius: 12
                    delegate: CardContent {
                        avatarSrc: "qrc:/svg/avatar_8.svg"
                        nameText: "孙丽"; positionText: "HR经理"
                        companyText: "星辰科技"; phoneText: "132-0008-0008"
                        emailText: "sunli@flacore.com"
                    }
                }
            }
        }

        // ========== 波浪线名片卡片区域 ==========
        Row {
            spacing: 10
            Layout.fillWidth: true
            Layout.preferredHeight: 18
            FlaImage {
                iconsource: FluentIcon.ico_Contact
            }
            Text {
                text: qsTr("波浪线名片卡片")
                font.pixelSize: 16
                font.bold: true
                color: Theme.Textcolor
            }
        }
        FlaCardCurveView {
            Layout.fillWidth: true
            Layout.preferredHeight: 220
            layout: FlaCardCurveView.LayoutType.Horizontal
            curveAmplitude: 35
            curveFrequency: 0.7
            borderColor: Theme.DividerColor
            borderWidth: 1
            borderVisible: true
            items: Objects {
                CardItemDelegate {
                    cardColor: Theme.FillCardColor
                    cardWidth: 250; cardHeight: 130; radius: 12
                    delegate: CardContent {
                        avatarSrc: "qrc:/svg/avatar_1.svg"
                        nameText: "周杰"; positionText: "技术总监"
                        companyText: "星辰科技"; phoneText: "138-0001-0001"
                        emailText: "zhoujie@flacore.com"
                    }
                }
                CardItemDelegate {
                    cardColor: Theme.FillCardColor
                    cardWidth: 250; cardHeight: 130; radius: 12
                    delegate: CardContent {
                        avatarSrc: "qrc:/svg/avatar_2.svg"
                        nameText: "李明"; positionText: "软件工程师"
                        companyText: "星辰科技"; phoneText: "139-0002-0002"
                        emailText: "liming@flacore.com"
                    }
                }
                CardItemDelegate {
                    cardColor: Theme.FillCardColor
                    cardWidth: 250; cardHeight: 130; radius: 12
                    delegate: CardContent {
                        avatarSrc: "qrc:/svg/avatar_3.svg"
                        nameText: "王芳"; positionText: "设计总监"
                        companyText: "创想设计"; phoneText: "137-0003-0003"
                        emailText: "wangfang@flacore.com"
                    }
                }
                CardItemDelegate {
                    cardColor: Theme.FillCardColor
                    cardWidth: 250; cardHeight: 130; radius: 12
                    delegate: CardContent {
                        avatarSrc: "qrc:/svg/avatar_4.svg"
                        nameText: "张伟"; positionText: "市场经理"
                        companyText: "博远传媒"; phoneText: "136-0004-0004"
                        emailText: "zhangwei@flacore.com"
                    }
                }
                CardItemDelegate {
                    cardColor: Theme.FillCardColor
                    cardWidth: 250; cardHeight: 130; radius: 12
                    delegate: CardContent {
                        avatarSrc: "qrc:/svg/avatar_5.svg"
                        nameText: "陈静"; positionText: "财务总监"
                        companyText: "星辰科技"; phoneText: "135-0005-0005"
                        emailText: "chenjing@flacore.com"
                    }
                }
                CardItemDelegate {
                    cardColor: Theme.FillCardColor
                    cardWidth: 250; cardHeight: 130; radius: 12
                    delegate: CardContent {
                        avatarSrc: "qrc:/svg/avatar_6.svg"
                        nameText: "刘洋"; positionText: "运营总监"
                        companyText: "云启网络"; phoneText: "134-0006-0006"
                        emailText: "liuyang@flacore.com"
                    }
                }
            }
        }

        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true
        }
    }
}
