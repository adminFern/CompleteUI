import QtQuick
import QtQuick.Controls.impl
import QtQuick.Templates as T
import QtQuick.Layouts
import QtQuick.Controls
import FlaCoreUI

T.Switch {
    id: control
    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding,
                             implicitIndicatorHeight + topPadding + bottomPadding)

    property color checkColor: Theme.PrimaryColor


    property color color: {
        if(control.checked){
            return control.checkColor
        }else{
            if(!control.enabled){
                return Theme.isDark? "#505050":"#F5F5F5"
            }
        }
        return "transparent"
    }
    property color bordercolor:{
        if(!control.enabled){
            return Theme.DisabledBorderColor
        }
        if(control.checked){
            return "transparent"
        }

        if(control.hovered){
            return Theme.isDark? "dimgrey":"#919191"   //137, 141, 142
        }
        return Theme.isDark? "dimgrey":"#A0A0A0"//Theme.ButtonNormalColor  137, 137, 137   158, 158, 158
    }

    font: Qt.font({family:Theme.defaultFontFamily,pixelSize : 14, weight: Font.Normal})
    padding: 4
    spacing: 4
    indicator: Rectangle {
        id: indicator
        width: 40
        height: 20
        x: control.text ? (control.mirrored ? control.width - width - control.rightPadding : control.leftPadding) : control.leftPadding + (control.availableWidth - width) / 2
        y: control.topPadding + (control.availableHeight - height) / 2
        radius: height / 2
        color:control.color
        border.width: 1
        border.color:control.bordercolor
        Rectangle {
            id: handle
            readonly property int offset: 4
            x: Math.max(offset, Math.min(parent.width - offset - width,control.visualPosition * parent.width - (width / 2)))
            y: (parent.height - height) / 2
            width: {
                if(control.pressed){
                    return 17
                }
                return 14
            }
            height: 14
            scale: {
                if(!control.enabled){
                    return 0.857
                }
                if(control.hovered){
                    return 1.0
                }
                return 0.857
            }
            radius: width / 2
            color: {
                if(control.checked){
                    if(!control.enabled){
                        return Theme.DisabledColor
                    }
                    return Theme.isDark ? Qt.rgba(0/255,0/255,0/255,1) : Qt.rgba(255/255,255/255,255/255,1)
                }else{
                    if(!control.enabled){
                        return Theme.DisabledColor
                    }
                    if(control.hovered){
                         return Theme.isDark ? Qt.rgba(210/255,210/255,210/255,0.8) : Qt.rgba(89/255,90/255,91/255,0.8)
                    }
                    return Theme.isDark ? Qt.rgba(209/255,209/255,209/255,0.8) : Qt.rgba(93/255,94/255,94/255,0.8)
                }
            }
            Behavior on x {
                enabled: !control.pressed
                NumberAnimation {
                    easing.type: Easing.InOutBack
                    duration: 300
                }
            }
            Behavior on width{
                enabled: control.pressed
                NumberAnimation {
                    easing.type:  Easing.OutCubic
                }
            }
            Behavior on scale {
                NumberAnimation {
                    duration: 150
                    easing.type: Easing.OutCubic// Theme.animationCurve
                }
            }
        }
    }
    //标题内容
    contentItem: Label {
        leftPadding: control.indicator && !control.mirrored ? control.indicator.width + control.spacing : 0
        rightPadding: control.indicator && control.mirrored ? control.indicator.width + control.spacing : 0
        text: control.text
        font: control.font
        color:{
            if(!control.enabled){
                return Theme.DisabledTextColor
            }
            return Theme.Textcolor
        }
        verticalAlignment: Qt.AlignVCenter
    }


}
