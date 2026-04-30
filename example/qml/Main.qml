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
    initialItem: "qrc:/qml/T_Content.qml"
}
    // FlaCardCurveView {
    //     id: curveView
    //     anchors.fill: parent
    //     anchors.margins: 20
    //     items: cardItems
    //     cardWidth: 200
    //     cardHeight: 300
    //     waveAmplitude: 120
    //     spacing: 25
    //     animationDuration: 800

    //     onCardClicked: (index, item) => {
    //         console.log("点击卡片:", index)
    //     }
    // }

    // Objects {
    //     id: cardItems

    //     CardItemDelegate {
    //         cardColor: "#FF6B6B"
    //         delegate: cardDelegate1
    //     }

    //     CardItemDelegate {
    //         cardColor: "#4ECDC4"
    //         delegate: cardDelegate2
    //     }

    //     CardItemDelegate {
    //         cardColor: "#45B7D1"
    //         delegate: cardDelegate3
    //     }

    //     CardItemDelegate {
    //         cardColor: "#96CEB4"
    //         delegate: cardDelegate4
    //     }

    //     CardItemDelegate {
    //         cardColor: "#FFEAA7"
    //         delegate: cardDelegate5
    //     }

    //     CardItemDelegate {
    //         cardColor: "#DDA0DD"
    //         delegate: cardDelegate6
    //     }

    //     CardItemDelegate {
    //         cardColor: "#F7DC6F"
    //         delegate: cardDelegate7
    //     }

    //     CardItemDelegate {
    //         cardColor: "#98D8C8"
    //         delegate: cardDelegate8
    //     }

    //     CardItemDelegate {
    //         cardColor: "#FF8C94"
    //         delegate: cardDelegate9
    //     }

    //     CardItemDelegate {
    //         cardColor: "#B8A9C9"
    //         delegate: cardDelegate10
    //     }
    // }

    // Component {
    //     id: cardDelegate1
    //     Column {
    //         anchors.fill: parent
    //         anchors.margins: 20
    //         spacing: 15
    //         Rectangle {
    //             width: 60
    //             height: 60
    //             anchors.horizontalCenter: parent.horizontalCenter
    //             radius: 30
    //             color: "black"
    //             Text {
    //                 anchors.centerIn: parent
    //                 text: "🎨"
    //                 font.pixelSize: 28
    //             }
    //         }
    //         Text {
    //             width: parent.width
    //             text: "创意设计"
    //             font.pixelSize: 18
    //             font.bold: true
    //             color: "black"
    //             horizontalAlignment: Text.AlignHCenter
    //         }
    //         Text {
    //             width: parent.width
    //             text: "设计精美界面"
    //             font.pixelSize: 13
    //             color: "#333333"
    //             horizontalAlignment: Text.AlignHCenter
    //         }
    //     }
    // }

    // Component {
    //     id: cardDelegate2
    //     Column {
    //         anchors.fill: parent
    //         anchors.margins: 20
    //         spacing: 15
    //         Rectangle {
    //             width: 60
    //             height: 60
    //             anchors.horizontalCenter: parent.horizontalCenter
    //             radius: 30
    //             color: "black"
    //             Text {
    //                 anchors.centerIn: parent
    //                 text: "💻"
    //                 font.pixelSize: 28
    //             }
    //         }
    //         Text {
    //             width: parent.width
    //             text: "Web开发"
    //             font.pixelSize: 18
    //             font.bold: true
    //             color: "black"
    //             horizontalAlignment: Text.AlignHCenter
    //         }
    //         Text {
    //             width: parent.width
    //             text: "构建现代化网站"
    //             font.pixelSize: 13
    //             color: "#333333"
    //             horizontalAlignment: Text.AlignHCenter
    //         }
    //     }
    // }

    // Component {
    //     id: cardDelegate3
    //     Column {
    //         anchors.fill: parent
    //         anchors.margins: 20
    //         spacing: 15
    //         Rectangle {
    //             width: 60
    //             height: 60
    //             anchors.horizontalCenter: parent.horizontalCenter
    //             radius: 30
    //             color: "black"
    //             Text {
    //                 anchors.centerIn: parent
    //                 text: "📱"
    //                 font.pixelSize: 28
    //             }
    //         }
    //         Text {
    //             width: parent.width
    //             text: "移动应用"
    //             font.pixelSize: 18
    //             font.bold: true
    //             color: "black"
    //             horizontalAlignment: Text.AlignHCenter
    //         }
    //         Text {
    //             width: parent.width
    //             text: "原生应用开发"
    //             font.pixelSize: 13
    //             color: "#333333"
    //             horizontalAlignment: Text.AlignHCenter
    //         }
    //     }
    // }

    // Component {
    //     id: cardDelegate4
    //     Column {
    //         anchors.fill: parent
    //         anchors.margins: 20
    //         spacing: 15
    //         Rectangle {
    //             width: 60
    //             height: 60
    //             anchors.horizontalCenter: parent.horizontalCenter
    //             radius: 30
    //             color: "black"
    //             Text {
    //                 anchors.centerIn: parent
    //                 text: "🎵"
    //                 font.pixelSize: 28
    //             }
    //         }
    //         Text {
    //             width: parent.width
    //             text: "音乐播放"
    //             font.pixelSize: 18
    //             font.bold: true
    //             color: "black"
    //             horizontalAlignment: Text.AlignHCenter
    //         }
    //         Text {
    //             width: parent.width
    //             text: "海量音乐资源"
    //             font.pixelSize: 13
    //             color: "#333333"
    //             horizontalAlignment: Text.AlignHCenter
    //         }
    //     }
    // }

    // Component {
    //     id: cardDelegate5
    //     Column {
    //         anchors.fill: parent
    //         anchors.margins: 20
    //         spacing: 15
    //         Rectangle {
    //             width: 60
    //             height: 60
    //             anchors.horizontalCenter: parent.horizontalCenter
    //             radius: 30
    //             color: "black"
    //             Text {
    //                 anchors.centerIn: parent
    //                 text: "📚"
    //                 font.pixelSize: 28
    //             }
    //         }
    //         Text {
    //             width: parent.width
    //             text: "电子书"
    //             font.pixelSize: 18
    //             font.bold: true
    //             color: "black"
    //             horizontalAlignment: Text.AlignHCenter
    //         }
    //         Text {
    //             width: parent.width
    //             text: "百万图书资源"
    //             font.pixelSize: 13
    //             color: "#333333"
    //             horizontalAlignment: Text.AlignHCenter
    //         }
    //     }
    // }

    // Component {
    //     id: cardDelegate6
    //     Column {
    //         anchors.fill: parent
    //         anchors.margins: 20
    //         spacing: 15
    //         Rectangle {
    //             width: 60
    //             height: 60
    //             anchors.horizontalCenter: parent.horizontalCenter
    //             radius: 30
    //             color: "black"
    //             Text {
    //                 anchors.centerIn: parent
    //                 text: "📷"
    //                 font.pixelSize: 28
    //             }
    //         }
    //         Text {
    //             width: parent.width
    //             text: "摄影摄像"
    //             font.pixelSize: 18
    //             font.bold: true
    //             color: "black"
    //             horizontalAlignment: Text.AlignHCenter
    //         }
    //         Text {
    //             width: parent.width
    //             text: "专业摄影后期"
    //             font.pixelSize: 13
    //             color: "#333333"
    //             horizontalAlignment: Text.AlignHCenter
    //         }
    //     }
    // }

    // Component {
    //     id: cardDelegate7
    //     Column {
    //         anchors.fill: parent
    //         anchors.margins: 20
    //         spacing: 15
    //         Rectangle {
    //             width: 60
    //             height: 60
    //             anchors.horizontalCenter: parent.horizontalCenter
    //             radius: 30
    //             color: "black"
    //             Text {
    //                 anchors.centerIn: parent
    //                 text: "🎯"
    //                 font.pixelSize: 28
    //             }
    //         }
    //         Text {
    //             width: parent.width
    //             text: "工具应用"
    //             font.pixelSize: 18
    //             font.bold: true
    //             color: "black"
    //             horizontalAlignment: Text.AlignHCenter
    //         }
    //         Text {
    //             width: parent.width
    //             text: "效率工具集合"
    //             font.pixelSize: 13
    //             color: "#333333"
    //             horizontalAlignment: Text.AlignHCenter
    //         }
    //     }
    // }

    // Component {
    //     id: cardDelegate8
    //     Column {
    //         anchors.fill: parent
    //         anchors.margins: 20
    //         spacing: 15
    //         Rectangle {
    //             width: 60
    //             height: 60
    //             anchors.horizontalCenter: parent.horizontalCenter
    //             radius: 30
    //             color: "black"
    //             Text {
    //                 anchors.centerIn: parent
    //                 text: "🌈"
    //                 font.pixelSize: 28
    //             }
    //         }
    //         Text {
    //             width: parent.width
    //             text: "艺术创作"
    //             font.pixelSize: 18
    //             font.bold: true
    //             color: "black"
    //             horizontalAlignment: Text.AlignHCenter
    //         }
    //         Text {
    //             width: parent.width
    //             text: "创意无限可能"
    //             font.pixelSize: 13
    //             color: "#333333"
    //             horizontalAlignment: Text.AlignHCenter
    //         }
    //     }
    // }

    // Component {
    //     id: cardDelegate9
    //     Column {
    //         anchors.fill: parent
    //         anchors.margins: 20
    //         spacing: 15
    //         Rectangle {
    //             width: 60
    //             height: 60
    //             anchors.horizontalCenter: parent.horizontalCenter
    //             radius: 30
    //             color: "black"
    //             Text {
    //                 anchors.centerIn: parent
    //                 text: "🚀"
    //                 font.pixelSize: 28
    //             }
    //         }
    //         Text {
    //             width: parent.width
    //             text: "科技创新"
    //             font.pixelSize: 18
    //             font.bold: true
    //             color: "black"
    //             horizontalAlignment: Text.AlignHCenter
    //         }
    //         Text {
    //             width: parent.width
    //             text: "前沿技术探索"
    //             font.pixelSize: 13
    //             color: "#333333"
    //             horizontalAlignment: Text.AlignHCenter
    //         }
    //     }
    // }

    // Component {
    //     id: cardDelegate10
    //     Column {
    //         anchors.fill: parent
    //         anchors.margins: 20
    //         spacing: 15
    //         Rectangle {
    //             width: 60
    //             height: 60
    //             anchors.horizontalCenter: parent.horizontalCenter
    //             radius: 30
    //             color: "black"
    //             Text {
    //                 anchors.centerIn: parent
    //                 text: "🎪"
    //                 font.pixelSize: 28
    //             }
    //         }
    //         Text {
    //             width: parent.width
    //             text: "娱乐互动"
    //             font.pixelSize: 18
    //             font.bold: true
    //             color: "black"
    //             horizontalAlignment: Text.AlignHCenter
    //         }
    //         Text {
    //             width: parent.width
    //             text: "精彩娱乐体验"
    //             font.pixelSize: 13
    //             color: "#333333"
    //             horizontalAlignment: Text.AlignHCenter
    //         }
    //     }
    // }
