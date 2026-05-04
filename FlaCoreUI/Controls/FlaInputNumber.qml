import QtQuick
import QtQuick.Templates as T
import QtQuick.Layouts
import QtQuick.Controls
import FlaCoreUI

// 数字输入框：支持步进增减、格式化、前后缀
T.Control {
    id: control
    signal valueModified()
    property bool animationEnabled: true
    property bool showHandler: true               // 显示增减按钮
    property bool alwaysShowHandler: false        // 始终显示增减按钮
    property bool useWheel: false                 // 支持滚轮调节
    property bool useKeyboard: true               // 支持键盘调节
    property real value: 0                        // 当前值
    property real min: Number.MIN_SAFE_INTEGER    // 最小值
    property real max: Number.MAX_SAFE_INTEGER    // 最大值
    property real step: 1                         // 步进值
    property int precision: 0                     // 小数位数
    property string suffix: 'Km'                    // 后缀
    property string upIcon: FluentIcon.ico_ChevronUp
    property string downIcon: FluentIcon.ico_ChevronDown
    property var formatter: (v) => v.toFixed(precision)   // 格式化函数
    property int handlerWidth: 24
    property color color: Theme.isDark ? "#3C3C3C" : "white"
    property color colorBorder: {
        if (!enabled) return Theme.DisabledBorderColor
        if (__input.activeFocus) return Theme.PrimaryColor
        if (control.hovered) return Theme.PrimaryColor
        return Theme.isDark ? Qt.rgba(1, 1, 1, 0.15) : Qt.rgba(0, 0, 0, 0.15)
    }
    property color colorText: !enabled ? Theme.DisabledTextColor : Theme.isDark ? "white" : "black"
    property int radius: 4

    property alias input: __input

    // 增加值
    function increase() {
        value = value + step > max ? max : value + step;
    }

    // 减少值
    function decrease() {
        value = value - step < min ? min : value - step;
    }

    // 全选
    function selectAll() {
        __input.selectAll();
    }

    onValueChanged: __input.text = formatter(value)
    onSuffixChanged: valueChanged()
    Component.onCompleted: valueChanged()

    font: Qt.font({ family: Theme.defaultFontFamily, pixelSize: 14, weight: Font.Normal })

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: 32

    contentItem: RowLayout {
        id: __row
        spacing: 2
        // 输入框
        TextInput {
            id: __input
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.leftMargin: 10
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            color: control.colorText
            font: control.font
            readOnly: true
            selectByMouse: true
            Keys.onUpPressed: {
                if (control.enabled && control.useKeyboard) {
                    control.increase();
                    control.valueModified();
                }
            }
            Keys.onDownPressed: {
                if (control.enabled && control.useKeyboard) {
                    control.decrease();
                    control.valueModified();
                }
            }

            // 滚轮调节
            WheelHandler {
                enabled: control.enabled && control.useWheel
                onWheel: function(wheel) {
                    if (wheel.angleDelta.y > 0) {
                        control.increase();
                        control.valueModified();
                    } else {
                        control.decrease();
                        control.valueModified();
                    }
                }
            }
        }
        // 后缀
        Text {
            Layout.fillWidth: false
            Layout.fillHeight: true
            Layout.rightMargin: 8
            visible: control.suffix !== ''
            text: control.suffix
            color: "darkgray"
            font.pixelSize: 11
            verticalAlignment: Text.AlignVCenter
            Layout.alignment: Qt.AlignRight
        }

        // 增减按钮区域
        Rectangle {
            id: __handlerRoot
            visible: control.showHandler
            Layout.preferredWidth: control.enabled && (control.hovered || control.alwaysShowHandler) ? control.handlerWidth : 0
            Layout.fillHeight: true
            color: "transparent"
            clip: true

            property real halfHeight: height * 0.5
            property real hoverHeight: height * 0.6
            property real noHoverHeight: height * 0.4
            Behavior on Layout.preferredWidth {
                enabled: control.animationEnabled
                NumberAnimation { easing.type: Easing.OutCubic; duration: 150 }
            }
            // 左侧分隔线
            Rectangle {
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                width: 1
                color: control.colorBorder
            }
            // 增加按钮
            Rectangle {
                id: __upButton
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.right: parent.right
                height: __upArea.containsMouse ? parent.hoverHeight : __downArea.containsMouse ? parent.noHoverHeight : parent.halfHeight
                color: "transparent"
                topLeftRadius: 0
                topRightRadius: control.radius
                bottomLeftRadius: 0
                bottomRightRadius: 0
                FlaImage {
                    anchors.centerIn: parent
                    iconsource: control.upIcon
                    iconsize: 10
                    iconbold: true
                    icocolor: control.enabled ? (__upArea.containsMouse ? Theme.PrimaryColor : control.colorText) : Theme.DisabledTextColor
                    scale: __upArea.pressed ? 1.3 : 1.0
                    Behavior on scale {
                        NumberAnimation { duration: 100; easing.type: Easing.OutCubic }
                    }
                }

                MouseArea {
                    id: __upArea
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: control.value < control.max ? Qt.PointingHandCursor : Qt.ArrowCursor
                    onClicked: {
                        control.increase();
                        control.valueModified();
                    }
                }

                Behavior on height {
                    enabled: control.animationEnabled
                    NumberAnimation { duration: 100 }
                }
            }
            // 中间分隔线
            Rectangle {
                anchors.left: parent.left
                anchors.right: parent.right
                y: __upButton.height + __upButton.y - 0.5
                height: 1
                color: control.colorBorder
            }
            // 减少按钮
            Rectangle {
                id: __downButton
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: __upButton.bottom
                anchors.topMargin: -1
                height: (__downArea.containsMouse ? parent.hoverHeight : __upArea.containsMouse ? parent.noHoverHeight : parent.halfHeight)
                color: "transparent"
                topLeftRadius: 0
                topRightRadius: 0
                bottomLeftRadius: 0
                bottomRightRadius: control.radius

                FlaImage {
                    anchors.centerIn: parent
                    iconsource: control.downIcon
                    iconsize: 10
                    iconbold: true
                    icocolor: control.enabled ? (__downArea.containsMouse ? Theme.PrimaryColor : control.colorText) : Theme.DisabledTextColor
                    scale: __downArea.pressed ? 1.3 : 1.0
                    Behavior on scale {
                        NumberAnimation { duration: 100; easing.type: Easing.OutCubic }
                    }
                }
                MouseArea {
                    id: __downArea
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: control.value > control.min ? Qt.PointingHandCursor : Qt.ArrowCursor
                    onClicked: {
                        control.decrease();
                        control.valueModified();
                    }
                }
                Behavior on height {
                    enabled: control.animationEnabled
                    NumberAnimation { duration: 100 }
                }
            }
        }
    }
    // 背景
    background: Rectangle {
        radius: control.radius
        color: control.color
        border.width: 1
        border.color: control.colorBorder
        Behavior on border.color { enabled: control.animationEnabled; ColorAnimation { duration: 200 } }
    }

    HoverHandler {
        cursorShape: control.enabled ? Qt.IBeamCursor : Qt.ArrowCursor
    }
}
