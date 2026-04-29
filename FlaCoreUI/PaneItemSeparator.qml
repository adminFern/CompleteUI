import QtQuick
import CompleteUI

// 导航分隔符：在导航列表中显示分隔线
QtObject {
    property int _idx                   // 内部索引
    property bool visible: true         // 是否可见
    property int xoffset: 4             // 左右边距
    property color dividercolor: Theme.DividerColor  // 分隔线颜色
}
