import QtQuick
import QtQuick.Controls.impl
import QtQuick.Templates as T
import QtQuick.Layouts
import FlaCoreUI

// 图标按钮组件：仅显示图标的简洁按钮
T.Button {
    id: control

    property bool handCursor: false              // 悬停时显示手型光标
    property int iconsize: 20                    // 图标大小
    property string iconsource: ""               // 图标源（FluentIcon.ico_xxx）
    // 颜色配置
    property color hoverColor: Theme.isDark ? Qt.rgba(1, 1, 1, 0.05) : Qt.rgba(0, 0, 0, 0.05)
    property color pressedColor: Theme.isDark ? Qt.rgba(1, 1, 1, 0.03) : Qt.rgba(0, 0, 0, 0.03)
    property color normalColor: "transparent"
    property color iconColor: Theme.isDark ? "white" : "black"
    property int radius: 4                       // 圆角
    property bool iconbold: false                // 图标加粗

    display: DisplayType.IconOnly
    font: Qt.font({ family: Theme.defaultFontFamily, pixelSize: 13, weight: Font.Normal })

    // 背景颜色：禁用 > 按下 > 悬停 > 默认
    property color color: {
        if (!enabled) {
            return Theme.DisabledColor
        }
        if (pressed) {
            return pressedColor
        }
        return hovered ? hoverColor : normalColor
    }

    // 内容项：图标标签
    contentItem: FlaIconLabel {
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

    // 背景
    background: Rectangle {
        radius: control.radius
        color: control.color
    }

    // 悬停光标处理
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
