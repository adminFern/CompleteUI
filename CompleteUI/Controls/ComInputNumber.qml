import QtQuick
import QtQuick.Templates as T
import QtQuick.Layouts
import QtQuick.Controls
import CompleteUI

// 数字输入框：支持步进增减、格式化、前后缀
T.Control {
    id: control

    signal valueModified()

    property bool animationEnabled: true
    property bool active: hovered || activeFocus
    property bool showHandler: true               // 显示增减按钮
    property bool alwaysShowHandler: false        // 始终显示增减按钮
    property bool useWheel: false                 // 支持滚轮调节
    property bool useKeyboard: true               // 支持键盘调节
    property real value: 0                        // 当前值
    property real min: Number.MIN_SAFE_INTEGER    // 最小值
    property real max: Number.MAX_SAFE_INTEGER    // 最大值
    property real step: 1                         // 步进值
    property int precision: 0                     // 小数位数
    property bool readOnly: false
    property string prefix: ''                    // 前缀
    property string suffix: ''                    // 后缀
    property string upIcon: FluentIcon.ico_ChevronUp
    property string downIcon: FluentIcon.ico_ChevronDown
    property var formatter: (v) => v.toFixed(precision)   // 格式化函数
    property var parser: (text) => parseFloat(text)       // 解析函数
    property int handlerWidth: 24
    property color colorBg: Theme.isDark ? Qt.rgba(1, 1, 1, 0.05) : Qt.rgba(0, 0, 0, 0.03)
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
    onPrefixChanged: valueChanged()
    onSuffixChanged: valueChanged()
    Component.onCompleted: valueChanged()

    font: Qt.font({ family: Theme.defaultFontFamily, pixelSize: 14, weight: Font.Normal })

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: 32

    contentItem: RowLayout {
        id: __row
        spacing: 0

        // 前缀
        Text {
            visible: control.prefix !== ''
            text: control.prefix
            color: control.colorText
            font: control.font
            verticalAlignment: Text.AlignVCenter
            leftPadding: 8
            rightPadding: 4
        }

        // 输入框
        TextInput {
            id: __input
            Layout.fillWidth: true
            Layout.fillHeight: true
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            color: control.colorText
            font: control.font
            readOnly: control.readOnly
            selectByMouse: true
            validator: DoubleValidator {
                locale: control.locale.name
                bottom: Math.min(control.min, control.max)
                top: Math.max(control.min, control.max)
                decimals: control.precision
            }

            onActiveFocusChanged: {
                if (!activeFocus) editingFinished();
            }
            onTextChanged: {
                if (length === 0) return;
                let v = control.parser(text);
                if (!isNaN(v) && v > control.max) {
                    editingFinished();
                }
            }
            onEditingFinished: {
                if (length === 0) return;
                let v = control.parser(text);
                if (isNaN(v)) v = control.value;
                text = control.formatter(v);
                control.value = v;
                control.valueModified();
            }

            // 键盘快捷键
            Keys.onReturnPressed: editingFinished()
            Keys.onEnterPressed: editingFinished()
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

            Component.onCompleted: editingFinished()
        }

        // 后缀
        Text {
            visible: control.suffix !== ''
            text: control.suffix
            color: control.colorText
            font: control.font
            verticalAlignment: Text.AlignVCenter
            leftPadding: 4
            rightPadding: 4
        }

        // 增减按钮区域
        Rectangle {
            id: __handlerRoot
            visible: control.showHandler && !control.readOnly
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
            ComIconButton {
                id: __upButton
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.right: parent.right
                height: hovered ? parent.hoverHeight : __downButton.hovered ? parent.noHoverHeight : parent.halfHeight
                padding: 0
                radius: 0
                iconsource: control.upIcon
                iconsize: 10
                iconbold: true
                iconColor: control.enabled ? (hovered ? Theme.PrimaryColor : control.colorText) : Theme.DisabledTextColor
                handCursor: control.value < control.max
                autoRepeat: true
                onClicked: {
                    control.increase();
                    control.valueModified();
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
            ComIconButton {
                id: __downButton
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: __upButton.bottom
                anchors.topMargin: -1
                height: (__downButton.hovered ? parent.hoverHeight : __upButton.hovered ? parent.noHoverHeight : parent.halfHeight) + 1
                padding: 0
                radius: 0
                iconsource: control.downIcon
                iconsize: 10
                iconbold: true
                iconColor: control.enabled ? (hovered ? Theme.PrimaryColor : control.colorText) : Theme.DisabledTextColor
                handCursor: control.value > control.min
                autoRepeat: true
                onClicked: {
                    control.decrease();
                    control.valueModified();
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
        color: control.colorBg
        border.width: 1
        border.color: control.colorBorder

        Behavior on border.color { enabled: control.animationEnabled; ColorAnimation { duration: 150 } }
    }

    HoverHandler {
        cursorShape: control.enabled ? Qt.IBeamCursor : Qt.ArrowCursor
    }
}
