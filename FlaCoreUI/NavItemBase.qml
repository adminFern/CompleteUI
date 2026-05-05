import QtQuick
import FlaCoreUI

// 导航项基础组件：封装图标/文本/背景/鼠标区域的公共逻辑
Item {
    id: root
    clip: true

    property var itemModel: null
    property bool isSelected: false
    property bool isChildItem: false
    property bool showExpandArrow: false
    property bool enablePressedState: false
    property bool isCompactMode: false
    property int itemHeight: 38
    property int iconSize: 17
    property int leftMargin: 0
    property font textFont: Qt.font({
        family: Theme.defaultFontFamily,
        pixelSize: 13,
        weight: Font.Normal
    })
    property color primaryColor: Theme.PrimaryColor
    property color textColor: Theme.Textcolor
    property color selectedBgColor: Theme.setColorAlpha(Theme.PrimaryColor, 100)
    property color hoverBgColor: Theme.isDark ? Qt.rgba(1, 1, 1, 0.05) : Qt.rgba(0, 0, 0, 0.05)
    readonly property bool isDisabled: itemModel ? (itemModel.disabled === true) : false
    property int hoverCursor: Qt.PointingHandCursor
    signal clicked
    height: itemHeight
    width: parent ? parent.width : 0

    // 统一背景颜色计算
    readonly property color bgColor: {
        if (isDisabled)
            return Theme.DisabledColor;
        if (enablePressedState && mouseArea.pressed)
            return Theme.setColorAlpha(Theme.isDark ? Qt.darker(primaryColor, 1.5) : Qt.lighter(primaryColor, 1.5), 150);
        if (isSelected)
            return selectedBgColor;
        if (mouseArea.containsMouse)
            return hoverBgColor;
        return "transparent";
    }
    // 统一文本/图标颜色计算
    readonly property color itemTextColor: {
        if (isDisabled)
            return Theme.DisabledTextColor;
        if (isSelected)
            return primaryColor;
        return textColor;
    }

    Rectangle {
        id: bgRect
        enabled: !root.isDisabled
        anchors.fill: parent
        anchors.leftMargin: root.leftMargin
        anchors.rightMargin: 1
        anchors.topMargin: 1
        anchors.bottomMargin: 1
        radius: 4
        color: root.bgColor
        Behavior on color {
            ColorAnimation {
                duration: 200
            }
        }

        Loader {
            id: iconLoader
            active: root.itemModel && root.itemModel.icon
            visible: active
            anchors.left: parent.left
            anchors.leftMargin: root.isChildItem ? 14 : (root.isCompactMode ? undefined : 8)
            anchors.verticalCenter: !root.isCompactMode ? parent.verticalCenter : undefined
            anchors.centerIn: root.isCompactMode ? parent : undefined
            sourceComponent: FlaImage {
                iconsource: root.itemModel && root.itemModel.icon ? root.itemModel.icon : ""
                iconsize: root.iconSize
               // iconbold: true
                icocolor: root.itemTextColor
            }
        }
        Loader {
            id: textLoader
            active: !root.isCompactMode && root.itemModel && root.itemModel.title !== ""
            visible: active
            anchors.left: iconLoader.right
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            sourceComponent: Text {
                text: root.itemModel ? root.itemModel.title : ""
                color: root.itemTextColor
                elide: Text.ElideRight
                font: root.textFont
                verticalAlignment: Text.AlignVCenter
            }
        }
        // 展开箭头（仅 expander 使用）
        Loader {
            active: root.showExpandArrow && !root.isCompactMode
            visible: active
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 10
            sourceComponent: FlaImage {
                rotation: root.itemModel && root.itemModel.isExpand ? 0 : 180
                iconsource: FluentIcon.ico_ChevronDown
                iconsize: 15
                icocolor: root.isDisabled ? "#9CA3AF" : root.textColor
                Behavior on rotation {
                    NumberAnimation {
                        duration: 200
                        easing.type: Easing.OutCubic
                    }
                }
            }
        }

        MouseArea {
            id: mouseArea
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: root.hoverCursor
            onClicked: root.clicked()
        }
    }
}
