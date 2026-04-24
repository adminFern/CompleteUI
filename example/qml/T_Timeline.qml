import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import CompleteUI

Item {
    id: root

    Flickable {
        id: flickable
        anchors.fill: parent
        clip: true
        contentWidth: width
        contentHeight: layout.implicitHeight + 40

        ScrollBar.vertical: ScrollBar {}

        ColumnLayout {
            id: layout
            x: 20
            y: 20
            width: flickable.width - 40
            spacing: 20

            Text {
                text: "ComTimeline 时间轴组件"
                font.pixelSize: 20
                font.bold: true
                color: Theme.Textcolor
            }

            // ===== 垂直布局示例 =====
            ComGroupBox {
                id: verticalBox
                Layout.fillWidth: true
                Layout.preferredHeight: verticalTimeline.implicitHeight + verticalBox.topPadding + 20
                padding: 16
                title: "垂直布局（默认）"

                ComTimeline {
                    id: verticalTimeline
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.topMargin: 4
                    orientation: ComTimeline.Direction.Vertical
                    currentIndex: 2
                    timeWidth: 80

                    model: ListModel {
                        ListElement { date: "04-24"; time: "14:30"; title: "需求评审"; subTitle: "产品、开发、测试三方确认需求文档" }
                        ListElement { date: "04-23"; time: "10:00"; title: "原型设计"; subTitle: "完成高保真原型，输出交互说明" }
                        ListElement { date: "04-22"; time: "16:00"; title: "项目启动"; subTitle: "确定项目范围、人员分工、时间节点" }
                        ListElement { date: "04-21"; time: "09:00"; title: "立项审批"; subTitle: "管理层审批通过，项目正式立项" }
                    }
                }
            }

            // ===== 水平布局示例 =====
            ComGroupBox {
                id: horizontalBox
                Layout.fillWidth: true
                Layout.preferredHeight: horizontalTimeline.implicitHeight + horizontalBox.topPadding + 20
                padding: 16
                title: "水平布局"

                Flickable {
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.topMargin: 4
                    height: horizontalTimeline.implicitHeight
                    contentWidth: horizontalTimeline.implicitWidth
                    clip: true
                    ScrollBar.horizontal: ScrollBar {}

                    ComTimeline {
                        id: horizontalTimeline
                        orientation: ComTimeline.Direction.Horizontal
                        currentIndex: 3
                        horizontalItemWidth: 140
                        spacing: 16
                        dotSize: 14
                        activeDotColor: "#3498DB"
                        activeLineColor: "#3498DB"
                        activeTimeColor: "#3498DB"

                        model: ListModel {
                            ListElement { date: "Q1"; time: "1-3月"; title: "市场调研"; subTitle: "用户需求分析" }
                            ListElement { date: "Q2"; time: "4-6月"; title: "产品设计"; subTitle: "UI/UX设计" }
                            ListElement { date: "Q3"; time: "7-9月"; title: "开发实现"; subTitle: "前后端开发" }
                            ListElement { date: "Q4"; time: "10-12月"; title: "测试上线"; subTitle: "正式发布" }
                        }
                    }
                }
            }

            // ===== 方向切换示例 =====
            ComGroupBox {
                id: switchBox
                Layout.fillWidth: true
                Layout.preferredHeight: switchContent.implicitHeight + switchBox.topPadding + 20
                padding: 16
                title: "方向切换演示"

                Column {
                    id: switchContent
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.topMargin: 4
                    spacing: 12

                    RowLayout {
                        width: parent.width
                        spacing: 8

                        Text {
                            text: "布局方向:"
                            font.pixelSize: 13
                            color: Theme.Textcolor
                        }

                        ComButton {
                            text: "垂直"
                            onClicked: switchTimeline.orientation = ComTimeline.Direction.Vertical
                        }

                        ComButton {
                            text: "水平"
                            onClicked: switchTimeline.orientation = ComTimeline.Direction.Horizontal
                        }

                        Item { Layout.fillWidth: true }

                        Text {
                            text: "当前进度:"
                            font.pixelSize: 13
                            color: Theme.Textcolor
                        }

                        ComButton {
                            text: "-"
                            onClicked: switchTimeline.currentIndex = Math.max(0, switchTimeline.currentIndex - 1)
                        }

                        Text {
                            text: switchTimeline.currentIndex + 1 + " / " + switchTimeline.model.count
                            font.pixelSize: 13
                            color: Theme.Textcolor
                            Layout.preferredWidth: 40
                            horizontalAlignment: Text.AlignHCenter
                        }

                        ComButton {
                            text: "+"
                            onClicked: switchTimeline.currentIndex = Math.min(switchTimeline.model.count - 1, switchTimeline.currentIndex + 1)
                        }
                    }

                    Item {
                        width: parent.width
                        height: switchTimeline.implicitHeight

                        ComTimeline {
                            id: switchTimeline
                            anchors.fill: parent
                            orientation: ComTimeline.Direction.Vertical
                            currentIndex: 1
                            timeWidth: 70
                            horizontalItemWidth: 130
                            spacing: 20
                            dotSize: 12
                            activeDotColor: "#E74C3C"
                            activeLineColor: "#E74C3C"
                            activeTimeColor: "#E74C3C"

                            model: ListModel {
                                ListElement { date: "步骤1"; time: "准备"; title: "环境搭建"; subTitle: "安装开发工具" }
                                ListElement { date: "步骤2"; time: "配置"; title: "项目初始化"; subTitle: "创建项目结构" }
                                ListElement { date: "步骤3"; time: "开发"; title: "功能开发"; subTitle: "编写业务代码" }
                                ListElement { date: "步骤4"; time: "测试"; title: "单元测试"; subTitle: "编写测试用例" }
                                ListElement { date: "步骤5"; time: "部署"; title: "发布上线"; subTitle: "部署到生产环境" }
                            }
                        }
                    }
                }
            }

            // ===== 快递物流示例 =====
            ComGroupBox {
                id: logisticsBox
                Layout.fillWidth: true
                Layout.preferredHeight: logisticsTimeline.implicitHeight + logisticsBox.topPadding + 20
                padding: 16
                title: "快递物流追踪（垂直）"

                ComTimeline {
                    id: logisticsTimeline
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.topMargin: 4
                    currentIndex: 3
                    timeWidth: 80

                    model: ListModel {
                        ListElement { date: "04-24"; time: "14:30"; title: "包裹已签收"; subTitle: "已签收，签收人：本人，如有问题请联系快递员" }
                        ListElement { date: "04-24"; time: "09:15"; title: "派送中"; subTitle: "快递员张师傅正在为您派送，电话：138****5678" }
                        ListElement { date: "04-23"; time: "22:40"; title: "到达目的城市"; subTitle: "包裹已到达【北京转运中心】" }
                        ListElement { date: "04-23"; time: "08:20"; title: "运输中"; subTitle: "包裹已从【上海转运中心】发出，下一站【北京转运中心】" }
                        ListElement { date: "04-22"; time: "16:05"; title: "已揽收"; subTitle: "快递员已揽收，预计24小时内发出" }
                        ListElement { date: "04-22"; time: "14:00"; title: "商家发货"; subTitle: "商家已发货，运单号：SF1234567890" }
                    }
                }
            }

            // ===== 订单进度示例 =====
            ComGroupBox {
                id: orderBox
                Layout.fillWidth: true
                Layout.preferredHeight: orderTimeline.implicitHeight + orderBox.topPadding + 20
                padding: 16
                title: "订单进度"

                ComTimeline {
                    id: orderTimeline
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.topMargin: 4
                    currentIndex: 2
                    activeDotColor: "#2ECC71"
                    activeLineColor: "#2ECC71"
                    activeTimeColor: "#2ECC71"
                    activeIcon: FluentIcon.ico_Completed
                    timeWidth: 90

                    model: ListModel {
                        ListElement { date: "04-24"; time: "10:00"; title: "提交订单"; subTitle: "订单号：ORD20260424001" }
                        ListElement { date: "04-24"; time: "10:02"; title: "支付成功"; subTitle: "支付金额：¥299.00，支付方式：微信支付" }
                        ListElement { date: "04-24"; time: "10:30"; title: "商家确认"; subTitle: "商家已确认订单，准备发货" }
                        ListElement { date: ""; time: ""; title: "商品出库"; subTitle: "" }
                        ListElement { date: ""; time: ""; title: "等待收货"; subTitle: "" }
                        ListElement { date: ""; time: ""; title: "完成评价"; subTitle: "" }
                    }
                }
            }

            // ===== 动态切换示例 =====
            ComGroupBox {
                id: dynamicBox
                Layout.fillWidth: true
                Layout.preferredHeight: dynamicContent.implicitHeight + dynamicBox.topPadding + 20
                padding: 16
                title: "动态切换进度"

                Column {
                    id: dynamicContent
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.topMargin: 4
                    spacing: 12

                    RowLayout {
                        width: parent.width
                        spacing: 8

                        Text {
                            text: "当前进度:"
                            font.pixelSize: 13
                            color: Theme.Textcolor
                        }

                        ComButton {
                            text: "-"
                            onClicked: timeline.currentIndex = Math.max(0, timeline.currentIndex - 1)
                        }

                        Text {
                            text: timeline.currentIndex + 1 + " / " + timeline.model.count
                            font.pixelSize: 13
                            color: Theme.Textcolor
                            Layout.preferredWidth: 40
                            horizontalAlignment: Text.AlignHCenter
                        }

                        ComButton {
                            text: "+"
                            onClicked: timeline.currentIndex = Math.min(timeline.model.count - 1, timeline.currentIndex + 1)
                        }
                    }

                    ComTimeline {
                        id: timeline
                        width: parent.width
                        currentIndex: 0
                        activeDotColor: "#E67E22"
                        activeLineColor: "#E67E22"
                        activeTimeColor: "#E67E22"
                        dotSize: 14
                        titleFontSize: 14
                        subTitleFontSize: 12
                        timeWidth: 70

                        model: ListModel {
                            ListElement { date: "第1周"; time: ""; title: "需求分析"; subTitle: "收集用户需求，编写需求文档" }
                            ListElement { date: "第2-3周"; time: ""; title: "系统设计"; subTitle: "架构设计、数据库设计、接口设计" }
                            ListElement { date: "第4-8周"; time: ""; title: "编码开发"; subTitle: "前后端开发，单元测试" }
                            ListElement { date: "第9周"; time: ""; title: "集成测试"; subTitle: "功能测试、性能测试、安全测试" }
                            ListElement { date: "第10周"; time: ""; title: "用户验收"; subTitle: "UAT测试，问题修复" }
                            ListElement { date: "第11周"; time: ""; title: "上线部署"; subTitle: "生产环境部署，监控运行" }
                        }
                    }
                }
            }

            // ===== 简约模式示例 =====
            ComGroupBox {
                id: simpleBox
                Layout.fillWidth: true
                Layout.preferredHeight: simpleTimeline.implicitHeight + simpleBox.topPadding + 20
                padding: 16
                title: "简约模式（仅日期，无副标题）"

                ComTimeline {
                    id: simpleTimeline
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.topMargin: 4
                    currentIndex: 1
                    dotSize: 10
                    spacing: 16
                    activeDotColor: "#9B59B6"
                    activeLineColor: "#9B59B6"
                    activeTimeColor: "#9B59B6"
                    timeWidth: 60

                    model: ListModel {
                        ListElement { date: "步骤1"; time: ""; title: "注册账号"; subTitle: "" }
                        ListElement { date: "步骤2"; time: ""; title: "完善资料"; subTitle: "" }
                        ListElement { date: "步骤3"; time: ""; title: "身份认证"; subTitle: "" }
                        ListElement { date: "步骤4"; time: ""; title: "开始使用"; subTitle: "" }
                    }
                }
            }

            Item {
                Layout.fillWidth: true
                Layout.minimumHeight: 20
            }
        }
    }
}
