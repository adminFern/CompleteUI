#include "Theme.h"
#include <QFont>
#include <QGuiApplication>
#include <QStyleHints>
#include"Def.h"
#include "DwmSpecialEffect.h"
Theme::Theme(QObject *parent)
    : QObject{parent}
{
    _accentColor = Colors::getInstance()->Blue();
    _systemDark=QGuiApplication::styleHints()->colorScheme() == Qt::ColorScheme::Dark;
    _ThemeType=Theme::Type::System;
    _SpecialEffect=EffectType::Normal;

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
             break;
        case Theme::Effect::Acrylic:
             if(Dwm->isWindow11())  backgroundColor(Qt::transparent);
             ButtonNormalColor(dark?QColor(42, 42, 42) : QColor(252, 252, 252));
             ButtonHoverColor(dark?QColor(48, 48, 48) : QColor(255, 255, 255));
             ButtonPressColor(dark?QColor(48, 48, 48,220) : QColor(255, 255, 255,220));
             ButtonBorderNormalColor(dark ? QColor(80, 80, 80, 255) : QColor(210, 210, 210, 255));
             Textcolor(dark ? Qt::white:Qt::black);
            break;
        default:
            backgroundColor(dark ? QColor(32, 32, 32, 255) : QColor(243, 243, 243, 255));
            DividerColor(dark ? QColor(80, 80, 80, 255) : QColor(210, 210, 210, 255));
            DisabledColor(dark ? QColor(42, 46, 55) : QColor(235, 235, 235));
            DisabledTextColor(dark ? QColor(107, 114, 128) : QColor(171, 171, 171));
            ButtonNormalColor(dark?QColor(42, 42, 42) : QColor(252, 252, 252));
            ButtonHoverColor(dark?QColor(48, 48, 48) : QColor(255, 255, 255));
            ButtonPressColor(dark?QColor(48, 48, 48,220) : QColor(255, 255, 255,220));
            ButtonBorderNormalColor(dark ? QColor(80, 80, 80, 255) : QColor(210, 210, 210, 255));
            Textcolor(dark ? Qt::white:Qt::black);
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
