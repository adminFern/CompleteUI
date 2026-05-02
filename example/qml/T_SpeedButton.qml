import QtQuick
import QtQuick.Layouts
import FlaCoreUI

Item {
    id: root

    Rectangle {
        anchors.fill: parent
        color: Theme.FillBackgroundColor
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 16

        Row {
            spacing: 10
            Layout.fillWidth: true
            Layout.preferredHeight: 18
            FlaImage {
                iconsource: FluentIcon.ico_Add
            }
            Text {
                text: qsTr("悬浮按钮 SpeedButton")
                font.pixelSize: 16
                font.bold: true
                color: Theme.Textcolor
            }
        }

        Text {
            text: qsTr("单击主按钮展开子按钮，再次点击收起。支持上/下/左/右四个方向展开。")
            font.pixelSize: 13
            color: Theme.DisabledTextColor
            wrapMode: Text.WordWrap
            Layout.fillWidth: true
        }

        Item { Layout.preferredHeight: 8 }

        Row {
            spacing: 60
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter

            Column {
                spacing: 8
                Text {
                    text: qsTr("向上展开")
                    font.pixelSize: 12
                    color: Theme.DisabledTextColor
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                Item {
                    width: 160
                    height: 200

                    FlaSpeedButton {
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.bottom: parent.bottom
                        direction: FlaSpeedButton.Direction.Up
                        primaryColor: Theme.PrimaryColor
                        items: Objects {
                            SpeedButtonItem {
                                icon: FluentIcon.ico_Edit
                                title: qsTr("编辑")
                                color: "#1CB7B1"
                            }
                            SpeedButtonItem {
                                icon: FluentIcon.ico_Copy
                                title: qsTr("复制")
                                color: "#1CB7B1"
                            }
                            SpeedButtonItem {
                                icon: FluentIcon.ico_Delete
                                title: qsTr("删除")
                                color:  "#1CB7B1"
                            }
                        }
                        onClicked: function(index, item) {
                            statusText.text = qsTr("点击了: ") + item.title
                        }
                    }
                }
            }

            Column {
                spacing: 8
                Text {
                    text: qsTr("向下展开")
                    font.pixelSize: 12
                    color: Theme.DisabledTextColor
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                Item {
                    width: 160
                    height: 200

                    FlaSpeedButton {
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.top: parent.top
                        direction: FlaSpeedButton.Direction.Down
                        primaryColor: "#1CB7B1"
                        iconsource: FluentIcon.ico_More
                        items: Objects {
                            SpeedButtonItem {
                                icon: FluentIcon.ico_Save
                                title: qsTr("保存")
                                color:  "#1CB7B1"
                            }
                            SpeedButtonItem {
                                icon: FluentIcon.ico_Share
                                title: qsTr("分享")
                                color: "#3B5BA1"
                            }
                        }
                        onClicked: function(index, item) {
                            statusText.text = qsTr("点击了: ") + item.title
                        }
                    }
                }
            }

            Column {
                spacing: 8
                Text {
                    text: qsTr("向左展开")
                    font.pixelSize: 12
                    color: Theme.DisabledTextColor
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                Item {
                    width: 200
                    height: 160

                    FlaSpeedButton {
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        direction: FlaSpeedButton.Direction.Left
                        primaryColor:  "#1CB7B1"
                        items: Objects {
                            SpeedButtonItem {
                                icon: FluentIcon.ico_Mail
                                title: qsTr("邮件")
                                color:  "#1CB7B1"
                            }
                            SpeedButtonItem {
                                icon: FluentIcon.ico_Phone
                                title: qsTr("电话")
                                color: "#1CB7B1"
                            }
                            SpeedButtonItem {
                                icon: FluentIcon.ico_Video
                                title: qsTr("视频")
                                color:  "#1CB7B1"
                            }
                        }
                        onClicked: function(index, item) {
                            statusText.text = qsTr("点击了: ") + item.title
                        }
                    }
                }
            }

            Column {
                spacing: 8
                Text {
                    text: qsTr("向右展开")
                    font.pixelSize: 12
                    color: Theme.DisabledTextColor
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                Item {
                    width: 200
                    height: 160

                    FlaSpeedButton {
                        anchors.left: parent.left
                        anchors.verticalCenter: parent.verticalCenter
                        direction: FlaSpeedButton.Direction.Right
                        primaryColor:  "#1CB7B1"
                        iconsource: FluentIcon.ico_FavoriteStarFill
                        items: Objects {
                            SpeedButtonItem {
                                icon: FluentIcon.ico_Search
                                title: qsTr("搜索")
                                color: "#1CB7B1"
                            }
                            SpeedButtonItem {
                                icon: FluentIcon.ico_Filter
                                title: qsTr("筛选")
                                color: "#1CB7B1"
                            }
                        }
                        onClicked: function(index, item) {
                            statusText.text = qsTr("点击了: ") + item.title
                        }
                    }
                }
            }
        }

        Item { Layout.fillHeight: true }

        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 36
            radius: 6
            color: Theme.ButtonNormalColor
            border.color: Theme.ButtonBorderNormalColor
            border.width: 1

            Text {
                id: statusText
                anchors.centerIn: parent
                text: qsTr("点击子按钮查看反馈")
                font.pixelSize: 13
                color: Theme.Textcolor
            }
        }
    }
}
