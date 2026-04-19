import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import CompleteUI

Item {
    id: root

    Column {
        anchors.centerIn: parent
        spacing: 40

        // ComProgressBar 示例
        Column {
            spacing: 20

            Label {
                text: "ComProgressBar - 线性进度条"
                font.pixelSize: 16
                font.bold: true
            }

            // 基本用法
            ComProgressBar {
                width: 300
                value: 0.6
            }

            // 自定义颜色和高度
            ComProgressBar {
                width: 300
                value: 0.75
                progressColor: "#FF6B6B"
                barHeight: 30
            }

            // 不显示进度文字
            ComProgressBar {
                width: 300
                value: 0.45
                showProgressText: false
                progressColor: "#4ECDC4"
                barHeight: 12
            }

            // 按钮控制进度
            Row {
                spacing: 20

                ComProgressBar {
                    id: controlledProgressBar
                    width: 200
                    value: 0.5
                    progressColor: "#3498DB"
                }

                Column {
                    spacing: 8

                    ComButton {
                        text: "+"
                        width: 40
                        height: 30
                        onClicked: {
                            if (controlledProgressBar.value < 1.0)
                                controlledProgressBar.value += 0.1
                        }
                    }

                    ComButton {
                        text: "-"
                        width: 40
                        height: 30
                        onClicked: {
                            if (controlledProgressBar.value > 0)
                                controlledProgressBar.value -= 0.1
                        }
                    }
                }
            }

            // 循环进度
            Column {
                id: linearLoopContainer
                spacing: 10

                property bool running: false

                Label {
                    text: "循环进度"
                    font.pixelSize: 14
                }

                ComProgressBar {
                    id: loopProgressBar
                    width: 300
                    progressColor: "#E67E22"
                    barHeight: 25
                }

                Row {
                    spacing: 10

                    ComButton {
                        text: linearLoopContainer.running ? "暂停" : "开始"
                        onClicked: linearLoopContainer.running = !linearLoopContainer.running
                    }

                    ComButton {
                        text: "重置"
                        onClicked: {
                            loopProgressBar.value = 0
                            linearLoopContainer.running = true
                        }
                    }
                }

                SequentialAnimation on running {
                    id: loopAnim
                    running: linearLoopContainer.running
                    loops: Animation.Infinite
                    PropertyAction { value: true }
                    NumberAnimation {
                        target: loopProgressBar
                        property: "value"
                        from: 0
                        to: 1
                        duration: 2000
                        easing.type: Easing.Linear
                    }
                    PropertyAction { value: false }
                    PauseAnimation { duration: 500 }
                    NumberAnimation {
                        target: loopProgressBar
                        property: "value"
                        from: 1
                        to: 0
                        duration: 2000
                        easing.type: Easing.Linear
                    }
                    PauseAnimation { duration: 500 }
                }
            }
        }

        // ComCircularProgressBar 示例
        Column {
            spacing: 20

            Label {
                text: "ComCircularProgressBar - 圆形进度条"
                font.pixelSize: 16
                font.bold: true
            }

            Row {
                spacing: 40

                // 基本用法
                ComCircularProgressBar {
                    value: 0.65
                }

                // 自定义颜色和大小
                ComCircularProgressBar {
                    value: 0.8
                    diameter: 120
                    strokeWidth: 10
                    progressColor: "#9B59B6"
                }

                // 自定义起始角度
                ComCircularProgressBar {
                    value: 0.5
                    diameter: 80
                    strokeWidth: 6
                    progressColor: "#2ECC71"
                    startAngle: 0
                }
            }

            // 不显示进度文字
            ComCircularProgressBar {
                value: 0.9
                diameter: 60
                strokeWidth: 5
                progressColor: "#E74C3C"
                showProgressText: false
            }

            // 按钮控制圆形进度
            Row {
                spacing: 20

                ComCircularProgressBar {
                    id: controlledCircularBar
                    diameter: 100
                    strokeWidth: 8
                    progressColor: "#1ABC9C"
                }

                Column {
                    spacing: 8

                    ComButton {
                        text: "+"
                        width: 40
                        height: 30
                        onClicked: {
                            if (controlledCircularBar.value < 1.0)
                                controlledCircularBar.value += 0.1
                        }
                    }

                    ComButton {
                        text: "-"
                        width: 40
                        height: 30
                        onClicked: {
                            if (controlledCircularBar.value > 0)
                                controlledCircularBar.value -= 0.1
                        }
                    }
                }
            }

            // 圆形循环进度
            Column {
                id: circularLoopContainer
                spacing: 10

                property bool running: false

                Label {
                    text: "循环进度"
                    font.pixelSize: 14
                }

                ComCircularProgressBar {
                    id: loopCircularBar
                    diameter: 100
                    strokeWidth: 8
                    progressColor: "#8E44AD"
                }

                Row {
                    spacing: 10

                    ComButton {
                        text: circularLoopContainer.running ? "暂停" : "开始"
                        onClicked: circularLoopContainer.running = !circularLoopContainer.running
                    }

                    ComButton {
                        text: "重置"
                        onClicked: {
                            loopCircularBar.value = 0
                            circularLoopContainer.running = true
                        }
                    }
                }

                SequentialAnimation on running {
                    id: loopCircularAnim
                    running: circularLoopContainer.running
                    loops: Animation.Infinite
                    PropertyAction { value: true }
                    NumberAnimation {
                        target: loopCircularBar
                        property: "value"
                        from: 0
                        to: 1
                        duration: 2000
                        easing.type: Easing.Linear
                    }
                    PropertyAction { value: false }
                    PauseAnimation { duration: 500 }
                    NumberAnimation {
                        target: loopCircularBar
                        property: "value"
                        from: 1
                        to: 0
                        duration: 2000
                        easing.type: Easing.Linear
                    }
                    PauseAnimation { duration: 500 }
                }
            }
        }
    }
}