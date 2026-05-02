import QtQuick
import FlaCoreUI

QtObject {
    property int _idx
    property color cardColor: "#f43f5e"
    property color shadowColor: Theme.isDark?"#4D000000" : "#1A000000"
    property int cardWidth: 130
    property int cardHeight: 130
    property int radius: 10
    property color borderColor: Theme.FillBorderColor
    property bool borderVisible: true
    property Component delegate

}
