import QtQuick
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
import FlaCoreUI

Item {
    id: root
    property alias table: tableView

    property var avatarIcons: [
        "qrc:/svg/avatar_1.svg",
        "qrc:/svg/avatar_2.svg",
        "qrc:/svg/avatar_3.svg",
        "qrc:/svg/avatar_4.svg",
        "qrc:/svg/avatar_5.svg",
        "qrc:/svg/avatar_6.svg",
        "qrc:/svg/avatar_7.svg",
        "qrc:/svg/avatar_8.svg"
    ]

    property var firstNames: ["张","王","李","赵","刘","陈","杨","黄","周","吴","徐","孙","马","朱","胡","郭","何","林","罗","高"]
    property var secondNames: ["伟","芳","娜","秀英","敏","静","丽","强","磊","军","洋","勇","艳","杰","涛","明","超","静","建华","鹏","辉","波","燕","霞","萍","婷婷","宇","浩","鑫","博","晨","旭","阳","欣"]
    property var occupations: ["教师","工程师","医生","律师","设计师","销售","司机","厨师","会计","护士","摄影师","程序员","项目经理","市场经理","个体户","保安","快递员","理发师","司机","建筑工人"]
    property var provinces: ["北京市","上海市","广东省","浙江省","江苏省","四川省","湖北省","湖南省","河南省","河北省","山东省","福建省","安徽省","辽宁省","陕西省"]
    property var cities: ["朝阳区","海淀区","浦东新区","黄浦区","天河区","越秀区","西湖区","江干区","玄武区","鼓楼区","锦江区","青羊区","武侯区","青山区","江汉区"]
    property var districts: ["中关村","望京","国贸","陆家嘴","静安寺","天河城","珠江新城","武林广场","三里屯","金融街","科技园","大学城","高新区"]

    function generateRandomPerson(index) {
        var firstName = firstNames[Math.floor(Math.random() * firstNames.length)]
        var secondName = secondNames[Math.floor(Math.random() * secondNames.length)]
        var gender = Math.random() > 0.5 ? "男" : "女"
        var avatar = avatarIcons[Math.floor(Math.random() * avatarIcons.length)]
        var age = Math.floor(Math.random() * 48) + 18
        var occupation = occupations[Math.floor(Math.random() * occupations.length)]
        var province = provinces[Math.floor(Math.random() * provinces.length)]
        var city = cities[Math.floor(Math.random() * cities.length)]
        var district = districts[Math.floor(Math.random() * districts.length)]
        var address = province + city + district

        return {
            rowIndex: index + 1,
            name: firstName + secondName,
            gender: gender,
            avatar: tableView.customItem(avatarCom, {avatarSrc: avatar}),
            age: age,
            occupation: occupation,
            address: address
        }
    }

    Component {
        id: avatarCom
        Item {
            width: 44; height: 44
            anchors.centerIn: parent
            Image {
                id: avatarImg
                width: 40; height: 40
                anchors.centerIn: parent
                source: options.avatarSrc || "qrc:/svg/avatar_1.svg"
                fillMode: Image.PreserveAspectCrop
                layer.enabled: true
                layer.effect: OpacityMask {
                    maskSource: Rectangle {
                        width: 40; height: 40
                        radius: 20
                    }
                }
            }
        }
    }

    function updateRowIndexes() {
        for (var i = 0; i < tableView.rows; i++) {
            var row = tableView.getRow(i)
            row.rowIndex = i + 1
            tableView.setRow(i, row)
        }
    }

    ColumnLayout {
        anchors.margins: 20
        anchors.fill: parent
        spacing: 16

        Text {
            text: "FlaTableView 人员信息表示例"
            font.pixelSize: 20
            font.weight: Font.Medium
            color: Theme.Textcolor
        }

        RowLayout {
            spacing: 12
            Layout.fillWidth: true

            FlaButton {
                text: "添加"
                iconsource: FluentIcon.ico_Add
                onClicked: {
                    tableView.appendRow(generateRandomPerson(tableView.rows))
                    Qt.callLater(updateRowIndexes)
                }
            }

            FlaButton {
                text: "删除选中"
                iconsource: FluentIcon.ico_Delete
                enabled: tableView.current !== null
                onClicked: {
                    var idx = tableView.currentIndex()
                    if (idx >= 0) {
                        tableView.removeRow(idx)
                        Qt.callLater(updateRowIndexes)
                    }
                }
            }

            FlaButton {
                text: "清空"
                iconsource: FluentIcon.ico_Cancel
                onClicked: {
                    tableView.clearRows()
                }
            }

            Item { Layout.fillWidth: true }

            Text {
                text: "总行数: " + tableView.rows
                color: Theme.Textcolor
                verticalAlignment: Text.AlignVCenter
            }
        }

        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.minimumHeight: 300
            color: Theme.BackgroundColor
            border.color: Theme.DividerColor
            border.width: 1
            radius: 4

            FlaTableView {
                id: tableView
                anchors.fill: parent
                anchors.margins: 1
                columnSource: [
                    { title: "序号", dataIndex: "rowIndex", width: 60, align: "center" },
                    { title: "姓名", dataIndex: "name", width: 120, minimumWidth: 80, align: "center" },
                    { title: "性别", dataIndex: "gender", width: 60, align: "center" },
                    { title: "头像", dataIndex: "avatar", width: 60 },
                    { title: "年龄", dataIndex: "age", width: 60, align: "center" },
                    { title: "职业", dataIndex: "occupation", width: 150, minimumWidth: 100, align: "center" },
                    { title: "住址", dataIndex: "address", width: 250, minimumWidth: 150 }
                ]

                Component.onCompleted: {
                    for (var i = 0; i < 2000; i++) {
                        appendRow(generateRandomPerson(i))
                    }
                }
            }
        }

        Rectangle {
            Layout.fillWidth: true
            Layout.minimumHeight: 60
            color: Theme.CardBackgroundColor
            radius: 4
            visible: tableView.current !== null

            RowLayout {
                anchors.margins: 16
                anchors.fill: parent
                spacing: 24

                Text {
                    text: "选中人员信息："
                    font.weight: Font.Medium
                    color: Theme.Textcolor
                }

                Text {
                    text: "姓名: " + (tableView.current ? tableView.current.name : "")
                    color: Theme.Textcolor
                }

                Text {
                    text: "性别: " + (tableView.current ? tableView.current.gender : "")
                    color: Theme.Textcolor
                }

                Text {
                    text: "年龄: " + (tableView.current ? tableView.current.age : "")
                    color: Theme.Textcolor
                }

                Text {
                    text: "职业: " + (tableView.current ? tableView.current.occupation : "")
                    color: Theme.Textcolor
                }

                Text {
                    text: "住址: " + (tableView.current ? tableView.current.address : "")
                    color: Theme.Textcolor
                    Layout.maximumWidth: 400
                    elide: Text.ElideRight
                }

                Item { Layout.fillWidth: true }
            }
        }
    }
}