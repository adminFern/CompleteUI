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
                iconsize: 14
                radius: 0
                iconsource: FluentIcon.ico_Settings//FluentIcons.Globe  //FluentIcons.Settings
                onClicked: {
                    menu.popup(btn_set, 0, btn_set.height)
                }
                Menu {
                    id: menu
                    width: 100
                    MenuItem {
                        text: qsTr("浅色")
                        onTriggered: Theme.ThemeType=Theme.Light
                    }
                    MenuItem {
                        text: qsTr("深色")
                        onTriggered: Theme.ThemeType=Theme.Dark
                    }
                    MenuItem {
                        text: qsTr("正常模式")
                        onClicked:Theme.SpecialEffect=EffectType.Normal

                    }
                    MenuItem {
                        text: qsTr("云母")
                        onClicked:Theme.SpecialEffect=EffectType.Mica

                    }
                    MenuItem {
                        text: qsTr("深云母")
                        onClicked:Theme.SpecialEffect=EffectType.MicaAlt

                    }
                    MenuItem {
                        text: qsTr("亚克力")
                        onClicked:Theme.SpecialEffect=EffectType.Acrylic

                    }
                    MenuSeparator {}
                    MenuItem {
                        text: qsTr("退出")
                        onTriggered: {
                            Qt.quit()
                        }
                    }
                }
            }
        }

    }
}
