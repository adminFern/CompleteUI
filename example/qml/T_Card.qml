import QtQuick
import QtQuick.Controls
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
            anchors.margins:3
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
                    color: "white"
                }
                Text {
                    text: positionText
                    font.pixelSize: 12
                    color: "white"
                }
                Text {
                    text: companyText
                    font.pixelSize: 12
                    color: "white"
                }
                Row {
                    spacing: 4
                    Text {
                        text: FluentIcon.ico_Phone
                        font.family: FluentIcon.fontLoader.name
                        font.pixelSize: 11
                        color: "white"
                    }
                    Text {
                        text: phoneText
                        font.pixelSize: 11
                        color: "white"
                    }
                }
                Row {
                    spacing: 4
                    Text {
                        text: FluentIcon.ico_Mail
                        font.family: FluentIcon.fontLoader.name
                        font.pixelSize: 11
                        color: "white"
                    }
                    Text {
                        text: emailText
                        font.pixelSize: 11
                        color: "darkslategray"
                    }
                }
            }
        }
    }
    // 波浪/垂直卡片通用内容：头像+名字+两段描述
    component CardContentEx: Item {
        anchors.fill: parent
        property string ico: ""
        property string nameText: ""
        property string desc1: ""
        property string desc2: ""
        RowLayout {
            anchors.fill: parent; spacing: 4
            Item {
                Layout.leftMargin: 5; Layout.rightMargin: 5
                Layout.topMargin: 5; Layout.bottomMargin: 5
                Layout.preferredWidth: 60; Layout.fillHeight: true
                Column {
                    anchors.fill: parent
                    anchors.horizontalCenter: parent.horizontalCenter
                    padding: 10; spacing: 10
                    Image {
                        width: 60; height: 60
                        anchors.horizontalCenter: parent.horizontalCenter
                        source: ico
                        fillMode: Image.PreserveAspectCrop
                        layer.enabled: true
                        layer.effect: OpacityMask {
                            maskSource: Rectangle { width: 60; height: 60; radius: 30 }
                        }
                    }
                    Text {
                        text: nameText
                        anchors.horizontalCenter: parent.horizontalCenter
                        color: "white"; font.pixelSize: 16; font.bold: true
                        horizontalAlignment: Text.AlignHCenter
                    }
                }
            }
            Item {
                Layout.leftMargin: 4; Layout.rightMargin: 4
                Layout.topMargin: 4; Layout.bottomMargin: 4
                Layout.fillWidth: true; Layout.fillHeight: true
                Column {
                    anchors.fill: parent
                    anchors.horizontalCenter: parent.horizontalCenter
                    padding: 5; spacing: 5
                    Text {
                        anchors.left: parent.left; width: parent.width
                        text: desc1
                        color: "white"; font.pixelSize: 13
                        wrapMode: Text.WordWrap; horizontalAlignment: Text.AlignLeft
                    }
                    Text {
                        anchors.left: parent.left; width: parent.width
                        text: desc2
                        color: "darkslategray"; font.pixelSize: 12
                        wrapMode: Text.WordWrap; horizontalAlignment: Text.AlignLeft
                    }
                }
            }
        }
    }

    Flickable {
        id: flickable
        anchors.fill: parent
        contentHeight: columnLayout.implicitHeight
        ScrollBar.vertical: FlaScrollBar { }
        ColumnLayout {
            id: columnLayout
            anchors.fill: parent
        // ========== 名片卡片区域 ==========
        Row {
            spacing: 10
            Layout.fillWidth: true
            Layout.preferredHeight: 18
            FlaImage {
                iconsource: FluentIcon.ico_IOT
            }
            Text {
                text: qsTr("名片卡片")
                font.pixelSize: 14
                font.bold: true
                color: Theme.Textcolor
            }
        }
        FlaCardCurveView {
            Layout.fillWidth: true
            Layout.preferredHeight: 160
            layout: FlaCardCurveView.LayoutType.Row
            items: Objects {
                CardItem {
                    cardColor:Theme.isDark? Qt.darker( Theme.setColorAlpha("#DDA0DD",200),0.9):
                                            Qt.lighter(Theme.setColorAlpha("#DDA0DD",200),1.2)
                    borderColor:"#DDA0DD"
                    cardWidth: 250; cardHeight: 130; radius: 12
                    delegate: CardContent {
                        avatarSrc: "qrc:/svg/avatar_1.svg"
                        nameText: "周杰"; positionText: "技术总监"
                        companyText: "星辰科技"; phoneText: "138-0001-0001"
                        emailText: "zhoujie@flacore.com"
                    }
                }
                CardItem {
                    //forestgreen
                    cardColor:Theme.isDark? Qt.darker( Theme.setColorAlpha("lightcoral",200),0.9):
                                            Qt.lighter(Theme.setColorAlpha("lightcoral",200),1.2)
                    borderColor:"lightcoral"
                    cardWidth: 250; cardHeight: 130; radius: 12
                    delegate: CardContent {
                        avatarSrc: "qrc:/svg/avatar_2.svg"
                        nameText: "李明"; positionText: "软件工程师"
                        companyText: "星辰科技"; phoneText: "139-0002-0002"
                        emailText: "liming@flacore.com"
                    }
                }
                CardItem {
                    cardColor:Theme.isDark? Qt.darker( Theme.setColorAlpha("lightsteelblue",200),0.9):
                                            Qt.lighter(Theme.setColorAlpha("lightsteelblue",200),1.2)
                    borderColor:"lightsteelblue"
                    cardWidth: 250; cardHeight: 130; radius: 12
                    delegate: CardContent {
                        avatarSrc: "qrc:/svg/avatar_3.svg"
                        nameText: "王芳"; positionText: "设计总监"
                        companyText: "创想设计"; phoneText: "137-0003-0003"
                        emailText: "wangfang@flacore.com"
                    }
                }
                CardItem {
                    cardColor:Theme.isDark? Qt.darker( Theme.setColorAlpha("sandybrown",200),0.9):
                                            Qt.lighter(Theme.setColorAlpha("sandybrown",200),1.2)
                    borderColor:"sandybrown"
                    cardWidth: 250; cardHeight: 130; radius: 12
                    delegate: CardContent {
                        avatarSrc: "qrc:/svg/avatar_4.svg"
                        nameText: "张伟"; positionText: "市场经理"
                        companyText: "博远传媒"; phoneText: "136-0004-0004"
                        emailText: "zhangwei@flacore.com"
                    }
                }
                CardItem {
                    cardColor:Theme.isDark? Qt.darker( Theme.setColorAlpha("tomato",200),0.9):
                                            Qt.lighter(Theme.setColorAlpha("tomato",200),1.2)
                    borderColor:"tomato"
                    cardWidth: 250; cardHeight: 130; radius: 12
                    delegate: CardContent {
                        avatarSrc: "qrc:/svg/avatar_5.svg"
                        nameText: "陈静"; positionText: "财务总监"
                        companyText: "星辰科技"; phoneText: "135-0005-0005"
                        emailText: "chenjing@flacore.com"
                    }
                }
            }
        }
        // ========== 波浪线名片卡片区域 ==========
        Row {
            spacing: 10
            Layout.fillWidth: true
            Layout.preferredHeight: 18
            Layout.topMargin: 10
            FlaImage {
                iconsource: FluentIcon.ico_ViewDashboard  //FluentIcons.graph_ViewDashboard
            }
            Text {
                text: qsTr("波浪线名片卡片")
                font.pixelSize: 14
                font.bold: true
                color: Theme.Textcolor
            }
        }
        FlaCardCurveView {
            Layout.fillWidth: true
            Layout.preferredHeight: 220
            layout: FlaCardCurveView.LayoutType.WaveHorizontal
            items: Objects {
                CardItem {
                    cardWidth: 250; cardHeight: 130
                    cardColor:Theme.isDark? Qt.darker( Theme.setColorAlpha("#FF6B6B",200),0.9):
                                            Qt.lighter(Theme.setColorAlpha("#FF6B6B",200),1.2)
                    borderColor:"#FF6B6B"; radius: 12
                    delegate: CardContentEx {
                        ico: "qrc:/svg/avatar_12.svg"
                        nameText: qsTr("哪吒")
                        desc1: qsTr("哪吒，托塔天王李靖第三子，陈塘关总兵之子")
                        desc2: qsTr("三头六臂闹海屠龙，剔骨还父后以莲花重塑肉身")
                    }
                }
                CardItem {
                    cardWidth: 250; cardHeight: 130
                    cardColor:Theme.isDark? Qt.darker( Theme.setColorAlpha("#4169E1",200),0.9):
                                            Qt.lighter(Theme.setColorAlpha("#4169E1",200),1.2)
                    borderColor:"#4169E1"; radius: 12
                    delegate: CardContentEx {
                        ico: "qrc:/svg/avatar_7.svg"
                        nameText: qsTr("姜子牙")
                        desc1: qsTr("姜子牙，元始天尊弟子，昆仑山玉虚宫修道四十年")
                        desc2: qsTr("垂钓渭水遇文王，辅佐武王伐纣兴周八百载")
                    }
                }
                CardItem {
                    cardWidth: 250; cardHeight: 130
                    cardColor:Theme.isDark? Qt.darker( Theme.setColorAlpha("#8B0000",200),0.9):
                                            Qt.lighter(Theme.setColorAlpha("#8B0000",200),1.2)
                    borderColor:"#8B0000"; radius: 12
                    delegate: CardContentEx {
                        ico: "qrc:/svg/avatar_3.svg"
                        nameText: qsTr("钟馗")
                        desc1: qsTr("钟馗，字正南，唐代进士，才华横溢貌丑")
                        desc2: qsTr("因貌见弃撞殿柱而亡，死后誓除天下妖孽")
                    }
                }
                CardItem {
                    cardWidth: 250; cardHeight: 130
                    cardColor:Theme.isDark? Qt.darker( Theme.setColorAlpha("#4B0082",200),0.9):
                                            Qt.lighter(Theme.setColorAlpha("#4B0082",200),1.2)
                    borderColor:"#4B0082"; radius: 12
                    delegate: CardContentEx {
                        ico: "qrc:/svg/avatar_9.svg"
                        nameText: qsTr("阎王")
                        desc1: qsTr("阎王，冥界之主，掌管生死簿判善恶因果")
                        desc2: qsTr("十殿阎罗各司其职，审判亡魂轮回转世")
                    }
                }
                CardItem {
                    cardWidth: 250; cardHeight: 130
                    cardColor:Theme.isDark? Qt.darker( Theme.setColorAlpha("#FFB6C1",200),0.9):
                                            Qt.lighter(Theme.setColorAlpha("#FFB6C1",200),1.2)
                    borderColor:"#FFB6C1"; radius: 12
                    delegate: CardContentEx {
                        ico: "qrc:/svg/avatar_1.svg"
                        nameText: qsTr("白娘子")
                        desc1: qsTr("白素贞，白蛇修炼成形，与许仙千年等一回")
                        desc2: qsTr("端午饮雄黄现原形，水漫金山被法海镇压雷峰塔")
                    }
                }
                CardItem {
                    cardWidth: 250; cardHeight: 130
                    cardColor:Theme.isDark? Qt.darker( Theme.setColorAlpha("#DDA0DD",200),0.9):
                                            Qt.lighter(Theme.setColorAlpha("#DDA0DD",200),1.2)
                    borderColor:"#DDA0DD"; radius: 12
                    delegate: CardContentEx {
                        ico: "qrc:/svg/avatar_2.svg"
                        nameText: qsTr("聂小倩")
                        desc1: qsTr("聂小倩，女鬼，十八线野鬼姥姥驱使害人")
                        desc2: qsTr("宁采臣义助超度，终随心上人投胎转世")
                    }
                }
                CardItem {
                    cardWidth: 250; cardHeight: 130
                    cardColor:Theme.isDark? Qt.darker( Theme.setColorAlpha("#D2B48C",200),0.9):
                                            Qt.lighter(Theme.setColorAlpha("#D2B48C",200),1.2)
                    borderColor:"#D2B48C"; radius: 12
                    delegate: CardContentEx {
                        ico: "qrc:/svg/avatar_4.svg"
                        nameText: qsTr("孟婆")
                        desc1: qsTr("孟婆，地府神祇，守奈何桥畔熬制孟婆汤")
                        desc2: qsTr("亡魂饮汤忘却前世记忆，放下执念重入轮回")
                    }
                }
                CardItem {
                    cardWidth: 250; cardHeight: 130
                    cardColor:Theme.isDark? Qt.darker( Theme.setColorAlpha("#2F4F4F",200),0.9):
                                            Qt.lighter(Theme.setColorAlpha("#2F4F4F",200),1.2)
                    borderColor:"#2F4F4F"; radius: 12
                    delegate: CardContentEx {
                        ico: "qrc:/svg/avatar_5.svg"
                        nameText: qsTr("刑天")
                        desc1: qsTr("刑天，上古刑神，与黄帝争位被斩首")
                        desc2: qsTr("以乳为目以脐为口，操干戚舞不止斗志不灭")
                    }
                }
                CardItem {
                    cardWidth: 250; cardHeight: 130
                    cardColor:Theme.isDark? Qt.darker( Theme.setColorAlpha("#4682B4",200),0.9):
                                            Qt.lighter(Theme.setColorAlpha("#4682B4",200),1.2)
                    borderColor:"#4682B4"; radius: 12
                    delegate: CardContentEx {
                        ico: "qrc:/svg/avatar_8.svg"
                        nameText: qsTr("共工")
                        desc1: qsTr("共工，水神，掌控天下水脉，性格刚烈")
                        desc2: qsTr("怒触不周山导致天塌地陷，女娲炼石补天")
                    }
                }
                CardItem {
                    cardWidth: 250; cardHeight: 130
                    cardColor:Theme.isDark? Qt.darker( Theme.setColorAlpha("#FF4500",200),0.9):
                                            Qt.lighter(Theme.setColorAlpha("#FF4500",200),1.2)
                    borderColor:"#FF4500"; radius: 12
                    delegate: CardContentEx {
                        ico: "qrc:/svg/avatar_11.svg"
                        nameText: qsTr("祝融")
                        desc1: qsTr("祝融，火神，南方天帝，驾龙车巡游")
                        desc2: qsTr("与共工大战不周山，火焰焚尽世间万物")
                    }
                }
            }
        }
        // ========== 普通垂直 + 波浪垂直 并排区域 ==========
        RowLayout {
            Layout.fillWidth: true
            Layout.preferredHeight: 420
            Layout.topMargin: 10
            spacing: 10
            // 左：普通垂直名片卡片
            ColumnLayout {
                Layout.fillWidth: true
                Layout.fillHeight: true
                Row {
                    spacing: 10
                    Layout.fillWidth: true
                    Layout.preferredHeight: 18
                    FlaImage {
                        iconsource: FluentIcon.ico_PrintCustomRange
                    }
                    Text {
                        text: qsTr("普通垂直名片卡片")
                        font.pixelSize: 14
                        font.bold: true
                        color: Theme.Textcolor
                    }
                }
                FlaCardCurveView {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    spacing:10
                    layout: FlaCardCurveView.LayoutType.Column
                    items: Objects {
                        CardItem {
                            cardWidth: 250; cardHeight: 130
                            cardColor:Theme.isDark? Qt.darker( Theme.setColorAlpha("#8B4513",200),0.9):
                                                    Qt.lighter(Theme.setColorAlpha("#8B4513",200),1.2)
                            borderColor:"#8B4513"; radius: 12
                            delegate: CardContentEx {
                                ico: "qrc:/svg/avatar_12.svg"
                                nameText: qsTr("盘古")
                                desc1: qsTr("盘古，开天辟地之神，孕育于混沌之中")
                                desc2: qsTr("以斧劈开天地，身化山河日月，功成身死")
                            }
                        }
                        CardItem {
                            cardWidth: 250; cardHeight: 130
                            cardColor:Theme.isDark? Qt.darker( Theme.setColorAlpha("#FF69B4",200),0.9):
                                                    Qt.lighter(Theme.setColorAlpha("#FF69B4",200),1.2)
                            borderColor:"#FF69B4"; radius: 12
                            delegate: CardContentEx {
                                ico: "qrc:/svg/avatar_7.svg"
                                nameText: qsTr("女娲")
                                desc1: qsTr("女娲，伏羲之妹，人类始祖神")
                                desc2: qsTr("抟土造人戏彩绳，炼五色石补天缺")
                            }
                        }
                        CardItem {
                            cardWidth: 250; cardHeight: 130
                            cardColor:Theme.isDark? Qt.darker( Theme.setColorAlpha("#DAA520",200),0.9):
                                                    Qt.lighter(Theme.setColorAlpha("#DAA520",200),1.2)
                            borderColor:"#DAA520"; radius: 12
                            delegate: CardContentEx {
                                ico: "qrc:/svg/avatar_3.svg"
                                nameText: qsTr("伏羲")
                                desc1: qsTr("伏羲，三皇之一，画卦创造八卦")
                                desc2: qsTr("教民结网狩猎创造乐器，与女娲同为人类始祖")
                            }
                        }
                        CardItem {
                            cardWidth: 250; cardHeight: 130
                            cardColor:Theme.isDark? Qt.darker( Theme.setColorAlpha("#228B22",200),0.9):
                                                    Qt.lighter(Theme.setColorAlpha("#228B22",200),1.2)
                            borderColor:"#228B22"; radius: 12
                            delegate: CardContentEx {
                                ico: "qrc:/svg/avatar_9.svg"
                                nameText: qsTr("神农")
                                desc1: qsTr("神农，姜水流域部落首领，号神农氏")
                                desc2: qsTr("亲尝百草辨药性，创农耕教民耕作")
                            }
                        }
                        CardItem {
                            cardWidth: 250; cardHeight: 130
                            cardColor:Theme.isDark? Qt.darker( Theme.setColorAlpha("#FF8C00",200),0.9):
                                                    Qt.lighter(Theme.setColorAlpha("#FF8C00",200),1.2)
                            borderColor:"#FF8C00"; radius: 12
                            delegate: CardContentEx {
                                ico: "qrc:/svg/avatar_1.svg"
                                nameText: qsTr("夸父")
                                desc1: qsTr("夸父，上古巨人，逐日之神")
                                desc2: qsTr("追逐太阳渴饮河渭，杖化邓林遗泽后世")
                            }
                        }
                        CardItem {
                            cardWidth: 250; cardHeight: 130
                            cardColor:Theme.isDark? Qt.darker( Theme.setColorAlpha("#4169E1",200),0.9):
                                                    Qt.lighter(Theme.setColorAlpha("#4169E1",200),1.2)
                            borderColor:"#4169E1"; radius: 12
                            delegate: CardContentEx {
                                ico: "qrc:/svg/avatar_2.svg"
                                nameText: qsTr("后羿")
                                desc1: qsTr("后羿，夏朝有穷国君，射日英雄")
                                desc2: qsTr("弯弓射落九日救苍生，嫦娥奔月是其妻")
                            }
                        }
                        CardItem {
                            cardWidth: 250; cardHeight: 130
                            cardColor:Theme.isDark? Qt.darker( Theme.setColorAlpha("#DDA0DD",200),0.9):
                                                    Qt.lighter(Theme.setColorAlpha("#DDA0DD",200),1.2)
                            borderColor:"#DDA0DD"; radius: 12
                            delegate: CardContentEx {
                                ico: "qrc:/svg/avatar_4.svg"
                                nameText: qsTr("嫦娥")
                                desc1: qsTr("嫦娥，后羿之妻，吞不死药飞升")
                                desc2: qsTr("奔月独守广寒宫，玉兔捣药伴其左右")
                            }
                        }
                        CardItem {
                            cardWidth: 250; cardHeight: 130
                            cardColor:Theme.isDark? Qt.darker( Theme.setColorAlpha("#CD853F",200),0.9):
                                                    Qt.lighter(Theme.setColorAlpha("#CD853F",200),1.2)
                            borderColor:"#CD853F"; radius: 12
                            delegate: CardContentEx {
                                ico: "qrc:/svg/avatar_5.svg"
                                nameText: qsTr("吴刚")
                                desc1: qsTr("吴刚，汉代西河人，学仙有过")
                                desc2: qsTr("斧伐桂树永不休，桂随创随合千年如一")
                            }
                        }
                    }
                }
            }
            // 右：波浪垂直名片卡片
            ColumnLayout {
                Layout.fillWidth: true
                Layout.fillHeight: true
                Row {
                    spacing: 10
                    Layout.fillWidth: true
                    Layout.preferredHeight: 18
                    FlaImage {
                        iconsource: FluentIcon.ico_WebSearch    //FluentIcons.graph_WebSearch
                    }
                    Text {
                        text: qsTr("波浪垂直名片卡片")
                        font.pixelSize: 14
                        font.bold: true
                        color: Theme.Textcolor
                    }
                }
                FlaCardCurveView {
                    Layout.preferredWidth: 350
                    Layout.fillHeight: true
                    layout: FlaCardCurveView.LayoutType.WaveVertical
                    spacing:10
                    items: Objects {
                        CardItem {
                            cardWidth: 250; cardHeight: 130
                            cardColor:Theme.isDark? Qt.darker( Theme.setColorAlpha("#B22222",200),0.9):
                                                    Qt.lighter(Theme.setColorAlpha("#B22222",200),1.2)
                            borderColor:"#B22222"; radius: 12
                            delegate: CardContentEx {
                                ico: "qrc:/svg/avatar_6.svg"
                                nameText: qsTr("精卫")
                                desc1: qsTr("精卫，炎帝女，名女娃，溺死于东海")
                                desc2: qsTr("化鸟衔木石誓填沧海，坚韧不拔的精神象征")
                            }
                        }
                        CardItem {
                            cardWidth: 250; cardHeight: 130
                            cardColor:Theme.isDark? Qt.darker( Theme.setColorAlpha("#4682B4",200),0.9):
                                                    Qt.lighter(Theme.setColorAlpha("#4682B4",200),1.2)
                            borderColor:"#4682B4"; radius: 12
                            delegate: CardContentEx {
                                ico: "qrc:/svg/avatar_8.svg"
                                nameText: qsTr("鲲鹏")
                                desc1: qsTr("鲲，北海鱼名，化而为鸟，其名曰鹏")
                                desc2: qsTr("翼若垂天之云，扶摇直上九万里，水击三千里")
                            }
                        }
                        CardItem {
                            cardWidth: 250; cardHeight: 130
                            cardColor:Theme.isDark? Qt.darker( Theme.setColorAlpha("#FF4500",200),0.9):
                                                    Qt.lighter(Theme.setColorAlpha("#FF4500",200),1.2)
                            borderColor:"#FF4500"; radius: 12
                            delegate: CardContentEx {
                                ico: "qrc:/svg/avatar_11.svg"
                                nameText: qsTr("烛龙")
                                desc1: qsTr("烛龙，人面龙身之神，开目为昼闭目为夜")
                                desc2: qsTr("衔火精照九泉之下，司昼夜明暗之神")
                            }
                        }
                        CardItem {
                            cardWidth: 250; cardHeight: 130
                            cardColor:Theme.isDark? Qt.darker( Theme.setColorAlpha("#9400D3",200),0.9):
                                                    Qt.lighter(Theme.setColorAlpha("#9400D3",200),1.2)
                            borderColor:"#9400D3"; radius: 12
                            delegate: CardContentEx {
                                ico: "qrc:/svg/avatar_5.svg"
                                nameText: qsTr("九天玄女")
                                desc1: qsTr("九天玄女，天界战神，人首鸟身")
                                desc2: qsTr("传授兵法天书于黄帝，破蚩尤妖术")
                            }
                        }
                        CardItem {
                            cardWidth: 250; cardHeight: 130
                            cardColor:Theme.isDark? Qt.darker( Theme.setColorAlpha("#708090",200),0.9):
                                                    Qt.lighter(Theme.setColorAlpha("#708090",200),1.2)
                            borderColor:"#708090"; radius: 12
                            delegate: CardContentEx {
                                ico: "qrc:/svg/avatar_12.svg"
                                nameText: qsTr("雷公")
                                desc1: qsTr("雷公，雷部主神，执掌天雷")
                                desc2: qsTr("凿目电母是其妻，驾龙车行雷布雨")
                            }
                        }
                        CardItem {
                            cardWidth: 250; cardHeight: 130
                            cardColor:Theme.isDark? Qt.darker( Theme.setColorAlpha("#00CED1",200),0.9):
                                                    Qt.lighter(Theme.setColorAlpha("#00CED1",200),1.2)
                            borderColor:"#00CED1"; radius: 12
                            delegate: CardContentEx {
                                ico: "qrc:/svg/avatar_7.svg"
                                nameText: qsTr("电母")
                                desc1: qsTr("电母，雷公之妻，持镜引闪电")
                                desc2: qsTr("与雷公同掌雷电视风雨，照耀世间黑暗")
                            }
                        }
                        CardItem {
                            cardWidth: 250; cardHeight: 130
                            cardColor:Theme.isDark? Qt.darker( Theme.setColorAlpha("#98FB98",200),0.9):
                                                    Qt.lighter(Theme.setColorAlpha("#98FB98",200),1.2)
                            borderColor:"#98FB98"; radius: 12
                            delegate: CardContentEx {
                                ico: "qrc:/svg/avatar_3.svg"
                                nameText: qsTr("风伯")
                                desc1: qsTr("风伯，飞廉，风神之首")
                                desc2: qsTr("翼扇搏风起云涌，助黄帝战蚩尤")
                            }
                        }
                        CardItem {
                            cardWidth: 250; cardHeight: 130
                            cardColor:Theme.isDark? Qt.darker( Theme.setColorAlpha("#87CEEB",200),0.9):
                                                    Qt.lighter(Theme.setColorAlpha("#87CEEB",200),1.2)
                            borderColor:"#87CEEB"; radius: 12
                            delegate: CardContentEx {
                                ico: "qrc:/svg/avatar_1.svg"
                                nameText: qsTr("雨师")
                                desc1: qsTr("雨师，屏翳，云雨之神")
                                desc2: qsTr("纵云雨润万物，潜随风入夜润物无声")
                            }
                        }
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
}
