import QtQuick
import QtQuick.Layouts
import FlaCoreUI

Item {
    id: root

    Rectangle {
        anchors.fill: parent
        color: Theme.FillBackgroundColor
    }

    Column {
        anchors.centerIn: parent
        spacing: 20

        Text {
            text: "🏠"
            font.pixelSize: 60
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Text {
            text: "欢迎使用 FlaCoreUI"
            font.pixelSize: 24
            font.bold: true
            color: Theme.Textcolor
            anchors.horizontalCenter: parent.horizontalCenter
        }
        Text {
            id: name
            text: qsTr("text")
        }
        Text {
            text: "这是一个基于 Qt6 + QML 的 Fluent Design UI 库"
            font.pixelSize: 14
            color: Theme.Textcolor
            anchors.horizontalCenter: parent.horizontalCenter
        }


    }
}