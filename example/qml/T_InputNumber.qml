import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import CompleteUI

Item {
    id: root

    Column {
        anchors.fill: parent
        spacing: 15

        ComGroupBox {
            width: parent.width - 4
            height: 120
            anchors.margins: 4
            title: "基础用法"
            font: Qt.font({family: Theme.defaultFontFamily, pixelSize: 16, weight: Font.Bold})

            Row {
                anchors.fill: parent
                anchors.margins: 10
                spacing: 30

                ColumnLayout {
                    spacing: 5
                    Text { text: "默认"; color: Theme.TextColor; font.pixelSize: 12 }
                    ComInputNumber {
                        value: 0
                        onValueModified: function(v) { console.log("value:", v) }
                    }
                }

                ColumnLayout {
                    spacing: 5
                    Text { text: "步长 5"; color: Theme.TextColor; font.pixelSize: 12 }
                    ComInputNumber {
                        value: 10
                        step: 5
                    }
                }

                ColumnLayout {
                    spacing: 5
                    Text { text: "精度 2"; color: Theme.TextColor; font.pixelSize: 12 }
                    ComInputNumber {
                        value: 1.23
                        precision: 2
                        step: 0.1
                    }
                }
            }
        }

        ComGroupBox {
            width: parent.width - 4
            height: 120
            anchors.margins: 4
            title: "范围与禁用"
            font: Qt.font({family: Theme.defaultFontFamily, pixelSize: 16, weight: Font.Bold})

            Row {
                anchors.fill: parent
                anchors.margins: 10
                spacing: 30

                ColumnLayout {
                    spacing: 5
                    Text { text: "1~100"; color: Theme.TextColor; font.pixelSize: 12 }
                    ComInputNumber {
                        value: 50
                        min: 1
                        max: 100
                    }
                }

                ColumnLayout {
                    spacing: 5
                    Text { text: "禁用"; color: Theme.TextColor; font.pixelSize: 12 }
                    ComInputNumber {
                        value: 42
                        disabled: true
                    }
                }

                ColumnLayout {
                    spacing: 5
                    Text { text: "只读"; color: Theme.TextColor; font.pixelSize: 12 }
                    ComInputNumber {
                        value: 99
                        readOnly: true
                    }
                }
            }
        }

        ComGroupBox {
            width: parent.width - 4
            height: 120
            anchors.margins: 4
            title: "前后缀"
            font: Qt.font({family: Theme.defaultFontFamily, pixelSize: 16, weight: Font.Bold})

            Row {
                anchors.fill: parent
                anchors.margins: 10
                spacing: 30

                ColumnLayout {
                    spacing: 5
                    Text { text: "前缀"; color: Theme.TextColor; font.pixelSize: 12 }
                    ComInputNumber {
                        value: 100
                        prefix: "$"
                    }
                }

                ColumnLayout {
                    spacing: 5
                    Text { text: "后缀"; color: Theme.TextColor; font.pixelSize: 12 }
                    ComInputNumber {
                        value: 30
                        suffix: "%"
                    }
                }

                ColumnLayout {
                    spacing: 5
                    Text { text: "前后缀"; color: Theme.TextColor; font.pixelSize: 12 }
                    ComInputNumber {
                        value: 1024
                        prefix: "$"
                        suffix: "KB"
                    }
                }
            }
        }

        ComGroupBox {
            width: parent.width - 4
            height: 100
            anchors.margins: 4
            title: "状态"
            font: Qt.font({family: Theme.defaultFontFamily, pixelSize: 16, weight: Font.Bold})

            Row {
                anchors.fill: parent
                anchors.margins: 10
                spacing: 30

                ColumnLayout {
                    spacing: 5
                    Text { text: "错误"; color: Theme.TextColor; font.pixelSize: 12 }
                    ComInputNumber {
                        value: 200
                        min: 0
                        max: 100
                    }
                }

                ColumnLayout {
                    spacing: 5
                    Text { text: "警告"; color: Theme.TextColor; font.pixelSize: 12 }
                    ComInputNumber {
                        value: 50
                        status: "warning"
                    }
                }

                ColumnLayout {
                    spacing: 5
                    Text { text: "无控制器"; color: Theme.TextColor; font.pixelSize: 12 }
                    ComInputNumber {
                        value: 88
                        controls: false
                        placeholder: "请输入"
                    }
                }
            }
        }

        Item { height: 10 }
    }
}