import QtQuick
import QtQuick.Controls.impl
import QtQuick.Templates as T
import QtQuick.Layouts
import QtQuick.Controls
import Qt5Compat.GraphicalEffects
import CompleteUI

/*!
    \qmltype ComFloatButton
    \inqmlmodule CompleteUI
    \brief 悬浮按钮组件，点击主按钮展开多个子按钮

    \section1 基本用法
    \qml
    ComFloatButton {
        direction: ComFloatButton.Direction.Up
        actions: [
            { icon: FluentIcon.ico_Edit, enabled: true },
            { icon: FluentIcon.ico_Delete, enabled: true },
            { icon: FluentIcon.ico_Share, enabled: true }
        ]
        onSubClicked: (index) => {
            console.log("点击了第", index, "个子按钮")
        }
    }
    \endqml

    \section2 方向枚举
    \value Direction.Up    向上展开
    \value Direction.Down  向下展开
    \value Direction.Left  向左展开
    \value Direction.Right 向右展开

    \section2 actions 数组属性
    每个元素支持以下字段：
    \list
        \li icon: string - 图标（使用 FluentIcon 图标代码）
        \li enabled: bool - 是否启用（禁用时显示灰色）
    \endlist

    \section2 信号
    \signal clicked - 主按钮点击时触发
    \signal subClicked(int index) - 子按钮点击时触发，index 表示按钮索引（从0开始）
*/

