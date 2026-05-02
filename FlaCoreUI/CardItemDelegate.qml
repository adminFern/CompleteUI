import QtQuick
import FlaCoreUI

QtObject {
    property int _idx
    property string title               // 显示标题
    property color cardColor: "#f43f5e"
    property int cardWidth: 130
    property int cardHeight: 130
    property int radius: 10
    property Component delegate
}
