import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import CompleteUI

Item {

    // Administrative {
    //     id: administrative
    // }

    // ComGroupBox{
    //     anchors.fill: parent
    //     title: "ComTreeView"
    //     anchors.margins: 3
        ColumnLayout{
            anchors.fill: parent
            anchors.margins: 10
            spacing: 6
            Text {
                text: "ComTreeView 案例"
                font.pixelSize: 24
                font.bold: true
                color: Theme.isDark ? "#FFFFFF" : "#000000"
                Layout.alignment: Qt.AlignHCenter
            }
            Item {
                Layout.fillWidth: true
                Layout.fillHeight: true
                RowLayout{
                    anchors.fill: parent
                    spacing: 6

                    ComTreeView{
                        id:treeview
                        //model: administrative
                        Layout.fillHeight: true
                        Layout.preferredWidth: 400
                    }
                    Item {
                        Layout.fillHeight: true
                        Layout.fillWidth: true

                        Column{
                            anchors.fill: parent
                            spacing: 10
                            padding: 10
                            Text {

                                text: qsTr("数据操作")
                                font.bold: true
                                color: Theme.isDark ? "#FFFFFF" : "#000000"
                                // Layout.alignment: Qt.AlignHCenter
                            }
                            Row{

                                spacing: 10
                                padding: 8
                                ComButton{
                                    text: "加载数据库数据"
                                    height: 35
                                    display: Button.TextBesideIcon
                                    iconsource: FluentIcon.ico_Connect
                                   // onClicked: administrative.loadAdministrativeData(5)
                                }
                                ComButton{
                                    text: "初始化默认数据"
                                    height: 35
                                    display: Button.TextBesideIcon
                                    iconsource: FluentIcon.ico_Ethernet
                                   // onClicked: administrative.initializeTestData()
                                }
                                ComButton{
                                    text: "清空数据"
                                    height: 35
                                    display: Button.TextBesideIcon
                                    iconsource: FluentIcon.ico_Delete
                                   // onClicked: administrative.clear()
                                }
                                ComSwitch{

                                    text: "启用线条"
                                }

                            }
                            Text {
                                text: qsTr("常规方法操作")
                                font.bold: true
                                color: Theme.isDark ? "#FFFFFF" : "#000000"
                                // Layout.alignment: Qt.AlignHCenter
                            }
                            Row{
                                spacing: 10
                                padding: 8
                                ComButton{
                                    text: "展开所有节点"
                                    height: 35
                                    display: Button.TextBesideIcon
                                    iconsource: FluentIcon.ico_Down
                                   // onClicked: administrative.allExpand()
                                }
                                ComButton{
                                    text: "收缩所有节点"
                                    height: 35
                                    display: Button.TextBesideIcon
                                    iconsource: FluentIcon.ico_Up
                                   // onClicked: administrative.allCollapse()
                                }
                                ComButton{
                                    text: "展开选中节点"
                                    height: 35
                                    display: Button.TextBesideIcon
                                    iconsource: FluentIcon.ico_Up
                                   // onClicked: administrative.allCollapse()
                                }
                                ComButton{
                                    text: "收缩选中节点"
                                    height: 35
                                    display: Button.TextBesideIcon
                                    iconsource: FluentIcon.ico_Up
                                   // onClicked: administrative.allCollapse()
                                }
                            }

                        }

                    }
                }
            }
        }
    //}
}