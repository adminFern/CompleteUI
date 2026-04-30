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
    property int layout: FlaCards.LayoutType.Horizontal
    property int spacing: 20
    property int cardRadius: 15
    property int animationDuration: 400

    signal cardClicked(int index, var item)

    QtObject {
        id: d
        property int hoveredIndex: -1
        property var pressedItem: null

        function handleItems() {
            var data = []
            if (items) {
                for (var i = 0; i < items.children.length; i++) {
                    var item = items.children[i]
                    if (item.visible !== true) continue
                    item._idx = i
                    data.push(item)
                }
            }
            return data
        }
    }

    Flickable {
        id: flickable
        anchors.fill: parent
        clip: true
        contentWidth: control.layout === FlaCard.LayoutType.Horizontal
                       ? contentRow.implicitWidth + 20
                       : flickable.width
        contentHeight: control.layout === FlaCard.LayoutType.Vertical
                        ? contentColumn.implicitHeight + 20
                        : flickable.height
        boundsBehavior: Flickable.DragAndOvershootBounds

        Item {
            id: container
            anchors.fill: parent
            Row {
                id: contentRow
                visible: control.layout === FlaCard.LayoutType.Horizontal
                y: (container.height - contentRow.implicitHeight) / 2
                spacing: control.spacing

                Item { width: 10; height: 1 }

                Repeater { model: d.handleItems(); delegate: cardDelegate }

                Item { width: 10; height: 1 }
            }

            Column {
                id: contentColumn
                visible: control.layout === FlaCard.LayoutType.Vertical
                x: (container.width - contentColumn.implicitWidth) / 2
                spacing: control.spacing

                Item { width: 1; height: 10 }

                Repeater { model: d.handleItems(); delegate: cardDelegate }

                Item { width: 1; height: 10 }
            }
        }


    }

    Component {
        id: cardDelegate
        Rectangle {
            id: card
            required property var modelData
            required property int index

            width: modelData.cardWidth
            height: modelData.cardHeight
            radius: control.cardRadius
            color: modelData.cardColor
            transformOrigin: Item.Center

            readonly property bool isSelfHovered: mouseArea.containsMouse
            property bool isPressed: d.pressedItem === this

            scale: {
                if (isPressed) return 0.98
                if (d.hoveredIndex !== -1 && d.hoveredIndex !== index) return 0.96
                if (isSelfHovered) return 1.05
                return 1.0
            }

            RectangularGlow {
                anchors.fill: card
                glowRadius: 6
                spread: 0.2
                color: modelData.cardColor
                cornerRadius: cardRadius + glowRadius
                opacity: !isPressed ? 0.6 : 0
                visible: opacity > 0
                z: -1
                Behavior on opacity { NumberAnimation { duration: 200; easing.type: Easing.OutQuad } }
            }

            Behavior on scale {
                NumberAnimation {
                    duration: control.animationDuration
                    easing.type: Easing.InOutCubic
                }
            }

            MouseArea {
                id: mouseArea
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                preventStealing: false

                onEntered: {
                    d.hoveredIndex = card.index
                }
                onExited: {
                    if (d.hoveredIndex === card.index) {
                        d.hoveredIndex = -1
                    }
                }
                onClicked: {
                    control.cardClicked(card.index, modelData)
                }
                onPressedChanged: {
                    if (pressed) {
                        d.pressedItem = card
                    } else if (d.pressedItem === card) {
                        d.pressedItem = null
                    }
                }
            }

            Loader {
                anchors.centerIn: parent
                sourceComponent: modelData.delegate
                property var model: modelData
                property int index: card.index
            }
        }
    }
}
