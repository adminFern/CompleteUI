import QtQuick
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
    property int cardRadius: 10
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
        contentWidth: control.layout === FlaCards.LayoutType.Horizontal
                       ? contentRow.implicitWidth + control.spacing
                       : flickable.width
        contentHeight: control.layout === FlaCards.LayoutType.Vertical
                        ? contentColumn.implicitHeight + control.spacing
                        : flickable.height
        boundsBehavior: Flickable.StopAtBounds

        Row {
            id: contentRow
            visible: control.layout === FlaCards.LayoutType.Horizontal
            y: (flickable.height - contentRow.implicitHeight) / 2
            spacing: control.spacing
            Repeater { model: d.handleItems(); delegate: cardDelegate }
        }

        Column {
            id: contentColumn
            visible: control.layout === FlaCards.LayoutType.Vertical
            x: (flickable.width - contentColumn.implicitWidth) / 2
            spacing: control.spacing
            Repeater { model: d.handleItems(); delegate: cardDelegate }
        }

        FlaScrollBar.horizontal: FlaScrollBar {
            policy: control.layout === FlaCards.LayoutType.Horizontal ? ScrollBar.AsNeeded : ScrollBar.AlwaysOff
        }

        FlaScrollBar.vertical: FlaScrollBar {
            policy: control.layout === FlaCards.LayoutType.Vertical ? ScrollBar.AsNeeded : ScrollBar.AlwaysOff
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

            readonly property bool isSelfHovered: hoverHandler.hovered
            readonly property bool shouldBlur: d.hoveredIndex !== -1 && d.hoveredIndex !== index && isSelfHovered === false
            property bool isPressed: d.pressedItem === this

            scale: {
                if (isPressed) return 0.95
                if (d.hoveredIndex !== -1 && d.hoveredIndex !== index) return 0.9
                if (isSelfHovered) return 1.1
                return 1.0
            }

            layer.enabled: shouldBlur
            layer.effect: FastBlur {
                radius: 64
                transparentBorder: true
            }

            Behavior on scale {
                NumberAnimation {
                    duration: control.animationDuration
                    easing.type: Easing.InOutCubic
                }
            }

            HoverHandler {
                id: hoverHandler
                cursorShape: Qt.PointingHandCursor
                onHoveredChanged: {
                    if (hovered) {
                        d.hoveredIndex = card.index
                    } else if (d.hoveredIndex === card.index) {
                        d.hoveredIndex = -1
                    }
                }
            }

            TapHandler {
                onPressedChanged: {
                    if (pressed) {
                        d.pressedItem = card
                    } else if (d.pressedItem === card) {
                        d.pressedItem = null
                    }
                }
                onTapped: {
                    control.cardClicked(card.index, modelData)
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
