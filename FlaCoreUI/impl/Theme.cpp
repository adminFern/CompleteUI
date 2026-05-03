#include "Theme.h"
#include <QFont>
#include <QGuiApplication>
#include <QStyleHints>
#include <QCursor>
#include"Def.h"
#include "DwmSpecialEffect.h"
Theme::Theme(QObject *parent)
    : QObject{parent}
{
    _accentColor = Colors::getInstance()->Blue();
    _systemDark=QGuiApplication::styleHints()->colorScheme() == Qt::ColorScheme::Dark;
    _ThemeType=Theme::Type::System;
    _SpecialEffect=EffectType::MicaAlt;

    connect(QGuiApplication::styleHints(), &QStyleHints::colorSchemeChanged,
            this, [this](Qt::ColorScheme colorScheme) {
                _systemDark = (colorScheme == Qt::ColorScheme::Dark);
                emit isDarkChanged();
            });
    connect(this, &Theme::ThemeTypeChanged, this, &Theme::isDarkChanged);
    connect(this, &Theme::isDarkChanged, this, &Theme::refreshColors);
    connect(this, &Theme::PrimaryColorChanged, this, &Theme::refreshColors);
    connect(this, &Theme::SpecialEffectChanged, this, &Theme::refreshColors);
    this->refreshColors();

}

void Theme::refreshColors()
{
    auto dark = isDark();

    PrimaryColor(dark ? _accentColor->dark() : _accentColor->lighter());
    switch (_SpecialEffect) {
    case Theme::Effect::Mica:
    case Theme::Effect::MicaAlt:
        if(Dwm->isWindow11())  backgroundColor(Qt::transparent);
        ButtonNormalColor(dark?QColor(50, 50, 50,200) : QColor(252, 252, 252,200));
        ButtonHoverColor(dark?QColor(62, 62, 62) : QColor(255, 255, 255));
        ButtonPressColor(dark?QColor(48, 48, 48,220) : QColor(255, 255, 255,220));
        ButtonBorderNormalColor(dark ? QColor(100, 100, 100, 210) : QColor(225, 225, 225, 210));
        Textcolor(dark ? Qt::white:Qt::black);
        DividerColor(dark ? QColor(80, 80, 80, 180) : QColor(200, 200, 200, 180));
        DisabledColor(dark ? QColor(46, 46, 46,100) : QColor(235, 235, 235,100));
        DisabledTextColor(dark ? QColor(107, 114, 128) : QColor(171, 171, 171));
        DisabledBorderColor(dark ? QColor(100, 100, 100,200) : QColor(200, 200, 200,200));
        FillBackgroundColor(dark ? QColor(60, 60, 60, 80) : QColor(255, 255, 255, 130));
        FillCardColor(dark ? QColor(45, 45, 45) : QColor(255, 255, 255));
        FillBorderColor(dark ? QColor(40, 40, 40, 180) : QColor(210, 210, 210, 255));
        break;
    case Theme::Effect::Acrylic:
        if(Dwm->isWindow11())  backgroundColor(Qt::transparent);
        ButtonNormalColor(dark?QColor(42, 42, 42,30) : QColor(252, 252, 252,120));
        ButtonHoverColor(dark?QColor(48, 48, 48,100) : QColor(255, 255, 255,100));
        ButtonPressColor(dark?QColor(48, 48, 48,80) : QColor(255, 255, 255,150));
        ButtonBorderNormalColor(dark ? QColor(80, 80, 80, 100) : QColor(210, 210, 210, 230));
        Textcolor(dark ? Qt::white:Qt::black);
        DividerColor(dark ? QColor(80, 80, 80, 110) : QColor(210, 210, 210, 200));
        DisabledColor(dark ? QColor(46, 46, 46,100) : QColor(235, 235, 235,100));
        DisabledTextColor(dark ? QColor(107, 114, 128) : QColor(171, 171, 171));
        DisabledBorderColor(dark ? QColor(100, 100, 100) : QColor(200, 200, 200));
        FillBackgroundColor(dark ? QColor(80, 80, 80, 30) : QColor(255, 255, 255, 100));
        FillCardColor(dark ? QColor(45, 45, 45) : QColor(255, 255, 255));
         FillBorderColor(dark ? QColor(40, 40, 40, 180) : QColor(210, 210, 210, 255));
        break;
    default:
        backgroundColor(dark ? QColor(32, 32, 32, 255) : QColor(240, 240, 240, 255));
        DividerColor(dark ? QColor(80, 80, 80, 255) : QColor(210, 210, 210, 255));
        DisabledColor(dark ? QColor(46, 46, 46,180) : QColor(235, 235, 235,180));
        DisabledTextColor(dark ? QColor(100, 100, 100) : QColor(190, 190, 190));
        DisabledBorderColor(dark ? QColor(100, 100, 100) : QColor(200, 200, 200));
        ButtonNormalColor(dark?QColor(42, 42, 42) : QColor(252, 252, 252));
        ButtonHoverColor(dark?QColor(48, 48, 48) : QColor(255, 255, 255));
        ButtonPressColor(dark?QColor(48, 48, 48,220) : QColor(255, 255, 255,220));
        ButtonBorderNormalColor(dark ? QColor(80, 80, 80, 255) : QColor(230, 230, 230, 255));
        Textcolor(dark ? Qt::white:Qt::black);
        FillBackgroundColor(dark ? QColor(40, 40, 40, 180) : QColor(255, 255, 255, 180));
        FillBorderColor(dark ? QColor(40, 40, 40, 180) : QColor(210, 210, 210, 255));
        FillCardColor(dark ? QColor(45, 45, 45) : QColor(255, 255, 255));
        break;   
    }
}


bool Theme::isDark() const
{
    return (_ThemeType ==Theme::Type::System) ? _systemDark :
               (_ThemeType ==Theme::Type::Dark);
}

QString Theme::defaultFontFamily() const
{
    return  QGuiApplication::font().family();
}

void Theme::setOverrideCursor(int shape)
{
    QGuiApplication::setOverrideCursor(QCursor(static_cast<Qt::CursorShape>(shape)));
}

void Theme::restoreOverrideCursor()
{
    QGuiApplication::restoreOverrideCursor();
}
