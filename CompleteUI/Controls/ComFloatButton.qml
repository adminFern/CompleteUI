import QtQuick
import QtQuick.Controls.impl
import QtQuick.Templates as T
import QtQuick.Layouts
import QtQuick.Controls
import Qt5Compat.GraphicalEffects
import CompleteUI

T.Control {
    id: control

    enum Direction {
        Up,
        Down,
        Left,
        Right
    }

    property int direction: ComFloatButton.Direction.Down
    property int buttonSize: 48
    property int buttonSpacing: 12
    property string iconsource: FluentIcon.ico_Add
    property color accentColor: Theme.PrimaryColor
    property alias expanded: d.expanded

    // 发光特效相关属性
    property bool glowEnabled: true
    property color glowColor: accentColor
    property real glowRadius: 15
    property real glowSpread: 0.4

    signal clicked
    signal subClicked(int index)

    property var actions: []

    hoverEnabled: true

    QtObject {
        id: d
        property bool expanded: false
    }

    Repeater {
        id: repeater
        model: control.actions.length > 0 ? control.actions.length : 0
        delegate: Item {
            id: subBtnWrapper
            property int idx: index
            property var actionData: control.actions[idx]

            width: control.buttonSize * 0.9
            height: control.buttonSize * 0.9

            property real targetX: {
                if (direction === ComFloatButton.Direction.Up || direction === ComFloatButton.Direction.Down) {
                    return mainBtnWrapper.x + (mainBtnWrapper.width - width) / 2
                }
                if (direction === ComFloatButton.Direction.Right) {
                    return mainBtnWrapper.x + (idx + 1) * (control.buttonSize + control.buttonSpacing)
                }
                return mainBtnWrapper.x - (idx + 1) * (control.buttonSize + control.buttonSpacing)
            }

            property real targetY: {
                if (direction === ComFloatButton.Direction.Left || direction === ComFloatButton.Direction.Right) {
                    return mainBtnWrapper.y + (mainBtnWrapper.height - height) / 2
                }
                if (direction === ComFloatButton.Direction.Down) {
                    return mainBtnWrapper.y + (idx + 1) * (control.buttonSize + control.buttonSpacing)
                }
                return mainBtnWrapper.y - (idx + 1) * (control.buttonSize + control.buttonSpacing)
            }

            x: d.expanded ? targetX : mainBtnWrapper.x + (mainBtnWrapper.width - width) / 2
            y: d.expanded ? targetY : mainBtnWrapper.y + (mainBtnWrapper.height - height) / 2
            scale: d.expanded ? 1 : 0
            z: 0

            Behavior on x { NumberAnimation { duration: 250; easing.type: Easing.OutCubic } }
            Behavior on y { NumberAnimation { duration: 250; easing.type: Easing.OutCubic } }
            Behavior on scale { NumberAnimation { duration: 200; easing.type: Easing.OutCubic } }

            Rectangle {
                id: subBtn
                anchors.fill: parent
                radius: width / 2

                color: {
                    if (!actionData || !actionData.enabled) return Theme.DisabledColor
                    if (subMouse.pressed) return Theme.isDark ? Qt.darker(accentColor, 1.3) : Qt.darker(accentColor, 1.15)
                    if (subMouse.hovered) return Theme.isDark ? Qt.lighter(accentColor, 1.2) : Qt.lighter(accentColor, 1.1)
                    return accentColor
                }
                border.width: 0
                opacity: (actionData && actionData.enabled) ? 1 : 0.5

                layer.enabled: (control.glowEnabled && subMouse.hovered && actionData && actionData.enabled === true) ? true : false
                layer.effect: DropShadow {
                    horizontalOffset: 0
                    verticalOffset: 0
                    radius: control.glowRadius * 0.8
                    samples: control.glowRadius * 2 + 1
                    color: control.glowColor
                    spread: control.glowSpread * 0.8
                    transparentBorder: true
                }

                Behavior on color { ColorAnimation { duration: 150 } }

                ComImage {
                    anchors.centerIn: parent
                    width: subBtn.width * 0.6
                    height: subBtn.height * 0.6
                    iconsource: actionData ? actionData.icon : ""
                    iconsize: control.buttonSize * 0.4
                    icocolor: "white"
                }
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

    Item {
        id: mainBtnWrapper
        x: 0
        y: 0
        width: control.buttonSize
        height: control.buttonSize
        z: 1

        Rectangle {
            id: mainBtn
            anchors.fill: parent
            radius: width / 2

            color: {
                if (mainMouse.pressed) return Theme.isDark ? Qt.darker(accentColor, 1.3) : Qt.darker(accentColor, 1.15)
                if (mainMouse.hovered) return Theme.isDark ? Qt.lighter(accentColor, 1.2) : Qt.lighter(accentColor, 1.1)
                return accentColor
            }

            layer.enabled: (control.glowEnabled && mainMouse.hovered) ? true : false
            layer.effect: DropShadow {
                horizontalOffset: 0
                verticalOffset: 0
                radius: control.glowRadius
                samples: control.glowRadius * 2 + 1
                color: control.glowColor
                spread: control.glowSpread
                transparentBorder: true
            }

            Behavior on color { ColorAnimation { duration: 150 } }
            Behavior on scale { NumberAnimation { duration: 150; easing.type: Easing.InOutQuad } }
            scale: mainMouse.pressed ? 0.92 : 1.0

            ComImage {
                anchors.centerIn: parent
                width: mainBtn.width * 0.6
                height: mainBtn.height * 0.6
                iconsource: control.iconsource
                iconsize: control.buttonSize * 0.4
                icocolor: "white"
                rotation: d.expanded ? 45 : 0
                Behavior on rotation { NumberAnimation { duration: 250; easing.type: Easing.OutCubic } }
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

    implicitWidth: buttonSize
    implicitHeight: buttonSize
}