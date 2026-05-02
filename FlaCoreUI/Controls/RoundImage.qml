import QtQuick
import FlaCoreUI

Item {
    property string source
    property int roundRadius: 10
    property alias fillMode: image.fillMode

    implicitWidth: 100
    implicitHeight: 100

    Rectangle {
        anchors.fill: parent
        radius: control.roundRadius
        clip: true

        Image {
            id: image
            anchors.fill: parent
            source: control.source
            fillMode: Image.PreserveAspectCrop
        }
    }
}