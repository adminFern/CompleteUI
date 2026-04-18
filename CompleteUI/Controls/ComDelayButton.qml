import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.impl
import QtQuick.Templates as T
import Qt5Compat.GraphicalEffects
import CompleteUI
T.DelayButton {
    id: control
    property color progressbarcolor: Theme.setColorAlpha(Theme.PrimaryColor,150)
    property color primarycolor:Theme.PrimaryColor
    property color color:{
        if (control.pressed){
            return Theme.ButtonPressColor
        }
        if (control.hovered){
            return Theme.ButtonHoverColor
        }
        return Theme.ButtonNormalColor
    }
    property color textcolor:{

        if(control.progress===1.0)
        {
            return "#FFFFFF"
        }
        return Theme.Textcolor
    }

    property color bordercolor:{
        if(control.hovered || control.progress===1.0) return control.primarycolor

        return Theme.ButtonBorderNormalColor
    }


    font: Qt.font({family:Theme.defaultFontFamily,pixelSize : 13, weight: Font.Normal})
    // 内容项
    contentItem: ComIconLabel {
        z:5
        id: contentItem
        anchors.fill: parent
        text: control.text
        iconsource: control.iconsource
        iconsize: control.iconsize
        font: control.font
        display: control.display
        spacing: control.spacing
        color: control.textcolor
        icocolor: control.textcolor
    }

    // 背景组件
    background: Item {
        z:0
        anchors.fill: parent
        RectangularGlow {
            id: glow
            anchors.fill: background
            glowRadius: 6
            spread: 0.4
            color: Theme.isDark ? Qt.darker(control.primarycolor, 0.9)
                                : Qt.lighter(control.primarycolor, 1.1)
            cornerRadius: background.radius + glowRadius
            opacity: (control.hovered && !control.pressed) ? 0.3 : 0
            visible: opacity > 0
            z: -1

        }
        Rectangle {
            id: background
            anchors.fill: parent
            radius: control.radius
            color: control.color
            border.width: 1
            border.color: control.bordercolor

            // 进度条填充
            Item {
                id: progressClip
                anchors.fill: parent
                anchors.margins: background.border.width
                clip: true
                Rectangle {
                    id: progressBar
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    width: Math.max(0, parent.width * control.progress)
                    radius: control.radius > background.border.width ? control.radius - background.border.width : 0
                    color: control.progressbarcolor
                }
            }
        }
    }


    transition: Transition {
        NumberAnimation {
            duration: control.delay * (control.pressed ? 1.0 - control.progress : 0.3 * control.progress)
            easing.type: Easing.Linear
        }
    }

    // 属性设置
    delay: 500
    focusPolicy: Qt.TabFocus
    display: DisplayType.TextOnly
    property int iconsize: 18
    property string iconsource
    property int radius: 4
    property bool handCursor: true
    //font: R.font
    spacing: 2
    padding: 4
    topPadding: 6
    bottomPadding: 6
    leftPadding: 6
    rightPadding: 6

    // 鼠标悬停处理
    HoverHandler {
        cursorShape: control.handCursor ? Qt.PointingHandCursor : Qt.ArrowCursor
    }

    // 大小计算
    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)
}
