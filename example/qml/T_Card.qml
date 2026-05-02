import QtQuick
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
import FlaCoreUI

Item {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 5
        spacing: 2
        Text {
            id: title
            text: qsTr("👥 名片卡片")
            font.pixelSize: 16
            font.bold: true
            color: Theme.Textcolor
        }
        FlaCard {
            Layout.fillWidth: true
            Layout.preferredHeight: 110
            layout: FlaCard.LayoutType.Horizontal
            spacing: 5
            items: Objects {
                CardItemDelegate {
                    cardColor: "white"
                    cardWidth: 200
                    cardHeight: 110
                    /*delegate: Item {
                        anchors.fill: parent

                        Row {
                            anchors.fill: parent

                            Rectangle {
                                width: 70
                                height: parent.height
                                color: "#6892ED"

                                Rectangle {
                                    anchors.centerIn: parent
                                    width: 50
                                    height: 50
                                    radius: 25
                                    clip: true
                                    Image {
                                        anchors.fill: parent
                                        source: "qrc:/svg/avatar_1.svg"
                                        fillMode: Image.PreserveAspectCrop
                                    }
                                }

                                Rectangle {
                                    width: 20
                                    height: 20
                                    radius: 10
                                    color: "#A5B4FC"
                                    opacity: 0.4
                                    anchors.right: parent.right
                                    anchors.top: parent.top
                                    anchors.margins: 5
                                }
                            }

                            Column {
                                width: 130
                                height: parent.height
                                padding: 10
                                spacing: 3
                                topPadding: 15

                                Text {
                                    text: "Lin Xiao"
                                    font.pixelSize: 11
                                    font.bold: true
                                    color: "#1E1E2E"
                                }

                                Text {
                                    text: "「设计是凝固的音乐」"
                                    font.pixelSize: 6
                                    font.italic: true
                                    color: "#8B5CF6"
                                }

                                Rectangle {
                                    width: 50
                                    height: 1
                                    color: "#E0E0E0"
                                }

                                Text {
                                    text: "📧 linxiao@design.studio"
                                    font.pixelSize: 5
                                    color: "#6B6B8D"
                                }

                                Text {
                                    text: "📞 +86 138 0000 1234"
                                    font.pixelSize: 5
                                    color: "#6B6B8D"
                                }

                                Text {
                                    text: "🌐 www.linxiao.design"
                                    font.pixelSize: 5
                                    color: "#6B6B8D"
                                }

                                Text {
                                    text: "📍 北京市朝阳区798艺术区"
                                    font.pixelSize: 5
                                    color: "#6B6B8D"
                                }
                            }
                        }
                    }*/
                }
                CardItemDelegate {
                    cardColor: "white"
                    cardWidth: 200
                    cardHeight: 110
                }
                CardItemDelegate {
                    cardColor: "white"
                    cardWidth: 200
                    cardHeight: 110
                }
                CardItemDelegate {
                    cardColor: "white"
                    cardWidth: 200
                    cardHeight: 110
                }


            }
        }

        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true
        }
    }
}