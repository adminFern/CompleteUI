import QtQuick
import QtQuick.Layouts
import CompleteUI

Item {
    id: control

    enum Direction {
        Vertical,
        Horizontal
    }

    // ===== 公开属性 =====
    property alias model: vRepeater.model
    property int orientation: ComTimeline.Direction.Vertical
    property color lineColor: Theme.isDark ? Qt.rgba(1, 1, 1, 0.12) : Qt.rgba(0, 0, 0, 0.12)
    property color activeLineColor: Theme.PrimaryColor
    property color dotColor: Theme.isDark ? Qt.rgba(1, 1, 1, 0.25) : Qt.rgba(0, 0, 0, 0.25)
    property color activeDotColor: Theme.PrimaryColor
    property color titleColor: Theme.Textcolor
    property color subTitleColor: Theme.isDark ? "#9CA3AF" : "#6B7280"
    property color timeColor: Theme.isDark ? "#6B7280" : "#9CA3AF"
    property color activeTimeColor: Theme.PrimaryColor
    property int dotSize: 12
    property int lineWidth: 2
    property int leftMargin: 16
    property int timeWidth: 100
    property int spacing: 24
    property int currentIndex: 0
    property int titleFontSize: 14
    property int subTitleFontSize: 12
    property int timeFontSize: 12
    property string activeIcon: FluentIcon.ico_CheckMark
    property bool showIcon: true

    // 水平模式每项宽度
    property int horizontalItemWidth: 120

    implicitWidth: orientation === ComTimeline.Direction.Vertical ? 300 : (vRepeater.count * (horizontalItemWidth + spacing))
    implicitHeight: orientation === ComTimeline.Direction.Vertical ? vColumn.implicitHeight : hRow.implicitHeight
    height: implicitHeight

    // ========================================================
    //  垂直布局
    // ========================================================
    Column {
        id: vColumn
        width: parent.width
        spacing: 0
        visible: control.orientation === ComTimeline.Direction.Vertical

        Repeater {
            id: vRepeater

            delegate: Item {
                id: vDelegate
                width: vColumn.width
                height: vContentRow.height + (index < vRepeater.count - 1 ? control.spacing : 0)

                readonly property bool isActive: index <= control.currentIndex
                readonly property bool isCurrent: index === control.currentIndex

                // 圆点中心 Y，与标题文字中心对齐
                readonly property real dotCenterY: vTitleText.implicitHeight / 2

                // ---- 内容行 ----
                Row {
                    id: vContentRow
                    width: parent.width
                    spacing: 0

                    // 左侧时间
                    Column {
                        id: vTimeCol
                        width: control.timeWidth
                        spacing: 2

                        Text {
                            text: model.date || ""
                            font.pixelSize: control.timeFontSize
                            font.family: Theme.defaultFontFamily
                            font.weight: vDelegate.isActive ? Font.Bold : Font.Normal
                            color: vDelegate.isActive ? control.activeTimeColor : control.timeColor
                            horizontalAlignment: Text.AlignRight
                            width: parent.width - control.dotSize / 2 - 10
                            topPadding: Math.max(0, (control.titleFontSize - control.timeFontSize) / 2)
                        }

                        Text {
                            text: model.time || ""
                            font.pixelSize: control.timeFontSize - 1
                            font.family: Theme.defaultFontFamily
                            color: vDelegate.isActive ? control.activeTimeColor : control.timeColor
                            horizontalAlignment: Text.AlignRight
                            width: parent.width - control.dotSize / 2 - 10
                            visible: text !== ""
                        }
                    }

                    // 轴线占位
                    Item {
                        width: control.dotSize + 12
                        height: vContentCol.height
                    }

                    // 右侧内容
                    Column {
                        id: vContentCol
                        width: vDelegate.width - vTimeCol.width - control.dotSize - 12 - 8
                        leftPadding: 8
                        spacing: 2

                        Text {
                            id: vTitleText
                            text: model.title || ""
                            font.pixelSize: control.titleFontSize
                            font.family: Theme.defaultFontFamily
                            font.weight: vDelegate.isActive ? Font.Bold : Font.Normal
                            color: vDelegate.isActive ? control.activeDotColor : control.titleColor
                            wrapMode: Text.WordWrap
                            maximumLineCount: 2
                            width: parent.width - parent.leftPadding
                        }

                        Text {
                            text: model.subTitle || ""
                            font.pixelSize: control.subTitleFontSize
                            font.family: Theme.defaultFontFamily
                            color: control.subTitleColor
                            width: parent.width - parent.leftPadding
                            visible: text !== ""
                            wrapMode: Text.WordWrap
                            maximumLineCount: 3
                        }
                    }
                }

                // ---- 上方线段（从 delegate 顶部到圆点中心）----
                Rectangle {
                    x: control.timeWidth + 6 + control.dotSize / 2 - control.lineWidth / 2
                    y: 0
                    width: control.lineWidth
                    height: vDelegate.dotCenterY
                    color: vDelegate.isActive ? control.activeLineColor : control.lineColor
                    visible: index > 0
                }

                // ---- 下方线段（从圆点中心到 delegate 底部）----
                Rectangle {
                    x: control.timeWidth + 6 + control.dotSize / 2 - control.lineWidth / 2
                    y: vDelegate.dotCenterY
                    width: control.lineWidth
                    height: vDelegate.height - vDelegate.dotCenterY
                    color: index < control.currentIndex ? control.activeLineColor : control.lineColor
                    visible: index < vRepeater.count - 1
                }

                // ---- 圆点 ----
                Rectangle {
                    id: vDot
                    x: control.timeWidth + 6
                    y: vDelegate.dotCenterY - control.dotSize / 2
                    width: control.dotSize
                    height: control.dotSize
                    radius: width / 2
                    color: vDelegate.isActive ? control.activeDotColor : control.dotColor
                    border.width: vDelegate.isActive ? 0 : 2
                    border.color: vDelegate.isActive ? "transparent" : control.dotColor

                    // 激活图标
                    Text {
                        anchors.centerIn: parent
                        text: control.activeIcon
                        font.family: FluentIcon.fontLoader.name
                        font.pixelSize: control.dotSize * 0.6
                        font.bold: true
                        color: "white"
                        visible: vDelegate.isActive && control.showIcon
                    }

                    // 当前项脉冲动画
                    Rectangle {
                        anchors.centerIn: parent
                        width: control.dotSize + 8
                        height: control.dotSize + 8
                        radius: width / 2
                        color: "transparent"
                        border.width: 2
                        border.color: Theme.setColorAlpha(control.activeDotColor, 80)
                        visible: vDelegate.isCurrent

                        SequentialAnimation on opacity {
                            running: vDelegate.isCurrent
                            loops: Animation.Infinite
                            NumberAnimation { from: 1; to: 0; duration: 1500; easing.type: Easing.OutCubic }
                            NumberAnimation { from: 0; to: 1; duration: 0 }
                            PauseAnimation { duration: 500 }
                        }
                    }

                    Behavior on color { ColorAnimation { duration: 200 } }
                    Behavior on border.color { ColorAnimation { duration: 200 } }
                }
            }
        }
    }

    // ========================================================
    //  水平布局
    // ========================================================
    Row {
        id: hRow
        height: parent.height
        spacing: 0
        visible: control.orientation === ComTimeline.Direction.Horizontal

        Repeater {
            id: hRepeater
            model: vRepeater.model

            delegate: Item {
                id: hDelegate
                width: control.horizontalItemWidth + (index < hRepeater.count - 1 ? control.spacing : 0)
                height: hRow.height

                readonly property bool isActive: index <= control.currentIndex
                readonly property bool isCurrent: index === control.currentIndex

                // 圆点中心 X
                readonly property real dotCenterX: control.horizontalItemWidth / 2

                // ---- 内容列 ----
                Column {
                    id: hItemCol
                    x: 0
                    width: control.horizontalItemWidth
                    height: parent.height
                    spacing: 0

                    // 上方时间
                    Column {
                        id: hTimeCol
                        width: parent.width
                        spacing: 0

                        Text {
                            text: model.date || ""
                            font.pixelSize: control.timeFontSize
                            font.family: Theme.defaultFontFamily
                            font.weight: hDelegate.isActive ? Font.Bold : Font.Normal
                            color: hDelegate.isActive ? control.activeTimeColor : control.timeColor
                            horizontalAlignment: Text.AlignHCenter
                            width: parent.width
                        }

                        Text {
                            text: model.time || ""
                            font.pixelSize: control.timeFontSize - 1
                            font.family: Theme.defaultFontFamily
                            color: hDelegate.isActive ? control.activeTimeColor : control.timeColor
                            horizontalAlignment: Text.AlignHCenter
                            width: parent.width
                            visible: text !== ""
                        }
                    }

                    // 轴线占位
                    Item {
                        width: parent.width
                        height: control.dotSize + 8

                        // 圆点
                        Rectangle {
                            id: hDot
                            anchors.centerIn: parent
                            width: control.dotSize
                            height: control.dotSize
                            radius: width / 2
                            color: hDelegate.isActive ? control.activeDotColor : control.dotColor
                            border.width: hDelegate.isActive ? 0 : 2
                            border.color: hDelegate.isActive ? "transparent" : control.dotColor

                            Text {
                                anchors.centerIn: parent
                                text: control.activeIcon
                                font.family: FluentIcon.fontLoader.name
                                font.pixelSize: control.dotSize * 0.6
                                font.bold: true
                                color: "white"
                                visible: hDelegate.isActive && control.showIcon
                            }

                            Rectangle {
                                anchors.centerIn: parent
                                width: control.dotSize + 8
                                height: control.dotSize + 8
                                radius: width / 2
                                color: "transparent"
                                border.width: 2
                                border.color: Theme.setColorAlpha(control.activeDotColor, 80)
                                visible: hDelegate.isCurrent

                                SequentialAnimation on opacity {
                                    running: hDelegate.isCurrent
                                    loops: Animation.Infinite
                                    NumberAnimation { from: 1; to: 0; duration: 1500; easing.type: Easing.OutCubic }
                                    NumberAnimation { from: 0; to: 1; duration: 0 }
                                    PauseAnimation { duration: 500 }
                                }
                            }

                            Behavior on color { ColorAnimation { duration: 200 } }
                            Behavior on border.color { ColorAnimation { duration: 200 } }
                        }
                    }

                    // 下方内容
                    Column {
                        width: parent.width
                        spacing: 2

                        Text {
                            text: model.title || ""
                            font.pixelSize: control.titleFontSize
                            font.family: Theme.defaultFontFamily
                            font.weight: hDelegate.isActive ? Font.Bold : Font.Normal
                            color: hDelegate.isActive ? control.activeDotColor : control.titleColor
                            horizontalAlignment: Text.AlignHCenter
                            width: parent.width
                            wrapMode: Text.WordWrap
                            maximumLineCount: 2
                        }

                        Text {
                            text: model.subTitle || ""
                            font.pixelSize: control.subTitleFontSize
                            font.family: Theme.defaultFontFamily
                            color: control.subTitleColor
                            horizontalAlignment: Text.AlignHCenter
                            width: parent.width
                            visible: text !== ""
                            wrapMode: Text.WordWrap
                            maximumLineCount: 2
                        }
                    }
                }

                // ---- 左侧线段（从 delegate 左边到圆点中心）----
                Rectangle {
                    y: hTimeCol.height + control.dotSize / 2 + 4 - control.lineWidth / 2
                    x: 0
                    height: control.lineWidth
                    width: hDelegate.dotCenterX
                    color: hDelegate.isActive ? control.activeLineColor : control.lineColor
                    visible: index > 0
                }

                // ---- 右侧线段（从圆点中心到 delegate 右边）----
                Rectangle {
                    y: hTimeCol.height + control.dotSize / 2 + 4 - control.lineWidth / 2
                    x: hDelegate.dotCenterX
                    height: control.lineWidth
                    width: hDelegate.width - hDelegate.dotCenterX
                    color: index < control.currentIndex ? control.activeLineColor : control.lineColor
                    visible: index < hRepeater.count - 1
                }
            }
        }
    }
}
