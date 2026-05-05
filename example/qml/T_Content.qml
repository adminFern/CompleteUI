import QtQuick
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
import FlaCoreUI

// 示例页面：展示 FlaNavigationView 完整功能
// 包含首页内容、主导航、分组展开、页脚项、自定义代理等
Item {
    id: root
    FlaNavigationView {
        anchors.margins: 2
        anchors.fill: parent
        initSelectIndex:0
        // 侧边栏顶部主页内容（可自定义任意组件）
        home: Item {
            anchors.fill: parent
            RowLayout{
                spacing: 5
                Image{
                    Layout.leftMargin: 5
                    Layout.topMargin: 5
                    Layout.bottomMargin: 5
                    Layout.preferredWidth: 60
                    Layout.preferredHeight: 60
                    source: "qrc:/svg/avatar_1.svg"
                    fillMode: Image.PreserveAspectCrop
                    layer.enabled: true
                    layer.effect: OpacityMask {
                        maskSource: Rectangle {
                            width: 60
                            height: 60
                            radius: 60
                        }
                    }
                }
                Item {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Column{
                        anchors {
                            left: parent.left
                            verticalCenter: parent.verticalCenter  // 垂直居中
                        }
                        spacing: 4
                        Text {
                            id: name
                            text: qsTr("清冷简约风")
                            color: Theme.Textcolor
                            font.pixelSize: 18

                            //horizontalAlignment: Text.AlignHCenter
                        }
                        Text {
                            text: qsTr("angela2018@qq.com")
                            color: Theme.Textcolor
                            font.pixelSize: 14
                        }
                        Text {
                            text: qsTr("韩非子・解老")
                            color: Theme.Textcolor
                              font.pixelSize: 12
                        }
                    }
                }
            }

            // Row{
            //     spacing: 5
            //     padding: 5


            // }
        }

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
                icon: FluentIcon.ico_OEM// "📊"   ///FluentIcons.graph_OEM
                PaneItem {
                    title: "按钮组件"
                    icon: FluentIcon.ico_ExploitProtection   //FluentIcons.graph_RingerBadge12FluentIcons.graph_ExploitProtection
                    // page: "qrc:/qml/T_Button.qml"
                }
                PaneItem {
                    title: "悬浮按钮"
                    icon: FluentIcon.ico_Location
                    page: "qrc:/qml/T_SpeedButton.qml"  //FluentIcons.graph_PaginationDotOutline10//FluentIcons.graph_Location
                }
                PaneItem {
                    title: "输入组件"
                    icon: FluentIcon.ico_Handwriting20   //FluentIcons.graph_Handwriting20   FluentIcons.graph_PreviewLink
                    page: "qrc:/qml/T_InputNumber.qml"
                }
            }
            PaneItemExpander{
                 title: "数据"
                 isExpand: true
                 icon: FluentIcon.ico_PreviewLink// "📊"   ///FluentIcons.graph_OEM
                 PaneItem {
                     title: "卡片"
                     icon:FluentIcon.ico_Website
                     page: "qrc:/qml/T_Card.qml"  //FluentIcons.graph_Website
                 }

                 PaneItem {
                     title: "轮番播放"
                     icon: FluentIcon.ico_Switch
                     page: "qrc:/qml/T_Carousel.qml"
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
