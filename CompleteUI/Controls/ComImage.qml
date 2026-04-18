import QtQuick
import CompleteUI
Item {
    id: control
    property string iconsource
    property int iconsize: 20
    property bool iconbold: false
    property color icocolor:Theme.isDark?"white":"black"
    implicitWidth: control.iconsize
    implicitHeight: control.iconsize
    readonly property string family:FluentIcon.fontLoader.name

    Loader{
        anchors.fill: parent
        sourceComponent:(iconsource && d.isEmoji(iconsource)) ? comp_emoji : comp_text
        Component.onDestruction: sourceComponent = undefined
    }

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
    Component {
        id: comp_emoji
        Text {
            font.pixelSize: control.iconsize
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            text: control.iconsource
        }
    }

    QtObject{
        id:d

        function isEmoji(source) {
            // 排除空值和URL
            if (!source) {
                return false
            }
            // 方法1: 检查字符长度 - Emoji通常是1-2个字符（考虑组合emoji）
            if (source.length > 4) { // 普通文本通常更长
                return false
            }
            // 方法2: 使用正则表达式匹配常见的Emoji字符范围
            // 这个正则表达式覆盖了大部分常见的Emoji
            var emojiRegex = /[\u{1F300}-\u{1F9FF}\u{2600}-\u{26FF}\u{2700}-\u{27BF}\u{1F900}-\u{1F9FF}\u{1F1E6}-\u{1F1FF}]/gu

            // 方法3: 检查特定的Emoji代码点范围
            for (var i = 0; i < source.length; i++) {
                var code = source.charCodeAt(i)

                // 常见Emoji范围检查
                if ((code >= 0x1F300 && code <= 0x1F9FF) || // 杂项符号和象形文字
                        (code >= 0x2600 && code <= 0x26FF) ||   // 杂项符号
                        (code >= 0x2700 && code <= 0x27BF) ||   // 装饰符号
                        (code >= 0x1F900 && code <= 0x1F9FF) || // 补充符号和象形文字
                        (code >= 0x1F600 && code <= 0x1F64F) || // 表情符号
                        (code >= 0x1F680 && code <= 0x1F6FF) || // 交通和地图符号
                        (code >= 0x1F700 && code <= 0x1F77F) || // 炼金术符号
                        (code >= 0x1F780 && code <= 0x1F7FF) || // 几何扩展
                        (code >= 0x1F800 && code <= 0x1F8FF) || // 补充箭头-C
                        (code >= 0x1FA00 && code <= 0x1FA6F)) { // 棋类符号等
                    return true
                }
            }
            // 方法4: 检查是否匹配正则表达式
            return emojiRegex.test(source)
        }
    }

}
