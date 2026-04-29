import QtQuick
import QtQuick.Controls.impl
import QtQuick.Templates as T
import Qt5Compat.GraphicalEffects
import CompleteUI

// 圆形进度条组件：支持动画过渡和进度文本显示
T.ProgressBar {
    id: control

    property color progressColor: Theme.PrimaryColor              // 进度颜色
    property color trackColor: Theme.setColorAlpha(progressColor, 20)  // 轨道颜色
    property real strokeWidth: 8                                   // 线条宽度
    property real diameter: 100                                    // 直径
    property bool showProgressText: true                           // 显示进度文本
    property int progressTextFontSize: diameter * 0.22            // 文本字体大小
    property color progressTextColor: Theme.isDark ? "#FFFFFF" : "#000000"  // 文本颜色
    property string progressTextFormat: "%1%"                      // 文本格式
    property int startAngle: -90                                   // 起始角度

    implicitWidth: diameter
    implicitHeight: diameter

    // 动画值：平滑过渡进度值
    property real animValue: 0
    Behavior on animValue {
        NumberAnimation { duration: 300; easing.type: Easing.OutCubic }
    }
    onValueChanged: animValue = value
    Component.onCompleted: animValue = value

    background: Item {
        // 发光效果
        RectangularGlow {
            anchors.fill: canvas
            glowRadius: 8
            spread: 0.5
            color: Theme.setColorAlpha(control.progressColor, 120)
            cornerRadius: canvas.width / 2 + glowRadius
            opacity: control.animValue > 0 ? 0.35 : 0
            visible: opacity > 0
            z: -1
            Behavior on opacity { NumberAnimation { duration: 200; easing.type: Easing.OutQuad } }
        }

        // Canvas 绘制圆形进度条
        Canvas {
            id: canvas
            width: control.diameter
            height: control.diameter
            onPaint: {
                var ctx = getContext("2d")
                ctx.reset()

                var cx = width / 2
                var cy = height / 2
                var r = Math.max(1, cx - control.strokeWidth / 2)
                var startRad = control.startAngle * Math.PI / 180
                var endRad = startRad + control.animValue * 2 * Math.PI

                ctx.lineWidth = control.strokeWidth
                ctx.lineCap = "round"

                // 绘制轨道
                ctx.beginPath()
                ctx.arc(cx, cy, r, 0, 2 * Math.PI)
                ctx.strokeStyle = control.trackColor
                ctx.stroke()

                // 绘制进度
                if (control.animValue > 0) {
                    ctx.beginPath()
                    ctx.arc(cx, cy, r, startRad, endRad)
                    ctx.strokeStyle = control.progressColor
                    ctx.stroke()
                }
            }

            // 监听属性变化重绘
            Connections {
                target: control
                function onAnimValueChanged() { canvas.requestPaint() }
                function onProgressColorChanged() { canvas.requestPaint() }
                function onTrackColorChanged() { canvas.requestPaint() }
                function onStrokeWidthChanged() { canvas.requestPaint() }
                function onStartAngleChanged() { canvas.requestPaint() }
            }
        }
    }

    // 进度文本
    contentItem: Text {
        visible: control.showProgressText
        text: control.progressTextFormat.arg(Math.round(control.value * 100))
        font.pixelSize: control.progressTextFontSize
        font.family: Theme.defaultFontFamily
        font.bold: true
        color: control.progressTextColor
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        anchors.centerIn: parent
    }
}
