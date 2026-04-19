import QtQuick
import QtQuick.Controls.impl
import QtQuick.Templates as T
import QtQuick.Layouts
import QtQuick.Controls
import Qt5Compat.GraphicalEffects
import CompleteUI

T.Button {
  id: control
  display:DisplayType.TextOnly
  property bool handCursor: true
  property int iconsize:16
  property string iconsource
  property int radius:4
  property color normalcolor:Theme.ButtonNormalColor
  property color hovercolor:Theme.ButtonHoverColor
  property color pressedcolor:Theme.ButtonPressColor
  property color primarycolor:Theme.PrimaryColor
  property color highlightedcolor: "hotpink"
  property color textcolor:{
    if(!enabled) return Theme.DisabledTextColor
    if(control.highlighted ) return Theme.isDark? "black":"white"
    return Theme.Textcolor
  }
  property bool enableAnimation: true
  property real scaleAnimationFactor: 0.95
  highlighted: false
  font: Qt.font({family:Theme.defaultFontFamily,pixelSize : 14, weight: Font.Normal})
  spacing: 2
  padding: 0
  topPadding: 6
  bottomPadding: 6
  leftPadding: 6
  rightPadding: 6
  property color bordercolor:{
    if(!enabled) return Theme.DisabledBorderColor
    if(control.hovered) return Theme.PrimaryColor
    return Theme.ButtonBorderNormalColor
  }
  // 动画部分
  contentItem:ComIconLabel {
    z:4
    id: contentItem
    anchors.centerIn: parent
    text: control.text
    iconsource:control.iconsource
    iconsize: control.iconsize
    font: control.font
    display: control.display
    spacing: control.spacing
    color:control.textcolor
    icocolor: control.textcolor
    scale: 1.0
  }
  background: Item{
    z:0
    anchors.fill: parent
    RectangularGlow {
      id: glow
      anchors.fill: background
      glowRadius: 6
      spread: 0.4
      color:{
        if(control.highlighted) return Theme.isDark? Qt.darker(control.highlightedcolor,0.9)
                                                   :Qt.lighter(control.highlightedcolor,1.1)
        return Theme.isDark? Qt.darker(control.primarycolor,0.9)
                           :Qt.lighter(control.primarycolor,1.1)
      }

      cornerRadius: background.radius + glowRadius
      opacity: (enabled &&!control.flat && control.hovered && !control.pressed) ? 0.3 : 0
      visible: opacity > 0
      scale: 1.0
      z: -1
      Behavior on opacity { NumberAnimation { duration: 200; easing.type: Easing.OutQuad } }
    }
    Rectangle{
      id: background
      anchors.fill: parent
      radius: control.radius
      color:{
        if(!enabled) return Theme.DisabledColor
        if(control.highlighted){
          if(control.pressed) return Theme.isDark? Qt.darker(control.highlightedcolor,0.8)
                                                 :Qt.lighter(control.highlightedcolor,1.1)
          if(control.hovered) return Theme.isDark? Qt.darker(control.highlightedcolor,0.9)
                                                 :Qt.lighter(control.highlightedcolor,1.2)
          return control.highlightedcolor
        }
        if(control.pressed) return control.pressedcolor
        if(control.hovered) return control.hovercolor
        return control.normalcolor
      }
      border.width: control.highlighted ? 0 : 1
      border.color:control.bordercolor
      scale: 1.0
      Behavior on border.color { ColorAnimation { duration: 200 } }
      Behavior on color { ColorAnimation { duration: 200 } }
    }
  }


  // 添加按下动画
  ParallelAnimation {
    id: pressAnimation
    running: false
    NumberAnimation {
      target: contentItem
      property: "scale"
      to: control.scaleAnimationFactor
      duration: 75
      easing.type: Easing.InOutQuad
    }
    NumberAnimation {
      target: background
      property: "scale"
      to: control.scaleAnimationFactor
      duration: 75
      easing.type: Easing.InOutQuad
    }
    NumberAnimation {
      target: glow
      property: "scale"
      to: control.scaleAnimationFactor
      duration: 75
      easing.type: Easing.InOutQuad
    }
  }

  // 添加释放动画
  ParallelAnimation {
    id: releaseAnimation
    running: false
    NumberAnimation {
      target: contentItem
      property: "scale"
      to: 1.0
      duration: 75
      easing.type: Easing.InOutQuad
    }
    NumberAnimation {
      target: background
      property: "scale"
      to: 1.0
      duration: 75
      easing.type: Easing.InOutQuad
    }
    NumberAnimation {
      target: glow
      property: "scale"
      to: 1.0
      duration: 75
      easing.type: Easing.InOutQuad
    }
  }

  // 监听按钮按下状态变化，触发动画
  onPressedChanged: {
    if (control.enableAnimation) {
      if (control.pressed) {
        releaseAnimation.stop()
        pressAnimation.start()
      } else {
        pressAnimation.stop()
        releaseAnimation.start()
      }
    }
  }
  HoverHandler {
    cursorShape: control.handCursor ? Qt.PointingHandCursor : Qt.ArrowCursor
  }
  implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                          implicitContentWidth + leftPadding + rightPadding)
  implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                           implicitContentHeight + topPadding + bottomPadding)
}