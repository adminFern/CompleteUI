import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import CompleteUI

Item {
    id: root

    // 自定义组件：状态标签
    Component {
        id: comp_status_badge
        Rectangle {
            property alias text: badge_text.text
            color: Theme.setColorAlpha(options.badgeColor || Theme.PrimaryColor, 30)
            radius: 4
            implicitWidth: badge_row.implicitWidth + 12
            implicitHeight: 22
            Row {
                id: badge_row
                anchors.centerIn: parent
                spacing: 4
                Rectangle {
                    anchors.verticalCenter: parent.verticalCenter
                    width: 6; height: 6; radius: 3
                    color: options.badgeColor || Theme.PrimaryColor
                }
                Text {
                    id: badge_text
                    text: options.text || ""
                    color: Theme.Textcolor
                    font.pixelSize: 12
                    anchors.verticalCenter: parent.verticalCenter
                }
            }
        }
    }

    // 自定义组件：行内操作按钮
    Component {
        id: comp_action_button
        Row {
            spacing: 4
            ComButton {
                text: "编辑"
                font.pixelSize: 11
                implicitHeight: 26
                onClicked: {
                    var rowData = control.getRow(options._row)
                    infoText.text = "编辑: " + (rowData ? rowData.name : "未知")
                }
            }
            ComButton {
                text: "删除"
                font.pixelSize: 11
                implicitHeight: 26
                highlighted: true
                onClicked: {
                    var rowData = control.getRow(options._row)
                    control.removeRow(options._row)
                    infoText.text = "已删除: " + (rowData ? rowData.name : "行 #" + (options._row + 1))
                }
            }
        }
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 12
        spacing: 8

        // 工具栏区域
        RowLayout {
            Layout.fillWidth: true
            spacing: 8

            ComButton {
                text: "新增行"
                onClicked: {
                    var names = ["张三", "李四", "王五", "赵六", "钱七", "孙八", "周九"]
                    var depts = ["研发部", "市场部", "财务部", "人事部", "运维部"]
                    var name = names[Math.floor(Math.random() * names.length)]
                    var dept = depts[Math.floor(Math.random() * depts.length)]
                    var age = 22 + Math.floor(Math.random() * 30)
                    var salary = 5000 + Math.floor(Math.random() * 15000)
                    var statuses = ["在职", "实习", "离职"]
                    var st = statuses[Math.floor(Math.random() * statuses.length)]
                    var colorMap = { "在职": "#10B981", "实习": "#3B82F6", "离职": "#9CA3AF" }
                    control.appendRow(buildRow(control.rows + 1, name, dept, age, salary, st, colorMap[st]))
                    infoText.text = "已新增: " + name
                }
            }

            ComButton {
                text: "删除选中行"
                onClicked: {
                    var idx = control.currentIndex()
                    if (idx >= 0) {
                        var row = control.getRow(idx)
                        control.removeRow(idx)
                        infoText.text = "已删除: " + row.name
                    } else {
                        infoText.text = "请先选择一行"
                    }
                }
            }

            ComButton {
                text: "清空所有行"
                onClicked: {
                    control.clearRows()
                    infoText.text = "已清空全部数据"
                }
            }

            ComButton {
                text: "重置示例数据"
                onClicked: { initData() }
            }

            Item { Layout.fillWidth: true }

            ComIconButton {
                id: btnHeader
                handCursor: true; iconbold: true; iconsize: 16
                iconsource: FluentIcon.ico_BulletedList; padding: 4
                ToolTip.text: "切换表头"
                ToolTip.visible: hovered
                onClicked: {
                    control.horizonalHeaderVisible = !control.horizonalHeaderVisible
                    if (!control.horizonalHeaderVisible && !control.verticalHeaderVisible)
                        control.horizonalHeaderVisible = true
                }
            }

            ComIconButton {
                id: btnRowHeader
                handCursor: true; iconbold: true; iconsize: 16
                iconsource: FluentIcon.ico_List; padding: 4; rotation: 90
                ToolTip.text: "切换行号"
                ToolTip.visible: hovered
                onClicked: {
                    control.verticalHeaderVisible = !control.verticalHeaderVisible
                    if (!control.horizonalHeaderVisible && !control.verticalHeaderVisible)
                        control.verticalHeaderVisible = true
                }
            }
        }

        // 表格
        ComTableView {
            id: control
            Layout.fillWidth: true
            Layout.fillHeight: true

            columnSource: [
                { dataIndex: "id", title: "ID", width: 60 },
                { dataIndex: "name", title: "姓名", width: 110 },
                { dataIndex: "dept", title: "部门", width: 100 },
                { dataIndex: "age", title: "年龄", width: 60 },
                { dataIndex: "salary", title: "薪资(元)", width: 110 },
                { dataIndex: "status", title: "状态", width: 90 },
                { dataIndex: "action", title: "操作", width: 140 }
            ]
        }

        // 状态栏
        RowLayout {
            Layout.fillWidth: true
            spacing: 16

            Label {
                id: infoText
                text: "共 " + control.rows + " 行，" + control.columns + " 列"
                color: Theme.Textcolor
                font.family: Theme.defaultFontFamily
                font.pixelSize: 12
            }

            Item { Layout.fillWidth: true }

            Label {
                text: "选中行: " + (control.current ? (control.current.name || "第" + (control.currentIndex() + 1) + "行") : "无")
                color: Theme.Textcolor
                font.family: Theme.defaultFontFamily
                font.pixelSize: 12
                elide: Text.ElideRight
            }
        }
    }

    function buildRow(id, name, dept, age, salary, statusText, statusColor) {
        return {
            "id": id,
            "name": name,
            "dept": dept,
            "age": age,
            "salary": salary,
            "status": control.customItem(comp_status_badge, {
                text: statusText || "在职",
                badgeColor: statusColor || "#10B981"
            }),
            "action": control.customItem(comp_action_button, {})
        }
    }

    function initData() {
        control.clearRows()
        var depts = ["研发部", "市场部", "财务部", "人事部", "运维部", "产品部"]
        var statuses = ["在职", "实习", "离职"]
        var colorMap = { "在职": "#10B981", "实习": "#3B82F6", "离职": "#9CA3AF" }
        var names = ["张伟", "李娜", "王强", "赵敏", "钱博", "孙雨", "周军", "陈芳", "林达", "黄磊",
                     "何平", "刘洋", "杨帆", "徐睿", "高山", "吴迪", "郑爽", "马超", "许晴", "唐明"]
        for (var i = 0; i < names.length; i++) {
            var st = statuses[Math.floor(Math.random() * statuses.length)]
            control.appendRow(buildRow(
                i + 1,
                names[i],
                depts[Math.floor(Math.random() * depts.length)],
                22 + Math.floor(Math.random() * 25),
                6000 + Math.floor(Math.random() * 20000),
                st,
                colorMap[st]
            ))
        }
        infoText.text = "已加载 " + control.rows + " 条示例数据"
    }

    Component.onCompleted: { initData() }
}
