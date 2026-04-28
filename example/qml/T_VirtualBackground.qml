import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import CompleteUI

Item {
    id: root

    property string currentEffectName: {
        switch (Theme.SpecialEffect) {
        case EffectType.Mica: return "Mica"
        case EffectType.MicaAlt: return "MicaAlt"
        case EffectType.Acrylic: return "Acrylic"
        default: return "Normal"
        }
    }

    Flickable {
        anchors.fill: parent
        contentHeight: mainColumn.implicitHeight + 64
        clip: true

        ScrollBar.vertical: ComScrollBar {
            active: true
            policy: ScrollBar.AlwaysOn
        }

        ColumnLayout {
            id: mainColumn
            x: 40
            width: parent.width - 80
            spacing: 32

            ColumnLayout {
                spacing: 12
                Layout.fillWidth: true
                Layout.topMargin: 40

                Text {
                    text: "欢迎使用 CompleteUI"
                    font.pixelSize: 40
                    font.bold: true
                    color: Theme.isDark ? "white" : "black"
                    Layout.fillWidth: true
                }

                Text {
                    text: "基于 Qt6 的 Fluent Design 组件库，为您提供现代化的桌面应用 UI 组件"
                    font.pixelSize: 16
                    color: Theme.isDark ? "#8E8E93" : "#6B7280"
                    Layout.fillWidth: true
                }

                RowLayout {
                    spacing: 12
                    Layout.topMargin: 16

                    ComButton {
                        text: "开始使用"
                        highlighted: true
                        highlightedcolor: Theme.PrimaryColor
                        iconsource: FluentIcon.ico_Play
                        iconsize: 16
                        display: DisplayType.IconBesideText
                    }

                    ComButton {
                        text: "查看组件"
                        flat: true
                        iconsource: FluentIcon.ico_Grid
                        iconsize: 16
                        display: DisplayType.IconBesideText
                    }
                }
            }

            Rectangle {
                Layout.fillWidth: true
                height: 1
                color: Theme.isDark ? "#2C2C2E" : "#E5E5EA"
            }

            ColumnLayout {
                spacing: 16
                Layout.fillWidth: true

                Text {
                    text: "主题模式"
                    font.pixelSize: 20
                    font.bold: true
                    color: Theme.isDark ? "white" : "black"
                }

                Text {
                    text: "切换浅色/深色主题，应用将自动更新所有组件颜色"
                    font.pixelSize: 14
                    color: Theme.isDark ? "#8E8E93" : "#6B7280"
                }

                RowLayout {
                    spacing: 12
                    Layout.topMargin: 8

                    ComButton {
                        text: "浅色"
                        highlighted: Theme.ThemeType === Theme.Light
                        highlightedcolor: Theme.PrimaryColor
                        onClicked: Theme.ThemeType = Theme.Light
                    }

                    ComButton {
                        text: "深色"
                        highlighted: Theme.ThemeType === Theme.Dark
                        highlightedcolor: Theme.PrimaryColor
                        onClicked: Theme.ThemeType = Theme.Dark
                    }

                    ComButton {
                        text: "跟随系统"
                        highlighted: Theme.ThemeType === Theme.System
                        highlightedcolor: Theme.PrimaryColor
                        onClicked: Theme.ThemeType = Theme.System
                    }
                }
            }

            Rectangle {
                Layout.fillWidth: true
                height: 1
                color: Theme.isDark ? "#2C2C2E" : "#E5E5EA"
            }

            ColumnLayout {
                spacing: 16
                Layout.fillWidth: true

                Text {
                    text: "特效模式"
                    font.pixelSize: 20
                    font.bold: true
                    color: Theme.isDark ? "white" : "black"
                }

                Text {
                    text: "Windows 11 虚拟背景特效，Mica/Acrylic 仅在 Win11 下生效"
                    font.pixelSize: 14
                    color: Theme.isDark ? "#8E8E93" : "#6B7280"
                }

                RowLayout {
                    spacing: 12
                    Layout.topMargin: 8

                    ComButton {
                        text: "Normal"
                        highlighted: Theme.SpecialEffect === EffectType.Normal
                        highlightedcolor: Theme.PrimaryColor
                        onClicked: Theme.SpecialEffect = EffectType.Normal
                    }

                    ComButton {
                        text: "Mica"
                        highlighted: Theme.SpecialEffect === EffectType.Mica
                        highlightedcolor: Theme.PrimaryColor
                        onClicked: Theme.SpecialEffect = EffectType.Mica
                    }

                    ComButton {
                        text: "MicaAlt"
                        highlighted: Theme.SpecialEffect === EffectType.MicaAlt
                        highlightedcolor: Theme.PrimaryColor
                        onClicked: Theme.SpecialEffect = EffectType.MicaAlt
                    }

                    ComButton {
                        text: "Acrylic"
                        highlighted: Theme.SpecialEffect === EffectType.Acrylic
                        highlightedcolor: Theme.PrimaryColor
                        onClicked: Theme.SpecialEffect = EffectType.Acrylic
                    }
                }
            }

            Rectangle {
                Layout.fillWidth: true
                height: 1
                color: Theme.isDark ? "#2C2C2E" : "#E5E5EA"
            }

            ColumnLayout {
                spacing: 16
                Layout.fillWidth: true

                Text {
                    text: "实时预览"
                    font.pixelSize: 20
                    font.bold: true
                    color: Theme.isDark ? "white" : "black"
                }

                Text {
                    text: "当前窗口应用的背景效果展示"
                    font.pixelSize: 14
                    color: Theme.isDark ? "#8E8E93" : "#6B7280"
                }

                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 280
                    Layout.topMargin: 8
                    color: Theme.backgroundColor
                    border.width: 1
                    border.color: Theme.DividerColor
                    radius: 8

                    ColumnLayout {
                        anchors.fill: parent
                        anchors.margins: 24
                        spacing: 16

                        RowLayout {
                            Layout.fillWidth: true
                            spacing: 24

                            ColumnLayout {
                                spacing: 8
                                Layout.fillWidth: true

                                Text {
                                    text: "当前状态"
                                    font.pixelSize: 16
                                    font.bold: true
                                    color: Theme.Textcolor
                                }

                                Rectangle {
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 80
                                    color: Theme.ButtonNormalColor
                                    radius: 6
                                    border.width: 1
                                    border.color: Theme.DividerColor

                                    ColumnLayout {
                                        anchors.centerIn: parent
                                        spacing: 4

                                        Text {
                                            text: "主题: " + (Theme.ThemeType === Theme.Light ? "浅色" : Theme.ThemeType === Theme.Dark ? "深色" : "跟随系统")
                                            font.pixelSize: 13
                                            color: Theme.Textcolor
                                        }

                                        Text {
                                            text: "特效: " + currentEffectName
                                            font.pixelSize: 13
                                            color: Theme.Textcolor
                                        }
                                    }
                                }
                            }

                            ColumnLayout {
                                spacing: 8
                                Layout.fillWidth: true

                                Text {
                                    text: "按钮示例"
                                    font.pixelSize: 16
                                    font.bold: true
                                    color: Theme.Textcolor
                                }

                                Rectangle {
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 80
                                    color: Theme.ButtonNormalColor
                                    radius: 6
                                    border.width: 1
                                    border.color: Theme.DividerColor

                                    RowLayout {
                                        anchors.centerIn: parent
                                        spacing: 8

                                        ComButton {
                                            text: "默认"
                                        }

                                        ComButton {
                                            text: "主要"
                                            highlighted: true
                                            highlightedcolor: Theme.PrimaryColor
                                        }

                                        ComButton {
                                            text: "危险"
                                            highlighted: true
                                            highlightedcolor: "#FF4444"
                                        }
                                    }
                                }
                            }
                        }

                        RowLayout {
                            Layout.fillWidth: true
                            spacing: 16

                            ColumnLayout {
                                spacing: 8
                                Layout.fillWidth: true

                                Text {
                                    text: "进度条"
                                    font.pixelSize: 16
                                    font.bold: true
                                    color: Theme.Textcolor
                                }

                                Rectangle {
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 60
                                    color: Theme.ButtonNormalColor
                                    radius: 6
                                    border.width: 1
                                    border.color: Theme.DividerColor

                                    ColumnLayout {
                                        anchors.centerIn: parent
                                        spacing: 8
                                        width: parent.width - 32

                                        ComProgressBar {
                                            Layout.fillWidth: true
                                            value: 0.3
                                        }

                                        ComProgressBar {
                                            Layout.fillWidth: true
                                            value: 0.7
                                            progressColor: Theme.PrimaryColor
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }

            Rectangle {
                Layout.fillWidth: true
                height: 1
                color: Theme.isDark ? "#2C2C2E" : "#E5E5EA"
            }

            ColumnLayout {
                spacing: 16
                Layout.fillWidth: true
                Layout.bottomMargin: 40

                Text {
                    text: "精选组件"
                    font.pixelSize: 20
                    font.bold: true
                    color: Theme.isDark ? "white" : "black"
                }

                GridLayout {
                    columns: 3
                    rowSpacing: 16
                    columnSpacing: 16
                    Layout.fillWidth: true

                    component CardItem: Rectangle {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 100
                        color: Theme.ButtonNormalColor
                        radius: 8
                        border.width: 1
                        border.color: Theme.DividerColor

                        ColumnLayout {
                            anchors.fill: parent
                            anchors.margins: 16
                            spacing: 8

                            Text {
                                text: cardTitle
                                font.pixelSize: 14
                                font.bold: true
                                color: Theme.Textcolor
                            }

                            Text {
                                text: cardDesc
                                font.pixelSize: 12
                                color: Theme.isDark ? "#8E8E93" : "#6B7280"
                                wrapMode: Text.Wrap
                                Layout.fillWidth: true
                            }
                        }
                    }

                    CardItem {
                        property string cardTitle: "ComButton"
                        property string cardDesc: "支持图标、动画和悬停效果的按钮组件"
                    }

                    CardItem {
                        property string cardTitle: "ComProgressBar"
                        property string cardDesc: "线性/圆形进度条，支持自定义颜色"
                    }

                    CardItem {
                        property string cardTitle: "ComInputNumber"
                        property string cardDesc: "数字输入框，支持步进和范围限制"
                    }

                    CardItem {
                        property string cardTitle: "ComNavigationView"
                        property string cardDesc: "可折叠的侧边导航视图"
                    }

                    CardItem {
                        property string cardTitle: "ComTimeline"
                        property string cardDesc: "时间轴组件，展示事件序列"
                    }
                }
            }
        }
    }
}
