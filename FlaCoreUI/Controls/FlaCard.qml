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
    property int spacing: 18
    signal clicked(int index, var item)
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

    Flickable {
        id: flickable
        anchors.leftMargin: 2
        anchors.rightMargin: 2
        anchors.topMargin: 2
        anchors.bottomMargin: 2
        anchors.fill: parent
        clip: true

        // 发光 + hover 放大溢出余量（两侧各一份）
        property real _glowPadding: 24
        contentWidth: control.layout === FlaCard.LayoutType.Horizontal
                       ? _glowPadding + rowLayout.implicitWidth + _glowPadding : flickable.width
        contentHeight: control.layout === FlaCard.LayoutType.Vertical
                        ? _glowPadding + columnLayout.implicitHeight + _glowPadding : flickable.height

        flickableDirection: control.layout === FlaCard.LayoutType.Horizontal
                            ? Flickable.HorizontalFlick : Flickable.VerticalFlick



        // 水平布局
        Row {
            anchors.verticalCenter: parent.verticalCenter
            id: rowLayout
            x: flickable._glowPadding
            spacing: control.spacing
            visible: control.layout === FlaCard.LayoutType.Horizontal
            Repeater {
                model: d.handleItems()
                delegate: cardDelegate
            }
        }

        // 垂直布局
        Column {
            id: columnLayout
            y: flickable._glowPadding
            spacing: control.spacing
            visible: control.layout === FlaCard.LayoutType.Vertical
            Repeater {
                model: d.handleItems()
                delegate: cardDelegate
            }
        }

        Component {
            id: cardDelegate
            Item {
                id: cardRect
                width: modelData.cardWidth
                height: modelData.cardHeight
                property bool isHovered: false
                property bool isPressed: false

                Item {
                    id: cardContainer
                    anchors.fill: parent
                    anchors.leftMargin: 8
                    transform: Scale {
                        id: cardScale
                        origin.x: cardRect.width / 2
                        origin.y: cardRect.height / 2
                        xScale: cardRect.isPressed ? 0.95 : (cardRect.isHovered ? 1.05 : 1.0)
                        yScale: cardRect.isPressed ? 0.95 : (cardRect.isHovered ? 1.05 : 1.0)
                        Behavior on xScale {
                            NumberAnimation { duration: 200; easing.type: Easing.OutCubic }
                        }
                        Behavior on yScale {
                            NumberAnimation { duration: 200; easing.type: Easing.OutCubic }
                        }
                    }

                    Rectangle {
                        anchors.rightMargin: 8
                        z: 3
                        id: cardBackground
                        width: modelData.cardWidth
                        height: modelData.cardHeight
                        color: modelData.cardColor
                        radius: modelData.radius
                        border.color: modelData.borderVisible ? modelData.borderColor: "transparent"
                        border.width:  modelData.borderVisible ? 1 : 0

                        Loader {
                            z: 4
                            anchors.fill: parent
                            sourceComponent: modelData.delegate
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
                            onClicked: control.clicked(index, modelData)
                        }
                    }
                    RectangularGlow {
                        id: glow
                        z: 0
                        anchors.fill: cardBackground
                        glowRadius: 7
                        spread: 0.3
                        color: modelData.shadowColor
                        cornerRadius: cardBackground.radius
                        opacity: (cardRect.isHovered || cardRect.isPressed) ? 1 : 0.6
                        Behavior on opacity {
                            NumberAnimation { duration: 200; easing.type: Easing.OutCubic }
                        }
                    }
                }
            }
        }
    }
}
