import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
import CompleteUI

Item {
    id: root

    Flickable {
        anchors.fill: parent
        contentHeight: mainColumn.implicitHeight + 40
        clip: true

        ScrollBar.vertical: ComScrollBar {
            active: true
            policy: ScrollBar.AsNeeded
        }

        Column {
            id: mainColumn
            anchors { left: parent.left; right: parent.right; margins: 40 }
            spacing: 0

            Column {
                width: parent.width
                spacing: 8
                topPadding: 48
                bottomPadding: 48
                leftPadding: 24
                rightPadding: 24

                Text {
                    text: "CompleteUI 组件库"
                    font.pixelSize: 36
                    font.weight: Font.Bold
                    color: Theme.isDark ? "#FFFFFF" : "#1A1A1A"
                  //  letterSpacing: -0.5
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Text {
                    text: "基于 Qt6 / Qt Quick 的 Fluent Design 组件库"
                    font.pixelSize: 15
                    color: Theme.isDark ? "#9CA3AF" : "#6B7280"
                    lineHeight: 1.5
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }

            Column {
                width: parent.width
                spacing: 28
                leftPadding: 24
                rightPadding: 24
                bottomPadding: 48

                Text {
                    text: "组件展示"
                    font.pixelSize: 28
                    font.weight: Font.Bold
                    color: Theme.isDark ? "#FFFFFF" : "#1A1A1A"
                    letterSpacing: -0.5
                }

                // 第一行：按钮 / 导航 / 输入
                Row {
                    width: parent.width
                    spacing: 20

                    ComponentPreview {
                        width: (parent.width - 40) / 3
                        cardTitle: "按钮组件"
                        componentList: "ComButton · ComIconButton\nComFloatButton · ComDelayButton"

                        Column {
                            width: parent.width
                            spacing: 8

                            Row {
                                width: parent.width
                                spacing: 8
                                layoutDirection: Qt.RightToLeft

                                Rectangle {
                                    width: 48
                                    height: 28
                                    color: "#0062FF"
                                    radius: 2

                                    Text {
                                        anchors.centerIn: parent
                                        text: "按钮"
                                        font.pixelSize: 12
                                        font.weight: Font.DemiBold
                                        color: "#FFFFFF"
                                    }
                                }

                                Rectangle {
                                    width: 48
                                    height: 28
                                    color: Theme.isDark ? "#2D2D2D" : "#FFFFFF"
                                    border { width: 1; color: Theme.isDark ? "#4B5563" : "#D1D5DB" }
                                    radius: 2

                                    Text {
                                        anchors.centerIn: parent
                                        text: "图标"
                                        font.pixelSize: 12
                                        font.weight: Font.DemiBold
                                        color: Theme.isDark ? "#E5E7EB" : "#1A1A1A"
                                    }
                                }
                            }

                            Row {
                                width: parent.width
                                spacing: 8
                                layoutDirection: Qt.RightToLeft

                                Rectangle {
                                    width: 40
                                    height: 24
                                    color: "#0062FF"
                                    radius: 4

                                    Text {
                                        anchors.centerIn: parent
                                        text: "悬浮"
                                        font.pixelSize: 11
                                        color: "#FFFFFF"
                                    }
                                }

                                Rectangle {
                                    width: 40
                                    height: 24
                                    color: Theme.isDark ? "#2D2D2D" : "#FFFFFF"
                                    border { width: 1; color: Theme.isDark ? "#4B5563" : "#D1D5DB" }
                                    radius: 4

                                    Text {
                                        anchors.centerIn: parent
                                        text: "延迟"
                                        font.pixelSize: 11
                                        color: Theme.isDark ? "#E5E7EB" : "#1A1A1A"
                                    }
                                }
                            }
                        }
                    }

                    ComponentPreview {
                        width: (parent.width - 40) / 3
                        cardTitle: "导航组件"
                        componentList: "ComNavigationView · ComNavIndicator\nComAppBar · ComWindow"

                        Rectangle {
                            width: parent.width
                            height: 28
                            color: Theme.isDark ? "#2D2D2D" : "#FFFFFF"
                            border { width: 1; color: Theme.isDark ? "#4B5563" : "#E5E7EB" }
                            radius: 2

                            Row {
                                anchors.fill: parent
                                anchors.margins: 2
                                spacing: 2

                                Rectangle {
                                    width: parent.width / 3
                                    height: parent.height
                                    color: "#0062FF"
                                    radius: 2

                                    Text {
                                        anchors.centerIn: parent
                                        text: "首页"
                                        font.pixelSize: 11
                                        font.weight: Font.DemiBold
                                        color: "#FFFFFF"
                                    }
                                }

                                Item {
                                    width: parent.width / 3
                                    height: parent.height

                                    Text {
                                        anchors.centerIn: parent
                                        text: "文件"
                                        font.pixelSize: 11
                                        color: Theme.isDark ? "#9CA3AF" : "#6B7280"
                                    }
                                }

                                Item {
                                    width: parent.width / 3
                                    height: parent.height

                                    Text {
                                        anchors.centerIn: parent
                                        text: "设置"
                                        font.pixelSize: 11
                                        color: Theme.isDark ? "#9CA3AF" : "#6B7280"
                                    }
                                }
                            }
                        }
                    }

                    ComponentPreview {
                        width: (parent.width - 40) / 3
                        cardTitle: "输入组件"
                        componentList: "ComInputNumber · ComScrollBar\nComGroupBox"

                        Column {
                            width: parent.width
                            spacing: 8

                            Row {
                                width: parent.width
                                spacing: 6
                                layoutDirection: Qt.RightToLeft

                                Rectangle {
                                    width: 28
                                    height: 28
                                    color: "#0062FF"
                                    radius: 2

                                    Text {
                                        anchors.centerIn: parent
                                        text: "+"
                                        font.pixelSize: 14
                                        font.weight: Font.DemiBold
                                        color: "#FFFFFF"
                                    }
                                }

                                Rectangle {
                                    width: 28
                                    height: 28
                                    color: Theme.isDark ? "#374151" : "#F3F4F6"
                                    border { width: 1; color: Theme.isDark ? "#4B5563" : "#D1D5DB" }
                                    radius: 2

                                    Text {
                                        anchors.centerIn: parent
                                        text: "-"
                                        font.pixelSize: 14
                                        color: Theme.isDark ? "#E5E7EB" : "#1A1A1A"
                                    }
                                }

                                Rectangle {
                                    width: 48
                                    height: 28
                                    color: Theme.isDark ? "#2D2D2D" : "#FFFFFF"
                                    border { width: 1; color: Theme.isDark ? "#4B5563" : "#D1D5DB" }
                                    radius: 2

                                    Text {
                                        anchors.centerIn: parent
                                        text: "42"
                                        font.pixelSize: 13
                                        color: Theme.isDark ? "#E5E7EB" : "#1A1A1A"
                                    }
                                }
                            }

                            Rectangle {
                                width: parent.width
                                height: 8
                                color: Theme.isDark ? "#4B5563" : "#E5E7EB"
                                radius: 4

                                Rectangle {
                                    width: 40
                                    height: parent.height
                                    color: Theme.isDark ? "#9CA3AF" : "#9CA3AF"
                                    radius: 4
                                }
                            }
                        }
                    }
                }

                // 间隔
                Item { width: 1; height: 4 }

                // 第二行：进度 / 图标 / 窗口
                Row {
                    width: parent.width
                    spacing: 20

                    ComponentPreview {
                        width: (parent.width - 40) / 3
                        cardTitle: "进度与显示"
                        componentList: "ComProgressBar · ComCircularProgressBar\nComTimeline"

                        Column {
                            width: parent.width
                            spacing: 8

                            Rectangle {
                                width: parent.width
                                height: 12
                                color: Theme.isDark ? "#4B5563" : "#E5E7EB"
                                radius: 6

                                Rectangle {
                                    width: parent.width * 0.65
                                    height: parent.height
                                    color: "#0062FF"
                                    radius: 6
                                }
                            }

                            Row {
                                width: parent.width
                                spacing: 8
                                anchors.horizontalCenter: parent.horizontalCenter

                                Rectangle {
                                    width: 24
                                    height: 24
                                    radius: 12
                                    color: "transparent"
                                    border { width: 3; color: Theme.isDark ? "#4B5563" : "#E5E7EB" }
                                }

                                Rectangle {
                                    width: 24
                                    height: 24
                                    radius: 12
                                    color: "transparent"
                                    border { width: 3; color: "#0062FF" }
                                }

                                Rectangle {
                                    width: 8
                                    height: 8
                                    radius: 4
                                    color: "#0062FF"
                                    anchors.verticalCenter: parent.verticalCenter
                                }
                            }
                        }
                    }

                    ComponentPreview {
                        width: (parent.width - 40) / 3
                        cardTitle: "图标与标签"
                        componentList: "FluentIcon · ComImage\nComIconLabel"

                        Row {
                            width: parent.width
                            spacing: 10
                            anchors.horizontalCenter: parent.horizontalCenter

                            Repeater {
                                model: ["🏠", "⚙", "📧", "🔍"]

                                Rectangle {
                                    width: 32
                                    height: 32
                                    color: Theme.isDark ? "#374151" : "#E5E7EB"
                                    radius: 6

                                    Text {
                                        anchors.centerIn: parent
                                        text: modelData
                                        font.pixelSize: 16
                                    }
                                }
                            }
                        }
                    }

                    ComponentPreview {
                        width: (parent.width - 40) / 3
                        cardTitle: "窗口与容器"
                        componentList: "ComWindow · ComGroupBox\nComAppBar"

                        Column {
                            width: parent.width
                            spacing: 8

                            Rectangle {
                                width: parent.width
                                height: 48
                                color: Theme.isDark ? "#2D2D2D" : "#FFFFFF"
                                border { width: 1; color: Theme.isDark ? "#4B5563" : "#D1D5DB" }
                                radius: 2

                                Column {
                                    anchors.fill: parent

                                    Rectangle {
                                        width: parent.width
                                        height: 20
                                        color: Theme.isDark ? "#374151" : "#F3F4F6"

                                        Row {
                                            anchors { left: parent.left; verticalCenter: parent.verticalCenter; margins: 6 }
                                            spacing: 4

                                            Rectangle { width: 6; height: 6; radius: 3; color: "#EF4444"; anchors.verticalCenter: parent.verticalCenter }
                                            Rectangle { width: 6; height: 6; radius: 3; color: "#F59E0B"; anchors.verticalCenter: parent.verticalCenter }
                                            Rectangle { width: 6; height: 6; radius: 3; color: "#10B981"; anchors.verticalCenter: parent.verticalCenter }

                                            Text {
                                                text: "CompleteUI 窗口"
                                                font.pixelSize: 10
                                                color: Theme.isDark ? "#9CA3AF" : "#6B7280"
                                                anchors.verticalCenter: parent.verticalCenter
                                                leftPadding: 8
                                            }
                                        }
                                    }

                                    Text {
                                        anchors.centerIn: parent
                                        text: "无边框 · Mica · 亚克力"
                                        font.pixelSize: 10
                                        color: Theme.isDark ? "#6B7280" : "#9CA3AF"
                                    }
                                }
                            }

                            Rectangle {
                                width: parent.width
                                height: 24
                                color: Theme.isDark ? "#2D2D2D" : "#FFFFFF"
                                border { width: 1; color: Theme.isDark ? "#4B5563" : "#D1D5DB" }
                                radius: 2

                                Text {
                                    anchors.centerIn: parent
                                    text: "分组容器"
                                    font.pixelSize: 11
                                    color: Theme.isDark ? "#9CA3AF" : "#6B7280"
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    // 组件卡片：带阴影的容器
    component ComponentPreview: Rectangle {
        id: card
        property string cardTitle
        property string componentList

        height: cardColumn.implicitHeight + 40
        color: Theme.isDark ? "#2D2D2D" : "#FFFFFF"
        border { width: 1; color: Theme.isDark ? "#4B5563" : "#E5E7EB" }
        radius: 4

        layer.enabled: true
        layer.effect: RectangularGlow {
            anchors.fill: card
            glowRadius: 8
            spread: 0.1
            color: Theme.isDark ? "#00000040" : "#0000000D"
            cornerRadius: card.radius + glowRadius
        }

        Column {
            id: cardColumn
            anchors { left: parent.left; right: parent.right; margins: 16 }
            y: 16
            spacing: 10

            Rectangle {
                width: parent.width
                height: previewArea.implicitHeight + 24
                color: Theme.isDark ? "#1F2937" : "#F9FAFB"
                border { width: 1; color: Theme.isDark ? "#4B5563" : "#D1D5DB"; style: Qt.DashLine }
                radius: 2

                Item {
                    id: previewArea
                    anchors { left: parent.left; right: parent.right; margins: 12 }
                    y: 12
                    implicitHeight: childrenRect.height
                    implicitWidth: childrenRect.width
                    clip: false

                    default property alias content: previewArea.data
                }
            }

            Text {
                text: cardTitle
                font.pixelSize: 18
                font.weight: Font.DemiBold
                color: Theme.isDark ? "#FFFFFF" : "#1A1A1A"
            }

            Text {
                text: componentList
                font.pixelSize: 13
                color: Theme.isDark ? "#9CA3AF" : "#4B5563"
                lineHeight: 1.6
            }
        }
    }
}
