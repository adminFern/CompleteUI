import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import CompleteUI

Item {
    id: root

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 20

        Text {
            text: "TabBar 组件示例"
            font.pixelSize: 20
            font.bold: true
            color: Theme.TextColor
            Layout.fillWidth: true
        }

        ComGroupBox {
            title: "基础用法"
            Layout.fillWidth: true
            Layout.preferredHeight: 180

            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 10
                spacing: 10

                ComTabBar {
                    id: tabBar1
                    Layout.fillWidth: true

                    Component.onCompleted: {
                        addItem("首页", FluentIcon.ico_Home)
                        addItem("消息", FluentIcon.ico_Mail)
                        addItem("设置", FluentIcon.ico_Setting)
                    }
                }

                StackLayout {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    currentIndex: tabBar1.currentIndex

                    Rectangle {
                        color: Theme.isDark ? "#3d3d3d" : "#f5f5f5"
                        Text {
                            anchors.centerIn: parent
                            text: "首页内容"
                            color: Theme.TextColor
                        }
                    }
                    Rectangle {
                        color: Theme.isDark ? "#3d3d3d" : "#f5f5f5"
                        Text {
                            anchors.centerIn: parent
                            text: "消息内容"
                            color: Theme.TextColor
                        }
                    }
                    Rectangle {
                        color: Theme.isDark ? "#3d3d3d" : "#f5f5f5"
                        Text {
                            anchors.centerIn: parent
                            text: "设置内容"
                            color: Theme.TextColor
                        }
                    }
                }
            }
        }

        ComGroupBox {
            title: "动态管理"
            Layout.fillWidth: true
            Layout.preferredHeight: 180

            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 10
                spacing: 10

                RowLayout {
                    Layout.fillWidth: true
                    spacing: 10

                    ComButton {
                        text: "添加选项卡"
                        onClicked: {
                            var count = tabBar2.getCount()
                            tabBar2.addItem("选项卡 " + (count + 1))
                        }
                    }

                    ComButton {
                        text: "删除当前项"
                        onClicked: {
                            if (tabBar2.currentIndex >= 0) {
                                tabBar2.removeItem(tabBar2.currentIndex)
                            }
                        }
                    }

                    Text {
                        text: "当前索引: " + tabBar2.currentIndex + " | 总数: " + tabBar2.getCount()
                        color: Theme.TextColor
                    }
                }

                ComTabBar {
                    id: tabBar2
                    Layout.fillWidth: true

                    Component.onCompleted: {
                        addItem("选项卡 1")
                        addItem("选项卡 2")
                    }

                    onItemAdded: function(index, item) {
                        console.log("添加选项卡:", index, item.text)
                    }

                    onItemRemoved: function(index, item) {
                        console.log("删除选项卡:", index, item.text)
                    }
                }
            }
        }

        ComGroupBox {
            title: "样式自定义"
            Layout.fillWidth: true
            Layout.preferredHeight: 120

            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 10
                spacing: 10

                ComTabBar {
                    id: tabBar3
                    Layout.fillWidth: true

                    selectedColor: "#FF6B6B"
                    hoverColor: Theme.isDark ? "#4a4a4a" : "#ffe0e0"
                    pressedColor: Theme.isDark ? "#3a3a3a" : "#ffc0c0"
                    textColor: Theme.TextColor
                    radius: 8
                    itemSpacing: 4

                    Component.onCompleted: {
                        addItem("红色", FluentIcon.ico_Favorite)
                        addItem("绿色", FluentIcon.ico_Accept)
                        addItem("蓝色", FluentIcon.ico_Color)
                    }
                }
            }
        }

        ComGroupBox {
            title: "不同显示模式"
            Layout.fillWidth: true
            Layout.preferredHeight: 120

            RowLayout {
                anchors.fill: parent
                anchors.margins: 10
                spacing: 20

                ColumnLayout {
                    spacing: 5
                    Text {
                        text: "仅文本"
                        color: Theme.TextColor
                        font.pixelSize: 12
                    }
                    ComTabBar {
                        Layout.preferredWidth: 200

                        Component.onCompleted: {
                            addItem("选项1")
                            addItem("选项2")
                            addItem("选项3")
                        }
                    }
                }

                ColumnLayout {
                    spacing: 5
                    Text {
                        text: "仅图标"
                        color: Theme.TextColor
                        font.pixelSize: 12
                    }
                    ComTabBar {
                        Layout.preferredWidth: 150

                        Component.onCompleted: {
                            addItem("", FluentIcon.ico_Home)
                            addItem("", FluentIcon.ico_Mail)
                            addItem("", FluentIcon.ico_Setting)
                        }
                    }
                }
            }
        }

        Item {
            Layout.fillHeight: true
        }
    }
}