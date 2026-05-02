import QtQuick
import FlaCoreUI

QtObject {
    property int _idx
    property string icon
    property string title
    property color color: Theme.PrimaryColor
    property color iconColor: "white"
    property bool visible: true
    property bool disabled: false
}
