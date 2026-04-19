#ifndef THEME_H
#define THEME_H
#include <QObject>
#include <QQmlEngine>
#include <QColor>
#include "stdafx.h"
#include "Colors.h"

class Theme : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool isDark READ isDark NOTIFY isDarkChanged FINAL)
    Q_PROPERTY(QString defaultFontFamily READ defaultFontFamily CONSTANT)
    Q_PROPERTY_AUTO(int, ThemeType)
    Q_PROPERTY_AUTO(int, SpecialEffect)
    //-----------------------------------------
    Q_PROPERTY_AUTO_P(AccentColor *, accentColor)
    Q_PROPERTY_AUTO(QColor, PrimaryColor)
    Q_PROPERTY_AUTO(QColor, backgroundColor)
    Q_PROPERTY_AUTO(QColor, DividerColor)
    Q_PROPERTY_AUTO(QColor, DisabledColor)
    Q_PROPERTY_AUTO(QColor, DisabledTextColor)
    Q_PROPERTY_AUTO(QColor, DisabledBorderColor)
    //按钮颜色配置
    Q_PROPERTY_AUTO(QColor, ButtonNormalColor)
    Q_PROPERTY_AUTO(QColor, ButtonHoverColor)
    Q_PROPERTY_AUTO(QColor, ButtonPressColor)
    Q_PROPERTY_AUTO(QColor, ButtonBorderNormalColor)
    Q_PROPERTY_AUTO(QColor, FillBackgroundColor)
    Q_PROPERTY_AUTO(QColor, Textcolor)
    //textcolor
    QML_SINGLETON
    QML_ELEMENT
private:
    explicit Theme(QObject *parent = nullptr);
    void refreshColors();
    bool _systemDark;
    QString m_defaultFontFamily;

public:
    enum Type {
        Light = 0x0001,
        Dark = 0x0002,
        System = 0x0003
    };
    Q_DECLARE_FLAGS(ThemeModes, Type)
    Q_FLAG(ThemeModes)

    enum Effect {
        Normal  = 0x0000,
        Mica  = 0x0001,
        MicaAlt  = 0x0002,
        Acrylic=0x0003
    };
    Q_DECLARE_FLAGS(SpecialEffec, Effect)
    Q_FLAG(SpecialEffec)

    SINGLETON(Theme)
    bool isDark() const;
    QString defaultFontFamily() const;
    Q_INVOKABLE inline QColor setColorAlpha(const QColor &color, int alpha=255)
    {
        // 把 alpha 限制在合法范围
        alpha = qBound(0, alpha, 255);
        // 构造一个新的 QColor，保持原有 RGB，只改 alpha
        return QColor::fromRgb(color.red(),
                               color.green(),
                               color.blue(),
                               alpha);
    }

signals:
    void isDarkChanged();
};

#endif // THEME_H
