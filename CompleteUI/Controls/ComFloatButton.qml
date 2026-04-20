import QtQuick
import QtQuick.Controls.impl
import QtQuick.Templates as T
import QtQuick.Layouts
import QtQuick.Controls
import CompleteUI

Item {
    id: control

    enum Direction {
        Up,
        Down,
        Left,
        Right
    }

    property int direction: ComFloatButton.Direction.Right
    property int buttonSize: 48
    property int spacing: 12
    property string iconsource: FluentIcon.ico_Add
    property color accentColor: Theme.PrimaryColor
    property alias expanded: d.expanded

    signal clicked
    signal subClicked(int index)

    property var actions: []

    QtObject {
        id: d
        property bool expanded: false
    }

    implicitWidth: buttonSize
    implicitHeight: buttonSize

    Repeater {
        id: repeater
        model: control.actions.length > 0 ? control.actions.length : 0

        delegate: Rectangle {
            id: subBtn
            property int idx: index

            width: control.buttonSize * 0.9
            height: control.buttonSize * 0.9
            radius: width / 2
            z: 0

            property var actionData: control.actions[idx]
            color: {
                if (!actionData || !actionData.enabled) return Theme.DisabledColor
                if (subMouse.pressed) return Theme.isDark ? Qt.darker(accentColor, 1.3) : Qt.darker(accentColor, 1.15)
                if (subMouse.hovered) return Theme.isDark ? Qt.lighter(accentColor, 1.2) : Qt.lighter(accentColor, 1.1)
                return accentColor
            }
            border.width: 0
            opacity: (actionData && actionData.enabled) ? 1 : 0.5

            property real targetX: {
                if (direction === ComFloatButton.Direction.Up || direction === ComFloatButton.Direction.Down) {
                    return mainBtn.x + (mainBtn.width - width) / 2
                }
                if (direction === ComFloatButton.Direction.Right) {
                    return mainBtn.x + (idx + 1) * (control.buttonSize + spacing)
                }
                return mainBtn.x - (idx + 1) * (control.buttonSize + spacing)
            }

            property real targetY: {
                if (direction === ComFloatButton.Direction.Left || direction === ComFloatButton.Direction.Right) {
                    return mainBtn.y + (mainBtn.height - height) / 2
                }
                if (direction === ComFloatButton.Direction.Down) {
                    return mainBtn.y + (idx + 1) * (control.buttonSize + spacing)
                }
                return mainBtn.y - (idx + 1) * (control.buttonSize + spacing)
            }

            x: d.expanded ? targetX : mainBtn.x + (mainBtn.width - width) / 2
            y: d.expanded ? targetY : mainBtn.y + (mainBtn.height - height) / 2
            scale: d.expanded ? 1 : 0

            Behavior on x { NumberAnimation { duration: 250; easing.type: Easing.OutCubic } }
            Behavior on y { NumberAnimation { duration: 250; easing.type: Easing.OutCubic } }
            Behavior on scale { NumberAnimation { duration: 200; easing.type: Easing.OutCubic } }
            Behavior on color { ColorAnimation { duration: 150 } }

            ComImage {
                anchors.centerIn: parent
                width: subBtn.width * 0.6
                height: subBtn.height * 0.6
                iconsource: actionData ? actionData.icon : ""
                iconsize: control.buttonSize * 0.4
                icocolor: "white"
            }

            MouseArea {
                id: subMouse
                anchors.fill: parent
                enabled: actionData ? actionData.enabled : false
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    control.subClicked(index)
                    d.expanded = false
                }
            }
        }
    }

    Rectangle {
        id: mainBtn
        x: 0
        y: 0
        width: control.buttonSize
        height: control.buttonSize
        radius: width / 2
        z: 1

        color: {
            if (mainMouse.pressed) return Theme.isDark ? Qt.darker(accentColor, 1.3) : Qt.darker(accentColor, 1.15)
            if (mainMouse.hovered) return Theme.isDark ? Qt.lighter(accentColor, 1.2) : Qt.lighter(accentColor, 1.1)
            return accentColor
        }

        Behavior on color { ColorAnimation { duration: 150 } }
        Behavior on scale { NumberAnimation { duration: 150; easing.type: Easing.InOutQuad } }
        scale: mainMouse.pressed ? 0.92 : 1.0

        Item {
            anchors.centerIn: parent
            width: mainBtn.width * 0.6
            height: mainBtn.height * 0.6

            rotation: d.expanded ? 45 : 0
            Behavior on rotation { NumberAnimation { duration: 250; easing.type: Easing.OutCubic } }

            ComImage {
                anchors.fill: parent
                iconsource: control.iconsource
                iconsize: control.buttonSize * 0.4
                icocolor: "white"
            }
        }

        MouseArea {
            id: mainMouse
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            onClicked: {
                d.expanded = !d.expanded
                control.clicked()
            }
        }
    }
}