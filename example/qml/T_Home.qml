import QtQuick
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
import FlaCoreUI
Item {
    id: root
    component CardContent: Item {
        anchors.fill: parent
        property string ico: ""
        property string nameText: ""
        property string desc1: ""
        property string desc2: ""
        RowLayout {
            anchors.fill: parent
            spacing: 4
            Item {
                Layout.leftMargin: 5   // 左外边距
                Layout.rightMargin: 5  // 右外边距
                Layout.topMargin: 5    // 上外边距
                Layout.bottomMargin: 5 // 下外边距
                Layout.preferredWidth: 60
                Layout.fillHeight: true

                Column {
                    anchors.fill: parent
                    anchors.horizontalCenter: parent.horizontalCenter
                    padding: 10
                    spacing: 10
                    Image {
                        width: 60
                        height: 60
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
                        color: "white"
                        font.pixelSize: 16
                        font.bold: true
                        horizontalAlignment: Text.AlignHCenter
                    }
                }
            }
            Item {
                Layout.leftMargin: 4   // 左外边距
                Layout.rightMargin: 4  // 右外边距
                Layout.topMargin: 4   // 上外边距
                Layout.bottomMargin:4 // 下外边距
                Layout.fillWidth: true
                Layout.fillHeight: true
                Column {
                    anchors.fill: parent
                    anchors.horizontalCenter: parent.horizontalCenter
                    padding: 5
                    spacing: 5
                    Text {
                        anchors.left: parent.left
                        width: parent.width
                        text: desc1
                        color: "white"
                        font.pixelSize: 13
                        wrapMode: Text.WordWrap
                        horizontalAlignment: Text.AlignLeft
                    }
                    Text {
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.left: parent.left
                        width: parent.width
                        text: desc2
                        color: "darkslategray"
                        font.pixelSize: 12
                        wrapMode: Text.WordWrap
                        horizontalAlignment: Text.AlignLeft
                    }
                }
            }
        }
    }
    FlaGroupBox{
        anchors.fill: parent
        radius: 8
        ColumnLayout{
            anchors.fill: parent
            spacing: 1
            Row{
                Layout.fillWidth: true
                Layout.preferredHeight: 80
                spacing: 10
                Image{
                    anchors.verticalCenter: parent.verticalCenter
                    width: 80
                    height: 80
                    source: "qrc:/favicon.ico"
                    fillMode: Image.PreserveAspectCrop
                }
                Text{
                    anchors.verticalCenter: parent.verticalCenter
                    text: "FlaCoreUI"
                    font.pixelSize: 30
                    font.bold: true
                    color: Theme.Textcolor
                }
            }
            Text {
                Layout.fillWidth: true
                text: qsTr("FlaCoreUI 是一套基于 Qt/QML 构建的 Fluent 风格核心组件库")
                color: Theme.Textcolor
                Layout.leftMargin: 15
            }
            Item {
                Layout.fillWidth: true
                FlaCardCurveView{
                    width: parent.width
                    height: 220
                    layout: FlaCardCurveView.LayoutType.WaveHorizontal
                    items: Objects{
                        CardItem {
                            cardWidth: 250
                            cardHeight: 130
                            cardColor:Theme.isDark? Qt.darker( Theme.setColorAlpha("#72AC9E",200),0.9):
                                                    Qt.lighter(Theme.setColorAlpha("#72AC9E",200),1.2)
                            borderColor:"#72AC9E"
                            radius: 12
                            delegate: CardContent {
                                ico: "qrc:/svg/avatar_12.svg"
                                nameText: qsTr("孙悟空")
                                desc1: qsTr("孙悟空，是中国古典名著《西游记》中的核心主角，又名美猴王、齐天大圣、孙行者")
                                desc2: qsTr("他从仙石中孕育而生，带领猴群发现水帘洞，被尊为美猴王")
                            }
                        }
                        CardItem {
                            cardWidth: 250
                            cardHeight: 130
                            cardColor:Theme.isDark? Qt.darker( Theme.setColorAlpha("#dc5474",200),0.9):
                                                    Qt.lighter(Theme.setColorAlpha("#dc5474",200),1.2)
                            borderColor:"#dc5474"
                            radius: 12
                            delegate: CardContent {
                                ico: "qrc:/svg/avatar_7.svg"
                                nameText: qsTr("唐僧")
                                desc1: qsTr("唐僧，是取经团队的领袖，原为如来佛祖弟子金蝉子转世")
                                desc2: qsTr("慈悲为怀，不畏艰险赴西天取经，三徒弟护法，终成正果，被封为旃檀功德佛")
                            }
                        }
                        CardItem {
                            cardWidth: 250
                            cardHeight: 130
                            cardColor:Theme.isDark? Qt.darker( Theme.setColorAlpha("#A578FF",200),0.9):
                                                    Qt.lighter(Theme.setColorAlpha("#A578FF",200),1.2)
                            borderColor:"#A578FF"
                            radius: 12
                            delegate: CardContent {
                                ico: "qrc:/svg/avatar_3.svg"
                                nameText: qsTr("猪八戒")
                                desc1: qsTr("猪八戒，原为天蓬元帅，因醉酒调戏嫦娥被贬下凡，错投猪胎")
                                desc2: qsTr("贪吃好色，法号悟能，但忠心耿耿辅助唐僧取经，被封为净坛使者")
                            }
                        }
                        CardItem {
                            cardWidth: 250
                            cardHeight: 130
                            cardColor:Theme.isDark? Qt.darker( Theme.setColorAlpha("#e28899",200),0.9):
                                                    Qt.lighter(Theme.setColorAlpha("#e28899",200),1.2)
                            borderColor:"#e28899"
                            radius: 12
                            delegate: CardContent {
                                ico: "qrc:/svg/avatar_9.svg"
                                nameText: qsTr("沙悟净")
                                desc1: qsTr("沙悟净，原为卷帘大将，因打破琉璃盏被贬流沙河，受观音点化拜唐僧为师")
                                desc2: qsTr("沉默寡言，忠诚可靠，一路挑担牵马护主，被封为金身罗汉")
                            }
                        }
                        CardItem {
                            cardWidth: 250
                            cardHeight: 130
                            cardColor:Theme.isDark? Qt.darker( Theme.setColorAlpha("#CD853F",200),0.9):
                                                    Qt.lighter(Theme.setColorAlpha("#CD853F",200),1.2)
                            borderColor:"#CD853F"
                            radius: 12
                            delegate: CardContent {
                                ico: "qrc:/svg/avatar_1.svg"
                                nameText: qsTr("牛魔王")
                                desc1: qsTr("牛魔王，孙悟空结拜大哥，翠云山芭蕉洞主，坐骑辟水金睛兽")
                                desc2: qsTr("手持混铁棍，与孙悟空大战不相上下，西游记中唯一敢称大圣的妖王")
                            }
                        }
                        CardItem {
                            cardWidth: 250
                            cardHeight: 130
                            cardColor:Theme.isDark? Qt.darker( Theme.setColorAlpha("#DB7093",200),0.9):
                                                    Qt.lighter(Theme.setColorAlpha("#DB7093",200),1.2)
                            borderColor:"#DB7093"
                            radius: 12
                            delegate: CardContent {
                                ico: "qrc:/svg/avatar_2.svg"
                                nameText: qsTr("铁扇公主")
                                desc1: qsTr("铁扇公主，牛魔王之妻，翠云山芭蕉洞女主人，又名罗刹女")
                                desc2: qsTr("手持芭蕉扇，能扇灭火焰山之火，儿子红孩儿后成观音弟子")
                            }
                        }
                        CardItem {
                            cardWidth: 250
                            cardHeight: 130
                            cardColor:Theme.isDark? Qt.darker( Theme.setColorAlpha("#708090",200),0.9):
                                                    Qt.lighter(Theme.setColorAlpha("#708090",200),1.2)
                            borderColor:"#708090"
                            radius: 12
                            delegate: CardContent {
                                ico: "qrc:/svg/avatar_4.svg"
                                nameText: qsTr("杨戬")
                                desc1: qsTr("杨戬，灌江口二郎神，玉帝外甥，三界战神，三眼能辨妖怪真伪")
                                desc2: qsTr("座下细犬随行，法力高强，听调不听宣，劈山救母威震三界")
                            }
                        }
                        CardItem {
                            cardWidth: 250
                            cardHeight: 130
                            cardColor:Theme.isDark? Qt.darker( Theme.setColorAlpha("#FF4500",200),0.9):
                                                                    Qt.lighter(Theme.setColorAlpha("#FF4500",200),1.2)
                            borderColor:"#FF4500"
                            radius: 12
                            delegate: CardContent {
                                ico: "qrc:/svg/avatar_5.svg"
                                nameText: qsTr("红孩儿")
                                desc1: qsTr("圣婴大王红孩儿，牛魔王与铁扇公主之子，修炼三昧真火神通")
                                desc2: qsTr("占山为王捉唐僧，观音菩萨用玉净瓶甘露降服，收为善财童子")
                            }
                        }
                        CardItem {
                            cardWidth: 250
                            cardHeight: 130
                            cardColor:Theme.isDark? Qt.darker( Theme.setColorAlpha("#DDA0DD",200),0.9):
                                                                    Qt.lighter(Theme.setColorAlpha("#DDA0DD",200),1.2)
                            borderColor:"#DDA0DD"
                            radius: 12
                            delegate: CardContent {
                                ico: "qrc:/svg/avatar_6.svg"
                                nameText: qsTr("玉兔精")
                                desc1: qsTr("玉兔精，本为广寒宫中捣药的玉兔，因私逃下界化作天竺国公主")
                                desc2: qsTr("欲取唐僧元阳成仙，被太阴星君识破收回月宫，幸免于孙悟空的追杀")
                            }
                        }
                        CardItem {
                            cardWidth: 250
                            cardHeight: 130
                            cardColor:Theme.isDark? Qt.darker( Theme.setColorAlpha("#4682B4",200),0.9):
                                                                    Qt.lighter(Theme.setColorAlpha("#4682B4",200),1.2)
                            borderColor:"#4682B4"
                            radius: 12
                            delegate: CardContent {
                                ico: "qrc:/svg/avatar_8.svg"
                                nameText: qsTr("小白龙")
                                desc1: qsTr("小白龙，西海龙王敖闰第三子，因纵火烧殿上明珠被贬蛇盘山鹰愁涧")
                                desc2: qsTr("得观音点化化作白马驮负唐僧西行，历经艰辛终成八部天龙广力菩萨")
                            }
                        }
                        CardItem {
                            cardWidth: 250
                            cardHeight: 130
                            cardColor:Theme.isDark? Qt.darker( Theme.setColorAlpha("#DAA520",200),0.9):
                                                                    Qt.lighter(Theme.setColorAlpha("#DAA520",200),1.2)
                            borderColor:"#DAA520"
                            radius: 12
                            delegate: CardContent {
                                ico: "qrc:/svg/avatar_11.svg"
                                nameText: qsTr("菩提祖师")
                                desc1: qsTr("菩提祖师，住灵台方寸山斜月三星洞，精通佛道儒三教法力深不可测")
                                desc2: qsTr("短短数年将孙悟空调教成三界闻名的齐天大圣，后再未现身于三界")
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