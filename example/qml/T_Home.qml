import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import CompleteUI

Item {
    id: root
    //  anchors.fill: parent
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 10
        spacing: 2

        Text {
            text: "QuickUI 简介"
            font.pixelSize: 24
            font.bold: true
            color: Theme.isDark ? "#FFFFFF" : "#000000"
            Layout.alignment: Qt.AlignHCenter
        }


        Rectangle {
            height: 1
            color: Theme.isDark ? "#444444" : "#CCCCCC"
            Layout.fillWidth: true
        }
        Row{
            Layout.fillWidth: true
            Layout.preferredHeight: 30
            spacing: 10

            ComButton{
                text: "正常背景"
                height: 30
                onClicked: Theme.SpecialEffect=EffectType.Normal
            }
            ComButton{
                text: "云母背景"
                height: 30
                onClicked: Theme.SpecialEffect=EffectType.Mica
            }
            ComButton{
                text: "深云母背景"
                height: 30
                onClicked: Theme.SpecialEffect=EffectType.MicaAlt
            }
            ComButton{
                text: "亚克力背景"
                height: 30
                onClicked: Theme.SpecialEffect=EffectType.Acrylic
            }
            ComButton{
                text: "浅色模式"
                height: 30
                onClicked:Theme.ThemeType=Theme.Light
            }
            ComButton{
                text: "深色模式"
                height: 30
                onClicked:Theme.ThemeType=Theme.Dark
            }
            ComIPAddressInput{
            anchors.verticalCenter: parent.verticalCenter

            }

        }
        Text {
            text: "QuickUI 是一个基于 Qt Quick 的现代化 UI 框架，专为 Windows 平台设计。\n\n" +
                  "主要特性：\n" +
                  "• 无边框窗口支持：提供现代化的窗口外观和原生窗口行为\n" +
                  "• DWM 特效集成：充分利用 Windows 系统的桌面窗口管理器特效\n" +
                  "• 深色/浅色主题：自动适配系统主题或手动切换\n" +
                  "• 跨平台兼容：虽然针对 Windows 优化，但仍保持 Qt 的跨平台特性\n" +
                  "• 组件丰富：包含按钮、输入框、导航视图等多种常用 UI 组件\n" +
                  "• 高性能：基于 Qt Quick 的硬件加速渲染\n\n" +
                  "QuickUI 旨在帮助开发者快速构建美观、现代的桌面应用程序。"
            font.pixelSize: 14
            color: Theme.isDark ? "white" : "black"
            Layout.fillWidth: true
            wrapMode: Text.Wrap
            lineHeight: 1.3
        }

        Rectangle {
            height: 1
            color: Theme.isDark ? "#444444" : "#CCCCCC"
            Layout.fillWidth: true
            Layout.topMargin: 10
        }

        Text {
            text: "ComProgressBar 进度条组件示例"
            font.pixelSize: 18
            font.bold: true
            color: Theme.isDark ? "#FFFFFF" : "#000000"
            Layout.alignment: Qt.AlignHCenter
            Layout.topMargin: 10
        }

        ColumnLayout {
            Layout.fillWidth: true
            spacing: 15

            Text {
                text: "确定进度条 (Deterministic Progress)"
                font.pixelSize: 14
                color: Theme.isDark ? "#FFFFFF" : "#000000"
            }

            ComProgressBar {
                id: determinateProgress
                Layout.fillWidth: true
                value: progressSlider.value / 100
                barHeight: 6
            }

            Row {
                Layout.fillWidth: true
                spacing: 10

                ComButton {
                    text: "开始"
                    width: 80
                    height: 30
                    onClicked: progressAnimation.start()
                }
                ComButton {
                    text: "暂停"
                    width: 80
                    height: 30
                    onClicked: progressAnimation.pause()
                }
                ComButton {
                    text: "重置"
                    width: 80
                    height: 30
                    onClicked: {
                        progressAnimation.stop()
                        progressSlider.value = 0
                    }
                }
                Text {
                    text: "当前值: " + Math.round(determinateProgress.value * 100) + "%"
                    anchors.verticalCenter: parent.verticalCenter
                    color: Theme.isDark ? "#FFFFFF" : "#000000"
                    font.pixelSize: 13
                }
            }

            Slider {
                id: progressSlider
                Layout.fillWidth: true
                from: 0
                to: 100
                value: 0
                stepSize: 1

                NumberAnimation on value {
                    id: progressAnimation
                    from: 0
                    to: 100
                    duration: 5000
                    running: false
                    loops: 1
                }
            }

            Rectangle {
                height: 1
                color: Theme.isDark ? "#333333" : "#EEEEEE"
                Layout.fillWidth: true
            }

            Text {
                text: "不确定进度条 (Indeterminate Progress)"
                font.pixelSize: 14
                color: Theme.isDark ? "#FFFFFF" : "#000000"
            }

            ComProgressBar {
                id: indeterminateProgress
                Layout.fillWidth: true
                indeterminateMode: true
                barHeight: 30
            }

            Row {
                Layout.fillWidth: true
                spacing: 10

                ComButton {
                    text: indeterminateProgress.visible ? "隐藏" : "显示"
                    width: 80
                    height: 30
                    onClicked: indeterminateProgress.visible = !indeterminateProgress.visible
                }
            }

            Rectangle {
                height: 1
                color: Theme.isDark ? "#333333" : "#EEEEEE"
                Layout.fillWidth: true
            }

            Text {
                text: "自定义样式进度条"
                font.pixelSize: 14
                color: Theme.isDark ? "#FFFFFF" : "#000000"
            }

            ColumnLayout {
                Layout.fillWidth: true
                spacing: 10

                Row {
                    Layout.fillWidth: true
                    spacing: 10
                    Text {
                        text: "默认颜色:"
                        anchors.verticalCenter: parent.verticalCenter
                        color: Theme.isDark ? "#FFFFFF" : "#000000"
                        font.pixelSize: 13
                        width: 70
                    }
                    ComProgressBar {
                        Layout.fillWidth: true
                        value: 0.7
                        barHeight: 8
                    }
                }

                Row {
                    Layout.fillWidth: true
                    spacing: 10
                    Text {
                        text: "绿色:"
                        anchors.verticalCenter: parent.verticalCenter
                        color: Theme.isDark ? "#FFFFFF" : "#000000"
                        font.pixelSize: 13
                        width: 70
                    }
                    ComProgressBar {
                        Layout.fillWidth: true
                        value: 0.5
                        barHeight: 8
                        progressColor: "#4CAF50"
                    }
                }

                Row {
                    Layout.fillWidth: true
                    spacing: 10
                    Text {
                        text: "橙色:"
                        anchors.verticalCenter: parent.verticalCenter
                        color: Theme.isDark ? "#FFFFFF" : "#000000"
                        font.pixelSize: 13
                        width: 70
                    }
                    ComProgressBar {
                        Layout.fillWidth: true
                        value: 0.65
                        barHeight: 8
                        progressColor: "#FF9800"
                    }
                }

                Row {
                    Layout.fillWidth: true
                    spacing: 10
                    Text {
                        text: "红色:"
                        anchors.verticalCenter: parent.verticalCenter
                        color: Theme.isDark ? "#FFFFFF" : "#000000"
                        font.pixelSize: 13
                        width: 70
                    }
                    ComProgressBar {
                        Layout.fillWidth: true
                        value: 0.85
                        barHeight: 8
                        progressColor: "#F44336"
                    }
                }

                Row {
                    Layout.fillWidth: true
                    spacing: 10
                    Text {
                        text: "细进度条:"
                        anchors.verticalCenter: parent.verticalCenter
                        color: Theme.isDark ? "#FFFFFF" : "#000000"
                        font.pixelSize: 13
                        width: 70
                    }
                    ComProgressBar {
                        Layout.fillWidth: true
                        value: 0.45
                        barHeight: 2
                    }
                }
            }

            Rectangle {
                height: 1
                color: Theme.isDark ? "#333333" : "#EEEEEE"
                Layout.fillWidth: true
            }

            Text {
                text: "带边框的进度条"
                font.pixelSize: 14
                color: Theme.isDark ? "#FFFFFF" : "#000000"
            }

            ColumnLayout {
                Layout.fillWidth: true
                spacing: 10

                Row {
                    Layout.fillWidth: true
                    spacing: 10
                    Text {
                        text: "默认边框:"
                        anchors.verticalCenter: parent.verticalCenter
                        color: Theme.isDark ? "#FFFFFF" : "#000000"
                        font.pixelSize: 13
                        width: 70
                    }
                    ComProgressBar {

                        Layout.fillWidth: true
                        value: 0.6
                        barHeight: 30
                         borderWidth: 2
                        showBorder: true
                        showProgressText: true
                         progressTextFontSize: 14
                    }
                }

                Row {
                    Layout.fillWidth: true
                    spacing: 10
                    Text {
                        text: "粗边框:"
                        anchors.verticalCenter: parent.verticalCenter
                        color: Theme.isDark ? "#FFFFFF" : "#000000"
                        font.pixelSize: 13
                        width: 70
                    }
                    ComProgressBar {
                        Layout.fillWidth: true
                        value: 0.75
                        barHeight: 8
                        showBorder: true
                        borderWidth: 2
                        borderColor: "#0078D4"
                    }
                }

                Row {
                    Layout.fillWidth: true
                    spacing: 10
                    Text {
                        text: "圆角边框:"
                        anchors.verticalCenter: parent.verticalCenter
                        color: Theme.isDark ? "#FFFFFF" : "#000000"
                        font.pixelSize: 13
                        width: 70
                    }
                    ComProgressBar {
                        Layout.fillWidth: true
                        value: 0.85
                        barHeight: 12
                        showBorder: true
                        borderWidth: 2
                        borderColor: "#4CAF50"
                        progressColor: "#81C784"
                    }
                }
            }

            Rectangle {
                height: 1
                color: Theme.isDark ? "#333333" : "#EEEEEE"
                Layout.fillWidth: true
            }

            Text {
                text: "显示进度文本的进度条"
                font.pixelSize: 14
                color: Theme.isDark ? "#FFFFFF" : "#000000"
            }

            ColumnLayout {
                Layout.fillWidth: true
                spacing: 15

                Row {
                    Layout.fillWidth: true
                    spacing: 10
                    Text {
                        text: "默认文本:"
                        anchors.verticalCenter: parent.verticalCenter
                        color: Theme.isDark ? "#FFFFFF" : "#000000"
                        font.pixelSize: 13
                        width: 70
                    }
                    ComProgressBar {
                        id: progressTextDemo1
                        Layout.fillWidth: true
                        value: progressSlider.value / 100
                        barHeight: 24
                        showProgressText: true
                        progressTextColor: Theme.isDark ? "#FFFFFF" : "#000000"
                    }
                }

                Row {
                    Layout.fillWidth: true
                    spacing: 10
                    Text {
                        text: "大字体:"
                        anchors.verticalCenter: parent.verticalCenter
                        color: Theme.isDark ? "#FFFFFF" : "#000000"
                        font.pixelSize: 13
                        width: 70
                    }
                    ComProgressBar {
                        Layout.fillWidth: true
                        value: 0.65
                        barHeight: 32
                        showProgressText: true
                        progressTextFontSize: 16
                        progressTextColor: "#FFFFFF"
                        progressColor: "#FF9800"
                    }
                }

                Row {
                    Layout.fillWidth: true
                    spacing: 10
                    Text {
                        text: "边框+文本:"
                        anchors.verticalCenter: parent.verticalCenter
                        color: Theme.isDark ? "#FFFFFF" : "#000000"
                        font.pixelSize: 13
                        width: 70
                    }
                    ComProgressBar {
                        Layout.fillWidth: true
                        value: 0.8
                        barHeight: 28
                        showBorder: true
                        borderWidth: 2
                        borderColor: "#0078D4"
                        showProgressText: true
                        progressTextFontSize: 14
                        progressTextColor: "#0078D4"
                        progressColor: "#E3F2FD"
                    }
                }

                Row {
                    Layout.fillWidth: true
                    spacing: 10
                    Text {
                        text: "自定义格式:"
                        anchors.verticalCenter: parent.verticalCenter
                        color: Theme.isDark ? "#FFFFFF" : "#000000"
                        font.pixelSize: 13
                        width: 70
                    }
                    ComProgressBar {
                        Layout.fillWidth: true
                        value: 0.55
                        barHeight: 26
                        showProgressText: true
                        progressTextFormat: "%1 / 100"
                        progressTextFontSize: 12
                        progressTextColor: "#F44336"
                        progressColor: "#FFCDD2"
                    }
                }
            }
        }
    }
}