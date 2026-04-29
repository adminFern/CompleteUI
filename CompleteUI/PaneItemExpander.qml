import QtQuick
import QtQuick.Controls

// 可展开分组项：继承 Objects，支持嵌套子项
// 点击可展开/折叠其子菜单项
Objects {
    property int _idx                   // 内部索引
    property bool visible: true         // 是否可见
    property string title               // 显示标题
    property string icon                // 图标
    property bool disabled: false       // 是否禁用
    property bool isExpand: false       // 是否展开状态
}
