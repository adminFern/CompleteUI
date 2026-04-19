import QtQuick
import QtQuick.Controls
import QtQuick.Window
import QtQuick.Controls.impl
import QtQuick.Templates as T
import CompleteUI

T.GroupBox {
    id: control
    z: 0
    property color bordercolor:Theme.ButtonBorderNormalColor
    property color textcolor:Theme.Textcolor
    property color normalcolor: Theme.FillBackgroundColor
    QtObject{
        id:d
        property color color: {
            if (!enabled) {
                return Theme.DisabledColor
            }
            return normalcolor
        }
    }
    property int radius: 4
    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset, contentWidth + leftPadding + rightPadding, implicitLabelWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset, contentHeight + topPadding + bottomPadding)
    spacing: 4
    padding:0
    font: Qt.font({
                      family: Theme.defaultFontFamily,
                      pixelSize: 14,
                      weight: Font.Bold
                  })
    topPadding: padding + (implicitLabelWidth > 0 ? implicitLabelHeight + spacing : 0)

    clip: true

    label: Text {
        width: control.availableWidth
        text: control.title
        font: control.font
        elide: Text.ElideRight
        verticalAlignment: Text.AlignVCenter
        color: textcolor
    }
    background: Rectangle {
        y: control.topPadding - control.bottomPadding
        width: parent.width
        height: parent.height - control.topPadding + control.bottomPadding
        radius: control.radius
        border.color: control.bordercolor
        border.width: 1
        color:d.color
    }
}
