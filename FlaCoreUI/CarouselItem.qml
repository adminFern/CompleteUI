import QtQuick
import QtQuick.Controls
import FlaCoreUI

QtObject {
    property int _idx
    property int cardWidth: 450
    property int cardHeight: 250
    property color cardColor: Theme.FillCardColor
    property string imagesource:""
    property bool visibleimage: true
    property Component delegate
}
