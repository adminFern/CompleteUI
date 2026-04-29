import QtQuick
import QtQuick.Controls.impl
import QtQuick.Templates as T
import CompleteUI

T.ScrollBar {
    id: control

    property bool enabled: true
    property color normalColor: Theme.isDark ? "#A0A0A0" : "#898989"
    property color hoverColor: Theme.isDark ? "#C0C0C0" : "#595959"
    property color pressedColor: Theme.isDark ? "#D0D0D0" : "#404040"
    property color disabledColor: Theme.isDark ? "#6B7280" : "#9CA3AF"

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)

    visible: control.policy !== T.ScrollBar.AlwaysOff && control.size < 1.0
    minimumSize: 0.08
    padding: 2
    interactive: enabled

    QtObject {
        id: d
        property bool buttonVisible: Number(control.contentItem.implicitWidth) === 6
    }

    verticalPadding: vertical ? padding + 12 : padding
    horizontalPadding: horizontal ? padding + 12 : padding

    contentItem: Rectangle {
        id: contentItemRect
        implicitWidth: 2
        implicitHeight: 2
        radius: width / 2
        color: {
            if (!control.enabled) return control.disabledColor
            if (control.pressed) return control.pressedColor
            if (control.hovered) return control.hoverColor
            return control.normalColor
        }

        states: State {
            name: "active"
            when: control.policy === T.ScrollBar.AlwaysOn || (control.active && control.size < 1.0)
            PropertyChanges {
                contentItemRect.implicitWidth: 6
                contentItemRect.implicitHeight: 6
            }
        }

        transitions: [
            Transition {
                from: "active"
                SequentialAnimation {
                    PauseAnimation { duration: 200 }
                    NumberAnimation {
                        target: contentItemRect
                        duration: 167
                        properties: "implicitWidth,implicitHeight"
                        to: 2
                        easing.type: Easing.OutCubic
                    }
                }
            },
            Transition {
                to: "active"
                SequentialAnimation {
                    PauseAnimation { duration: 50 }
                    NumberAnimation {
                        target: contentItemRect
                        duration: 167
                        properties: "implicitWidth,implicitHeight"
                        to: 6
                        easing.type: Easing.OutCubic
                    }
                }
            }
        ]
    }

    background: Rectangle {
        radius: 5
        color: Theme.isDark ? "#292929" : "#F8F8F8"
        opacity: control.active ? 1 : 0.5
        Behavior on opacity {
            NumberAnimation { duration: 50 }
        }
    }

    // 上按钮
    MouseArea {
        width: 8
        height: 8
        visible: d.buttonVisible && control.vertical
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        anchors {
            horizontalCenter: parent.horizontalCenter
            top: parent.top
            topMargin: 4
        }
        ComImage {
            anchors.fill: parent
            iconsize: 8
            iconsource: FluentIcon.ico_CaretUpSolid8
            icocolor: parent.containsMouse ? control.hoverColor : control.normalColor
            scale: parent.pressed ? 0.85 : 1
        }
        onClicked: control.decrease()
    }

    // 下按钮
    MouseArea {
        width: 8
        height: 8
        visible: d.buttonVisible && control.vertical
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        anchors {
            horizontalCenter: parent.horizontalCenter
            bottom: parent.bottom
            bottomMargin: 4
        }
        ComImage {
            anchors.fill: parent
            iconsize: 8
            iconsource: FluentIcon.ico_CaretDownSolid8
            icocolor: parent.containsMouse ? control.hoverColor : control.normalColor
            scale: parent.pressed ? 0.85 : 1
        }
        onClicked: control.increase()
    }

    // 左按钮
    MouseArea {
        width: 8
        height: 8
        visible: d.buttonVisible && control.horizontal
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        anchors {
            verticalCenter: parent.verticalCenter
            left: parent.left
            leftMargin: 4
        }
        ComImage {
            anchors.fill: parent
            iconsize: 8
            iconsource: FluentIcon.ico_CaretLeftSolid8
            icocolor: parent.containsMouse ? control.hoverColor : control.normalColor
            scale: parent.pressed ? 0.85 : 1
        }
        onClicked: control.decrease()
    }

    // 右按钮
    MouseArea {
        width: 8
        height: 8
        visible: d.buttonVisible && control.horizontal
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        anchors {
            verticalCenter: parent.verticalCenter
            right: parent.right
            rightMargin: 4
        }
        ComImage {
            anchors.fill: parent
            iconsize: 8
            iconsource: FluentIcon.ico_CaretRightSolid8
            icocolor: parent.containsMouse ? control.hoverColor : control.normalColor
            scale: parent.pressed ? 0.85 : 1
        }
        onClicked: control.increase()
    }
}
