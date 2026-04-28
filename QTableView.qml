import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt.labs.qmlmodels
import QuickUI


Rectangle {
    id: control

    // ==================== 公共属性接口 ====================

    /**
     * 只读属性，暴露内部表格的行数和列数
     * 便于外部获取表格的当前状态
     */
    readonly property alias rows: table_view.rows
    readonly property alias columns: table_view.columns

    /**
     * 当前选中的行数据（只读）
     * 当用户点击行时自动更新，外部可以监听此属性变化
     */
    readonly property alias current: d.current

    /**
     * 数据模型 - 核心数据管理属性
     * 使用 FluTableModel 作为数据源，同时管理数据和列定义
     */
    property var sourceModel: QTableModel {
        // 列定义与 columnSource 属性同步
        columnSource: control.columnSource
    }

    /**
     * 列定义数据源 - 表格结构配置
     * 格式：[{ dataIndex: "字段名", title: "列标题", width: 列宽 }, ...]
     * 支持属性：dataIndex, title, width, minimumWidth, maximumWidth
     */
    property var columnSource: []

    /**
     * 表格边框颜色
     * 根据主题自动适配深色/浅色模式
     */
    property color borderColor: Theme.BorderNormalColor
    /**
     * 水平表头可见性
     * 控制是否显示列标题栏
     */
    property bool horizonalHeaderVisible: true

    /**
     * 垂直表头可见性
     * 控制是否显示行号栏
     */
    property bool verticalHeaderVisible: !true

    /**
     * 选中行的边框颜色
     * 用于高亮显示当前选中的行
     */
    property color selectedBorderColor:Theme.primaryColor

    /**
     * 选中行的背景颜色
     * 使用主色调的半透明版本
     */
    property color selectedColor:Theme.setColorAlpha(Theme.primaryColor,100) // FluTools.withOpacity(FluTheme.primaryColor,0.3)

    /**
     * 对外暴露的表格视图引用
     * 便于外部直接访问内部的 TableView 组件
     */
    property alias view: table_view

    /**
     * 列宽度提供器函数
     * 用于动态计算每列的宽度，支持自定义逻辑
     * @param column 列索引
     * @return 列宽度值
     */
    property var columnWidthProvider: function(column) {
        var columnModel = control.columnSource[column]
        // 优先级：显式宽度 > 最小宽度 > 默认宽度
        var width = columnModel.width
        if(width){
            return width
        }
        var minimumWidth = columnModel.minimumWidth
        if(minimumWidth){
            return minimumWidth
        }
        return d.defaultItemWidth
    }

    /**
     * 行高度提供器函数
     * 用于动态计算每行的高度，支持自定义逻辑
     * @param row 行索引
     * @return 行高度值
     */
    property var rowHeightProvider: function(row) {
        var rowModel = control.getRow(row)
        // 优先级：显式高度 > 最小高度 > 默认高度
        var height = rowModel.height
        if(height){
            return height
        }
        var minimumHeight = rowModel._minimumHeight
        if(minimumHeight){
            return minimumHeight
        }
        return d.defaultItemHeight
    }

    /**
     * 组件背景颜色
     * 根据窗口激活状态变化，提供视觉反馈
     */
    color:"transparent" /*{
        if(Window.active){
            return FluTheme.frameActiveColor
        }
        return FluTheme.frameColor
    }*/

    // ==================== 核心业务逻辑 ====================

    /**
     * 列定义变化处理函数
     *
     * 当 columnSource 发生变化时，重新构建表头模型
     * 这是表格初始化的关键步骤，完成以下工作：
     * 1. 创建 TableModelColumn 对象
     * 2. 构建表头数据
     * 3. 计算列位置信息
     */
    onColumnSourceChanged: {
        // 确保列定义不为空
        if(columnSource.length !== 0){
            var columns = []        // 存储创建的列对象
            var headerRow = {}      // 表头行数据
            var offsetX = 0         // 列位置累积偏移量

            // 遍历所有列定义
            for(var i = 0; i <= columnSource.length - 1; i++){
                var item = columnSource[i]  // 当前列定义

                // 设置默认宽度
                if(!item.width){
                    item.width = d.defaultItemWidth
                }

                // 计算列的位置（用于潜在的冻结列功能）
                item.x = offsetX
                offsetX = offsetX + item.width

                /**
                 * 动态创建 TableModelColumn 对象
                 * display 属性必须与数据字段名对应，这是数据绑定的关键
                 */
                var column = Qt.createQmlObject(
                            'import Qt.labs.qmlmodels 1.0; TableModelColumn{}',
                            sourceModel
                            )
                column.display = item.dataIndex

                columns.push(column)

                // 构建表头数据，键为 dataIndex，值为列定义
                headerRow[item.dataIndex] = item
            }

            // 更新表头模型
            header_column_model.columns = columns
            header_column_model.rows = [headerRow]
        }
    }

    /**
     * 组件销毁时的清理工作
     */
    Component.onDestruction: {
        table_view.contentY = 0  // 重置滚动位置
    }

    // ==================== 内部状态管理 ====================

    /**
     * 内部状态对象
     * 封装组件的内部状态，避免污染公共接口
     */
    QtObject {
        id: d
        property var current                  // 当前选中的行数据
        property int rowHoverIndex: -1        // 鼠标悬停的行索引
        property int defaultItemWidth: 100    // 默认列宽度
        property int defaultItemHeight: 42    // 默认行高度
        signal tableItemLayout(int column)    // 表格项布局信号
    }

    // ==================== 表头数据模型 ====================

    /**
     * 表头列模型
     * 用于显示列标题，只包含一个 "title" 字段
     */
    TableModel {
        id: header_column_model
        TableModelColumn { display: "title" }
    }

    /**
     * 表头行模型
     * 用于显示行号
     */
    TableModel {
        id: header_row_model
        TableModelColumn { display: "rowIndex" }
    }

    // ==================== 显示组件定义 ====================

    /**
     * 文本显示组件 - 默认的单元格内容渲染器
     *
     * 特性：
     * - 自动文本截断和省略号显示
     * - 支持文本换行
     * - 智能工具提示（文本被截断时显示）
     */
    Component {
        id: com_text
        Text {
            id: item_text
            text: String(display)  // 确保显示内容为字符串
            elide: Text.ElideRight // 文本过长时右侧显示省略号
            wrapMode: Text.WrapAnywhere  // 支持任意位置换行
            anchors {
                fill: parent
                leftMargin: 11    // 左右边距
                rightMargin: 11
                topMargin: 6      // 上下边距
                bottomMargin: 6
            }
            verticalAlignment: Text.AlignVCenter  // 垂直居中显示
            color: Theme.TextColor

            // 鼠标悬停检测区域
            MouseArea {
                acceptedButtons: Qt.NoButton  // 不处理点击，只检测悬停
                id: hover_handler
                hoverEnabled: true
                anchors.fill: parent
            }

            // 智能工具提示
            /* FluTooltip {
                text: item_text.text
                delay: 500  // 延迟500ms显示
                // 只在文本被截断且鼠标悬停时显示
                visible: item_text.contentWidth < item_text.implicitWidth &&
                        item_text.contentHeight < item_text.implicitHeight &&
                        hover_handler.containsMouse
            }*/
        }
    }

    /**
     * 表格单元格委托组件
     *
     * 这是表格渲染的核心组件，负责：
     * 1. 单元格的视觉呈现
     * 2. 用户交互处理
     * 3. 数据加载和显示
     * 4. 选中状态管理
     */
    Component {
        id: com_table_delegate
        MouseArea {
            id: item_table_mouse
            property var _model: model        // 单元格的模型数据
            property bool isMainTable: TableView.view == table_view
            property var currentTableView: TableView.view
            property bool isHide: {
                // 在主表格中，隐藏冻结列
                if(isMainTable && columnModel.frozen){
                    return true
                }
                // 在冻结列的 TableView 中，只显示对应的列
                if(!isMainTable){
                    if(currentTableView.dataIndex !== columnModel.dataIndex)
                        return true
                }
                return false
            }

            /**
             * 当前行选中状态计算属性
             * 通过比较 _key 字段判断是否为选中行
             */
            property bool isRowSelected: {
                if(!rowModel) return false
                if(d.current){
                    return rowModel._key === d.current._key
                }
                return false
            }

            implicitWidth: isHide ? Number.MIN_VALUE : TableView.view.width
            visible: !isHide
            hoverEnabled: true  // 启用鼠标悬停检测

            /**
             * 鼠标进入单元格事件
             * 更新悬停行索引，用于显示悬停效果
             */
            onEntered: {
                d.rowHoverIndex = row
            }

            /**
             * 更新表格项位置
             */
            function updateTableItem(){
                var columnModel = control.columnSource[column]
                columnModel.x = item_table_mouse.x
                columnModel.y = item_table_mouse.y
                d.tableItemLayout(column)
            }

            // 监听位置和尺寸变化，更新冻结列位置
            onWidthChanged: {
                if(isMainTable){
                    updateTableItem()
                }
            }
            onHeightChanged: {
                if(isMainTable){
                    updateTableItem()
                }
            }
            onXChanged: {
                if(isMainTable){
                    updateTableItem()
                }
            }
            onYChanged: {
                if(isMainTable){
                    updateTableItem()
                }
            }

            // 单元格背景和交互区域
            Rectangle {
                anchors.fill: parent
                /**
                 * 背景颜色逻辑：
                 * 1. 选中行：使用选中颜色
                 * 2. 悬停行：使用悬停颜色
                 * 3. 其他行：斑马纹交替背景
                 */
                color: {
                    // 选中行背景
                    if(item_table_mouse.isRowSelected){
                        return control.selectedColor
                    }
                    // 悬停行背景
                    if(d.rowHoverIndex === row){
                        return Theme.isDark ?
                                    Qt.rgba(1,1,1,0.06) :
                                    Qt.rgba(0,0,0,0.06)
                    }
                    // 斑马纹背景：奇数行使用主背景色，偶数行使用交替色
                    return (row % 2 !== 0) ? control.color :
                                             (Theme.isDark ?
                                                  Qt.rgba(1,1,1,0.03) :
                                                  Qt.rgba(0,0,0,0.03))
                }

                // 单元格点击交互区域
                MouseArea {
                    anchors.fill: parent
                    acceptedButtons: Qt.LeftButton  // 只响应左键点击

                    /**
                     * 点击事件处理
                     * 设置当前选中行
                     */
                    onClicked: (event) => {
                                   d.current = rowModel  // 更新选中行
                                   event.accepted = true // 阻止事件继续传播
                               }
                }

                /**
                 * 动态内容加载器
                 *
                 * 根据数据类型智能选择显示组件：
                 * - 对象类型：使用自定义组件
                 * - 其他类型：使用默认文本组件
                 */
                Loader {
                    id: item_table_loader
                    property var model: item_table_mouse._model
                    // 关键：通过 dataIndex 动态获取对应字段的数据
                    property var display: rowModel[columnModel.dataIndex]
                    property var rowModel: model.rowModel      // 行数据对象
                    property var columnModel: model.columnModel // 列定义对象
                    property int row: model.row
                    property int column: model.column
                    property bool isObject: typeof(display) == "object"
                    property var options: {
                        if(isObject){
                            return display.options  // 自定义组件的配置参数
                        }
                        return {}
                    }
                    anchors.fill: parent

                    // 动态组件选择逻辑
                    sourceComponent: {
                        if(item_table_mouse.visible){
                            if(isObject){
                                return display.comId  // 自定义组件
                            }
                            return com_text  // 默认文本组件
                        }
                        return undefined
                    }
                }

                /**
                 * 选中行边框指示器
                 * 只在选中行的边缘单元格显示边框，避免视觉混乱
                 */
                Item {
                    anchors.fill: parent
                  //  visible: item_table_mouse.isRowSelected

                    // 左边框（只在第一列显示）
                    Rectangle {
                        width: 1
                        height: parent.height
                        anchors.left: parent.left
                        color: {
                            if(item_table_mouse.isRowSelected) {
                                return control.selectedBorderColor
                            }
                            // 如果有垂直表头，第一列左边框透明；否则显示边框颜色
                            return control.verticalHeaderVisible ? "transparent" : control.borderColor
                        }
                        visible: column === 0
                    }

                    // 右边框（只在最后一列显示）
                    Rectangle {
                        width: 1
                        height: parent.height
                        anchors.right: parent.right
                        color:item_table_mouse.isRowSelected? control.selectedBorderColor:control.borderColor
                        visible: column === control.columns - 1
                    }

                    // 上边框
                    Rectangle {
                        width: parent.width
                        height: 1
                        anchors.top: parent.top
                       color:item_table_mouse.isRowSelected? control.selectedBorderColor:"transparent"
                    }

                    // 下边框
                    Rectangle {
                        width: parent.width
                        height: 1
                        anchors.bottom: parent.bottom
                        color: {
                            if(item_table_mouse.isRowSelected) {
                                return control.selectedBorderColor
                            }
                            // 只在最后一行显示边框颜色，其他行透明
                            return (row === table_view.rows - 1) ? control.borderColor : "transparent"
                        }
                    }
                }
            }
        }
    }

    // ==================== 主表格区域 ====================

    /**
     * 表格主区域的鼠标检测
     * 用于处理鼠标离开表格时的状态清理
     */
    MouseArea {
        id: layout_mouse_table
        hoverEnabled: true
        anchors {
            left: header_vertical.right
            top: header_horizontal.bottom
            right: parent.right
            bottom: parent.bottom
        }

        // 鼠标离开时清除悬停状态
        onExited: {
            d.rowHoverIndex = -1
        }

        onCanceled: {
            d.rowHoverIndex = -1
        }

        /**
         * 主表格视图
         * 负责数据的实际渲染和滚动管理
         */
        TableView {
            id: table_view
            boundsBehavior: Flickable.StopAtBounds  // 滚动到边界时停止
            anchors.fill: parent
            ScrollBar.horizontal: scroll_bar_h      // 水平滚动条
            ScrollBar.vertical: scroll_bar_v        // 垂直滚动条
            columnWidthProvider: control.columnWidthProvider  // 列宽计算
            rowHeightProvider: control.rowHeightProvider      // 行高计算
            model: control.sourceModel  // 数据模型
            clip: true  // 裁剪超出显示区域的内容

            /**
             * 行数变化处理
             * 关闭编辑器并触发轻微滚动以刷新显示
             */
            onRowsChanged: {
                control.closeEditor()
                table_view.flick(0, 1)
            }

            // 使用统一的单元格委托
            delegate: com_table_delegate
        }
    }

    // ==================== 表头组件 ====================

    /**
     * 水平表头委托组件
     * 负责表头单元格的渲染和交互
     */
    Component {
        id: com_column_header_delegate
        Rectangle {
            id: column_item_control
            property var currentTableView: TableView.view
            readonly property real cellPadding: 8    // 单元格内边距
            property bool canceled: false           // 交互取消状态
            property var _model: model              // 表头模型数据
            readonly property var columnModel: control.columnSource[_index]
            // 通过 dataIndex 查找列索引
            readonly property int _index: {
                const isDataIndex = (element) => {
                    return element.dataIndex === display.dataIndex
                }
                return control.columnSource.findIndex(isDataIndex)
            }
            readonly property bool isHeaderHorizontal: TableView.view == header_horizontal
            readonly property bool isHide: {
                // 在主表头中显示所有列
                if(isHeaderHorizontal){
                    return false
                }
                // 在冻结列的表头中，只显示对应的列
                if(!isHeaderHorizontal){
                    if(currentTableView.dataIndex !== columnModel.dataIndex)
                        return true
                }
                return false
            }
            visible: !isHide

            // 动态计算列宽（考虑内容宽度和内边距）
            implicitWidth: {
                if(isHide){
                    return Number.MIN_VALUE
                }
                if(isHeaderHorizontal){
                    return (item_column_loader.item && item_column_loader.item.implicitWidth) + (cellPadding * 2)
                }
                return Math.max(TableView.view.width, Number.MIN_VALUE)
            }

            // 动态计算行高（至少36像素）
            implicitHeight: {
                if(isHeaderHorizontal){
                    return Math.max(36, (item_column_loader.item && item_column_loader.item.implicitHeight) + (cellPadding * 2))
                }
                return Math.max(TableView.view.height, Number.MIN_VALUE)
            }

            // 表头背景色（与主题适配）
            color: Theme.isDark ?
                       Qt.rgba(50/255,50/255,50/255,1) :
                       Qt.rgba(247/255,247/255,247/255,1)

            // 表头边框设置
            Rectangle {
                border.color: control.borderColor
                width: parent.width
                height: 1
                anchors.top: parent.top
                color: "#00000000"  // 透明填充
            }
            Rectangle {
                border.color: control.borderColor
                width: parent.width
                height: 1
                anchors.bottom: parent.bottom
                color: "#00000000"
            }
            Rectangle {
                border.color: control.borderColor
                width: 1
                height: parent.height
                anchors.left: parent.left
                visible: {
                    // 如果是第一列
                    if(column_item_control._index === 0) {
                        // 没有垂直表头时，第一列需要显示左边框
                        return !control.verticalHeaderVisible
                    }
                    // 其他列都显示左边框
                    return true
                }
                color: "#00000000"
            }
            Rectangle {
                border.color: control.borderColor
                width: 1
                height: parent.height
                anchors.right: parent.right
                color: "#00000000"
                visible: column_item_control._index === table_view.columns - 1  // 最后一列显示右边框
            }

            // 表头交互区域
            MouseArea {
                id: column_item_control_mouse
                anchors.fill: parent
                anchors.rightMargin: 6  // 为调整手柄留出空间
                hoverEnabled: true
                onCanceled: {
                    column_item_control.canceled = true
                }
                onContainsMouseChanged: {
                    if(!containsMouse){
                        column_item_control.canceled = false
                    }
                }
                onClicked: (event) => {
                               control.closeEditor()  // 点击表头时关闭编辑器
                           }
            }

            // 表头内容加载器
            Loader {
                id: item_column_loader
                property var model: column_item_control._model
                property var display: model.display.title  // 表头标题文本
                property var tableView: table_view
                property var sourceModel: control.sourceModel
                property bool isObject: typeof(display) == "object"
                property var options: {
                    if(isObject){
                        return display.options
                    }
                    return {}
                }
                property int column: column_item_control._index
                width: parent.width
                height: parent.height

                // 动态选择表头显示组件
                sourceComponent: {
                    if(isObject){
                        return display.comId  // 自定义表头组件
                    }
                    return com_column_text    // 默认文本表头
                }
            }

            /**
             * 列宽调整手柄
             * 允许用户通过拖拽调整列宽
             */
            MouseArea {
                property point clickPos: "0,0"  // 鼠标点击起始位置
                height: parent.height
                width: 6  // 手柄宽度
                anchors.right: parent.right
                acceptedButtons: Qt.LeftButton
                hoverEnabled: true
                // 只在可调整的列显示手柄
                visible: !columnModel.frozen &&
                         !(columnModel.width === columnModel.minimumWidth &&
                           columnModel.width === columnModel.maximumWidth &&
                           columnModel.width)
                cursorShape: Qt.SplitHCursor  // 显示列调整光标
                preventStealing: true  // 阻止事件被父组件处理

                onPressed: (mouse) => {
                               AppHelper.setOverrideCursor(Qt.SplitHCursor)  // 设置鼠标样式
                               clickPos = Qt.point(mouse.x, mouse.y)  // 记录起始位置
                           }

                onReleased: {
                    AppHelper.restoreOverrideCursor()  // 恢复默认鼠标样式
                }

                onCanceled: {
                    AppHelper.restoreOverrideCursor()
                }

                // 拖拽调整列宽
                onPositionChanged: (mouse) => {
                                       if(!pressed) return

                                       // 计算鼠标移动距离
                                       var delta = Qt.point(mouse.x - clickPos.x, mouse.y - clickPos.y)
                                       var minimumWidth = columnModel.minimumWidth
                                       var maximumWidth = columnModel.maximumWidth
                                       var w = columnModel.width

                                       // 设置默认值
                                       if(!w) w = d.defaultItemWidth
                                       if(!minimumWidth) minimumWidth = d.defaultItemWidth
                                       if(!maximumWidth) maximumWidth = 600  // 足够大的最大值

                                       // 计算新宽度并限制在有效范围内
                                       columnModel.width = Math.min(
                                           Math.max(minimumWidth, w + delta.x),
                                           maximumWidth
                                           )

                                       // 强制表格重新布局
                                       table_view.forceLayout()
                                       header_horizontal.forceLayout()
                                   }
            }
        }
    }

    /**
     * 表头文本显示组件
     * 默认的表头内容渲染器
     */
    Component {
        id: com_column_text
        Text {
            id: column_text
            text: String(display)  // 表头标题
            anchors.fill: parent
            horizontalAlignment: Text.AlignHCenter  // 水平居中
            verticalAlignment: Text.AlignVCenter    // 垂直居中
            color: Theme.TextColor
        }
    }

    /**
     * 水平表头视图
     * 显示列标题，并与主表格水平同步滚动
     */
    TableView {
        id: header_horizontal
        model: header_column_model  // 表头数据模型
        anchors {
            left: header_vertical.right
            right: layout_mouse_table.right
            top: parent.top
        }
        visible: control.horizonalHeaderVisible  // 可控的可见性
        height: visible ? Math.max(1, contentHeight) : 0  // 动态高度
        boundsBehavior: Flickable.StopAtBounds
        clip: true
        syncDirection: Qt.Horizontal  // 水平滚动同步
        ScrollBar.horizontal: scroll_bar_h_2
        columnWidthProvider: table_view.columnWidthProvider  // 共享列宽计算
        syncView: table_view.rows === 0 ? null : table_view  // 同步的主视图
        onContentXChanged: {
            timer_horizontal_force_layout.restart()  // 延迟重新布局
        }

        /**
         * 延迟布局定时器
         * 避免在快速滚动时频繁触发布局计算，提升性能
         */
        Timer {
            id: timer_horizontal_force_layout
            interval: 50  // 50ms 延迟
            onTriggered: {
                header_horizontal.forceLayout()
            }
        }

        // 使用表头委托组件
        delegate: com_column_header_delegate
    }

    // ==================== 垂直表头组件 ====================

    /**
     * 垂直表头与水平表头交叉区域 左上角区域
     */
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
            color: Theme.isDark ? Qt.rgba(50/255,50/255,50/255,1) : Qt.rgba(247/255,247/255,247/255,1)
        }
        
        Rectangle {
            border.color: control.borderColor
            width: parent.width
            height: 1
            anchors.top: parent.top
            color: "#00000000"
        }
        Rectangle {
            border.color: control.borderColor
            width: parent.width
            height: 1
            anchors.bottom: parent.bottom
            color: "#00000000"
        }
        Rectangle {
            border.color: control.borderColor
            width: 1
            height: parent.height
            anchors.left: parent.left
            color: "#00000000"
        }
        Rectangle {
            border.color: control.borderColor
            width: 1
            height: parent.height
            anchors.right: parent.right
            color: "#00000000"
        }
    }

    /**
     * 垂直表头视图
     * 显示行号，并与主表格垂直同步滚动
     */
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
        
        onContentYChanged: {
            timer_vertical_force_layout.restart()
        }
        
        Connections {
            target: table_view
            function onRowsChanged(){
                header_row_model.rows = Array.from({length: table_view.rows}, (_, i) => ({rowIndex: i + 1}))
            }
        }
        
        Timer {
            id: timer_vertical_force_layout
            interval: 50
            onTriggered: {
                header_vertical.forceLayout()
            }
        }
    }

    /**
     * 行表头委托组件
     */
    Component {
        id: com_row_header_delegate
        Rectangle {
            id: item_control
            readonly property real cellPadding: 6
            property bool canceled: false
            property var rowModel: control.getRow(row)
            implicitWidth: Math.max(30, row_text.implicitWidth + (cellPadding * 2))
            implicitHeight: row_text.implicitHeight + (cellPadding * 2)
            color: Theme.isDark ? Qt.rgba(50/255,50/255,50/255,1) : Qt.rgba(247/255,247/255,247/255,1)
            
            Rectangle {
                border.color: control.borderColor
                width: parent.width
                height: 1
                anchors.top: parent.top
                visible: row !== 0
                color: "#00000000"
            }
            Rectangle {
                border.color: control.borderColor
                width: parent.width
                height: 1
                anchors.bottom: parent.bottom
                visible: row === table_view.rows - 1
                color: "#00000000"
            }
            Rectangle {
                border.color: control.borderColor
                width: 1
                height: parent.height
                anchors.left: parent.left
                color: "#00000000"
            }
            Rectangle {
                border.color: control.borderColor
                width: 1
                height: parent.height
                anchors.right: parent.right
                color: "#00000000"
            }
            
            Text {
                id: row_text
                anchors.centerIn: parent
                text: model.display
                color: Theme.TextColor
            }
            
            MouseArea {
                id: item_control_mouse
                anchors.fill: parent
                anchors.bottomMargin: 6
                hoverEnabled: true
                onCanceled: {
                    item_control.canceled = true
                }
                onContainsMouseChanged: {
                    if(!containsMouse){
                        item_control.canceled = false
                    }
                }
                onClicked: (event) => {
                               control.closeEditor()
                           }
            }
            
            // 行高调整手柄
            MouseArea {
                property point clickPos: "0,0"
                height: 6
                width: parent.width
                anchors.bottom: parent.bottom
                acceptedButtons: Qt.LeftButton
                cursorShape: Qt.SplitVCursor
                preventStealing: true
                visible: {
                    if(rowModel === null)
                        return false
                    return !(rowModel.height === rowModel._minimumHeight && rowModel.height === rowModel._maximumHeight && rowModel.height)
                }
                onPressed: (mouse) => {
                               AppHelper.setOverrideCursor(Qt.SplitVCursor)
                               clickPos = Qt.point(mouse.x, mouse.y)
                           }
                onReleased: {
                    AppHelper.restoreOverrideCursor()
                }
                onCanceled: {
                    AppHelper.restoreOverrideCursor()
                }
                onPositionChanged: (mouse) => {
                                       if(!pressed){
                                           return
                                       }
                                       var rowModel = control.getRow(row)
                                       var delta = Qt.point(mouse.x - clickPos.x, mouse.y - clickPos.y)
                                       var minimumHeight = rowModel._minimumHeight
                                       var maximumHeight = rowModel._maximumHeight
                                       var h = rowModel.height
                                       if(!h){
                                           h = d.defaultItemHeight
                                       }
                                       if(!minimumHeight){
                                           minimumHeight = d.defaultItemHeight
                                       }
                                       if(!maximumHeight){
                                           maximumHeight = 65535
                                       }
                                       rowModel.height = Math.min(Math.max(minimumHeight, h + delta.y), maximumHeight)
                                       control.setRow(row, rowModel)
                                       table_view.forceLayout()
                                   }
            }
        }
    }

    // ==================== 冻结列组件 ====================

    /**
     * 冻结列容器
     * 用于显示固定在左侧或右侧的列
     */
    Item {
        anchors {
            left: header_vertical.right
            top: parent.top
            bottom: parent.bottom
            right: parent.right
        }
        z: 100  // 确保冻结列在最上层

        /**
         * 冻结列组件
         */
        Component {
            id: com_table_frozen
            Item {
                id: item_layout_frozen
                anchors.fill: parent
                // color: {
                //     if(Window.active){
                //         return Theme.isDark ? Qt.rgba(48/255,48/255,48/255,1) : Qt.rgba(1,1,1,1)
                //     }
                //     return Theme.isDark ? Qt.rgba(56/255,56/255,56/255,1) : Qt.rgba(243/255,243/255,243/255,1)
                // }
                visible: table_view.rows !== 0

                // 冻结列边框
                Rectangle {
                    z: 0
                    anchors.topMargin:  item_table_frozen_header.height
                    width: item_table_frozen.width
                    height: item_table_frozen.height-item_table_frozen_header.height-13

                    border.width: 1
                     border.color: Theme.isDark ? Qt.rgba(26/255,26/255,26/255,0.6) : Qt.rgba(191/255,191/255,191/255,0.5)
                    color: {
                        if(Window.active){
                            return Theme.isDark ? Qt.rgba(48/255,48/255,48/255,1) : Qt.rgba(1,1,1,1)
                        }
                        return Theme.isDark ? Qt.rgba(56/255,56/255,56/255,1) : Qt.rgba(243/255,243/255,243/255,1)
                    }
                    Shadow{

                    }
                }

                // 冻结列的数据表格
                TableView {
                    property string dataIndex: columnModel.dataIndex
                    id: item_table_frozen
                    interactive: false
                    clip: true
                    anchors {
                        left: parent.left
                        right: parent.right
                    }
                    contentWidth: width
                    height: table_view.height
                    y: header_horizontal.height
                    boundsBehavior: TableView.StopAtBounds
                    model: table_view.model
                    delegate: table_view.delegate
                    syncDirection: Qt.Vertical
                    syncView: table_view
                }

                // 冻结列的表头
                TableView {
                    property string dataIndex: columnModel.dataIndex
                    id: item_table_frozen_header
                    model: header_column_model
                    boundsBehavior: Flickable.StopAtBounds
                    interactive: false
                    clip: true
                    contentWidth: width
                    anchors {
                        left: parent.left
                        right: parent.right
                        top: parent.top
                        bottom: item_table_frozen.top
                    }
                    delegate: com_column_header_delegate
                    Component.onCompleted: {
                        item_table_frozen_header.forceLayout()
                    }
                }

                Connections {
                    target: table_view
                    function onWidthChanged() {
                        item_table_frozen_header.forceLayout()
                    }
                }
            }
        }

        /**
         * 冻结列重复器
         * 为每个冻结列创建一个浮动层
         */
        Repeater {
            Component.onCompleted: {
                model = control.columnSource
            }
            delegate: Loader {
                id: item_layout_frozen
                readonly property int _index: model.index
                readonly property var columnModel: control.columnSource[_index]
                readonly property bool isHide: {
                    if(columnModel.frozen){
                        return false
                    }
                    return true
                }

                Connections {
                    target: d
                    function onTableItemLayout(column){
                        if(item_layout_frozen._index === column){
                            updateLayout()
                        }
                    }
                }

                Connections {
                    target: table_view
                    function onContentXChanged(){
                        updateLayout()
                    }
                }

                function updateLayout(){
                    width = table_view.columnWidthProvider(_index)
                    x = Qt.binding(function(){
                        var minX = 0
                        var maxX = table_view.width - width
                        for(var i = 0; i < _index; i++){
                            var item = control.columnSource[i]
                            if(item.frozen){
                                minX = minX + table_view.columnWidthProvider(i)
                            }
                        }
                        for(i = _index + 1; i < control.columnSource.length; i++){
                            item = control.columnSource[i]
                            if(item.frozen){
                                maxX = maxX - table_view.columnWidthProvider(i)
                            }
                        }
                        var calculatedX = columnModel.x - table_view.contentX
                        return Math.min(Math.max(calculatedX, minX), maxX)
                    })
                }

                Component.onCompleted: {
                    updateLayout()
                }

                height: control.height
                visible: !item_layout_frozen.isHide
                sourceComponent: item_layout_frozen.isHide ? undefined : com_table_frozen
                z: 10  // 确保冻结列显示在上层
            }
        }
    }

    // ==================== 滚动条组件 ====================

    /**
     * 水平滚动条（有数据时显示）
     */
    QScrollBar {
        id: scroll_bar_h
        anchors {
            left: layout_mouse_table.left
            right: parent.right
            bottom: layout_mouse_table.bottom
        }
        visible: table_view.rows !== 0  // 无数据时隐藏
        z: 999  // 确保显示在最上层
    }

    /**
     * 水平滚动条（无数据时显示）
     */
    QScrollBar {
        id: scroll_bar_h_2
        anchors {
            left: layout_mouse_table.left
            right: parent.right
            bottom: layout_mouse_table.bottom
        }
        visible: table_view.rows === 0  // 只在无数据时显示
        z: 999
    }

    /**
     * 垂直滚动条
     */
    QScrollBar {
        id: scroll_bar_v
        anchors {
            top: layout_mouse_table.top
            bottom: layout_mouse_table.bottom
            right: parent.right
        }
        z: 999
    }

    // ==================== 公共方法接口 ====================

    /**
     * 重置滚动位置
     * 将水平和垂直滚动条都重置到起始位置
     */
    function resetPosition() {
        scroll_bar_h.position = 0
        scroll_bar_v.position = 0
    }

    /**
     * 关闭编辑器
     * 空实现，保持API兼容性
     */
    function closeEditor() {
        // 空实现，因为已移除编辑功能
        // 保留此函数以避免调用错误
    }

    /**
     * 创建自定义显示项
     *
     * 用于创建需要自定义组件渲染的单元格数据
     *
     * @param comId 自定义组件的 Component ID
     * @param options 传递给自定义组件的配置参数
     * @return 自定义项对象，可直接赋值给数据字段
     */
    function customItem(comId, options = {}) {
        var o = {}
        o.comId = comId    // 组件引用
        o.options = options // 配置选项
        return o
    }

    /**
     * 获取指定行数据
     *
     * @param rowIndex 行索引（从0开始）
     * @return 行数据对象，如果索引无效返回 null
     */
    function getRow(rowIndex) {
        if(rowIndex >= 0 && rowIndex < table_view.rows) {
            return sourceModel.getRow(rowIndex)
        }
        return null
    }

    /**
     * 删除指定行
     *
     * @param rowIndex 起始行索引
     * @param rows 删除的行数（默认1行）
     */
    function removeRow(rowIndex, rows = 1) {
        if(rowIndex >= 0 && rowIndex < table_view.rows) {
            sourceModel.removeRow(rowIndex, rows)
        }
    }

    /**
     * 在指定位置插入行
     *
     * @param rowIndex 插入位置
     * @param obj 要插入的行数据对象
     */
    function insertRow(rowIndex, obj) {
        if(rowIndex >= 0 && rowIndex <= table_view.rows) {  // 允许插入到末尾
            sourceModel.insertRow(rowIndex, obj)
        }
    }

    /**
     * 获取当前选中行的索引
     *
     * 通过遍历比较 _key 字段来查找选中行的索引
     *
     * @return 选中行索引，未选中返回 -1
     */
    function currentIndex() {
        var index = -1
        if(!d.current) return index

        // 遍历所有行查找匹配的 _key
        for (var i = 0; i <= sourceModel.rowCount - 1; i++) {
            var sourceItem = sourceModel.getRow(i)
            if(sourceItem._key === d.current._key) {
                index = i
                break
            }
        }
        return index
    }

    /**
     * 在末尾添加行
     *
     * @param obj 要添加的行数据对象
     */
    function appendRow(obj) {
        sourceModel.appendRow(obj)
    }

    /**
     * 设置指定行数据
     *
     * @param rowIndex 行索引
     * @param obj 要设置的行数据对象
     */
    function setRow(rowIndex, obj) {
        if(rowIndex >= 0 && rowIndex < table_view.rows) {
            sourceModel.setRow(rowIndex, obj)
        }
    }

    /**
     * 组件宽度变化处理
     * 强制表格重新布局以适应新的宽度
     */
    onWidthChanged: {
        table_view.forceLayout()
    }
}
