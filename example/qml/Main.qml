import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import CompleteUI

ComWindow {
   id:win
   width: 1128
   height: 700
   visible: true
   title: qsTr("CompleteUI 示例")
   color: "transparent"
   initialItem:"qrc:/qml/T_Content.qml"

   // Row{
   //    y:50
   //    anchors.fill: parent
   //    padding: 5
   //    spacing: 10

   //    ComButton{
   //       text: "中国移动"
   //    }


   // }


   appBar: ComAppBar{
      winIcon:"qrc:/favicon.ico"
      title:win.title
      action: RowLayout{
         ComIconButton{
            id: btn_dark
            padding: 0
            radius: 0
            handCursor: true
            Layout.preferredWidth:  40
            Layout.preferredHeight: parent.height
            iconsize: 12
            iconbold: true
            iconsource: FluentIcon.ico_GlobalNavButton  //FluentIcons.SettingsSolidFluentIcons.GlobalNavButton
            onClicked: menu_dark.open()
            Menu{
               id: menu_dark
               width: 110
               x: btn_dark.x
               y: btn_dark.y + btn_dark.height
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

