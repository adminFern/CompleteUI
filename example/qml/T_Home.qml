import QtQuick
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
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
        Image {
              id: sourceImage
            width: 100
            height: 100
            source:"qrc:/svg/avatar_4.svg"
            fillMode: Image.PreserveAspectCrop
            //visible: false  // 隐藏原图，只作为遮罩的源
             layer.enabled: true
             layer.effect: OpacityMask {
                 maskSource: Rectangle {
                     width: sourceImage.width
                     height: sourceImage.height
                     radius: 20   // 圆角半径
                 }
             }
        }

        Text {
            text: "这是一个基于 Qt6 + QML 的 Fluent Design UI 库"
            font.pixelSize: 14
            color: Theme.Textcolor
            anchors.horizontalCenter: parent.horizontalCenter
        }
        //RoundImage{}



    }
}