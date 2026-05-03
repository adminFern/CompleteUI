import QtQuick
import QtQuick.Controls

// 导航项定义：用于 ComNavigationView 的普通导航项
// 通过 page 属性驱动 StackView 页面切换
QtObject {
    property int _idx               // 内部索引，由 NavigationView 自动分配
    property int cardWidth: 450
    property int cardHeight: 250
    property int radius: 10
    property string imagesource:""
    property Component delegate
}
