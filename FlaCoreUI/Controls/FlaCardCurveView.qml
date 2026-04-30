import QtQuick
import Qt5Compat.GraphicalEffects
import FlaCoreUI

Item {
    id: root

    property Objects items
    property real cardWidth: 200
    property real cardHeight: 300
    property real waveAmplitude: 120
    property real spacing: 20
    property bool isHovered: false
    property real viewOffset: 0
    property real maxOffset: 0
    property int restoreDelay: 3000
    property int animationDuration: 800
    property var wavePeaks: []

    signal cardClicked(int index, var item)

    QtObject {
        id: d
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
    }

    function getTotalWidth() {
        var totalCards = d.getItemCount()
        return totalCards * cardWidth + (totalCards - 1) * spacing
    }

    function updateMaxOffset() {
        var totalWidth = getTotalWidth()
        maxOffset = Math.max(0, totalWidth - root.width + 40)
    }

    function enterCardZone() {
        restoreTimer.stop()
        isHovered = true
        updateMaxOffset()
    }

    function leaveCardZone() {
        restoreTimer.restart()
    }

    function activityInZone() {
        if (isHovered) {
            restoreTimer.restart()
        }
    }

    function getCardPosition(index, totalCards) {
        if (isHovered) {
            var totalWidth = getTotalWidth()
            var startX = (root.width - totalWidth) / 2 + viewOffset
            return {
                x: startX + index * (cardWidth + spacing),
                y: (root.height - cardHeight) / 2,
                rotation: 0
            }
        } else {
            var startX = root.width * 0.05
            var availableWidth = root.width * 0.9
            var stepX = (totalCards > 1) ? availableWidth / (totalCards - 1) : 0
            var x = startX + stepX * index
            var baseY = root.height * 0.5 - cardHeight / 2
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
        updateMaxOffset()
    }

    function refreshWave() {
        if (!isHovered) {
            generateRandomWave()
        }
    }

    Rectangle {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 5
        width: 240
        height: 28
        radius: 14
        color: {
            if (restoreTimer.running) return "#E67E22"
            else if (isHovered) return "#27AE60"
            else return "#3498DB"
        }
        opacity: isHovered || restoreTimer.running ? 0.9 : 0.6

        Behavior on opacity {
            NumberAnimation { duration: 300 }
        }

        Text {
            anchors.centerIn: parent
            text: {
                if (restoreTimer.running) {
                    return "⏱ 将在 " + Math.ceil(restoreTimer.remainingTime / 1000) + " 秒后恢复波浪排列"
                } else if (isHovered) {
                    return "✓ 水平展开中（操作会重置计时）剩余卡片: " + d.getItemCount()
                } else {
                    return "🌊 波浪排列 (振幅: " + Math.round(waveAmplitude) + "px)"
                }
            }
            font.pixelSize: 12
            color: "white"
            font.bold: true
        }

        Rectangle {
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            width: restoreTimer.running ?
                   parent.width * (1 - restoreTimer.remainingTime / restoreDelay) : 0
            radius: parent.radius
            color: "#2ECC71"
            visible: restoreTimer.running

            Behavior on width {
                NumberAnimation { duration: 1000 }
            }
        }
    }

    Rectangle {
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.margins: 10
        width: 110
        height: 30
        radius: 15
        color: "#80000000"
        visible: !isHovered && !restoreTimer.running

        Text {
            anchors.centerIn: parent
            text: "🔄 随机波浪"
            font.pixelSize: 12
            color: "white"
        }

        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            onClicked: {
                generateRandomWave()
            }
        }
    }

    Rectangle {
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.margins: 10
        width: 90
        height: 30
        radius: 15
        color: "#E74C3C"
        visible: isHovered || restoreTimer.running

        Text {
            anchors.centerIn: parent
            text: "强制恢复"
            font.pixelSize: 12
            color: "white"
            font.bold: true
        }

        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            onClicked: {
                restoreTimer.stop()
                forceRestore()
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

        onEntered: {
        }
    }

    MouseArea {
        id: dragArea
        anchors.fill: parent
        enabled: isHovered
        hoverEnabled: true

        property real lastX: 0

        onPressed: function(mouse) {
            lastX = mouse.x
            activityInZone()
        }

        onPositionChanged: function(mouse) {
            if (isHovered) {
                var delta = mouse.x - lastX
                var newOffset = viewOffset + delta

                if (newOffset > 0) {
                    viewOffset = 0
                } else if (newOffset < -maxOffset) {
                    viewOffset = -maxOffset
                } else {
                    viewOffset = newOffset
                }

                lastX = mouse.x
            }
        }

        onWheel: function(wheel) {
            if (isHovered) {
                activityInZone()

                var delta = wheel.angleDelta.y / 2
                var newOffset = viewOffset + delta

                if (newOffset > 0) {
                    viewOffset = 0
                } else if (newOffset < -maxOffset) {
                    viewOffset = -maxOffset
                } else {
                    viewOffset = newOffset
                }
            }
        }
    }

    Rectangle {
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.verticalCenter: parent.verticalCenter
        width: 40
        height: 40
        radius: 20
        color: "#40000000"
        visible: isHovered && viewOffset < 0

        Text {
            anchors.centerIn: parent
            text: "‹"
            font.pixelSize: 24
            color: "white"
        }

        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            onClicked: {
                activityInZone()
                var newOffset = viewOffset + 300
                if (newOffset > 0) {
                    viewOffset = 0
                } else {
                    viewOffset = newOffset
                }
            }
        }
    }

    Rectangle {
        anchors.right: parent.right
        anchors.rightMargin: 10
        anchors.verticalCenter: parent.verticalCenter
        width: 40
        height: 40
        radius: 20
        color: "#40000000"
        visible: isHovered && viewOffset > -maxOffset

        Text {
            anchors.centerIn: parent
            text: "›"
            font.pixelSize: 24
            color: "white"
        }

        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            onClicked: {
                activityInZone()
                var newOffset = viewOffset - 300
                if (newOffset < -maxOffset) {
                    viewOffset = -maxOffset
                } else {
                    viewOffset = newOffset
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
                    property int index: cardItem.index
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

                    onEntered: {
                        enterCardZone()
                        cardItem.scale = 1.08
                    }

                    onExited: {
                        cardItem.scale = 1.0
                        leaveCardZone()
                    }

                    onClicked: {
                        activityInZone()
                        if (cardData) {
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