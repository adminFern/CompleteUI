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
        items: Objects {
            PaneItem {
                title: "首页"
                icon: FluentIcon.ico_Home
                page: "qrc:/qml/T_Home.qml"
            }
            PaneItemSeparator {}
            PaneItem {
                title: "卡片"
                icon: "📉"
                page: "qrc:/qml/T_Card.qml"
            }
            PaneItemExpander {
                title: "基本组件"
                isExpand: true
                icon: "📊"
                PaneItem {
                    title: "按钮组件"
                    icon: "📉"
                  // page: "qrc:/qml/T_Button.qml"
                }
                PaneItem {
                    title: "数字输入"
                    icon: "⏳"
                  //  page: "qrc:/qml/T_ProgressBar.qml"
                }
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
