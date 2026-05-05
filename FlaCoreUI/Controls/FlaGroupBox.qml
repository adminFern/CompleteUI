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
    property color bordercolor:{
        if(Theme.SpecialEffect===Theme.Mica ||Theme.SpecialEffect===Theme.MicaAlt){
            return Theme.isDark? Theme.setColorAlpha( "#5A5A5A",120):Theme.setColorAlpha( "#D7D7D7",120)
        }
        if(Theme.SpecialEffect===Theme.Acrylic ){
             return Theme.isDark? Theme.setColorAlpha( "#5A5A5A",150):Theme.setColorAlpha( "#D7D7D7",140)
        }
        return Theme.isDark? "#5A5A5A":"#D7D7D7"
    }
    property color textcolor: Theme.Textcolor
    property color backgroundcolor:{
        if (!enabled) return Theme.DisabledColor
        if(Theme.SpecialEffect===Theme.Mica ||Theme.SpecialEffect===Theme.MicaAlt){
            return Theme.isDark? Theme.setColorAlpha( "#292929",80):Theme.setColorAlpha( "#F8F8F8",100)
        }
        if(Theme.SpecialEffect===Theme.Acrylic ){
             return Theme.isDark? Theme.setColorAlpha( "#292929",50):Theme.setColorAlpha( "#F8F8F8",100)
        }
        return Theme.isDark? "#292929":"#F8F8F8"
    }
    property int radius: 4
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
        color: control.backgroundcolor
    }
}
