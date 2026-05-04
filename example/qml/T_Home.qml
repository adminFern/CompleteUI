import QtQuick
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
import FlaCoreUI
Item {
    id: root

    component CardContent: Item{
        anchors.fill: parent
        property string ico: ""
        property string nameText: ""
        property string positionText: ""
        property string companyText: ""
        property string phoneText: ""
        property string emailText: ""
        Image {
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.topMargin: 10
            anchors.leftMargin: 10
            width: 50
            height: 50
            source: ico
            fillMode: Image.PreserveAspectCrop
            // ColorOverlay {
            //       anchors.fill: parent
            //       source: parent
            //       color: "dimgray"           // 你想要的颜色
            //   }

        }

    }

    Rectangle{
        anchors.fill: parent
        color: Theme.isDark?  Theme.setColorAlpha("#3C3C3C",100): Theme.setColorAlpha("white",150)
        Column{
            anchors.fill: parent
            padding: 10
            spacing: 5
            Row{
                width: parent.width
                height: 80
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
                text: qsTr("FlaCoreUI 是一套基于 Qt/QML 构建的 Fluent 风格核心组件库")
                color: Theme.Textcolor
                Layout.leftMargin: 15
            }
            FlaCardCurveView{
                width: parent.width
                height: 170
                layout: FlaCardCurveView.LayoutType.WaveHorizontal
                items: Objects{

                    CardItem {
                        cardWidth: 250
                        cardHeight: 130
                        cardColor:Theme.isDark?"#1E293B":"#FFFFFF"
                        radius: 12
                        delegate: CardContent {
                            ico:  "qrc:/svg/github.svg"
                            nameText: "周杰"; positionText: "技术总监"
                            companyText: "星辰科技"; phoneText: "138-0001-0001"
                            emailText: "zhoujie@flacore.com"
                        }
                    }
                    CardItem {
                        cardWidth: 250
                        cardHeight: 130
                        radius: 12
                          cardColor:Theme.isDark?"#1E293B":"#FFFFFF"
                        delegate: CardContent {
                            ico:  "qrc:/svg/github.svg"
                            nameText: "周杰"; positionText: "技术总监"
                            companyText: "星辰科技"; phoneText: "138-0001-0001"
                            emailText: "zhoujie@flacore.com"
                        }
                    }
                    CardItem {
                        cardWidth: 250
                        cardHeight: 130
                        radius: 12
                          cardColor:Theme.isDark?"#1E293B":"#FFFFFF"
                        delegate: CardContent {
                            ico:  "qrc:/svg/github.svg"
                            nameText: "周杰"; positionText: "技术总监"
                            companyText: "星辰科技"; phoneText: "138-0001-0001"
                            emailText: "zhoujie@flacore.com"
                        }
                    }
                    CardItem {
                        cardWidth: 250
                        cardHeight: 130
                        radius: 12
                          cardColor:Theme.isDark?"#1E293B":"#FFFFFF"
                        delegate: CardContent {
                            ico:  "qrc:/svg/github.svg"
                            nameText: "周杰"; positionText: "技术总监"
                            companyText: "星辰科技"; phoneText: "138-0001-0001"
                            emailText: "zhoujie@flacore.com"
                        }
                    }
                    CardItem {
                        cardWidth: 250
                        cardHeight: 130
                        radius: 12
                          cardColor:Theme.isDark?"#1E293B":"#FFFFFF"
                        delegate: CardContent {
                            ico:  "qrc:/svg/github.svg"
                            nameText: "周杰"; positionText: "技术总监"
                            companyText: "星辰科技"; phoneText: "138-0001-0001"
                            emailText: "zhoujie@flacore.com"
                        }
                    }

                }
            }
            Text {
                text: qsTr("最新组件")
                color: Theme.Textcolor
            }
            FlaCardCurveView{
                width: parent.width
                height: 170
                items: Objects{
                    CardItem {
                          cardColor:Theme.isDark?"#1E293B":"#FFFFFF"
                       /// cardColor: Theme.FillCardColor
                        cardWidth: 250
                        cardHeight: 130
                        radius: 12
                        // delegate: CardContent {
                        //     avatarSrc: "qrc:/svg/avatar_2.svg"
                        //     nameText: "李明"; positionText: "软件工程师"
                        //     companyText: "星辰科技"; phoneText: "139-0002-0002"
                        //     emailText: "liming@flacore.com"
                        // }
                    }
                    CardItem {
                          cardColor:Theme.isDark?"#1E293B":"#FFFFFF"
                       /// cardColor: Theme.FillCardColor
                        cardWidth: 250
                        cardHeight: 130
                        radius: 12
                        // delegate: CardContent {
                        //     avatarSrc: "qrc:/svg/avatar_2.svg"
                        //     nameText: "李明"; positionText: "软件工程师"
                        //     companyText: "星辰科技"; phoneText: "139-0002-0002"
                        //     emailText: "liming@flacore.com"
                        // }
                    }
                    CardItem {
                          cardColor:Theme.isDark?"#1E293B":"#FFFFFF"
                       /// cardColor: Theme.FillCardColor
                        cardWidth: 250
                        cardHeight: 130
                        radius: 12
                        // delegate: CardContent {
                        //     avatarSrc: "qrc:/svg/avatar_2.svg"
                        //     nameText: "李明"; positionText: "软件工程师"
                        //     companyText: "星辰科技"; phoneText: "139-0002-0002"
                        //     emailText: "liming@flacore.com"
                        // }
                    }
                    CardItem {
                          cardColor:Theme.isDark?"#1E293B":"#FFFFFF"
                       /// cardColor: Theme.FillCardColor
                        cardWidth: 250
                        cardHeight: 130
                        radius: 12
                        // delegate: CardContent {
                        //     avatarSrc: "qrc:/svg/avatar_2.svg"
                        //     nameText: "李明"; positionText: "软件工程师"
                        //     companyText: "星辰科技"; phoneText: "139-0002-0002"
                        //     emailText: "liming@flacore.com"
                        // }
                    }
                    CardItem {
                          cardColor:Theme.isDark?"#1E293B":"#FFFFFF"
                       /// cardColor: Theme.FillCardColor
                        cardWidth: 250
                        cardHeight: 130
                        radius: 12
                        // delegate: CardContent {
                        //     avatarSrc: "qrc:/svg/avatar_2.svg"
                        //     nameText: "李明"; positionText: "软件工程师"
                        //     companyText: "星辰科技"; phoneText: "139-0002-0002"
                        //     emailText: "liming@flacore.com"
                        // }
                    }
                    CardItem {
                          cardColor:Theme.isDark?"#1E293B":"#FFFFFF"
                       /// cardColor: Theme.FillCardColor
                        cardWidth: 250
                        cardHeight: 130
                        radius: 12
                        // delegate: CardContent {
                        //     avatarSrc: "qrc:/svg/avatar_2.svg"
                        //     nameText: "李明"; positionText: "软件工程师"
                        //     companyText: "星辰科技"; phoneText: "139-0002-0002"
                        //     emailText: "liming@flacore.com"
                        // }
                    }
                }

            }
            FlaCarousel{
                anchors.horizontalCenter: parent.horizontalCenter
                items: Objects {
                    CarouselItem { imagesource: "https://picsum.photos/seed/ghibli-meadow/800/500.jpg" }
                    CarouselItem { imagesource: "https://picsum.photos/seed/ghibli-sky/800/500.jpg" }
                    CarouselItem { imagesource: "https://picsum.photos/seed/ghibli-cat/800/500.jpg" }
                    CarouselItem { imagesource: "https://picsum.photos/seed/ghibli-forest/800/500.jpg" }
                    CarouselItem { imagesource: "https://picsum.photos/seed/ghibli-ocean/800/500.jpg" }
                }
            }
        }
    }

}

