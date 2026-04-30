import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import FlaCoreUI

FlaWindow {
    id: win
    width: 1128
    height: 700
    visible: true
    title: qsTr("FlaCardCurveView 波浪卡片示例")
    icon: "qrc:/favicon.ico"

    FlaCardCurveView {
        id: curveView
        anchors.fill: parent
        anchors.margins: 20
        items: cardItems
        cardWidth: 200
        cardHeight: 300
        waveAmplitude: 120
        spacing: 25
        animationDuration: 800

        onCardClicked: (index, item) => {
            console.log("点击卡片:", index)
        }
    }

    Objects {
        id: cardItems

        Rectangle {
            readonly property int cardWidth: 200
            readonly property int cardHeight: 300
            readonly property color cardColor: "#FF6B6B"
            readonly property Component delegate: cardDelegate1
        }

        Rectangle {
            readonly property int cardWidth: 200
            readonly property int cardHeight: 280
            readonly property color cardColor: "#4ECDC4"
            readonly property Component delegate: cardDelegate2
        }

        Rectangle {
            readonly property int cardWidth: 200
            readonly property int cardHeight: 320
            readonly property color cardColor: "#45B7D1"
            readonly property Component delegate: cardDelegate3
        }

        Rectangle {
            readonly property int cardWidth: 200
            readonly property int cardHeight: 290
            readonly property color cardColor: "#96CEB4"
            readonly property Component delegate: cardDelegate4
        }

        Rectangle {
            readonly property int cardWidth: 200
            readonly property int cardHeight: 310
            readonly property color cardColor: "#FFEAA7"
            readonly property Component delegate: cardDelegate5
        }
    }

    Component {
        id: cardDelegate1
        Column {
            anchors.fill: parent
            anchors.margins: 20
            spacing: 15
            Rectangle {
                width: 60
                height: 60
                anchors.horizontalCenter: parent.horizontalCenter
                radius: 30
                color: "white"
                Text {
                    anchors.centerIn: parent
                    text: "🎨"
                    font.pixelSize: 28
                }
            }
            Text {
                width: parent.width
                text: "创意设计"
                font.pixelSize: 18
                font.bold: true
                color: "white"
                horizontalAlignment: Text.AlignHCenter
            }
            Text {
                width: parent.width
                text: "设计精美界面"
                font.pixelSize: 13
                color: "#F0F0F0"
                horizontalAlignment: Text.AlignHCenter
            }
        }
    }

    Component {
        id: cardDelegate2
        Column {
            anchors.fill: parent
            anchors.margins: 20
            spacing: 15
            Rectangle {
                width: 60
                height: 60
                anchors.horizontalCenter: parent.horizontalCenter
                radius: 30
                color: "white"
                Text {
                    anchors.centerIn: parent
                    text: "💻"
                    font.pixelSize: 28
                }
            }
            Text {
                width: parent.width
                text: "Web开发"
                font.pixelSize: 18
                font.bold: true
                color: "white"
                horizontalAlignment: Text.AlignHCenter
            }
            Text {
                width: parent.width
                text: "构建现代化网站"
                font.pixelSize: 13
                color: "#F0F0F0"
                horizontalAlignment: Text.AlignHCenter
            }
        }
    }

    Component {
        id: cardDelegate3
        Column {
            anchors.fill: parent
            anchors.margins: 20
            spacing: 15
            Rectangle {
                width: 60
                height: 60
                anchors.horizontalCenter: parent.horizontalCenter
                radius: 30
                color: "white"
                Text {
                    anchors.centerIn: parent
                    text: "📱"
                    font.pixelSize: 28
                }
            }
            Text {
                width: parent.width
                text: "移动应用"
                font.pixelSize: 18
                font.bold: true
                color: "white"
                horizontalAlignment: Text.AlignHCenter
            }
            Text {
                width: parent.width
                text: "原生应用开发"
                font.pixelSize: 13
                color: "#F0F0F0"
                horizontalAlignment: Text.AlignHCenter
            }
        }
    }

    Component {
        id: cardDelegate4
        Column {
            anchors.fill: parent
            anchors.margins: 20
            spacing: 15
            Rectangle {
                width: 60
                height: 60
                anchors.horizontalCenter: parent.horizontalCenter
                radius: 30
                color: "white"
                Text {
                    anchors.centerIn: parent
                    text: "🎵"
                    font.pixelSize: 28
                }
            }
            Text {
                width: parent.width
                text: "音乐播放"
                font.pixelSize: 18
                font.bold: true
                color: "white"
                horizontalAlignment: Text.AlignHCenter
            }
            Text {
                width: parent.width
                text: "海量音乐资源"
                font.pixelSize: 13
                color: "#F0F0F0"
                horizontalAlignment: Text.AlignHCenter
            }
        }
    }

    Component {
        id: cardDelegate5
        Column {
            anchors.fill: parent
            anchors.margins: 20
            spacing: 15
            Rectangle {
                width: 60
                height: 60
                anchors.horizontalCenter: parent.horizontalCenter
                radius: 30
                color: "white"
                Text {
                    anchors.centerIn: parent
                    text: "📚"
                    font.pixelSize: 28
                }
            }
            Text {
                width: parent.width
                text: "电子书"
                font.pixelSize: 18
                font.bold: true
                color: "white"
                horizontalAlignment: Text.AlignHCenter
            }
            Text {
                width: parent.width
                text: "百万图书资源"
                font.pixelSize: 13
                color: "#F0F0F0"
                horizontalAlignment: Text.AlignHCenter
            }
        }
    }
}