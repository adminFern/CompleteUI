import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.impl
import QtQuick.Templates as T
import Qt5Compat.GraphicalEffects
import CompleteUI

// 延迟按钮：需长按指定时间后触发 clicked 信号，进度条填充提示
T.DelayButton {
    id: control

    property color progressbarcolor: Theme.setColorAlpha(Theme.PrimaryColor, 150)  // 进度条颜色
    property color primarycolor: Theme.PrimaryColor
    property bool flat: false                              // 扁平模式

    // 背景颜色：禁用 > 按下 > 悬停 > 默认
    property color color: {
        if (!enabled) return Theme.DisabledColor
        if (control.pressed) return Theme.ButtonPressColor
        if (control.hovered) return Theme.ButtonHoverColor
        return Theme.ButtonNormalColor
    }

    // 文本颜色：禁用 > 完成 > 默认
    property color textcolor: {
        if (!enabled) return Theme.DisabledTextColor
        if (control.progress === 1.0) return "#FFFFFF"
        return Theme.Textcolor
    }

    // 边框颜色：禁用 > 悬停/完成 > 默认
    property color bordercolor: {
        if (!enabled) return Theme.DisabledBorderColor
        if (control.hovered || control.progress === 1.0) return control.primarycolor
        return Theme.ButtonBorderNormalColor
    }

    font: Qt.font({ family: Theme.defaultFontFamily, pixelSize: 13, weight: Font.Normal })

    // 内容项：图标 + 文本
    contentItem: ComIconLabel {
        z: 5
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

    // 背景组件：发光效果 + 背景矩形 + 进度条
    background: Item {
        z: 0
        anchors.fill: parent

        // 发光效果
        RectangularGlow {
            id: glow
            anchors.fill: background
            glowRadius: 6
            spread: 0.4
            color: Theme.isDark ? Qt.darker(control.primarycolor, 0.9) : Qt.lighter(control.primarycolor, 1.1)
            cornerRadius: background.radius + glowRadius
            opacity: (!flat && enabled && control.hovered && !control.pressed) ? 0.3 : 0
            visible: opacity > 0
            z: -1
        }

        Rectangle {
            id: background
            anchors.fill: parent
            radius: control.radius
            color: control.color
            border.width: control.flat ? 0 : 1
            border.color: control.bordercolor

            // 进度条填充区域
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

    // 进度过渡动画
    transition: Transition {
        NumberAnimation {
            duration: control.delay * (control.pressed ? 1.0 - control.progress : 0.3 * control.progress)
            easing.type: Easing.Linear
        }
    }

    delay: 500                   // 延迟时间（毫秒）
    focusPolicy: Qt.TabFocus
    display: DisplayType.TextOnly
    property int iconsize: 18
    property string iconsource
    property int radius: 4
    property bool handCursor: true
    spacing: 2
    padding: 4
    topPadding: 6
    bottomPadding: 6
    leftPadding: 6
    rightPadding: 6

    HoverHandler {
        cursorShape: control.handCursor ? Qt.PointingHandCursor : Qt.ArrowCursor
    }

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)
}
