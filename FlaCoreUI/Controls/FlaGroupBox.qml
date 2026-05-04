import QtQuick
import QtQuick.Controls
import QtQuick.Window
import QtQuick.Controls.impl
import QtQuick.Templates as T
import FlaCoreUI

// 分组框组件：带标题的容器，用于组织相关控件
T.GroupBox {
    id: control
    z: 0
    property color bordercolor: Theme.FillBorderColor
    property color textcolor: Theme.Textcolor
    property color normalcolor: Theme.FillBackgroundColor
    property int radius: 4
    QtObject {
        id: d
        property color color: {
            if (!enabled) return Theme.DisabledColor
            return normalcolor
        }
    }
    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset, contentWidth + leftPadding + rightPadding, implicitLabelWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset, contentHeight + topPadding + bottomPadding)
    spacing: 4
    padding: 0
    font: Qt.font({
        family: Theme.defaultFontFamily,
        pixelSize: 14,
        weight: Font.Bold
    })
    topPadding: padding + (implicitLabelWidth > 0 ? implicitLabelHeight + spacing : 0)
    clip: true

    // 标题标签
    label: Text {
        width: control.availableWidth
        text: control.title
        font: control.font
        elide: Text.ElideRight
        verticalAlignment: Text.AlignVCenter
        color: textcolor
    }

    // 背景
    background: Rectangle {
        y: control.topPadding - control.bottomPadding
        width: parent.width
        height: parent.height - control.topPadding + control.bottomPadding
        radius: control.radius
        border.color: control.bordercolor
        border.width: 1
        color: d.color
    }
}
