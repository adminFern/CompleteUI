import QtQuick
import QtQuick.Controls.impl
import QtQuick.Templates as T
import QtQuick.Layouts
import QtQuick.Controls
import Qt5Compat.GraphicalEffects
import CompleteUI

// 按钮组件：支持图标、文本、高亮状态和按压动画
T.Button {
    id: control

    display: DisplayType.TextOnly
    property bool handCursor: true
    property int iconsize: 16
    property string iconsource                // 图标源
    property int radius: 4                    // 圆角

    // 颜色配置
    property color normalcolor: Theme.ButtonNormalColor
    property color hovercolor: Theme.ButtonHoverColor
    property color pressedcolor: Theme.ButtonPressColor
    property color primarycolor: Theme.PrimaryColor
    property color highlightedcolor: "hotpink"

    // 文本颜色：禁用 > 高亮 > 默认
    property color textcolor: {
        if (!enabled) return Theme.DisabledTextColor
        if (control.highlighted) return "white"
        return Theme.Textcolor
    }

    // 边框颜色：禁用 > flat > 高亮 > 悬停 > 默认
    property color bordercolor: {
        if (!enabled) return Theme.DisabledBorderColor
        if (flat) return "transparent"
        if (highlighted) return highlightedcolor
        if (control.hovered) return Theme.PrimaryColor
        return Theme.ButtonBorderNormalColor
    }

    // 内部状态
    QtObject {
        id: d
        // 背景颜色计算：禁用 > 高亮 > 按下 > 悬停 > 默认
        property color color: {
            if (!enabled) return Theme.DisabledColor
            // 高亮状态颜色处理
            if (highlighted) {
                if (flat) {
                    if (control.pressed) return Theme.isDark ? Qt.darker(control.highlightedcolor, 0.8) : Qt.lighter(control.highlightedcolor, 1.1)
                    if (control.hovered) return Theme.isDark ? Qt.darker(control.highlightedcolor, 0.9) : Qt.lighter(control.highlightedcolor, 1.2)
                    return control.highlightedcolor
                } else {
                    if (control.pressed) return Theme.isDark ? Theme.setColorAlpha(Qt.darker(control.highlightedcolor, 0.8), 230) : Theme.setColorAlpha(Qt.lighter(control.highlightedcolor, 1.1), 230)
                    if (control.hovered) return Theme.isDark ? Theme.setColorAlpha(Qt.darker(control.highlightedcolor, 0.9), 230) : Theme.setColorAlpha(Qt.lighter(control.highlightedcolor, 1.2), 230)
                    return Theme.setColorAlpha(control.highlightedcolor, 230)
                }
            }
            if (control.pressed) return control.pressedcolor
            if (control.hovered) return control.hovercolor
            return control.normalcolor
        }
    }

    property bool enableAnimation: true           // 启用按压动画
    property real scaleAnimationFactor: 0.95      // 缩放比例
    highlighted: false
    font: Qt.font({ family: Theme.defaultFontFamily, pixelSize: 14, weight: Font.Normal })
    spacing: 2
    padding: 0
    topPadding: 6
    bottomPadding: 6
    leftPadding: 6
    rightPadding: 6

    // 内容项：图标 + 文本
    contentItem: ComIconLabel {
        z: 4
        id: contentItem
        anchors.centerIn: parent
        text: control.text
        iconsource: control.iconsource
        iconsize: control.iconsize
        font: control.font
        display: control.display
        spacing: control.spacing
        color: control.textcolor
        icocolor: control.textcolor
        scale: 1.0
    }

    // 背景项：发光效果 + 背景矩形
    background: Item {
        z: 0
        anchors.fill: parent

        // 发光效果（悬停时显示）
        RectangularGlow {
            id: glow
            anchors.fill: background
            glowRadius: 6
            spread: 0.4
            color: {
                if (control.highlighted) return Theme.isDark ? Qt.darker(control.highlightedcolor, 0.9) : Qt.lighter(control.highlightedcolor, 1.1)
                return Theme.isDark ? Qt.darker(control.primarycolor, 0.9) : Qt.lighter(control.primarycolor, 1.1)
            }
            cornerRadius: background.radius + glowRadius
            opacity: (enabled && !control.flat && control.hovered && !control.pressed) ? 0.3 : 0
            visible: opacity > 0
            scale: 1.0
            z: -1
            Behavior on opacity { NumberAnimation { duration: 200; easing.type: Easing.OutQuad } }
        }

        // 背景矩形
        Rectangle {
            id: background
            anchors.fill: parent
            radius: control.radius
            color: d.color
            border.width: control.flat ? 0 : 1
            border.color: control.bordercolor
            scale: 1.0
            Behavior on border.color { ColorAnimation { duration: 200 } }
            Behavior on color { ColorAnimation { duration: 200 } }
        }
    }

    // 按下动画
    ParallelAnimation {
        id: pressAnimation
        running: false
        NumberAnimation { target: contentItem; property: "scale"; to: control.scaleAnimationFactor; duration: 75; easing.type: Easing.InOutQuad }
        NumberAnimation { target: background; property: "scale"; to: control.scaleAnimationFactor; duration: 75; easing.type: Easing.InOutQuad }
        NumberAnimation { target: glow; property: "scale"; to: control.scaleAnimationFactor; duration: 75; easing.type: Easing.InOutQuad }
    }

    // 释放动画
    ParallelAnimation {
        id: releaseAnimation
        running: false
        NumberAnimation { target: contentItem; property: "scale"; to: 1.0; duration: 75; easing.type: Easing.InOutQuad }
        NumberAnimation { target: background; property: "scale"; to: 1.0; duration: 75; easing.type: Easing.InOutQuad }
        NumberAnimation { target: glow; property: "scale"; to: 1.0; duration: 75; easing.type: Easing.InOutQuad }
    }

    // 监听按下状态触发动画
    onPressedChanged: {
        if (control.enableAnimation) {
            if (control.pressed) {
                releaseAnimation.stop()
                pressAnimation.start()
            } else {
                pressAnimation.stop()
                releaseAnimation.start()
            }
        }
    }

    HoverHandler {
        cursorShape: control.handCursor ? Qt.PointingHandCursor : Qt.ArrowCursor
    }

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)
}
