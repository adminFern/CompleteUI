import QtQuick
import QtQuick.Controls
import CompleteUI
Window {

   id: control
   property string initialItem //加载的布局内容
   // property alias containerItem: layout_container
   property string winIcon
   property bool topmost: false
   property bool fixSize: false
   property int margins: 0

   color:"transparent"
   property ComAppBar appBar: ComAppBar{
      showMaximize: !control.fixSize
      title:control.title
      winIcon: control.winIcon
   }

   Component.onCompleted: {
      if(appBar && Number(appBar.width) === 0){
         appBar.width = Qt.binding(function(){ return control.width })
      }


   }
   Component.onDestruction: {
      frameless.onDestruction()
   }

   /*Component{
      id: comp_background
      Rectangle{
         color: Theme.backgroundColor/*{
            if(Qt.platform.os === "windows" && Theme.SpecialEffect !== EffectType.Normal && frameless.isWindow11){
               return "transparent"
            }
            return Theme.backgroundColor
         }
      }
   }

   Loader{
      anchors.fill: parent
      sourceComponent: comp_background
   }*/

   Rectangle{
      z:0
      anchors.fill: parent
      color: Theme.backgroundColor
   }

   Frameless{
      id: frameless
      appbar:control.appBar
      maximizeButton: appBar.buttonMaximized
      isDarkMode:Theme.isDark
      topmost: topmost
      fixSize: fixSize
      effect: Theme.SpecialEffect
   }

   Item{
      id: layout_container
      anchors.fill: parent

      Loader{
         id: loader_container
         anchors.margins: control.margins
         anchors{
            fill: parent
            topMargin:layout_appbar.height
         }
         source: {
            if(control.initialItem){
               return control.initialItem
            }
            return ""
         }
      }

      Item{
         id: layout_appbar
         data: [appBar]
         width: parent.width
         height: childrenRect.height
         visible: !frameless.disabled
      }

   }
   function setHitTestVisible(id){
      frameless.setHitTestVisible(id)
   }


}
