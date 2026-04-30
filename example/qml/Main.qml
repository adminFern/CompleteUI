import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import FlaCoreUI

FlaWindow {
    id: win
    width: 1128
    height: 700
    visible: true
    title: qsTr("FlaCards 布局示例")
    icon: "qrc:/favicon.ico"
    fixSize: true

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 30
        spacing: 40

        Text {
            text: "Horizontal Layout"
            font.pixelSize: 20
            font.weight: Font.Bold
        }

        FlaCards {
            Layout.fillWidth: true
            Layout.preferredHeight: 140
            layout: FlaCards.LayoutType.Horizontal
            spacing: 20

            items: Objects {
                CardItemDelegate {
                    cardColor: "#f43f5e"
                    delegate: Column {
                        spacing: 5
                        Text {
                            anchors.horizontalCenter: parent.horizontalCenter
                            text: "Hover Me"
                            color: "white"
                            font.pixelSize: 16
                            font.weight: Font.Bold
                        }
                        Text {
                            anchors.horizontalCenter: parent.horizontalCenter
                            text: "Lorem Ipsum"
                            color: "white"
                            font.pixelSize: 11
                        }
                    }
                }
                CardItemDelegate {
                    cardColor: "#3b82f6"
                    delegate: Column {
                        spacing: 2
                        Text {
                            anchors.horizontalCenter: parent.horizontalCenter
                            text: "Users"
                            color: "white"
                            font.pixelSize: 12
                        }
                        Row {
                            anchors.horizontalCenter: parent.horizontalCenter
                            spacing: 2
                            Text {
                                text: "1,234"
                                color: "white"
                                font.pixelSize: 28
                                font.weight: Font.Bold
                            }
                            Text {
                                text: "online"
                                color: "white"
                                font.pixelSize: 14
                                anchors.baseline: parent.children[0].baseline
                            }
                        }
                    }
                }
                CardItemDelegate {
                    cardColor: "#10b981"
                    delegate: Column {
                        spacing: 8
                        FlaImage {
                            anchors.horizontalCenter: parent.horizontalCenter
                            iconsource: FluentIcon.ico_Checkmark
                            iconsize: 32
                            icocolor: "white"
                        }
                        Text {
                            anchors.horizontalCenter: parent.horizontalCenter
                            text: "Custom Component"
                            color: "white"
                            font.pixelSize: 18
                            font.weight: Font.Bold
                        }
                    }
                }
            }
            onCardClicked: function(index, item) {
                console.log("Horizontal clicked:", index)
            }
        }

        Text {
            text: "Vertical Layout"
            font.pixelSize: 20
            font.weight: Font.Bold
        }

        FlaCards {
            Layout.fillWidth: true
            Layout.fillHeight: true
            layout: FlaCards.LayoutType.Vertical
            spacing: 15

            items: Objects {
                CardItemDelegate {
                    cardColor: "#8b5cf6"
                    cardWidth: 220
                    cardHeight: 60
                    delegate: Row {
                        spacing: 10
                        anchors.verticalCenter: parent.verticalCenter
                        FlaImage {
                            iconsource: FluentIcon.ico_Mail
                            iconsize: 20
                            icocolor: "white"
                        }
                        Text {
                            text: "Inbox"
                            color: "white"
                            font.pixelSize: 14
                            font.weight: Font.Bold
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        Text {
                            text: "3 new"
                            color: "#c4b5fd"
                            font.pixelSize: 12
                            anchors.verticalCenter: parent.verticalCenter
                        }
                    }
                }
                CardItemDelegate {
                    cardColor: "#ec4899"
                    cardWidth: 220
                    cardHeight: 60
                    delegate: Row {
                        spacing: 10
                        anchors.verticalCenter: parent.verticalCenter
                        FlaImage {
                            iconsource: FluentIcon.ico_Heart
                            iconsize: 20
                            icocolor: "white"
                        }
                        Text {
                            text: "Favorites"
                            color: "white"
                            font.pixelSize: 14
                            font.weight: Font.Bold
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        Text {
                            text: "12 items"
                            color: "#f9a8d4"
                            font.pixelSize: 12
                            anchors.verticalCenter: parent.verticalCenter
                        }
                    }
                }
                CardItemDelegate {
                    cardColor: "#f59e0b"
                    cardWidth: 220
                    cardHeight: 60
                    delegate: Row {
                        spacing: 10
                        anchors.verticalCenter: parent.verticalCenter
                        FlaImage {
                            iconsource: FluentIcon.ico_Star
                            iconsize: 20
                            icocolor: "white"
                        }
                        Text {
                            text: "Starred"
                            color: "white"
                            font.pixelSize: 14
                            font.weight: Font.Bold
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        Text {
                            text: "5 items"
                            color: "#fde68a"
                            font.pixelSize: 12
                            anchors.verticalCenter: parent.verticalCenter
                        }
                    }
                }
            }
            onCardClicked: function(index, item) {
                console.log("Vertical clicked:", index)
            }
        }
    }
}
