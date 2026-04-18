import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import CompleteUI
Item{
    id: scrollView
    Column{
        anchors.fill: parent
        spacing: 15

    ComGroupBox{
        width: parent.width-4
        height: 85
        anchors.margins:4
        title: "按钮组件"
        font: Qt.font({
                          family: "微软雅黑",
                          pixelSize: 18,
                          weight: Font.Bold
                      })

        Item {
            id:buttLayout
            anchors.fill: parent
            anchors.margins:10

            Row{
                anchors.fill: parent
                spacing: 15
                ComButton{
                    id:a
                    anchors.verticalCenter: parent.verticalCenter
                    text: "基础按钮"
                }
                ComButton{
                    id:b
                    text: "图标按钮"
                    display: Button.IconOnly
                    iconsource: FluentIcon.ico_Wifi
                    anchors.verticalCenter: parent.verticalCenter
                    //enabled: false
                }
                ComButton{
                    id:c
                    anchors.verticalCenter: parent.verticalCenter
                    text: "图标按钮"
                    display: Button.TextBesideIcon
                    iconsource: FluentIcon.ico_MapPin
                }
                ComButton{
                    id:d
                    anchors.verticalCenter: parent.verticalCenter
                    text: "Emoji图标按钮"
                    display: Button.TextBesideIcon
                    iconsource: "📉"
                }
                ComButton{
                    id:e
                    anchors.verticalCenter: parent.verticalCenter
                    text: "图标按钮"
                    display: Button.TextUnderIcon
                    iconsource: FluentIcon.ico_VPN
                }
                ComButton{
                    id:f
                    anchors.verticalCenter: parent.verticalCenter
                    text: "图标按钮"
                    display: Button.TextUnderIcon
                    iconsource: "🪁"
                }
                ComFlatButton{
                    id:g
                    anchors.verticalCenter: parent.verticalCenter
                    text: "图标按钮"
                }
                ComFlatButton{
                    id:h
                    anchors.verticalCenter: parent.verticalCenter
                    text: "图标按钮"
                    display: Button.TextUnderIcon
                    iconsource: "🪁"
                }
                ComFlatButton{
                    id:i
                    anchors.verticalCenter: parent.verticalCenter
                    text: "图标按钮"
                    display: Button.TextBesideIcon
                    iconsource: "📊"
                    normalcolor: "salmon"
                }
                ComSwitch{
                    anchors.verticalCenter: parent.verticalCenter
                    text: "禁用"
                    onCheckedChanged: {
                        a.enabled=!checked
                        b.enabled=!checked
                        c.enabled=!checked
                        d.enabled=!checked
                        e.enabled=!checked
                        f.enabled=!checked
                        g.enabled=!checked
                        h.enabled=!checked
                        i.enabled=!checked
                    }
                }
            }
        }
    }

    ComGroupBox{
        width: parent.width-4
        height: 120
        anchors.margins:4
        title: "日期框组件"
        font: Qt.font({
                          family: "微软雅黑",
                          pixelSize: 18,
                          weight: Font.Bold
                      })

        Item {
            id:dateLayout
            anchors.fill: parent
            anchors.margins:10

            Row{
                anchors.fill: parent
                spacing: 15

                ComDatePicker{
                    id: datePicker1
                    anchors.verticalCenter: parent.verticalCenter
                    // selectedDate: new Date()
                    // onDateSelected: function(date) {
                    // }
                }

                // ComDatePicker{
                //     id: datePicker2
                //     anchors.verticalCenter: parent.verticalCenter
                //     onDateSelected: function(date) {
                //     }
                // }

                // ComDatePicker{
                //     id: datePicker3
                //     anchors.verticalCenter: parent.verticalCenter
                //     selectedDate: new Date()
                //     radius: 8
                //     selectedColor: "#FF6B6B"
                //     onDateSelected: function(date) {
                //     }
                // }

                // ComSwitch{
                //     anchors.verticalCenter: parent.verticalCenter
                //     onCheckedChanged: {
                //         datePicker1.enabled = !checked
                //         datePicker2.enabled = !checked
                //         datePicker3.enabled = !checked
                //     }
                // }
            }
        }
    }
    }
}