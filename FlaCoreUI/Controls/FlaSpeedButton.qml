import QtQuick
import Qt5Compat.GraphicalEffects
import FlaCoreUI

Item {
    id: control

    enum Direction {
        Up = 0,
        Down = 1,
        Left = 2,
        Right = 3
    }

    property Objects items
    property int direction: FlaSpeedButton.Direction.Up
    property int buttonSize: 48
    property int subButtonSize: 40
    property int spacing: 12
    property string iconsource: FluentIcon.ico_Add
    property color primaryColor: Theme.PrimaryColor
    property color iconColor: "white"
    property color hoverColor: Theme.isDark ? Qt.darker(primaryColor, 1.2) : Qt.lighter(primaryColor, 1.1)
    property color pressedColor: Theme.isDark ? Qt.darker(primaryColor, 1.4) : Qt.lighter(primaryColor, 1.2)
    property bool expanded: false
    property bool autoCollapse: true
    property int animationDuration: 200
    property int iconsize: 20
    property int subIconsize: 16

    signal clicked(int index, var item)

    implicitWidth: control.buttonSize
    implicitHeight: control.buttonSize
    clip: false

    QtObject {
        id: d
        property bool isHovered: false
        property bool isPressed: false

        function handleItems() {
            var data = []
            if (items) {
                for (var i = 0; i < items.children.length; i++) {
                    var item = items.children[i]
                    if (item.visible !== false) {
                        item._idx = i
                        data.push(item)
                    }
                }
            }
            return data
        }

        function isVertical() {
            return control.direction === FlaSpeedButton.Direction.Up
                || control.direction === FlaSpeedButton.Direction.Down
        }

        function subButtonTargetX(index) {
            var step = control.subButtonSize + control.spacing
            var centerOffset = (control.buttonSize - control.subButtonSize) / 2
            switch (control.direction) {
            case FlaSpeedButton.Direction.Left:
                return -(step * (index + 1)) + centerOffset
            case FlaSpeedButton.Direction.Right:
                return step * (index + 1) + centerOffset
            default:
                return centerOffset
            }
        }

        function subButtonTargetY(index) {
            var step = control.subButtonSize + control.spacing
            var centerOffset = (control.buttonSize - control.subButtonSize) / 2
            switch (control.direction) {
            case FlaSpeedButton.Direction.Up:
                return -(step * (index + 1)) + centerOffset
            case FlaSpeedButton.Direction.Down:
                return step * (index + 1) + centerOffset
            default:
                return centerOffset
            }
        }

        function subButtonRestX() {
            return (control.buttonSize - control.subButtonSize) / 2
        }

        function subButtonRestY() {
            return (control.buttonSize - control.subButtonSize) / 2
        }
    }

    Repeater {
        model: d.handleItems()
        delegate: Item {
            id: subButtonContainer
            z: 0
            width: control.subButtonSize
            height: control.subButtonSize
            property bool isHovered: false
            property bool isPressed: false

            x: control.expanded ? d.subButtonTargetX(index) : d.subButtonRestX()
            y: control.expanded ? d.subButtonTargetY(index) : d.subButtonRestY()
            scale: control.expanded ? 1.0 : 0.0
            opacity: control.expanded ? 1.0 : 0.0
            visible: opacity > 0.01

            Behavior on x { NumberAnimation { duration: control.animationDuration; easing.type: Easing.OutCubic } }
            Behavior on y { NumberAnimation { duration: control.animationDuration; easing.type: Easing.OutCubic } }
            Behavior on scale { NumberAnimation { duration: control.animationDuration; easing.type: Easing.OutCubic } }
            Behavior on opacity { NumberAnimation { duration: control.animationDuration; easing.type: Easing.OutCubic } }

            RectangularGlow {
                anchors.fill: subBackground
                glowRadius: 6
                spread: 0.3
                color: Theme.isDark ? "#4D000000" : "#1A000000"
                cornerRadius: subBackground.radius
                opacity: subButtonContainer.isHovered ? 1.0 : 0.5
                visible: opacity > 0
                Behavior on opacity { NumberAnimation { duration: 150; easing.type: Easing.OutCubic } }
            }

            Rectangle {
                id: subBackground
                anchors.fill: parent
                radius: width / 2
                color: {
                    if (modelData.disabled) return Theme.DisabledColor
                    if (subButtonContainer.isPressed) return Theme.isDark ? Qt.darker(modelData.color, 1.3) : Qt.lighter(modelData.color, 1.15)
                    if (subButtonContainer.isHovered) return Theme.isDark ? Qt.darker(modelData.color, 1.15) : Qt.lighter(modelData.color, 1.08)
                    return modelData.color
                }
                Behavior on color { ColorAnimation { duration: 150 } }

                FlaImage {
                    anchors.centerIn: parent
                    iconsource: modelData.icon
                    iconsize: control.subIconsize
                    icocolor: modelData.iconColor
                }

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: modelData.disabled ? Qt.ForbiddenCursor : Qt.PointingHandCursor
                    onEntered: subButtonContainer.isHovered = true
                    onExited: {
                        subButtonContainer.isHovered = false
                        subButtonContainer.isPressed = false
                    }
                    onPressed: subButtonContainer.isPressed = true
                    onReleased: subButtonContainer.isPressed = false
                    onClicked: {
                        if (!modelData.disabled) {
                            control.clicked(index, modelData)
                            if (control.autoCollapse) control.expanded = false
                        }
                    }
                }
            }

            // ToolTip.visible: subButtonContainer.isHovered && modelData.title !== ""
            // ToolTip.text: modelData.title
            // ToolTip.delay: 500
        }
    }

    RectangularGlow {
        anchors.fill: mainBackground
        glowRadius: 8
        spread: 0.35
        color: Theme.isDark ? "#66000000" : "#33000000"
        cornerRadius: mainBackground.radius
        opacity: (d.isHovered || d.isPressed) ? 1.0 : 0.6
        Behavior on opacity { NumberAnimation { duration: 150; easing.type: Easing.OutCubic } }
    }

    Rectangle {
        id: mainBackground
        width: control.buttonSize
        height: control.buttonSize
        radius: width / 2
        color: {
            if (d.isPressed) return control.pressedColor
            if (d.isHovered) return control.hoverColor
            return control.primaryColor
        }
        Behavior on color { ColorAnimation { duration: 150 } }

        z: 1

        FlaImage {
            id: mainIcon
            anchors.centerIn: parent
            iconsource: control.iconsource
            iconsize: control.iconsize
            icocolor: control.iconColor
            rotation: control.expanded ? 45 : 0
            Behavior on rotation { NumberAnimation { duration: control.animationDuration; easing.type: Easing.OutCubic } }
        }

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            onEntered: d.isHovered = true
            onExited: {
                d.isHovered = false
                d.isPressed = false
            }
            onPressed: d.isPressed = true
            onReleased: d.isPressed = false
            onClicked: control.expanded = !control.expanded
        }

        transform: Scale {
            origin.x: mainBackground.width / 2
            origin.y: mainBackground.height / 2
            xScale: d.isPressed ? 0.92 : (d.isHovered ? 1.06 : 1.0)
            yScale: d.isPressed ? 0.92 : (d.isHovered ? 1.06 : 1.0)
            Behavior on xScale { NumberAnimation { duration: 150; easing.type: Easing.OutCubic } }
            Behavior on yScale { NumberAnimation { duration: 150; easing.type: Easing.OutCubic } }
        }
    }
}
