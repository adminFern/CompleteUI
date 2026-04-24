import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import CompleteUI

Item {
    id: root

    ComFloatButton{
        x:50
        y:60
        actions: [
            { icon: FluentIcon.ico_Mail, enabled: true },
            { icon: FluentIcon.ico_FavoriteStarFill, enabled: false },
            { icon: FluentIcon.ico_Send, enabled: true },
            { icon: FluentIcon.ico_Delete, enabled: true },
            { icon: FluentIcon.ico_Save, enabled: true }
        ]
    }

    ColumnLayout {
        x: 50
        y: 120
        spacing: 16

        Text {
            text: "ComInputNumber 组件示例"
            font.pixelSize: 18
            font.bold: true
            color: Theme.isDark ? "white" : "black"
        }

        // 基础用法
        RowLayout {
            spacing: 8
            Text {
                text: "基础用法:"
                font.pixelSize: 14
                color: Theme.isDark ? "white" : "black"
                Layout.preferredWidth: 80
            }
            ComInputNumber {
                value: 0
                min: -10
                max: 100
                step: 1
                onValueModified: console.log("基础值:", value)
            }
        }

        // 带前缀后缀
        RowLayout {
            spacing: 8
            Text {
                text: "前缀后缀:"
                font.pixelSize: 14
                color: Theme.isDark ? "white" : "black"
                Layout.preferredWidth: 80
            }
            ComInputNumber {
                value: 100
                prefix: '¥'
                suffix: '元'
                step: 10
                min: 0
                max: 9999
                onValueModified: console.log("金额:", value)
            }
        }

        // 小数精度
        RowLayout {
            spacing: 8
            Text {
                text: "小数精度:"
                font.pixelSize: 14
                color: Theme.isDark ? "white" : "black"
                Layout.preferredWidth: 80
            }
            ComInputNumber {
                value: 1.5
                precision: 2
                step: 0.1
                min: 0
                max: 10
                onValueModified: console.log("精度值:", value)
            }
        }

        // 只读模式
        RowLayout {
            spacing: 8
            Text {
                text: "只读模式:"
                font.pixelSize: 14
                color: Theme.isDark ? "white" : "black"
                Layout.preferredWidth: 80
            }
            ComInputNumber {
                value: 42
                readOnly: true
            }
        }

        // 禁用状态
        RowLayout {
            spacing: 8
            Text {
                text: "禁用状态:"
                font.pixelSize: 14
                color: Theme.isDark ? "white" : "black"
                Layout.preferredWidth: 80
            }
            ComInputNumber {
                value: 0
                enabled: false
            }
        }

        // 滚轮调节
        RowLayout {
            spacing: 8
            Text {
                text: "滚轮调节:"
                font.pixelSize: 14
                color: Theme.isDark ? "white" : "black"
                Layout.preferredWidth: 80
            }
            ComInputNumber {
                value: 50
                useWheel: true
                step: 5
                min: 0
                max: 100
            }
        }
    }
}
