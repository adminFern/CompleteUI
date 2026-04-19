import QtQuick
import QtQuick.Controls.impl
import QtQuick.Templates as T
import QtQuick.Layouts
import QtQuick.Controls
import Qt5Compat.GraphicalEffects
import CompleteUI

Item {
    id: control

    enum Direction {
        Up,
        Down,
        Left,
        Right
    }

    property int direction: ComFloatButton.Direction.Up
    property int buttonSize: 48
    property int spacing: 12
    property string iconsource: FluentIcon.ico_Add
    property color accentColor: Theme.PrimaryColor
    property alias expanded: d.expanded

    signal clicked
    signal subClicked(int index)

    property list<var> actions: [
        { icon: FluentIcon.ico_Edit, enabled: true },
        { icon: FluentIcon.ico_FavoriteStar, enabled: true },
        { icon: FluentIcon.ico_Share, enabled: true }
    ]

    QtObject {
        id: d
        property bool expanded: false
    }

    implicitWidth: {
        if (direction === ComFloatButton.Direction.Left ||
            direction === ComFloatButton.Direction.Right) {
            return buttonSize * 2 + spacing
        }
        return buttonSize
    }
    implicitHeight: {
        if (direction === ComFloatButton.Direction.Up ||
            direction === ComFloatButton.Direction.Down) {
            return buttonSize * 2 + spacing
        }
        return buttonSize
    }

    Item {
        id: content
        anchors.fill: parent

        Repeater {
            id: repeater
            model: actions.length
            delegate: Rectangle {
                id: subBtn
                property int idx: index
                width: buttonSize
                height: buttonSize
                radius: buttonSize / 2
                z: 0
                visible: actions[index].enabled

                color: {
                    if (subMouse.pressed) return Theme.isDark ? Qt.darker(accentColor, 1.3) : Qt.darker(accentColor, 1.15)
                    if (subMouse.hovered) return Theme.isDark ? Qt.lighter(accentColor, 1.2) : Qt.lighter(accentColor, 1.1)
                    return accentColor
                }
                border.width: 1
                border.color: Theme.isDark ? Qt.rgba(1, 1, 1, 0.1) : Qt.rgba(0, 0, 0, 0.1)

                property real targetX: {
                    if (direction === ComFloatButton.Direction.Up || direction === ComFloatButton.Direction.Down) {
                        return mainBtn.x
                    }
                    if (direction === ComFloatButton.Direction.Right) {
                        return mainBtn.x + (idx + 1) * (buttonSize + spacing)
                    }
                    return mainBtn.x - (idx + 1) * (buttonSize + spacing)
                }
                property real targetY: {
                    if (direction === ComFloatButton.Direction.Left || direction === ComFloatButton.Direction.Right) {
                        return mainBtn.y
                    }
                    if (direction === ComFloatButton.Direction.Down) {
                        return mainBtn.y + (idx + 1) * (buttonSize + spacing)
                    }
                    return mainBtn.y - (idx + 1) * (buttonSize + spacing)
                }

                x: d.expanded ? targetX : mainBtn.x
                y: d.expanded ? targetY : mainBtn.y
                scale: d.expanded ? 1 : 0
                opacity: d.expanded ? 1 : 0

                Behavior on x { NumberAnimation { duration: 250; easing.type: Easing.OutCubic } }
                Behavior on y { NumberAnimation { duration: 250; easing.type: Easing.OutCubic } }
                Behavior on scale { NumberAnimation { duration: 200; easing.type: Easing.OutCubic } }
                Behavior on opacity { NumberAnimation { duration: 200 } }
                Behavior on color { ColorAnimation { duration: 150 } }

                RectangularGlow {
                    anchors.fill: parent
                    glowRadius: 4
                    spread: 0.3
                    color: accentColor
                    cornerRadius: parent.radius + glowRadius
                    opacity: subMouse.hovered && !subMouse.pressed ? 0.3 : 0
                    visible: opacity > 0
                    z: -1
                    Behavior on opacity { NumberAnimation { duration: 150 } }
                }

                Text {
                    anchors.centerIn: parent
                    font.family: FluentIcon.fontLoader.name
                    font.pixelSize: buttonSize * 0.4
                    text: actions[index].icon
                    color: "white"
                    renderType: Text.NativeRendering
                }

                MouseArea {
                    id: subMouse
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onClicked: control.subClicked(index)
                }
            }
        }

        Rectangle {
            id: mainBtn
            width: buttonSize
            height: buttonSize
            radius: buttonSize / 2
            z: 1

            x: {
                if (direction === ComFloatButton.Direction.Left) return control.width - buttonSize
                if (direction === ComFloatButton.Direction.Right) return 0
                return (control.width - buttonSize) / 2
            }
            y: {
                if (direction === ComFloatButton.Direction.Down) return 0
                if (direction === ComFloatButton.Direction.Up) return control.height - buttonSize
                return (control.height - buttonSize) / 2
            }

            color: {
                if (mainMouse.pressed) return Theme.isDark ? Qt.darker(accentColor, 1.3) : Qt.darker(accentColor, 1.15)
                if (mainMouse.hovered) return Theme.isDark ? Qt.lighter(accentColor, 1.2) : Qt.lighter(accentColor, 1.1)
                return accentColor
            }
            border.width: 1
            border.color: Theme.isDark ? Qt.rgba(1, 1, 1, 0.1) : Qt.rgba(0, 0, 0, 0.1)

            Behavior on color { ColorAnimation { duration: 150 } }
            Behavior on scale { NumberAnimation { duration: 150; easing.type: Easing.InOutQuad } }
            scale: mainMouse.pressed ? 0.92 : 1.0

            RectangularGlow {
                anchors.fill: parent
                glowRadius: 6
                spread: 0.35
                color: accentColor
                cornerRadius: parent.radius + glowRadius
                opacity: mainMouse.hovered && !mainMouse.pressed ? 0.4 : 0
                visible: opacity > 0
                z: -1
                Behavior on opacity { NumberAnimation { duration: 200 } }
            }

            Text {
                anchors.centerIn: parent
                font.family: FluentIcon.fontLoader.name
                font.pixelSize: buttonSize * 0.4
                text: control.iconsource
                color: "white"
                renderType: Text.NativeRendering
                rotation: d.expanded ? 45 : 0
                Behavior on rotation { NumberAnimation { duration: 250; easing.type: Easing.OutCubic } }
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
}
