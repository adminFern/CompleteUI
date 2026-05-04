import QtQuick
import QtQuick.Controls
import Qt.labs.qmlmodels
import FlaCoreUI

Item {
    id: control

    // ==================== 公共属性 ====================
    readonly property alias rows: table_view.rows
    readonly property alias columns: table_view.columns
    readonly property alias current: d.current    // 当前选中行数据
    property alias view: table_view               // TableView 实例引用

    property var columnSource: []                 // 列配置数组
    property color borderColor: Theme.DividerColor
    property bool horizonalHeaderVisible: true    // 水平表头可见性
    property bool verticalHeaderVisible: false    // 垂直表头可见性
    property color selectedBorderColor: Theme.PrimaryColor
    property color selectedColor: Theme.setColorAlpha(Theme.PrimaryColor, 100)

    // 列宽计算：优先使用配置宽度，否则使用默认宽度
    property var columnWidthProvider: function(column) {
        var columnModel = control.columnSource[column]
        if (columnModel.width) return columnModel.width
        if (columnModel.minimumWidth) return columnModel.minimumWidth
        return d.defaultItemWidth
    }

    // 行高计算：优先使用行配置高度，否则使用默认高度
    property var rowHeightProvider: function(row) {
        var rowModel = control.getRow(row)
        if (rowModel && rowModel.height) return rowModel.height
        if (rowModel && rowModel._minimumHeight) return rowModel._minimumHeight
        return d.defaultItemHeight
    }

    // ==================== 内部状态 ====================
    QtObject {
        id: d
        property var current                    // 当前选中行数据对象
        property int rowHoverIndex: -1          // 鼠标悬停行索引
        property int defaultItemWidth: 100
        property int defaultItemHeight: 42
        property int _keyCounter: 0             // 行唯一键计数器
    }

    // ==================== 数据模型（动态创建） ====================
    property QtObject tableModel: null
    property QtObject headerColumnModel: null

    // 根据列配置重建 TableModel
    function _rebuildModels() {
        if (columnSource.length === 0) return

        // 销毁旧模型
        if (tableModel) tableModel.destroy()
        if (headerColumnModel) headerColumnModel.destroy()

        var headerRow = {}
        var mainCols = ''
        var offsetX = 0

        // 遍历列配置，构建 TableModelColumn 字符串
        for (var i = 0; i < columnSource.length; i++) {
            var item = columnSource[i]
            if (!item.width) item.width = d.defaultItemWidth
            item.x = offsetX
            offsetX = offsetX + item.width
            var di = item.dataIndex
            mainCols += 'TableModelColumn { display: "' + di + '" } '
            headerRow[di] = item
        }

        // 动态创建主数据模型
        var modelStr = 'import Qt.labs.qmlmodels 1.0; TableModel { ' + mainCols + '}'
        tableModel = Qt.createQmlObject(modelStr, control)

        // 动态创建表头模型
        modelStr = 'import Qt.labs.qmlmodels 1.0; TableModel { ' + mainCols + '}'
        headerColumnModel = Qt.createQmlObject(modelStr, control)
        headerColumnModel.rows = [headerRow]
    }

    onColumnSourceChanged: _rebuildModels()

    Component.onDestruction: {
        table_view.contentY = 0
        if (tableModel) tableModel.destroy()
        if (headerColumnModel) headerColumnModel.destroy()
    }

    // ==================== 行号表头模型 ====================
    TableModel {
        id: header_row_model
        TableModelColumn { display: "rowIndex" }
    }

    // ==================== 单元格显示组件 ====================

    // 文本单元格组件
    Component {
        id: com_text
        Text {
            id: item_text
            text: typeof display === "object" ? display.text : String(display)
            elide: Text.ElideRight
            wrapMode: Text.WrapAnywhere
            anchors {
                fill: parent
                leftMargin: 11
                rightMargin: 11
                topMargin: 6
                bottomMargin: 6
            }
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: {
                var align = typeof display === "object" ? display.align : (columnModel ? columnModel.align : undefined)
                return align === "center" ? Text.AlignHCenter : Text.AlignLeft
            }
            color: Theme.Textcolor
        }
    }

    // 单元格委托组件
    Component {
        id: com_table_delegate
        MouseArea {
            id: item_table_mouse
            readonly property int viewRow: row
            readonly property int viewColumn: column
            // 获取当前行数据模型，依赖 table_view.rows 确保数据刷新
            property var rowModel: {
                var _rows = table_view.rows
                return control.getRow(viewRow)
            }
            property var columnModel: columnSource instanceof Array ? control.columnSource[viewColumn] : null
            // 判断当前行是否为选中行
            property bool isRowSelected: {
                var _rows = table_view.rows
                if (!rowModel) return false
                if (d.current) return rowModel._key === d.current._key
                return false
            }

            implicitWidth: TableView.view.width
            hoverEnabled: true

            onEntered: { d.rowHoverIndex = viewRow }

            Rectangle {
                anchors.fill: parent
                // 行背景色：选中 > 悬停 > 斑马纹
                color: {
                    if (item_table_mouse.isRowSelected) return control.selectedColor
                    if (d.rowHoverIndex === viewRow)
                        return Theme.isDark ? Qt.rgba(1, 1, 1, 0.06) : Qt.rgba(0, 0, 0, 0.06)
                    return (viewRow % 2 !== 0) ? "transparent"
                        : (Theme.isDark ? Qt.rgba(1, 1, 1, 0.03) : Qt.rgba(0, 0, 0, 0.03))
                }

                // 左键点击选中行
                MouseArea {
                    anchors.fill: parent
                    acceptedButtons: Qt.LeftButton
                    onClicked: function(event) {
                        d.current = item_table_mouse.rowModel
                        event.accepted = true
                    }
                }

                // 单元格内容加载器，支持文本或自定义组件
                Loader {
                    id: item_table_loader
                    readonly property var cellRowModel: item_table_mouse.rowModel
                    readonly property var cellColumnModel: item_table_mouse.columnModel
                    property var display: cellRowModel && cellColumnModel ? cellRowModel[cellColumnModel.dataIndex] : ""
                    property int row: item_table_mouse.viewRow
                    property int column: item_table_mouse.viewColumn
                    property bool isObject: typeof (display) === "object"
                    // 合并自定义组件选项
                    readonly property var _mergedOptions: {
                        if (!isObject) return {}
                        var base = display.options
                        var merged = {}
                        for (var k in base) { merged[k] = base[k] }
                        merged._row = item_table_mouse.viewRow
                        merged._column = item_table_mouse.viewColumn
                        return merged
                    }
                    property var options: _mergedOptions
                    anchors.fill: parent
                    sourceComponent: {
                        if (isObject) return display.comId
                        return com_text
                    }
                }

                // 选中行边框
                Item {
                    anchors.fill: parent
                    Rectangle {
                        width: 1; height: parent.height
                        anchors.left: parent.left
                        color: item_table_mouse.isRowSelected ? control.selectedBorderColor
                            : (control.verticalHeaderVisible ? "transparent" : control.borderColor)
                        visible: column === 0
                    }
                    Rectangle {
                        width: 1; height: parent.height
                        anchors.right: parent.right
                        color: item_table_mouse.isRowSelected ? control.selectedBorderColor : control.borderColor
                        visible: column === control.columns - 1
                    }
                    Rectangle {
                        width: parent.width; height: 1
                        anchors.top: parent.top
                        color: item_table_mouse.isRowSelected ? control.selectedBorderColor : "transparent"
                    }
                    Rectangle {
                        width: parent.width; height: 1
                        anchors.bottom: parent.bottom
                        color: item_table_mouse.isRowSelected ? control.selectedBorderColor : control.borderColor
                    }
                }
            }
        }
    }

    // ==================== 主表格区域 ====================
    MouseArea {
        id: layout_mouse_table
        hoverEnabled: true
        anchors {
            left: header_vertical.right
            top: header_horizontal.bottom
            right: parent.right
            bottom: parent.bottom
        }
        onExited: { d.rowHoverIndex = -1 }
        onCanceled: { d.rowHoverIndex = -1 }

        TableView {
            id: table_view
            boundsBehavior: Flickable.StopAtBounds
            anchors.fill: parent
            ScrollBar.horizontal: scroll_bar_h
            ScrollBar.vertical: scroll_bar_v
            columnWidthProvider: control.columnWidthProvider
            rowHeightProvider: control.rowHeightProvider
            model: control.tableModel
            clip: true

            onRowsChanged: {
                control.closeEditor()
                d.rowHoverIndex = -1
                Qt.callLater(table_view.forceLayout)
            }

            delegate: com_table_delegate
        }
    }

    // ==================== 水平表头 ====================
    Component {
        id: com_column_header_delegate
        Rectangle {
            id: column_item_control
            property var currentTableView: TableView.view
            readonly property real cellPadding: 8
            property bool canceled: false
            property var _model: model
            readonly property var columnModel: control.columnSource[_index]
            // 查找当前列索引
            readonly property int _index: {
                for (var i = 0; i < control.columnSource.length; i++) {
                    if (control.columnSource[i].dataIndex === display.dataIndex) return i
                }
                return -1
            }
            readonly property bool isHeaderHorizontal: TableView.view === header_horizontal

            implicitWidth: isHeaderHorizontal
                ? (item_column_loader.item && item_column_loader.item.implicitWidth) + (cellPadding * 2)
                : Math.max(TableView.view.width, Number.MIN_VALUE)
            implicitHeight: isHeaderHorizontal
                ? Math.max(36, (item_column_loader.item && item_column_loader.item.implicitHeight) + (cellPadding * 2))
                : Math.max(TableView.view.height, Number.MIN_VALUE)

            color: Theme.isDark ? Qt.rgba(50 / 255, 50 / 255, 50 / 255, 1)
                                : Qt.rgba(247 / 255, 247 / 255, 247, 1)

            // 表头边框
            Rectangle { border.color: control.borderColor; width: parent.width; height: 1; anchors.top: parent.top; color: "#00000000" }
            Rectangle { border.color: control.borderColor; width: parent.width; height: 1; anchors.bottom: parent.bottom; color: "#00000000" }
            Rectangle {
                border.color: control.borderColor; width: 1; height: parent.height; anchors.left: parent.left
                color: "#00000000"
                visible: column_item_control._index === 0 ? !control.verticalHeaderVisible : true
            }
            Rectangle {
                border.color: control.borderColor; width: 1; height: parent.height; anchors.right: parent.right
                color: "#00000000"
                visible: column_item_control._index === table_view.columns - 1
            }

            MouseArea {
                id: column_item_control_mouse
                anchors.fill: parent; anchors.rightMargin: 6
                hoverEnabled: true
                onCanceled: { column_item_control.canceled = true }
                onContainsMouseChanged: { if (!containsMouse) column_item_control.canceled = false }
                onClicked: function(event) { control.closeEditor() }
            }

            // 表头内容加载器
            Loader {
                id: item_column_loader
                property var model: column_item_control._model
                property var display: model.display.title
                property var tableView: table_view
                property var sourceModel: control.tableModel
                property bool isObject: typeof (display) === "object"
                property var options: isObject ? display.options : {}
                property int column: column_item_control._index
                width: parent.width; height: parent.height
                sourceComponent: isObject ? display.comId : com_column_text
            }

            // 列宽拖拽调整手柄
            MouseArea {
                property point clickPos: "0,0"
                height: parent.height; width: 6
                anchors.right: parent.right
                acceptedButtons: Qt.LeftButton; hoverEnabled: true
                // 冻结列或固定宽度列不显示调整手柄
                visible: !columnModel.frozen
                         && !(columnModel.width === columnModel.minimumWidth
                              && columnModel.width === columnModel.maximumWidth
                              && columnModel.width)
                cursorShape: Qt.SplitHCursor
                preventStealing: true

                onPressed: function(mouse) {
                    Theme.setOverrideCursor(Qt.SplitHCursor)
                    clickPos = Qt.point(mouse.x, mouse.y)
                }
                onReleased: { Theme.restoreOverrideCursor() }
                onCanceled: { Theme.restoreOverrideCursor() }
                // 拖拽调整列宽
                onPositionChanged: function(mouse) {
                    if (!pressed) return
                    var delta = Qt.point(mouse.x - clickPos.x, mouse.y - clickPos.y)
                    var minimumWidth = columnModel.minimumWidth
                    var maximumWidth = columnModel.maximumWidth
                    var w = columnModel.width
                    if (!w) w = d.defaultItemWidth
                    if (!minimumWidth) minimumWidth = d.defaultItemWidth
                    if (!maximumWidth) maximumWidth = 600
                    columnModel.width = Math.min(Math.max(minimumWidth, w + delta.x), maximumWidth)
                    Qt.callLater(function() {
                        table_view.forceLayout()
                        header_horizontal.forceLayout()
                    })
                }
            }
        }
    }

    // 表头文本组件
    Component {
        id: com_column_text
        Text {
            text: String(display)
            anchors.fill: parent
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            color: Theme.Textcolor
        }
    }

    // 水平表头 TableView
    TableView {
        id: header_horizontal
        model: control.headerColumnModel
        anchors {
            left: header_vertical.right
            right: layout_mouse_table.right
            top: parent.top
        }
        visible: control.horizonalHeaderVisible
        height: visible ? Math.max(1, contentHeight) : 0
        boundsBehavior: Flickable.StopAtBounds
        clip: true
        syncDirection: Qt.Horizontal
        ScrollBar.horizontal: scroll_bar_h_2
        columnWidthProvider: table_view.columnWidthProvider
        syncView: table_view.rows === 0 ? null : table_view    // 无数据时不与主表格同步
        onContentXChanged: { timer_horizontal_force_layout.restart() }

        Timer {
            id: timer_horizontal_force_layout
            interval: 50
            onTriggered: { header_horizontal.forceLayout() }
        }

        delegate: com_column_header_delegate
    }

    // ==================== 垂直表头 ====================
    // 左上角空白区域
    Item {
        id: header_vertical_column
        anchors {
            top: header_horizontal.top
            bottom: header_horizontal.bottom
            left: parent.left
            right: header_vertical.right
        }
        visible: control.verticalHeaderVisible && control.horizonalHeaderVisible

        Rectangle {
            anchors.fill: parent
            color: Theme.isDark ? Qt.rgba(50 / 255, 50 / 255, 50 / 255, 1)
                                : Qt.rgba(247 / 255, 247 / 255, 247, 1)
        }
        Rectangle { border.color: control.borderColor; width: parent.width; height: 1; anchors.top: parent.top; color: "#00000000" }
        Rectangle { border.color: control.borderColor; width: parent.width; height: 1; anchors.bottom: parent.bottom; color: "#00000000" }
        Rectangle { border.color: control.borderColor; width: 1; height: parent.height; anchors.left: parent.left; color: "#00000000" }
        Rectangle { border.color: control.borderColor; width: 1; height: parent.height; anchors.right: parent.right; color: "#00000000" }
    }

    // 行号单元格委托
    Component {
        id: com_row_header_delegate
        Rectangle {
            id: item_control
            readonly property real cellPadding: 6
            property bool canceled: false
            property var rowModel: control.getRow(row)
            implicitWidth: Math.max(30, row_text.implicitWidth + (cellPadding * 2))
            implicitHeight: row_text.implicitHeight + (cellPadding * 2)
            color: Theme.isDark ? Qt.rgba(50 / 255, 50 / 255, 50 / 255, 1)
                                : Qt.rgba(247 / 255, 247 / 255, 247, 1)

            Rectangle { border.color: control.borderColor; width: parent.width; height: 1; anchors.top: parent.top
                visible: row !== 0; color: "#00000000" }
            Rectangle { border.color: control.borderColor; width: parent.width; height: 1; anchors.bottom: parent.bottom
                visible: row === table_view.rows - 1; color: "#00000000" }
            Rectangle { border.color: control.borderColor; width: 1; height: parent.height; anchors.left: parent.left; color: "#00000000" }
            Rectangle { border.color: control.borderColor; width: 1; height: parent.height; anchors.right: parent.right; color: "#00000000" }

            Text {
                id: row_text
                anchors.centerIn: parent
                text: model.display
                color: Theme.Textcolor
            }

            MouseArea {
                id: item_control_mouse
                anchors.fill: parent; anchors.bottomMargin: 6
                hoverEnabled: true
                onCanceled: { item_control.canceled = true }
                onContainsMouseChanged: { if (!containsMouse) item_control.canceled = false }
                onClicked: function(event) { control.closeEditor() }
            }

            // 行高拖拽调整手柄
            MouseArea {
                property point clickPos: "0,0"
                height: 6; width: parent.width
                anchors.bottom: parent.bottom
                acceptedButtons: Qt.LeftButton
                cursorShape: Qt.SplitVCursor
                preventStealing: true
                // 固定高度行不显示调整手柄
                visible: {
                    if (!rowModel) return false
                    return !(rowModel.height === rowModel._minimumHeight
                             && rowModel.height === rowModel._maximumHeight
                             && rowModel.height)
                }
                onPressed: function(mouse) {
                    Theme.setOverrideCursor(Qt.SplitVCursor)
                    clickPos = Qt.point(mouse.x, mouse.y)
                }
                onReleased: { Theme.restoreOverrideCursor() }
                onCanceled: { Theme.restoreOverrideCursor() }
                // 拖拽调整行高
                onPositionChanged: function(mouse) {
                    if (!pressed) return
                    var rm = control.getRow(row)
                    if (!rm) return
                    var delta = Qt.point(mouse.x - clickPos.x, mouse.y - clickPos.y)
                    var minimumHeight = rm._minimumHeight
                    var maximumHeight = rm._maximumHeight
                    var h = rm.height
                    if (!h) h = d.defaultItemHeight
                    if (!minimumHeight) minimumHeight = d.defaultItemHeight
                    if (!maximumHeight) maximumHeight = 65535
                    rm.height = Math.min(Math.max(minimumHeight, h + delta.y), maximumHeight)
                    control.setRow(row, rm)
                    Qt.callLater(table_view.forceLayout)
                }
            }
        }
    }

    // 垂直表头 TableView
    TableView {
        id: header_vertical
        boundsBehavior: Flickable.StopAtBounds
        anchors {
            top: layout_mouse_table.top
            left: parent.left
        }
        visible: control.verticalHeaderVisible
        implicitWidth: visible ? Math.max(1, contentWidth) : 0
        implicitHeight: syncView ? syncView.height : 0
        syncDirection: Qt.Vertical
        syncView: table_view
        clip: true
        model: header_row_model
        delegate: com_row_header_delegate

        onContentYChanged: { timer_vertical_force_layout.restart() }

        // 监听主表格行数变化，更新行号模型
        Connections {
            target: table_view
            function onRowsChanged() {
                var arr = []
                for (var i = 0; i < table_view.rows; i++) {
                    arr.push({ rowIndex: i + 1 })
                }
                header_row_model.rows = arr
            }
        }

        Timer {
            id: timer_vertical_force_layout
            interval: 50
            onTriggered: { header_vertical.forceLayout() }
        }
    }

    // ==================== 滚动条 ====================
    // 主表格水平滚动条
    FlaScrollBar {
        id: scroll_bar_h
        anchors {
            left: layout_mouse_table.left
            right: parent.right
            bottom: layout_mouse_table.bottom
        }
        visible: table_view.rows !== 0 && table_view.contentWidth > table_view.width
        z: 999
    }

    // 空表格时的水平滚动条
    FlaScrollBar {
        id: scroll_bar_h_2
        anchors {
            left: layout_mouse_table.left
            right: parent.right
            bottom: layout_mouse_table.bottom
        }
        visible: table_view.rows === 0
        z: 999
    }

    // 垂直滚动条
    FlaScrollBar {
        id: scroll_bar_v
        anchors {
            top: layout_mouse_table.top
            bottom: layout_mouse_table.bottom
            right: parent.right
        }
        visible: table_view.contentHeight > table_view.height
        z: 999
    }

    // ==================== 公共方法 ====================
    // 重置滚动位置
    function resetPosition() {
        scroll_bar_h.decrease()
        scroll_bar_v.decrease()
    }

    function closeEditor() {}

    // 创建自定义单元格组件配置对象
    function customItem(comId, options) {
        var o = {}
        o.comId = comId
        o.options = options || {}
        return o
    }

    // 获取指定行数据
    function getRow(rowIndex) {
        if (!tableModel) return null
        return tableModel.getRow(rowIndex)
    }

    // 清空所有行
    function clearRows() {
        if (!tableModel) return
        d.current = null
        tableModel.clear()
    }

    // 删除指定行
    function removeRow(rowIndex, rows) {
        if (!tableModel) return
        if (rowIndex >= tableModel.rowCount) return
        var count = rows !== undefined ? rows : 1
        // 删除选中行时清除引用，避免悬空引用
        if (d.current) {
            var curIdx = currentIndex()
            if (curIdx >= 0 && curIdx >= rowIndex && curIdx < rowIndex + count)
                d.current = null
        }
        tableModel.removeRow(rowIndex, count)
    }

    // 在指定位置插入行
    function insertRow(rowIndex, obj) {
        if (!tableModel) return
        if (!obj._key) obj._key = "row_" + (++d._keyCounter)
        tableModel.insertRow(rowIndex, obj)
    }

    // 追加行到末尾
    function appendRow(obj) {
        if (!tableModel) return
        if (!obj._key) obj._key = "row_" + (++d._keyCounter)
        tableModel.appendRow(obj)
    }

    // 更新指定行数据
    function setRow(rowIndex, obj) {
        if (!tableModel) return
        tableModel.setRow(rowIndex, obj)
    }

    // 获取当前选中行索引
    function currentIndex() {
        if (!tableModel) return -1
        var index = -1
        if (!d.current) return index
        for (var i = 0; i < tableModel.rowCount; i++) {
            if (tableModel.getRow(i)._key === d.current._key) {
                index = i
                break
            }
        }
        return index
    }

    onWidthChanged: { Qt.callLater(table_view.forceLayout) }
}
