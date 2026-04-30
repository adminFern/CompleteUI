import QtQuick
import QtQuick.Controls

// 页脚项定义：用于 ComNavigationView 底部区域
QtObject {
    property int _idx               // 内部索引
    property bool visible: true     // 是否可见
    property string title           // 显示标题
    property string icon            // 图标
    property bool disabled: false   // 是否禁用
}
