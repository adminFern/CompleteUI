import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import FlaCoreUI

Window {
    id: win
    width: 1128
    height: 700
    visible: true
    title: qsTr("CompleteUI 示例")
    color: "transparent"

    RowLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 40

        // 垂直滚动条示例
        ColumnLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            spacing: 10

            Text {
                text: "垂直滚动条"
                font.pixelSize: 16
                font.bold: true
                color: Theme.isDark ? "white" : "black"
            }

            Item {
                Layout.fillWidth: true
                Layout.fillHeight: true
                clip: true

                Rectangle {
                    anchors.fill: parent
                    color: Theme.isDark ? "#1E1E1E" : "#FFFFFF"
                    border.color: Theme.isDark ? "#333333" : "#E0E0E0"
                    radius: 4
                }

                Flickable {
                    anchors.fill: parent
                    anchors.margins: 10
                    contentWidth: parent.width
                    contentHeight: contentColumn.implicitHeight

                    Column {
                        id: contentColumn
                        width: parent.width
                        spacing: 10

                        Repeater {
                            model: 30
                            Rectangle {
                                width: parent.width
                                height: 40
                                color: index % 2 === 0 ? (Theme.isDark ? "#2A2A2A" : "#F5F5F5") : (Theme.isDark ? "#252525" : "#FAFAFA")
                                radius: 4

                                Text {
                                    anchors.centerIn: parent
                                    text: "项目 " + (index + 1)
                                    color: Theme.isDark ? "white" : "black"
                                }
                            }
                        }
                    }

                    ScrollBar.vertical: FlaScrollBar {
                        enabled: true
                    }
                }
            }
        }

        // 水平滚动条示例
        ColumnLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            spacing: 10

            Text {
                text: "水平滚动条"
                font.pixelSize: 16
                font.bold: true
                color: Theme.isDark ? "white" : "black"
            }

            Item {
                Layout.fillWidth: true
                Layout.fillHeight: true
                clip: true

                Rectangle {
                    anchors.fill: parent
                    color: Theme.isDark ? "#1E1E1E" : "#FFFFFF"
                    border.color: Theme.isDark ? "#333333" : "#E0E0E0"
                    radius: 4
                }

                Flickable {
                    anchors.fill: parent
                    anchors.margins: 10
                    contentWidth: contentRow.implicitWidth
                    contentHeight: parent.height

                    Row {
                        id: contentRow
                        height: parent.height
                        spacing: 10

                        Repeater {
                            model: 20
                            Rectangle {
                                width: 120
                                height: parent.height
                                color: index % 2 === 0 ? (Theme.isDark ? "#2A2A2A" : "#F5F5F5") : (Theme.isDark ? "#252525" : "#FAFAFA")
                                radius: 4

                                Text {
                                    anchors.centerIn: parent
                                    text: "卡片 " + (index + 1)
                                    color: Theme.isDark ? "white" : "black"
                                }
                            }
                        }
                    }

                    ScrollBar.horizontal: FlaScrollBar {
                        enabled: true
                    }
                }
            }
        }

        // 双向滚动条示例
        ColumnLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            spacing: 10

            Text {
                text: "双向滚动条"
                font.pixelSize: 16
                font.bold: true
                color: Theme.isDark ? "white" : "black"
            }

            Item {
                Layout.fillWidth: true
                Layout.fillHeight: true
                clip: true

                Rectangle {
                    anchors.fill: parent
                    color: Theme.isDark ? "#1E1E1E" : "#FFFFFF"
                    border.color: Theme.isDark ? "#333333" : "#E0E0E0"
                    radius: 4
                }

                Flickable {
                    anchors.fill: parent
                    anchors.margins: 10
                    contentWidth: grid.implicitWidth
                    contentHeight: grid.implicitHeight

                    Grid {
                        id: grid
                        columns: 10
                        spacing: 5

                        Repeater {
                            model: 100
                            Rectangle {
                                width: 80
                                height: 40
                                color: {
                                    if (Theme.isDark) {
                                        return index % 3 === 0 ? "#2A2A2A" : (index % 3 === 1 ? "#252525" : "#303030")
                                    } else {
                                        return index % 3 === 0 ? "#F5F5F5" : (index % 3 === 1 ? "#FAFAFA" : "#EEEEEE")
                                    }
                                }
                                radius: 4

                                Text {
                                    anchors.centerIn: parent
                                    text: (index + 1)
                                    color: Theme.isDark ? "white" : "black"
                                }
                            }
                        }
                    }

                    ScrollBar.vertical: FlaScrollBar {
                        enabled: true
                    }

                    ScrollBar.horizontal: FlaScrollBar {
                        enabled: true
                    }
                }
            }
        }
    }
}
