import QtQuick
import QtQuick.Controls
import FlaCoreUI

// 阴影组件：通过多层叠加的边框矩形模拟阴影效果
Item {
    property color color: Theme.isDark ? "#000000" : "#999999"   // 阴影颜色
    property int elevation: 5        // 阴影层数（越大越明显）
    property int radius: 4           // 圆角半径

    id: control
    anchors.fill: parent

    // 根据 elevation 层数叠加矩形模拟阴影
    Repeater {
        model: elevation
        Rectangle {
            anchors.fill: parent
            color: "#00000000"
            opacity: 0.01 * (elevation - index + 1)    // 越外层越透明
            anchors.margins: -index                     // 向外扩展
            radius: control.radius + index              // 圆角随层级增大
            border.width: index
            border.color: control.color
        }
    }
}
