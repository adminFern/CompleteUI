import QtQuick
import QtQuick.Templates as T
import QtQuick.Controls
import FlaCoreUI

T.RadioButton {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding,
                             implicitIndicatorHeight + topPadding + bottomPadding)
    padding: 6
    spacing: 6
    font: Qt.font({family:Theme.defaultFontFamily,pixelSize : 13, weight: Font.Normal})
    property color checkColor: Theme.PrimaryColor
    indicator: Rectangle {
        x: control.text ? (control.mirrored ? control.width - width - control.rightPadding : control.leftPadding) : control.leftPadding + (control.availableWidth - width) / 2
        y: control.topPadding + (control.availableHeight - height) / 2
        implicitWidth: 20
        implicitHeight: 20
        radius: width / 2
        color: {
            if(control.checked){
                return  Theme.setColorAlpha(Theme.isDark? "black":"white",120)

            }else{
                if(!control.enabled){
                    return Theme.DisabledColor
                }
                return "transparent"
            }
        }
        border.width: {
            if(control.checked){
                if(control.enabled){
                    if(control.hovered && !control.pressed){
                         return 3.4
                    }
                    return 5.0
                }else{
                    return 4.0
                }
            }else{
                if(control.pressed){
                    return 4.5
                }
                return 1
            }
        }
        border.color: {
            if(control.checked){
                return checkColor
            }else{
                if(!control.enabled){
                    return Theme.DisabledBorderColor
                }
                if(control.hovered){
                    return Theme.ButtonHoverColor
                }
                return Theme.ButtonNormalColor
            }
        }
        Behavior on border.width {
            NumberAnimation{
               // duration: Theme.fastAnimationDuration
                easing.type:Easing.OutCubic
            }
        }
    }
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
