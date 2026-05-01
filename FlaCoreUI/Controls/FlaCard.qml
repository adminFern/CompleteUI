import QtQuick
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
import FlaCoreUI

Item {
    id: control
    enum LayoutType {
        Horizontal = 0,
        Vertical = 1
    }
    property Objects items
    property int layout: FlaCard.LayoutType.Horizontal
    property int spacing: 2
    QtObject {
        id: d
        property int hoveredIndex: -1
        property var pressedItem: null
        function handleItems() {
            var data = []
            if (items) {
                for (var i = 0; i < items.children.length; i++) {
                    var item = items.children[i]
                    item._idx = i

                    console.log(item.title)
                    data.push(item)
                }
            }
            return data
        }
    }
    ListView {

        id: ist
        anchors.leftMargin: 5
        anchors.rightMargin: 5
        anchors.topMargin: 5
        anchors.bottomMargin: 5
        anchors.fill: parent
        model: d.handleItems()
        currentIndex: -1
        reuseItems: true
        interactive: true
        clip: false
        spacing: control.spacing
        orientation: control.layout === FlaCard.LayoutType.Horizontal
                     ? ListView.Horizontal : ListView.Vertical

        delegate: Item {
            id: cardRect
            width:  modelData.cardWidth + 5
            height: modelData.cardHeight + 5
            property bool isHovered: false
            property bool isPressed: false

            Rectangle{
              id: cardBackground
              anchors.centerIn: parent
              width: modelData.cardWidth
              height: modelData.cardHeight
              color: modelData.cardColor
              radius: modelData.radius
              Loader {
                 anchors.fill: parent
               //  anchors.margins: 4
                  sourceComponent: modelData.delegate
              }
            }
            //Loader
            //加载标题
            Loader{
                 anchors.top: cardBackground.bottom
                 anchors.horizontalCenter: parent.horizontalCenter
                 anchors.topMargin: 2
                 active: modelData.title!==""
                 visible: active
                 sourceComponent:  Text {
                    text: modelData.title
                    font.pixelSize: 11
            }
           }



                transform: Scale {
                id: cardScale
                origin.x: cardRect.width / 2
                origin.y: cardRect.height / 2
                xScale: cardRect.isPressed ? 0.95 : (cardRect.isHovered ? 1.05 : 1.0)
                yScale: cardRect.isPressed ? 0.95 : (cardRect.isHovered ? 1.05 : 1.0)
                Behavior on xScale {
                    NumberAnimation {
                        duration: 200
                        easing.type: Easing.OutCubic
                    }
                }
                Behavior on yScale {
                    NumberAnimation {
                        duration: 200
                        easing.type: Easing.OutCubic
                    }
                }
            }
            DropShadow {
                anchors.fill: cardBackground
                horizontalOffset: 3
                verticalOffset: 5
                radius: 10
                samples: 21
                color: "#50000000"
                spread: 0.1
                source: cardBackground
                cached: true
            }

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onEntered: cardRect.isHovered = true
                onExited: {
                    cardRect.isHovered = false
                    cardRect.isPressed = false
                }
                onPressed: cardRect.isPressed = true
                onReleased: cardRect.isPressed = false
            }
        }
    }
}