/*Rectangle {
        anchors.fill: parent
        color: Theme.FillBackgroundColor
        ColumnLayout{
            anchors.fill: parent
            spacing: 10
            anchors.margins: 5
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



            FlaCardCurveView {
                Layout.fillWidth: true
                Layout.fillHeight: true
                layout: FlaCardCurveView.LayoutType.WaveHorizontal
                items: Objects {
                    CardItemDelegate {
                        cardWidth: 250
                        cardHeight: 130
                        radius: 12
                        delegate: CardContent {
                            ico:  "qrc:/svg/github.svg"
                            nameText: "周杰"; positionText: "技术总监"
                            companyText: "星辰科技"; phoneText: "138-0001-0001"
                            emailText: "zhoujie@flacore.com"
                        }
                    }
                    CardItemDelegate {
                        cardWidth: 250
                        cardHeight: 130
                        radius: 12
                        delegate: CardContent {
                            ico:  "qrc:/svg/git.svg"
                            nameText: "周杰"; positionText: "技术总监"
                            companyText: "星辰科技"; phoneText: "138-0001-0001"
                            emailText: "zhoujie@flacore.com"
                        }
                    }
                    CardItemDelegate {
                        cardWidth: 250
                        cardHeight: 130
                        radius: 12
                        delegate: CardContent {
                            ico:  "qrc:/png/Git.png"
                            nameText: "周杰"; positionText: "技术总监"
                            companyText: "星辰科技"; phoneText: "138-0001-0001"
                            emailText: "zhoujie@flacore.com"
                        }
                    }
                    CardItemDelegate {
                        cardWidth: 250
                        cardHeight: 130
                        radius: 12
                        delegate: CardContent {
                            ico: "qrc:/svg/logo.svg"
                            nameText: "周杰"; positionText: "技术总监"
                            companyText: "星辰科技"; phoneText: "138-0001-0001"
                            emailText: "zhoujie@flacore.com"
                        }
                    }
                    CardItemDelegate {
                        cardWidth: 250
                        cardHeight: 130
                        radius: 12
                        // delegate: CardContent {
                        //     avatarSrc: "qrc:/svg/avatar_1.svg"
                        //     nameText: "周杰"; positionText: "技术总监"
                        //     companyText: "星辰科技"; phoneText: "138-0001-0001"
                        //     emailText: "zhoujie@flacore.com"
                        // }
                    }

                }

            }
            Item {
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.leftMargin: 15
                Column{
                    anchors.fill: parent
                    Text {
                        Layout.fillWidth: true
                        text: qsTr("最新组件")
                        color: Theme.Textcolor
                    }
                    FlaCardCurveView{
                        items: Objects{
                            CardItemDelegate {
                               /// cardColor: Theme.FillCardColor
                                cardWidth: 250
                                cardHeight: 130
                                radius: 12
                                // delegate: CardContent {
                                //     avatarSrc: "qrc:/svg/avatar_2.svg"
                                //     nameText: "李明"; positionText: "软件工程师"
                                //     companyText: "星辰科技"; phoneText: "139-0002-0002"
                                //     emailText: "liming@flacore.com"
                                // }
                            }
                        }

                    }
                }



            }

            // Image {
            //     id: name
            //     width: 100
            //     height: 100
            //     source: "qrc:/svg/github.svg"
            //     fillMode: Image.PreserveAspectCrop

            // }


            Item {
                Layout.fillWidth: true
                Layout.fillHeight: true
            }

        }


    }*/



