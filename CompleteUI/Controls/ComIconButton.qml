import QtQuick
import QtQuick.Controls.impl
import QtQuick.Templates as T
import QtQuick.Layouts
import QtQuick.Controls
import CompleteUI

T.Button {
    id: control
    property bool handCursor: false
    property int iconsize: 20
    property string iconsource: ""
    property color hoverColor: Theme.isDark ? Qt.rgba(1,1,1,0.05) : Qt.rgba(0,0,0,0.05)
    property color pressedColor: Theme.isDark ? Qt.rgba(1,1,1,0.03) : Qt.rgba(0,0,0,0.03)
    property color normalColor: "transparent"
    property color iconColor: Theme.isDark ? "white" : "black"
    property int radius: 4
    property bool iconbold: false
    display: DisplayType.IconOnly
    font: Qt.font({family: Theme.defaultFontFamily, pixelSize: 13, weight: Font.Normal})
    property color color: {
        if (!enabled) {
            return disableColor
        }
        if (pressed) {
            return pressedColor
        }
        return hovered ? hoverColor : normalColor
    }

    contentItem: ComIconLabel {
        text: control.text
        iconsource: control.iconsource
        iconsize: control.iconsize
        font: control.font
        display: control.display
        spacing: control.spacing
        color: control.iconColor
        icocolor: control.iconColor
        iconbold: control.iconbold
    }
    background: Rectangle {
        radius: control.radius
        color:control.color
    }
    HoverHandler {
        cursorShape: control.handCursor ? Qt.PointingHandCursor : Qt.ArrowCursor
    }
    spacing: 2
    padding: 0
    topPadding: 4
    bottomPadding: 4
    leftPadding: 8
    rightPadding: 8
    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)
}
