import QtQuick
import QtQuick.Controls
import QtQuick.Window
import FlaCoreUI
Item {
    property bool animationEnabled: true
    property string  headerText: ""
    property bool expand: false
    property int contentHeight : 400
    default property alias content: container.data
    id:control
    implicitHeight: Math.max((layout_header.height + layout_container.height),layout_header.height)
    implicitWidth: parent.width
    QtObject{
        id:d
        property bool flag: false
        function toggle(){
            d.flag = true
            expand = !expand
            d.flag = false
        }
    }
    clip: true
    Rectangle{
        id:layout_header
        width: parent.width
        height: 40
        radius: 4
        border.color:{
            if(Theme.SpecialEffect===Theme.Mica ||Theme.SpecialEffect===Theme.MicaAlt){
                return Theme.isDark? Theme.setColorAlpha( "#5A5A5A",120):Theme.setColorAlpha( "#D7D7D7",120)
            }
            if(Theme.SpecialEffect===Theme.Acrylic ){
                 return Theme.isDark? Theme.setColorAlpha( "#5A5A5A",150):Theme.setColorAlpha( "#D7D7D7",140)
            }
            return Theme.isDark? "#5A5A5A":"#D7D7D7"
        }
        color:{
            if(Theme.SpecialEffect===Theme.Mica ||Theme.SpecialEffect===Theme.MicaAlt){
                return Theme.isDark? Theme.setColorAlpha( "#232323",150):Theme.setColorAlpha( "#FFFFFF",200)
            }
            if(Theme.SpecialEffect===Theme.Acrylic ){
                return Theme.isDark? Theme.setColorAlpha( "#232323",150):Theme.setColorAlpha( "#FFFFFF",200)
            }
            return  Theme.isDark? "#232323":"#FFFFFF"
        }

        MouseArea{
            id:control_mouse
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            onClicked: {
                d.toggle()
            }
        }
        Text{
            text: headerText
            color:Theme.Textcolor
            anchors{
                verticalCenter: parent.verticalCenter
                left: parent.left
                leftMargin: 15
            }
        }
        FlaImage {
            id: toggleIcon
            anchors {
                verticalCenter: parent.verticalCenter
                right: parent.right
                rightMargin: 15
            }
            rotation: expand ? 0 : 180
            iconsource: FluentIcon.ico_ChevronUp
            iconsize: 15
            Behavior on rotation {
                enabled: animationEnabled
                NumberAnimation {
                    duration: 167
                    easing.type: Easing.OutCubic
                }
            }
        }
    }
    Item{
        id:layout_container
        anchors{
            top: layout_header.bottom
            topMargin: -1
            left: layout_header.left
        }
        visible: contentHeight+container.anchors.topMargin !== 0
        height: contentHeight+container.anchors.topMargin
        width: parent.width
        z:-999
        clip: true
        Rectangle{
            id:container
            anchors.fill: parent
            radius: 4
            clip: true
            color:{
                if(Theme.SpecialEffect===Theme.Mica ||Theme.SpecialEffect===Theme.MicaAlt){
                    return Theme.isDark? Theme.setColorAlpha( "#303030",80):Theme.setColorAlpha( "#FDFDFD",100)
                }
                if(Theme.SpecialEffect===Theme.Acrylic ){
                     return Theme.isDark? Theme.setColorAlpha( "#303030",50):Theme.setColorAlpha( "#FDFDFD",100)
                }
                return Theme.isDark? "#303030":"#FDFDFD"
            }
            border.color: {
                if(Theme.SpecialEffect===Theme.Mica ||Theme.SpecialEffect===Theme.MicaAlt){
                    return Theme.isDark? Theme.setColorAlpha( "#5A5A5A",120):Theme.setColorAlpha( "#D7D7D7",120)
                }
                if(Theme.SpecialEffect===Theme.Acrylic ){
                     return Theme.isDark? Theme.setColorAlpha( "#5A5A5A",150):Theme.setColorAlpha( "#D7D7D7",140)
                }
                return Theme.isDark? "#5A5A5A":"#D7D7D7"

            }
            anchors.topMargin: -contentHeight
            states: [
                State{
                    name:"expand"
                    when: control.expand
                    PropertyChanges {
                        target: container
                        anchors.topMargin:0
                    }
                },
                State{
                    name:"collapsed"
                    when: !control.expand
                    PropertyChanges {
                        target: container
                        anchors.topMargin:-contentHeight
                    }
                }
            ]
            transitions: [
                Transition {
                    to:"expand"
                    NumberAnimation {
                        properties: "anchors.topMargin"
                        duration: animationEnabled && d.flag ? 167 : 0
                        easing.type: Easing.OutCubic
                    }
                },
                Transition {
                    to:"collapsed"
                    NumberAnimation {
                        properties: "anchors.topMargin"
                        duration: animationEnabled && d.flag ? 167 : 0
                        easing.type: Easing.OutCubic
                    }
                }
            ]
        }
    }
}
