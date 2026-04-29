import QtQuick
import CompleteUI

// 图标组件：支持 Fluent 图标字体和 Emoji
Item {
    id: control

    property string iconsource     // 图标源（FluentIcon.ico_xxx 或 Emoji）
    property int iconsize: 20      // 图标大小
    property bool iconbold: false  // 图标加粗
    property color icocolor: Theme.isDark ? "white" : "black"

    implicitWidth: control.iconsize
    implicitHeight: control.iconsize
    readonly property string family: FluentIcon.fontLoader.name

    // 根据 iconsource 类型加载不同组件
    Loader {
        anchors.fill: parent
        sourceComponent: (iconsource && d.isEmoji(iconsource)) ? comp_emoji : comp_text
        Component.onDestruction: sourceComponent = undefined
    }

    // Fluent 图标字体组件
    Component {
        id: comp_text
        Text {
            font.family: family
            font.pixelSize: control.iconsize
            font.weight: iconbold ? Font.Bold : Font.Normal
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            color: control.icocolor
            text: control.iconsource
        }
    }

    // Emoji 组件（不需要特殊字体）
    Component {
        id: comp_emoji
        Text {
            font.pixelSize: control.iconsize
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            text: control.iconsource
        }
    }

    // 辅助工具：判断是否为 Emoji
    QtObject {
        id: d

        function isEmoji(source) {
            if (!source) return false

            // Emoji 通常较短
            if (source.length > 4) return false

            var emojiRegex = /[\u{1F300}-\u{1F9FF}\u{2600}-\u{26FF}\u{2700}-\u{27BF}\u{1F900}-\u{1F9FF}\u{1F1E6}-\u{1F1FF}]/gu

            // 检查 Emoji 代码点范围
            for (var i = 0; i < source.length; i++) {
                var code = source.charCodeAt(i)
                if ((code >= 0x1F300 && code <= 0x1F9FF) ||
                    (code >= 0x2600 && code <= 0x26FF) ||
                    (code >= 0x2700 && code <= 0x27BF) ||
                    (code >= 0x1F900 && code <= 0x1F9FF) ||
                    (code >= 0x1F600 && code <= 0x1F64F) ||
                    (code >= 0x1F680 && code <= 0x1F6FF) ||
                    (code >= 0x1F700 && code <= 0x1F77F) ||
                    (code >= 0x1F780 && code <= 0x1F7FF) ||
                    (code >= 0x1F800 && code <= 0x1F8FF) ||
                    (code >= 0x1FA00 && code <= 0x1FA6F)) {
                    return true
                }
            }
            return emojiRegex.test(source)
        }
    }
}
