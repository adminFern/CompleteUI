import QtQuick
import QtQuick.Controls.impl
import QtQuick.Templates as T
import CompleteUI

T.ScrollBar {
    id: control

    property bool enabled: true
    property color normalColor: Theme.isDark ? Qt.rgba(159/255,159/255,159/255,0.6) : Qt.rgba(138/255,138/255,138/255,0.6)
    property color hoveredColor: Theme.isDark ? Qt.lighter(normalColor, 1.2) : Qt.darker(normalColor, 1.2)
    property color pressedColor: Theme.isDark ? Qt.lighter(normalColor, 1.4) : Qt.darker(normalColor, 1.4)
    property color disabledColor: Theme.isDark ? Qt.rgba(107/255,114/255,128/255,1) : Qt.rgba(156/255,163/255,175/255,1)
    property color minLineColor: Theme.isDark ? Qt.rgba(159/255,159/255,159/255,0.1) : Qt.rgba(138/255,138/255,138/255,0.1)

    QtObject{
        id: d
        property int minLine: 2
        property int maxLine: 6
        property bool isExpanded: contentItem.collapsed
    }

    implicitWidth: vertical ? 12 : Math.max(implicitBackgroundWidth + leftInset + rightInset, implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: horizontal ? 12 : Math.max(implicitBackgroundHeight + topInset + bottomInset, implicitContentHeight + topPadding + bottomPadding)

    visible: control.policy !== T.ScrollBar.AlwaysOff
    minimumSize: Math.max(orientation === Qt.Horizontal ? height / width : width / height, 0.3)

    interactive: enabled

    z: horizontal? 10 : 20
    verticalPadding : vertical ? 15 : 3
    horizontalPadding : horizontal ? 15 : 3

    background: Rectangle{
        id: back_rect
        radius: 5
        color: "transparent"
        opacity: d.isExpanded ? 1 : 0.5
        Behavior on opacity {
            NumberAnimation{
                duration: 50
            }
        }
    }

    // 水平滚动条 - 左按钮
    ComIconButton{
        id: leftBtn
        width: 12
        height: 12
        iconsize: 8
        handCursor: true
        leftPadding: 0
        rightPadding: 0
        topPadding: 0
        bottomPadding: 0
        visible: control.horizontal
        opacity: back_rect.opacity
        iconColor: {
            if (!control.enabled) return control.disabledColor
            if (leftBtn.pressed) return control.pressedColor
            if (leftBtn.hovered) return control.hoveredColor
            return "transparent"
        }
        enabled: control.enabled
        anchors{
            left: parent.left
            leftMargin: 2
            verticalCenter: parent.verticalCenter
        }
        iconsource: FluentIcon.ico_CaretLeftSolid8
        onClicked: {
            control.decrease()
        }
    }

    // 水平滚动条 - 右按钮
    ComIconButton{
        id: rightBtn
        width: 12
        height: 12
        iconsize: 8
        leftPadding: 0
        rightPadding: 0
        topPadding: 0
        bottomPadding: 0
        handCursor: true
        opacity: back_rect.opacity
        iconColor: {
            if (!control.enabled) return control.disabledColor
            if (rightBtn.pressed) return control.pressedColor
            if (rightBtn.hovered) return control.hoveredColor
            return "transparent"
        }
        enabled: control.enabled
        anchors{
            right: parent.right
            rightMargin: 2
            verticalCenter: parent.verticalCenter
        }
        visible: control.horizontal
        iconsource: FluentIcon.ico_CaretRightSolid8
        onClicked: {
            control.increase()
        }
    }

    // 垂直滚动条 - 上按钮
    ComIconButton{
        id: upBtn
        width: 12
        height: 12
        iconsize: 8
        leftPadding: 0
        rightPadding: 0
        topPadding: 0
        bottomPadding: 0
        handCursor: true
        opacity: back_rect.opacity
        iconColor: {
            if (!control.enabled) return control.disabledColor
            if (upBtn.pressed) return control.pressedColor
            if (upBtn.hovered) return control.hoveredColor
            return "transparent"
        }
        enabled: control.enabled
        anchors{
            top: parent.top
            topMargin: 2
            horizontalCenter: parent.horizontalCenter
        }
        visible: control.vertical
        iconsource: FluentIcon.ico_CaretUpSolid8
        onClicked: {
            control.decrease()
        }
    }

    // 垂直滚动条 - 下按钮
    ComIconButton{
        id: downBtn
        width: 12
        height: 12
        iconsize: 8
        leftPadding: 0
        rightPadding: 0
        topPadding: 0
        bottomPadding: 0
        handCursor: true
        opacity: back_rect.opacity
        iconColor: {
            if (!control.enabled) return control.disabledColor
            if (downBtn.pressed) return control.pressedColor
            if (downBtn.hovered) return control.hoveredColor
            return "transparent"
        }
        enabled: control.enabled
        anchors{
            bottom: parent.bottom
            bottomMargin: 2
            horizontalCenter: parent.horizontalCenter
        }
        visible: control.vertical
        iconsource: FluentIcon.ico_CaretDownSolid8
        onClicked: {
            control.increase()
        }
    }

    contentItem: Item {
        id: contentItemRoot
        property bool collapsed: (control.policy === T.ScrollBar.AlwaysOn || (control.active && control.size < 1.0))

        implicitWidth: 12
        implicitHeight: 12

        Rectangle{
            id: rect_bar
            radius: width / 2
            color: {
                if (!control.enabled) {
                    return control.disabledColor
                }
                if (control.pressed) {
                    return control.pressedColor
                }
                if (control.hovered) {
                    return control.hoveredColor
                }
                if (!contentItemRoot.collapsed) {
                    return control.minLineColor
                }
                return control.normalColor
            }
            visible: control.size < 1.0

            // 动态设置滑块位置和大小
            x: {
                if (control.horizontal) {
                    return control.position * (parent.width - width)
                }
                return (parent.width - width) / 2
            }

            y: {
                if (control.vertical) {
                    return control.position * (parent.height - height)
                }
                return (parent.height - height) / 2
            }

            width: {
                if (control.vertical) {
                    // 垂直滚动条：宽度固定，根据状态改变
                    return contentItemRoot.collapsed ? d.maxLine : d.minLine
                } else {
                    // 水平滚动条：宽度根据滚动范围动态计算
                    return Math.max(control.size * parent.width, d.minLine)
                }
            }

            height: {
                if (control.horizontal) {
                    // 水平滚动条：高度固定，根据状态改变
                    return contentItemRoot.collapsed ? d.maxLine : d.minLine
                } else {
                    // 垂直滚动条：高度根据滚动范围动态计算
                    return Math.max(control.size * parent.height, d.minLine)
                }
            }

            // 添加位置变化的动画
            Behavior on x {
                NumberAnimation { duration: 100; easing.type: Easing.OutCubic }
            }

            Behavior on y {
                NumberAnimation { duration: 100; easing.type: Easing.OutCubic }
            }

            // 添加大小变化的动画
            Behavior on width {
                NumberAnimation { duration: 167; easing.type: Easing.OutCubic }
            }

            Behavior on height {
                NumberAnimation { duration: 167; easing.type: Easing.OutCubic }
            }
        }
    }
}