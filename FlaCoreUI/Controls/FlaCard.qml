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
    property int spacing: 10
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
        cacheBuffer: control.layout === FlaCard.LayoutType.Horizontal
                     ? ist.width * 2 : ist.height * 2
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
                z:1
                id: cardBackground
                width: modelData.cardWidth
                height: modelData.cardHeight
                color: modelData.cardColor
                radius: modelData.radius
                Loader {
                    z:3
                    anchors.fill: parent
                    sourceComponent: modelData.delegate
                }

            }
            RectangularGlow {
                id: glow
                z: 0  // 放在矩形后面
                anchors.fill: cardBackground
                glowRadius: 8          // 发光半径
                spread: 0.3            // 发光的扩散程度 (0.0 - 1.0)
                color:Theme.isDark?"#4D000000" : "#1A000000" //Theme.PrimaryColor      // 发光颜色   "#4D000000" : "#1A000000"
                cornerRadius: cardBackground.radius  // 圆角要与矩形一致
                opacity: (cardRect.isHovered || cardRect.isPressed) ? 1 : 0.6  // 根据悬停/按压状态变化透明度
                Behavior on opacity {
                    NumberAnimation { duration: 200; easing.type: Easing.OutCubic }
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
