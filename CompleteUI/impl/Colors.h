#ifndef COLORS_H
#define COLORS_H
#include <QObject>
#include <QQmlEngine>
#include <QColor>
#include "stdafx.h"
//##include "Theme.h"


class AccentColor : public QObject {
    Q_OBJECT
    Q_PROPERTY_AUTO(QColor, darkest)
    Q_PROPERTY_AUTO(QColor, darker)
    Q_PROPERTY_AUTO(QColor, dark)
    Q_PROPERTY_AUTO(QColor, normal)
    Q_PROPERTY_AUTO(QColor, light)
    Q_PROPERTY_AUTO(QColor, lighter)
    Q_PROPERTY_AUTO(QColor, lightest)
    QML_ELEMENT
public:
    explicit AccentColor(QObject *parent = nullptr) : QObject{parent}{};
};

class Colors : public QObject
{
    Q_OBJECT
    Q_PROPERTY_AUTO(QColor, Transparent)
    Q_PROPERTY_AUTO(QColor, Black)
    Q_PROPERTY_AUTO(QColor, White)
    Q_PROPERTY_AUTO(QColor, Grey10)
    Q_PROPERTY_AUTO(QColor, Grey20)
    Q_PROPERTY_AUTO(QColor, Grey30)
    Q_PROPERTY_AUTO(QColor, Grey40)
    Q_PROPERTY_AUTO(QColor, Grey50)
    Q_PROPERTY_AUTO(QColor, Grey60)
    Q_PROPERTY_AUTO(QColor, Grey70)
    Q_PROPERTY_AUTO(QColor, Grey80)
    Q_PROPERTY_AUTO(QColor, Grey90)
    Q_PROPERTY_AUTO(QColor, Grey100)
    Q_PROPERTY_AUTO(QColor, Grey110)
    Q_PROPERTY_AUTO(QColor, Grey120)
    Q_PROPERTY_AUTO(QColor, Grey130)
    Q_PROPERTY_AUTO(QColor, Grey140)
    Q_PROPERTY_AUTO(QColor, Grey150)
    Q_PROPERTY_AUTO(QColor, Grey160)
    Q_PROPERTY_AUTO(QColor, Grey170)
    Q_PROPERTY_AUTO(QColor, Grey180)
    Q_PROPERTY_AUTO(QColor, Grey190)
    Q_PROPERTY_AUTO(QColor, Grey200)
    Q_PROPERTY_AUTO(QColor, Grey210)
    Q_PROPERTY_AUTO(QColor, Grey220)
    Q_PROPERTY_AUTO_P(AccentColor *, Yellow)
    Q_PROPERTY_AUTO_P(AccentColor *, Orange)
    Q_PROPERTY_AUTO_P(AccentColor *, Red)
    Q_PROPERTY_AUTO_P(AccentColor *, Magenta)
    Q_PROPERTY_AUTO_P(AccentColor *, Purple)
    Q_PROPERTY_AUTO_P(AccentColor *, Blue)
    Q_PROPERTY_AUTO_P(AccentColor *, Teal)
    Q_PROPERTY_AUTO_P(AccentColor *, Green)

    QML_ELEMENT
    QML_SINGLETON
private:
    explicit Colors(QObject *parent = nullptr);
public:
    SINGLETON(Colors)

};

#endif // COLORS_H
