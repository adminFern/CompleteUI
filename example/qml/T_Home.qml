import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import CompleteUI

Item {
    id: root

    ComFloatButton{
        actions: [
            { icon: FluentIcon.ico_Mail, enabled: true },
            { icon: FluentIcon.ico_FavoriteStarFill, enabled: false },
            { icon: FluentIcon.ico_Send, enabled: true },
            { icon: FluentIcon.ico_Delete, enabled: true },
            { icon: FluentIcon.ico_Save, enabled: true }
        ]
    }
}