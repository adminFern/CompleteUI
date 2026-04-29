import QtQuick
import QtQuick.Controls.impl
import QtQuick.Templates as T
import Qt5Compat.GraphicalEffects
import CompleteUI

// 进度条组件：带发光效果和平滑动画
T.ProgressBar {
    id: control

    property color progressColor: Theme.PrimaryColor   // 进度颜色
    property real barHeight: 20                          // 进度条高度

    property bool showProgressText: true                 // 显示进度文本
    property int progressTextFontSize: barHeight * 0.7
    property color progressTextColor: Theme.Textcolor
    property string progressTextFormat: "%1%"

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)

    background: Rectangle {
        id: bgRect
        implicitWidth: 200
        implicitHeight: control.barHeight
        x: control.leftPadding
        y: control.topPadding + (control.availableHeight - height) / 2
        width: control.availableWidth
        height: control.barHeight
        radius: control.barHeight / 2
        color: Theme.setColorAlpha(control.progressColor, 10)

        // 发光效果
        RectangularGlow {
            id: glow
            x: 0
            y: 0
            width: progressRect.animatedWidth
            height: bgRect.height
            glowRadius: 6
            spread: 0.2
            color: Theme.setColorAlpha(control.progressColor, 150)
            cornerRadius: bgRect.radius + glowRadius
            opacity: control.visualPosition > 0 ? 0.4 : 0
            visible: opacity > 0
            z: -1
            Behavior on opacity {
                NumberAnimation { duration: 200; easing.type: Easing.OutQuad }
            }
        }

        // 进度填充区域
        Item {
            id: progressClip
            anchors.fill: parent
            clip: true

            Rectangle {
                id: progressRect
                property real animatedWidth: 0
                width: animatedWidth
                height: parent.height
                radius: bgRect.radius
                color: control.progressColor

                Binding {
                    target: progressRect
                    property: "animatedWidth"
                    value: control.visualPosition * progressClip.width
                }

                // 进度宽度动画
                Behavior on animatedWidth {
                    NumberAnimation { duration: 300; easing.type: Easing.OutCubic }
                }

                Component.onCompleted: animatedWidth = control.visualPosition * progressClip.width
            }
        }
    }

    // 进度文本
    contentItem: Text {
        visible: control.showProgressText
        text: control.progressTextFormat.arg(Math.round(control.value * 100))
        font.pixelSize: control.progressTextFontSize
        font.family: Theme.defaultFontFamily
        color: control.progressTextColor
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
    }
}
