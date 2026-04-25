import QtQuick
import QtQuick.Controls.Basic
import CompleteUI
// 导航指示器组件：基于 HighlightRectangle 的拉伸/吸附动画实现
// 专用于垂直导航列表，支持切换时的胶囊动画和展开/折叠时的平滑跟随
Rectangle {
    id: control

    // === 公共属性 ===
    property var targetListView           // 关联的目标 ListView
    property color indicatorColor: Theme.PrimaryColor  // 指示器颜色
    property int highlightSize: 20        // 高亮条长度
    property int indicatorX: 4            // X轴位置

    // === 内部状态属性 ===
    property real topPos: 0
    property real bottomPos: highlightSize
    property real oldTopPos: 0
    property int lastIndex: -1

    // === 目标位置计算 ===
    property real targetTop: {
        if (!targetListView || targetListView.currentIndex < 0 || !targetListView.currentItem) return 0
        return targetListView.currentItem.y - targetListView.contentY
                + (targetListView.currentItem.height - highlightSize) / 2
    }
    property real targetBottom: {
        if (!targetListView || targetListView.currentIndex < 0 || !targetListView.currentItem) return highlightSize
        return targetListView.currentItem.y - targetListView.contentY
                + (targetListView.currentItem.height + highlightSize) / 2
    }

    // === 基础设置 ===
    z: 1
    width: 3
    radius: 1.5
    color: control.indicatorColor

    x: control.indicatorX
    y: topPos
    height: bottomPos - topPos

    visible: targetListView && targetListView.currentIndex >= 0

    state: "normal"

    // === 索引变化处理 ===
    Connections {
        target: targetListView
        function onCurrentIndexChanged() {
            if (targetListView.currentIndex >= 0) {
                var dir = targetListView.currentIndex - control.lastIndex
                if (dir > 0 && control.lastIndex >= 0 && !trans_enter.running) {
                    // 向下移动：底边先拉伸到新位置，顶边保持旧位置
                    control.oldTopPos = control.topPos
                    control.state = "startEnter"
                    control.state = "normal"
                } else if (dir < 0 && control.lastIndex >= 0 && !trans_enter.running) {
                    // 向上移动：顶边先拉伸到新位置，底边保持旧位置
                    control.oldTopPos = control.topPos
                    control.state = "endEnter"
                    control.state = "normal"
                } else {
                    control.state = "normal"
                }
                control.lastIndex = targetListView.currentIndex
            }
        }
    }

    // === 状态定义 ===
    states: [
        State {
            name: "endEnter"
            // 向上移动：顶边到达新位置，底边保持旧位置 → 产生向上拉伸
            PropertyChanges {
                target: control
                topPos: control.targetTop
                bottomPos: control.oldTopPos + control.highlightSize
            }
        },
        State {
            name: "startEnter"
            // 向下移动：底边到达新位置，顶边保持旧位置 → 产生向下拉伸
            PropertyChanges {
                target: control
                topPos: control.oldTopPos
                bottomPos: control.targetBottom
            }
        },
        State {
            name: "normal"
            // 正常状态：两边都贴合目标位置
            PropertyChanges {
                target: control
                topPos: control.targetTop
                bottomPos: control.targetBottom
            }
        }
    ]

    // === 过渡动画 ===
    transitions: [
        Transition {
            id: trans_enter
            to: "normal"
            SequentialAnimation {
                PauseAnimation { duration: 80 }
                PropertyAnimation {
                    target: control
                    properties: "topPos,bottomPos"
                    duration: 200
                    easing.type: Easing.OutCubic
                }
            }
        }
    ]

    // === 展开/折叠时的平滑跟随 ===
    // 拉伸/吸附过渡期间禁用，避免冲突
    // 时长 250ms 与项目高度动画 Behavior on height 一致
    Behavior on topPos {
        enabled: !trans_enter.running
        NumberAnimation { duration: 250; easing.type: Easing.OutCubic }
    }
    Behavior on bottomPos {
        enabled: !trans_enter.running
        NumberAnimation { duration: 250; easing.type: Easing.OutCubic }
    }
}
