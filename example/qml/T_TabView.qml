import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import FlaCoreUI

Item {
    id: root

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        // TabWidthBehavior 切换
        RowLayout {
            Layout.fillWidth: true
            Layout.preferredHeight: 36
            spacing: 10

            Label {
                text: "TabWidthBehavior:"
                font: Qt.font({ family: Theme.defaultFontFamily, pixelSize: 13, weight: Font.Normal })
                color: Theme.isDark ? "white" : "black"
                Layout.alignment: Qt.AlignVCenter
            }
            FlaButton {
                text: "Equal"
                highlighted: tabView.tabWidthBehavior === FlaTabView.TabWidthBehavior.Equal
                onClicked: tabView.tabWidthBehavior = FlaTabView.TabWidthBehavior.Equal
            }
            FlaButton {
                text: "SizeToContent"
                highlighted: tabView.tabWidthBehavior === FlaTabView.TabWidthBehavior.SizeToContent
                onClicked: tabView.tabWidthBehavior = FlaTabView.TabWidthBehavior.SizeToContent
            }
            FlaButton {
                text: "Compact"
                highlighted: tabView.tabWidthBehavior === FlaTabView.TabWidthBehavior.Compact
                onClicked: tabView.tabWidthBehavior = FlaTabView.TabWidthBehavior.Compact
            }
            Item { Layout.fillWidth: true }
        }

        // CloseButtonVisibility 切换
        RowLayout {
            Layout.fillWidth: true
            Layout.preferredHeight: 36
            spacing: 10

            Label {
                text: "CloseButtonVisibility:"
                font: Qt.font({ family: Theme.defaultFontFamily, pixelSize: 13, weight: Font.Normal })
                color: Theme.isDark ? "white" : "black"
                Layout.alignment: Qt.AlignVCenter
            }
            FlaButton {
                text: "Never"
                highlighted: tabView.closeButtonVisibility === FlaTabView.CloseButtonVisibility.Never
                onClicked: tabView.closeButtonVisibility = FlaTabView.CloseButtonVisibility.Never
            }
            FlaButton {
                text: "Always"
                highlighted: tabView.closeButtonVisibility === FlaTabView.CloseButtonVisibility.Always
                onClicked: tabView.closeButtonVisibility = FlaTabView.CloseButtonVisibility.Always
            }
            FlaButton {
                text: "OnHover"
                highlighted: tabView.closeButtonVisibility === FlaTabView.CloseButtonVisibility.OnHover
                onClicked: tabView.closeButtonVisibility = FlaTabView.CloseButtonVisibility.OnHover
            }
            Item { Layout.fillWidth: true }
        }

        // 选项卡视图
        FlaTabView {
            id: tabView
            Layout.fillWidth: true
            Layout.fillHeight: true
            closeButtonVisibility: FlaTabView.CloseButtonVisibility.OnHover

            onNewPressed: {
                var idx = tabView.count + 1
                tabView.appendTab("", "Tab " + idx, tabPageComponent)
            }

            onTabClosed: (index) => {
                console.log("Tab closed:", index)
            }

            Component {
                id: tabPageComponent
                Rectangle {
                    color: Theme.isDark ? Qt.rgba(1, 1, 1, 0.03) : Qt.rgba(0, 0, 0, 0.03)
                    Label {
                        anchors.centerIn: parent
                        text: "Tab Content Page"
                        font: Qt.font({ family: Theme.defaultFontFamily, pixelSize: 18, weight: Font.Normal })
                        color: Theme.isDark ? "white" : "black"
                    }
                }
            }

            Component.onCompleted: {
                setTabList([
                    createTab("", "首页", tabPageComponent),
                    createTab("", "文档", tabPageComponent),
                    createTab("", "设置", tabPageComponent),
                    createTab("", "关于", tabPageComponent)
                ])
            }
        }
    }
}
