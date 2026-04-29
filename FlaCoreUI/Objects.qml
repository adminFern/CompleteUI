import QtQuick
import QtQuick.Controls

// 通用容器对象，用于导航栏 items/footerItems 的子项包裹
// 支持通过 children 属性嵌套多个 PaneItem 子项
QtObject {
    default property list<QtObject> children
    id: control
}
