import QtQuick
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
import FlaCoreUI

Item {
    component SlideContent: Item {
        property string imageSrc: ""
        anchors.fill: parent

        Image {
            id: bgImage
            anchors.fill: parent
            source: imageSrc
            fillMode: Image.PreserveAspectCrop
            opacity: 0.3
        }
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 10
        spacing: 5
        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true
        }
    }
}
