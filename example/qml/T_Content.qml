import QtQuick
import QtQuick.Layouts
import FlaCoreUI

// 示例页面：展示 FlaNavigationView 完整功能
// 包含主导航、分组展开、页脚项等内容
Item {
    id: root
    FlaNavigationView {
        anchors.margins: 2
        anchors.fill: parent
        initSelectIndex:0
        items: Objects {
            PaneItem {
                title: "首页"
                icon: FluentIcon.ico_Home
                page: "qrc:/qml/T_Home.qml"
            }
            PaneItemSeparator {}

            PaneItemExpander {
                title: "基本组件"
                isExpand: true
                icon:FluentIcon.ico_ExploitProtection   //FluentIcons.graph_CheckboxComposite
                PaneItem {
                    title: "按钮组件"
                    icon:FluentIcon.ico_CheckboxComposite    //FluentIcons.graph_ExploitProtection
                    // page: "qrc:/qml/T_Button.qml"
                }
                PaneItem {
                    title: "数据输入"
                    icon: FluentIcon.ico_Trackers  //FluentIcons.graph_Trackers
                    //  page: "qrc:/qml/T_ProgressBar.qml"
                }
            }
            PaneItem {
                title: "卡片"
                icon: FluentIcon.ico_Tablet   //FluentIcons.graph_Tablet
                page: "qrc:/qml/T_Card.qml"
            }
        }
        footerItems: Objects {
            PaneItemSeparator {}
            PaneItemHeader {
                title: "设置"
                icon: FluentIcon.ico_Settings
            }
        }
    }
}
