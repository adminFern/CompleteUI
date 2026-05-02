import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import FlaCoreUI

Item {
    id: root

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 5
        spacing: 5
        Text {
            id: title
            text: qsTr("👥 团队成员")
            font.pixelSize: 16
            font.bold: true
            color: Theme.Textcolor
        }
        FlaCard {
            Layout.fillWidth: true
            Layout.preferredWidth: 300
            Layout.preferredHeight: 100
            layout: FlaCard.LayoutType.Horizontal
            spacing: 5
            items: Objects {
                CardItemDelegate {
                    title: "IT资深员"
                    cardColor: "#38D7FF"
                    delegate: Item {
                        anchors.fill: parent
                        ColumnLayout {
                            anchors.fill: parent
                            spacing: 4
                            Text {
                                text: qsTr("张三")
                                font.bold: true
                                color: Theme.Textcolor
                            }
                            Text {
                                text: qsTr("资深前端工程师")
                                font.pixelSize: 11
                                color: Theme.Textcolor
                            }
                            Text {
                                Layout.fillWidth: true
                                elide: Text.ElideRight
                                text: qsTr("负责核心组件开发与架构设计")
                                font.pixelSize: 10
                                color: Theme.Textcolor
                                clip: true
                            }
                        }
                    }
                }
                CardItemDelegate {
                    title: "UI设计师"
                    cardColor: "#FF6B6B"
                    delegate: Item {
                        anchors.fill: parent
                        ColumnLayout {
                            anchors.fill: parent
                            spacing: 4
                            Text {
                                text: qsTr("李四")
                                font.bold: true
                                color: Theme.Textcolor
                            }
                            Text {
                                text: qsTr("UI设计师")
                                font.pixelSize: 11
                                color: Theme.Textcolor
                            }
                            Text {
                                Layout.fillWidth: true
                                elide: Text.ElideRight
                                text: qsTr("专注界面设计与用户体验优化")
                                font.pixelSize: 10
                                color: Theme.Textcolor
                                clip: true
                            }
                        }
                    }
                }
                CardItemDelegate {
                    title: "后端开发"
                    cardColor: "#4ECDC4"
                    delegate: Item {
                        anchors.fill: parent
                        ColumnLayout {
                            anchors.fill: parent
                            spacing: 4
                            Text {
                                text: qsTr("王五")
                                font.bold: true
                                color: Theme.Textcolor
                            }
                            Text {
                                text: qsTr("后端工程师")
                                font.pixelSize: 11
                                color: Theme.Textcolor
                            }
                            Text {
                                Layout.fillWidth: true
                                elide: Text.ElideRight
                                text: qsTr("负责服务器端逻辑与数据库管理")
                                font.pixelSize: 10
                                color: Theme.Textcolor
                                clip: true
                            }
                        }
                    }
                }
                CardItemDelegate {
                    title: "产品经理"
                    cardColor: "#45B7D1"
                    delegate: Item {
                        anchors.fill: parent
                        ColumnLayout {
                            anchors.fill: parent
                            spacing: 4
                            Text {
                                text: qsTr("赵六")
                                font.bold: true
                                color: Theme.Textcolor
                            }
                            Text {
                                text: qsTr("产品经理")
                                font.pixelSize: 11
                                color: Theme.Textcolor
                            }
                            Text {
                                Layout.fillWidth: true
                                elide: Text.ElideRight
                                text: qsTr("规划产品方向与需求分析")
                                font.pixelSize: 10
                                color: Theme.Textcolor
                                clip: true
                            }
                        }
                    }
                }
                CardItemDelegate {
                    title: "测试工程师"
                    cardColor: "#96CEB4"
                    delegate: Item {
                        anchors.fill: parent
                        ColumnLayout {
                            anchors.fill: parent
                            spacing: 4
                            Text {
                                text: qsTr("孙七")
                                font.bold: true
                                color: Theme.Textcolor
                            }
                            Text {
                                text: qsTr("测试工程师")
                                font.pixelSize: 11
                                color: Theme.Textcolor
                            }
                            Text {
                                Layout.fillWidth: true
                                elide: Text.ElideRight
                                text: qsTr("确保产品质量与功能稳定性")
                                font.pixelSize: 10
                                color: Theme.Textcolor
                                clip: true
                            }
                        }
                    }
                }
                CardItemDelegate {
                    title: "运维专家"
                    cardColor: "#FFEAA7"
                    delegate: Item {
                        anchors.fill: parent
                        ColumnLayout {
                            anchors.fill: parent
                            spacing: 4
                            Text {
                                text: qsTr("周八")
                                font.bold: true
                                color: Theme.Textcolor
                            }
                            Text {
                                text: qsTr("运维工程师")
                                font.pixelSize: 11
                                color: Theme.Textcolor
                            }
                            Text {
                                Layout.fillWidth: true
                                elide: Text.ElideRight
                                text: qsTr("维护系统稳定运行与性能优化")
                                font.pixelSize: 10
                                color: Theme.Textcolor
                                clip: true
                            }
                        }
                    }
                }
                CardItemDelegate {
                    title: "数据分析师"
                    cardColor: "#DDA0DD"
                    delegate: Item {
                        anchors.fill: parent
                        ColumnLayout {
                            anchors.fill: parent
                            spacing: 4
                            Text {
                                text: qsTr("吴九")
                                font.bold: true
                                color: Theme.Textcolor
                            }
                            Text {
                                text: qsTr("数据分析师")
                                font.pixelSize: 11
                                color: Theme.Textcolor
                            }
                            Text {
                                Layout.fillWidth: true
                                elide: Text.ElideRight
                                text: qsTr("挖掘数据价值与业务洞察")
                                font.pixelSize: 10
                                color: Theme.Textcolor
                                clip: true
                            }
                        }
                    }
                }
                CardItemDelegate {
                    title: "移动端开发"
                    cardColor: "#F7DC6F"
                    delegate: Item {
                        anchors.fill: parent
                        ColumnLayout {
                            anchors.fill: parent
                            spacing: 4
                            Text {
                                text: qsTr("郑十")
                                font.bold: true
                                color: Theme.Textcolor
                            }
                            Text {
                                text: qsTr("移动端工程师")
                                font.pixelSize: 11
                                color: Theme.Textcolor
                            }
                            Text {
                                Layout.fillWidth: true
                                elide: Text.ElideRight
                                text: qsTr("开发iOS与Android原生应用")
                                font.pixelSize: 10
                                color: Theme.Textcolor
                                clip: true
                            }
                        }
                    }
                }
                CardItemDelegate {
                    title: "算法工程师"
                    cardColor: "#98D8C8"
                    delegate: Item {
                        anchors.fill: parent
                        ColumnLayout {
                            anchors.fill: parent
                            spacing: 4
                            Text {
                                text: qsTr("钱十一")
                                font.bold: true
                                color: Theme.Textcolor
                            }
                            Text {
                                text: qsTr("算法工程师")
                                font.pixelSize: 11
                                color: Theme.Textcolor
                            }
                            Text {
                                Layout.fillWidth: true
                                elide: Text.ElideRight
                                text: qsTr("研究机器学习与深度学习算法")
                                font.pixelSize: 10
                                color: Theme.Textcolor
                                clip: true
                            }
                        }
                    }
                }
                CardItemDelegate {
                    title: "安全专家"
                    cardColor: "#FF8C94"
                    delegate: Item {
                        anchors.fill: parent
                        ColumnLayout {
                            anchors.fill: parent
                            spacing: 4
                            Text {
                                text: qsTr("陈十二")
                                font.bold: true
                                color: Theme.Textcolor
                            }
                            Text {
                                text: qsTr("安全工程师")
                                font.pixelSize: 11
                                color: Theme.Textcolor
                            }
                            Text {
                                Layout.fillWidth: true
                                elide: Text.ElideRight
                                text: qsTr("保障系统安全与漏洞防护")
                                font.pixelSize: 10
                                color: Theme.Textcolor
                                clip: true
                            }
                        }
                    }
                }
            }
        }

        Text {
            text: qsTr("🌊 曲线卡片视图")
            font.pixelSize: 16
            font.bold: true
            color: Theme.Textcolor
        }

        FlaCardCurveView {
            Layout.fillWidth: true
            Layout.preferredHeight: 350
            cardWidth: 120
            cardHeight: 160
            waveAmplitude: 80
            spacing: 15
            animationDuration: 600
            onCardClicked: function (index, item) {
                console.log("点击卡片:", index, item.title);
            }
            items: Objects {
                CardItemDelegate {
                    title: "项目A"
                    cardColor: "#38D7FF"
                    delegate: Item {
                        anchors.fill: parent
                        ColumnLayout {
                            anchors.fill: parent
                            spacing: 4
                            Text {
                                text: qsTr("项目A")
                                font.bold: true
                                color: "#fff"
                            }
                            Text {
                                text: qsTr("进行中")
                                font.pixelSize: 11
                                color: "#eee"
                            }
                            Text {
                                text: qsTr("进度 75%")
                                font.pixelSize: 10
                                color: "#ddd"
                            }
                        }
                    }
                }
                CardItemDelegate {
                    title: "项目B"
                    cardColor: "#FF6B6B"
                    delegate: Item {
                        anchors.fill: parent
                        ColumnLayout {
                            anchors.fill: parent
                            spacing: 4
                            Text {
                                text: qsTr("项目B")
                                font.bold: true
                                color: "#fff"
                            }
                            Text {
                                text: qsTr("已完成")
                                font.pixelSize: 11
                                color: "#eee"
                            }
                            Text {
                                text: qsTr("进度 100%")
                                font.pixelSize: 10
                                color: "#ddd"
                            }
                        }
                    }
                }
                CardItemDelegate {
                    title: "项目C"
                    cardColor: "#4ECDC4"
                    delegate: Item {
                        anchors.fill: parent
                        ColumnLayout {
                            anchors.fill: parent
                            spacing: 4
                            Text {
                                text: qsTr("项目C")
                                font.bold: true
                                color: "#fff"
                            }
                            Text {
                                text: qsTr("待启动")
                                font.pixelSize: 11
                                color: "#eee"
                            }
                            Text {
                                text: qsTr("进度 0%")
                                font.pixelSize: 10
                                color: "#ddd"
                            }
                        }
                    }
                }
                CardItemDelegate {
                    title: "项目D"
                    cardColor: "#45B7D1"
                    delegate: Item {
                        anchors.fill: parent
                        ColumnLayout {
                            anchors.fill: parent
                            spacing: 4
                            Text {
                                text: qsTr("项目D")
                                font.bold: true
                                color: "#fff"
                            }
                            Text {
                                text: qsTr("进行中")
                                font.pixelSize: 11
                                color: "#eee"
                            }
                            Text {
                                text: qsTr("进度 50%")
                                font.pixelSize: 10
                                color: "#ddd"
                            }
                        }
                    }
                }
                CardItemDelegate {
                    title: "项目E"
                    cardColor: "#96CEB4"
                    delegate: Item {
                        anchors.fill: parent
                        ColumnLayout {
                            anchors.fill: parent
                            spacing: 4
                            Text {
                                text: qsTr("项目E")
                                font.bold: true
                                color: "#fff"
                            }
                            Text {
                                text: qsTr("评审中")
                                font.pixelSize: 11
                                color: "#eee"
                            }
                            Text {
                                text: qsTr("进度 30%")
                                font.pixelSize: 10
                                color: "#ddd"
                            }
                        }
                    }
                }
                CardItemDelegate {
                    title: "项目F"
                    cardColor: "#DDA0DD"
                    delegate: Item {
                        anchors.fill: parent
                        ColumnLayout {
                            anchors.fill: parent
                            spacing: 4
                            Text {
                                text: qsTr("项目F")
                                font.bold: true
                                color: "#fff"
                            }
                            Text {
                                text: qsTr("进行中")
                                font.pixelSize: 11
                                color: "#eee"
                            }
                            Text {
                                text: qsTr("进度 60%")
                                font.pixelSize: 10
                                color: "#ddd"
                            }
                        }
                    }
                }
            }
        }
    }
}