Item {
    id: control

    /*! 展开方向，可选值：Up, Down, Left, Right */
    enum Direction {
        Up,    ///< 向上展开
        Down,  ///< 向下展开
        Left,  ///< 向左展开
        Right  ///< 向右展开
    }

    /*! 展开方向，默认为向上 */
    property int direction: ComFloatButton.Direction.Up

    /*! 按钮尺寸（直径），默认为48 */
    property int buttonSize: 48

    /*! 子按钮之间的间距，默认为12 */
    property int spacing: 12

    /*! 主按钮图标 */
    property string iconsource: FluentIcon.ico_Add

    /*! 主题颜色，默认为系统主色 */
    property color accentColor: Theme.PrimaryColor

    /*! 是否展开状态，可绑定或手动控制 */
    property alias expanded: d.expanded

    /*! 主按钮点击信号 */
    signal clicked

    /*! 子按钮点击信号
        \param index 子按钮索引，从0开始
    */
    signal subClicked(int index)

    /*!
        \qmlproperty var actions

        子按钮配置数组，每个元素为对象：
        \code
        actions: [
            { icon: FluentIcon.ico_Edit, enabled: true },
            { icon: FluentIcon.ico_Delete, enabled: false },
            ...
        ]
        \endcode

        支持字段：
        \list
            \li icon    - 图标代码（FluentIcon）
            \li enabled - 是否启用（禁用显示灰色）
        \endlist
    */
    property var actions: []

    /*! 内部数据对象 */
    QtObject {
        id: d
        property bool expanded: false  ///< 展开/收起状态
    }

    /*!
        根据方向计算组件宽度
        左右展开时宽度 = buttonSize + spacing + 子按钮总宽度
        上下展开时宽度 = buttonSize
    */
    implicitWidth: {
        if (direction === ComFloatButton.Direction.Left ||
            direction === ComFloatButton.Direction.Right) {
            // 左右展开：主按钮 + spacing + 每个子按钮(直径+间距)
            return buttonSize * 2 + spacing
        }
        return buttonSize
    }

    /*!
        根据方向计算组件高度
        上下展开时高度 = buttonSize + spacing + 子按钮总高度
        左右展开时高度 = buttonSize
    */
    implicitHeight: {
        if (direction === ComFloatButton.Direction.Up ||
            direction === ComFloatButton.Direction.Down) {
            // 上下展开：主按钮 + spacing + 每个子按钮(直径+间距)
            return buttonSize * 2 + spacing
        }
        return buttonSize
    }

    /*! 内容层，包含所有按钮 */
    Item {
        id: content
        anchors.fill: parent

        /*!
            子按钮 Repeater
            通过遍历 actions 数组动态创建对应数量的子按钮
        */
        Repeater {
            id: repeater
            model: actions.length  ///< 根据 actions 数量创建按钮

            delegate: Rectangle {
                id: subBtn
                property int idx: index  ///< 当前按钮索引

                width: buttonSize
                height: buttonSize
                radius: buttonSize / 2  ///< 圆形按钮
                z: 0  ///< 在主按钮下方

                /*!
                    按钮颜色状态：
                    1. 禁用状态 -> DisabledColor
                    2. 按下状态 -> 深色（根据主题明暗调整）
                    3. 悬停状态 -> 浅色
                    4. 默认状态 -> accentColor
                */
                color: {
                    if (!actions[idx].enabled) return Theme.DisabledColor
                    if (subMouse.pressed) return Theme.isDark ? Qt.darker(accentColor, 1.3) : Qt.darker(accentColor, 1.15)
                    if (subMouse.hovered) return Theme.isDark ? Qt.lighter(accentColor, 1.2) : Qt.lighter(accentColor, 1.1)
                    return accentColor
                }
                border.width: 1
                border.color: Theme.isDark ? Qt.rgba(1, 1, 1, 0.1) : Qt.rgba(0, 0, 0, 0.1)
                opacity: actions[idx].enabled ? 1 : 0.5  ///< 禁用时半透明

                /*!
                    计算子按钮展开后的目标X坐标
                    上下展开：所有子按钮X坐标与主按钮对齐
                    向右展开：从主按钮位置向右依次排列
                    向左展开：从主按钮位置向左依次排列
                */
                property real targetX: {
                    if (direction === ComFloatButton.Direction.Up || direction === ComFloatButton.Direction.Down) {
                        return mainBtn.x  ///< 上下展开时X与主按钮对齐
                    }
                    if (direction === ComFloatButton.Direction.Right) {
                        // 向右展开：主按钮X + (索引+1) * (按钮直径+间距)
                        return mainBtn.x + (idx + 1) * (buttonSize + spacing)
                    }
                    // 向左展开：主按钮X - (索引+1) * (按钮直径+间距)
                    return mainBtn.x - (idx + 1) * (buttonSize + spacing)
                }

                /*!
                    计算子按钮展开后的目标Y坐标
                    左右展开：所有子按钮Y坐标与主按钮对齐
                    向下展开：从主按钮位置向下依次排列
                    向上展开：从主按钮位置向上依次排列
                */
                property real targetY: {
                    if (direction === ComFloatButton.Direction.Left || direction === ComFloatButton.Direction.Right) {
                        return mainBtn.y  ///< 左右展开时Y与主按钮对齐
                    }
                    if (direction === ComFloatButton.Direction.Down) {
                        // 向下展开：主按钮Y + (索引+1) * (按钮直径+间距)
                        return mainBtn.y + (idx + 1) * (buttonSize + spacing)
                    }
                    // 向上展开：主按钮Y - (索引+1) * (按钮直径+间距)
                    return mainBtn.y - (idx + 1) * (buttonSize + spacing)
                }

                /*!
                    动画绑定：
                    - 收起时：位置、缩放回到主按钮位置和原始大小
                    - 展开时：位置、缩放到目标位置和正常大小
                */
                x: d.expanded ? targetX : mainBtn.x
                y: d.expanded ? targetY : mainBtn.y
                scale: d.expanded ? 1 : 0  ///< 收起时缩放为0，展开时恢复

                /*!
                    位移动画
                    - duration: 250ms
                    - easing: OutCubic 缓出效果
                */
                Behavior on x { NumberAnimation { duration: 250; easing.type: Easing.OutCubic } }
                Behavior on y { NumberAnimation { duration: 250; easing.type: Easing.OutCubic } }

                /*! 缩放动画 */
                Behavior on scale { NumberAnimation { duration: 200; easing.type: Easing.OutCubic } }

                /*! 颜色过渡动画 */
                Behavior on color { ColorAnimation { duration: 150 } }

                /*!
                    悬停发光效果
                    使用 RectangularGlow 实现类似按钮的悬停高亮效果
                */
                RectangularGlow {
                    anchors.fill: parent
                    glowRadius: 6           ///< 发光半径
                    spread: 0.4             ///< 发光扩散强度
                    color: Theme.isDark ? Qt.darker(accentColor, 0.9) : Qt.lighter(accentColor, 1.1)
                    cornerRadius: parent.radius + glowRadius
                    /*!
                        发光可见条件：
                        1. 已展开
                        2. 鼠标悬停
                        3. 未按下
                        4. 按钮启用
                    */
                    opacity: subMouse.hovered && !subMouse.pressed && actions[idx].enabled ? 0.3 : 0
                    visible: opacity > 0
                    z: -1  ///< 在按钮下方
                    Behavior on opacity { NumberAnimation { duration: 200; easing.type: Easing.OutQuad } }
                }

                /*! 子按钮图标，使用 ComImage 组件支持多种图标格式 */
                ComImage {
                    anchors.centerIn: parent
                    width: buttonSize * 0.6
                    height: buttonSize * 0.6
                    iconsource: actions[idx].icon
                    iconsize: buttonSize * 0.4
                    icocolor: "white"
                }

                /*! 子按钮鼠标交互区域 */
                MouseArea {
                    id: subMouse
                    anchors.fill: parent
                    enabled: actions[idx].enabled  ///< 跟随按钮启用状态
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onClicked: {
                        /*! 触发子按钮点击信号，传递索引 */
                        control.subClicked(index)
                    }
                }
            }
        }

        /*!
            主按钮
            始终可见，点击控制展开/收起
        */
        Rectangle {
            id: mainBtn
            width: buttonSize
            height: buttonSize
            radius: buttonSize / 2  ///< 圆形
            z: 1  ///< 在子按钮上方

            /*!
                主按钮位置计算
                根据方向将主按钮放置在组件边缘：
                - Left:  右边缘
                - Right: 左边缘
                - Up:    下边缘
                - Down:  上边缘
            */
            x: {
                if (direction === ComFloatButton.Direction.Left) return control.width - buttonSize
                if (direction === ComFloatButton.Direction.Right) return 0
                return (control.width - buttonSize) / 2  ///< 居中
            }
            y: {
                if (direction === ComFloatButton.Direction.Down) return 0
                if (direction === ComFloatButton.Direction.Up) return control.height - buttonSize
                return (control.height - buttonSize) / 2  ///< 居中
            }

            /*! 主按钮颜色（与子按钮逻辑相同） */
            color: {
                if (mainMouse.pressed) return Theme.isDark ? Qt.darker(accentColor, 1.3) : Qt.darker(accentColor, 1.15)
                if (mainMouse.hovered) return Theme.isDark ? Qt.lighter(accentColor, 1.2) : Qt.lighter(accentColor, 1.1)
                return accentColor
            }
            border.width: 1
            border.color: Theme.isDark ? Qt.rgba(1, 1, 1, 0.1) : Qt.rgba(0, 0, 0, 0.1)

            Behavior on color { ColorAnimation { duration: 150 } }

            /*! 按下时缩放动画 */
            Behavior on scale { NumberAnimation { duration: 150; easing.type: Easing.InOutQuad } }
            scale: mainMouse.pressed ? 0.92 : 1.0

            /*! 主按钮悬停发光效果 */
            RectangularGlow {
                anchors.fill: parent
                glowRadius: 6
                spread: 0.4
                color: Theme.isDark ? Qt.darker(accentColor, 0.9) : Qt.lighter(accentColor, 1.1)
                cornerRadius: parent.radius + glowRadius
                opacity: mainMouse.hovered && !mainMouse.pressed ? 0.3 : 0
                visible: opacity > 0
                z: -1
                Behavior on opacity { NumberAnimation { duration: 200; easing.type: Easing.OutQuad } }
            }

            /*!
                主按钮图标容器
                使用 Item 包裹 ComImage 以支持旋转动画
            */
            Item {
                anchors.centerIn: parent
                width: buttonSize * 0.6
                height: buttonSize * 0.6

                /*! 展开时旋转45度（+变成×） */
                rotation: d.expanded ? 45 : 0
                Behavior on rotation { NumberAnimation { duration: 250; easing.type: Easing.OutCubic } }

                ComImage {
                    anchors.fill: parent
                    iconsource: control.iconsource
                    iconsize: buttonSize * 0.4
                    icocolor: "white"
                }
            }

            /*! 主按钮鼠标区域 */
            MouseArea {
                id: mainMouse
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    d.expanded = !d.expanded  ///< 切换展开状态
                    control.clicked()         ///< 触发点击信号
                }
            }
        }
    }
}
