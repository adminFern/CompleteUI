import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import FlaCoreUI

FlaWindow {
    id: win
    width: 1128
    height: 700
    visible: true


    initialItem: "qrc:/qml/T_Content.qml"

    appBar: AppBar{
        icon: "qrc:/favicon.ico"
          title: qsTr("FlaCardCurveView 波浪卡片示例")
        action: RowLayout{
            // 最小化按钮
            FlaIconButton {
                id: btn_set
                Layout.preferredWidth: 28
                Layout.preferredHeight: parent.height
                iconsize: 12
                radius: 0
                iconsource: FluentIcon.ico_Globe  //FluentIcons.Globe
                onClicked: {
                    menu_dark.open()
                }
                Menu{
                    id: menu_dark
                    width: 110
                    x: btn_set.x
                    y: btn_set.y + btn_set.height
                    MenuItem {
                        text: "浅色"
                        onClicked:Theme.ThemeType=Theme.Light
                    }
                    MenuItem {
                        text: "深色"
                        onClicked: Theme.ThemeType=Theme.Dark
                    }
                    MenuItem {
                        text: "正常模式"
                        onClicked:Theme.SpecialEffect=EffectType.Normal
                    }
                    MenuItem {
                        text: "云母"
                        onClicked: Theme.SpecialEffect=EffectType.Mica
                    }
                    MenuItem {
                        text: "深云母"
                        onClicked: Theme.SpecialEffect=EffectType.MicaAlt
                    }
                    MenuItem {
                        text: "亚克力"
                        onClicked: Theme.SpecialEffect=EffectType.Acrylic
                    }
                }
            }
        }

    }
}
