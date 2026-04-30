import QtQuick
import Qt5Compat.GraphicalEffects
import FlaCoreUI

Item {
    id: control

    property Objects items
    property real cardWidth: 200
    property real cardHeight: 300
    property real waveAmplitude: 120
    property real spacing: 20
    property int animationDuration: 800
    property int restoreDelay: 3000
    property var wavePeaks: []

    property bool isHovered: false
    property real viewOffset: 0

    signal cardClicked(int index, var item)

    QtObject {
        id: d
        property bool dragging: false
        function getItemCount() {
            return items ? items.children.length : 0
        }
    }

    Timer {
        id: restoreTimer
        interval: restoreDelay
        repeat: false
        running: false
        onTriggered: {
            forceRestore()
        }
    }

    function forceRestore() {
        isHovered = false
        viewOffset = 0
        console.log("[FlaCardCurveView] forceRestore")
    }

    function generateRandomWave() {
        wavePeaks = []
        var totalCards = d.getItemCount()
        if (totalCards === 0) return

        var randomSeed = Math.random() * 100

        for (var i = 0; i < totalCards; i++) {
            var t = i / (totalCards - 1)
            var sinWave = Math.sin(t * Math.PI * 2 + randomSeed) * 0.5
            var randomNoise = (Math.random() - 0.5) * 0.8
            var cosWave = Math.cos(t * Math.PI * 3 + randomSeed * 2) * 0.3
            var positionWeight = Math.sin(t * Math.PI)
            var waveValue = (sinWave + randomNoise + cosWave) * positionWeight
            wavePeaks.push(waveValue * waveAmplitude)
        }
        console.log("[FlaCardCurveView] generateRandomWave:", wavePeaks.map(function(v) { return Math.round(v) }).join(", "))
    }

    function getTotalWidth() {
        var totalCards = d.getItemCount()
        return totalCards * cardWidth + (totalCards - 1) * spacing
    }

    function getWaveSpacing() {
        var n = d.getItemCount()
        if (n <= 1) return 0
        var available = Math.max(0, control.width * 0.85 - cardWidth)
        var s = available / (n - 1) - cardWidth
        return Math.max(-cardWidth * 0.5, Math.min(20, s))
    }

    function getExpandOffset() {
        var totalWidth = getTotalWidth()
        if (totalWidth <= control.width) return 0
        var padding = 20
        return (totalWidth - control.width) / 2 + padding
    }

    function enterCardZone() {
        restoreTimer.stop()
        isHovered = true
        console.log("[FlaCardCurveView] enterCardZone, isHovered:", isHovered)
    }

    function leaveCardZone() {
        restoreTimer.restart()
        console.log("[FlaCardCurveView] leaveCardZone, restoreTimer running:", restoreTimer.running)
    }

    function activityInZone() {
        if (isHovered) {
            restoreTimer.restart()
        }
    }

    function clampOffset(offset) {
        if (!isHovered) return 0
        var limit = getExpandOffset()
        if (limit <= 0) return 0
        return Math.max(-limit, Math.min(limit, offset))
    }

    function getCardPosition(index, totalCards) {
        if (isHovered) {
            var totalWidth = getTotalWidth()
            var startX = (control.width - totalWidth) / 2 + viewOffset
            return {
                x: startX + index * (cardWidth + spacing),
                y: (control.height - cardHeight) / 2,
                rotation: 0
            }
        } else {
            var stepX = cardWidth + getWaveSpacing()
            var totalSpan = stepX * (totalCards - 1)
            var visualWidth = totalSpan + cardWidth
            var startX = (control.width - visualWidth) / 2
            var x = startX + stepX * index
            var baseY = control.height * 0.5 - cardHeight / 2
            var waveY = (index < wavePeaks.length) ? wavePeaks[index] : 0
            var y = baseY + waveY

            var rotation = 0
            if (totalCards > 1 && wavePeaks.length > 0) {
                if (index === 0) {
                    var nextY = (1 < wavePeaks.length) ? wavePeaks[1] : 0
                    rotation = Math.atan2(nextY - waveY, stepX) * 180 / Math.PI * 0.5
                } else if (index === totalCards - 1) {
                    var prevY = (index - 1 < wavePeaks.length) ? wavePeaks[index - 1] : 0
                    rotation = Math.atan2(waveY - prevY, stepX) * 180 / Math.PI * 0.5
                } else {
                    var prevY2 = wavePeaks[index - 1] || 0
                    var nextY2 = wavePeaks[index + 1] || 0
                    rotation = Math.atan2(nextY2 - prevY2, stepX * 2) * 180 / Math.PI * 0.5
                }
            }

            return {
                x: x,
                y: y,
                rotation: rotation
            }
        }
    }

    Component.onCompleted: {
        generateRandomWave()
        console.log("[FlaCardCurveView] Component.onCompleted, itemCount:", d.getItemCount())
    }

    function refreshWave() {
        if (!isHovered) {
            generateRandomWave()
        }
    }

    MouseArea {
        id: wheelArea
        anchors.fill: parent
        acceptedButtons: Qt.NoButton
        hoverEnabled: true

        onWheel: function(wheel) {
            if (isHovered) {
                activityInZone()
                viewOffset = clampOffset(viewOffset + wheel.angleDelta.y / 2)
            }
        }
    }

    MouseArea {
        id: rootArea
        anchors.fill: parent
        hoverEnabled: true
        z: -1

        onExited: {
            if (isHovered || restoreTimer.running) {
                if (!restoreTimer.running) {
                    restoreTimer.restart()
                }
            }
        }
    }

    Item {
        id: cardsContainer
        anchors.fill: parent

        Repeater {
            id: cardRepeater
            model: d.getItemCount()

            delegate: Item {
                id: cardItem
                width: cardWidth
                height: cardHeight

                property var cardData: items ? items.children[index] : null
                property var cardPos: getCardPosition(index, d.getItemCount())

                x: cardPos.x
                y: cardPos.y
                rotation: cardPos.rotation

                Rectangle {
                    id: cardBackground
                    anchors.fill: parent
                    radius: 12
                    color: cardData ? cardData.cardColor : "#CCCCCC"
                }

                Loader {
                    anchors.centerIn: parent
                    sourceComponent: cardData ? cardData.delegate : null
                    property var model: cardData
                    property int index: index
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

                Behavior on x {
                    enabled: !d.dragging
                    NumberAnimation {
                        duration: animationDuration
                        easing.type: Easing.InOutCubic
                    }
                }

                Behavior on y {
                    NumberAnimation {
                        duration: animationDuration
                        easing.type: Easing.InOutCubic
                    }
                }

                Behavior on rotation {
                    NumberAnimation {
                        duration: animationDuration
                        easing.type: Easing.InOutCubic
                    }
                }

                MouseArea {
                    id: cardHoverArea
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor

                    property real pressX: 0

                    onPressed: function(mouse) {
                        pressX = mouse.x
                        d.dragging = false
                        activityInZone()
                    }

                    onPositionChanged: function(mouse) {
                        if (pressed && isHovered) {
                            var dx = mouse.x - pressX
                            if (Math.abs(dx) > 5 && !d.dragging) {
                                d.dragging = true
                            }
                            if (d.dragging) {
                                viewOffset = clampOffset(viewOffset + dx)
                                pressX = mouse.x
                            }
                        }
                    }

                    onReleased: {
                        d.dragging = false
                    }

                    onEntered: {
                        enterCardZone()
                        if (!d.dragging) {
                            cardItem.scale = 1.05
                        }
                    }

                    onExited: {
                        cardItem.scale = 1.0
                        leaveCardZone()
                    }

                    onClicked: {
                        if (!d.dragging && cardData) {
                            control.cardClicked(index, cardData)
                        }
                    }
                }

                Behavior on scale {
                    NumberAnimation {
                        duration: 250
                        easing.type: Easing.OutBack
                    }
                }

                z: cardHoverArea.containsMouse ? 1 : 0
            }
        }
    }
}