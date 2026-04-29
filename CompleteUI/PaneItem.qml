import QtQuick
import QtQuick.Controls

// 导航项定义：用于 ComNavigationView 的普通导航项
// 通过 page 属性驱动 StackView 页面切换
QtObject {
    property int _idx               // 内部索引，由 NavigationView 自动分配
    property var _ext               // 扩展数据
    property var _parent            // 父级引用（用于二级菜单回溯）
    property bool visible: true     // 是否可见
    property string title           // 显示标题
    property string page            // 目标页面 URL（qrc:/qml/xxx.qml）
    property bool disabled: false   // 是否禁用
    property string icon            // 图标（FluentIcon.ico_xxx）
}
