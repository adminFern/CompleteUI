import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import FlaCoreUI

Item {
    id: root

    property string currentCategory: "buttons"
    property StackView stackView: stackView

    StackView {
        id: stackView
        anchors.fill: parent
        initialItem: "qrc:/qml/Showcase/Showcase_Buttons.qml"
    }

    FlaGroupBox {
        id: topBar
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: 16
        height: 56
        radius: 8
        normalcolor: Theme.FillCardColor

        Row {
            anchors.fill: parent
            anchors.leftMargin: 16
            anchors.rightMargin: 16
            spacing: 8
            Layout.alignment: Qt.AlignHCenter

            FlaIconButton {
                id: btnHome
                width: 44
                height: 44
                anchors.verticalCenter: parent.verticalCenter
                iconsize: 20
                iconsource: FluentIcon.ico_Home
                iconColor: Theme.Textcolor
                normalColor: "transparent"
                hoverColor: Theme.ButtonHoverColor
                pressedColor: Theme.ButtonPressedColor
                radius: 6
                onClicked: {
                    stackView.replace("qrc:/qml/Showcase/Showcase_Buttons.qml")
                    currentCategory = "buttons"
                }
            }

            Rectangle {
                anchors.verticalCenter: parent.verticalCenter
                width: 1
                height: 24
                color: Theme.DividerColor
            }

            Repeater {
                model: [
                    { name: "按钮", icon: FluentIcon.ico_Cursor, id: "buttons" },
                    { name: "导航", icon: FluentIcon.ico_Navigation, id: "navigation" },
                    { name: "容器", icon: FluentIcon.ico_Layers, id: "containers" },
                    { name: "图形", icon: FluentIcon.ico_PaintBrush, id: "graphics" },
                    { name: "滚动条", icon: FluentIcon.ico_ScrollBar, id: "scrollbar" },
                    { name: "窗口", icon: FluentIcon.ico_Window, id: "window" }
                ]
                delegate: FlaButton {
                    property string catId: modelData.id
                    text: modelData.name
                    iconsize: 14
                    iconsource: modelData.icon
                    radius: 6
                    normalcolor: currentCategory === catId ? Theme.PrimaryColor : "transparent"
                    hovercolor: currentCategory === catId ? Theme.PrimaryColor : Theme.ButtonHoverColor
                    pressedcolor: currentCategory === catId ? Theme.PrimaryColor : Theme.ButtonPressedColor
                    primarycolor: currentCategory === catId ? "#FFFFFF" : Theme.Textcolor
                   // iconcolor: currentCategory === catId ? "#FFFFFF" : Theme.Textcolor
                    textcolor: currentCategory === catId ? "#FFFFFF" : Theme.Textcolor
                    onClicked: {
                        currentCategory = catId
                        stackView.replace("qrc:/qml/Showcase/Showcase_" + catId.charAt(0).toUpperCase() + catId.slice(1) + ".qml")
                    }
                }
            }
        }
    }

    Rectangle {
        id: contentArea
        anchors.top: topBar.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: 16
        anchors.topMargin: 12
        color: Theme.FillBackgroundColor
        radius: 8

        StackView {
            id: contentStack
            anchors.fill: parent
            anchors.margins: 16
        }
    }

    Component.onCompleted: {
        contentStack.push("qrc:/qml/Showcase/Showcase_Buttons.qml")
    }
}