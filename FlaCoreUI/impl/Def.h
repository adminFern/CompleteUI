#pragma once
#include <QObject>
#include <QtQml/qqml.h>
namespace EffectType{
Q_NAMESPACE
enum Effect {
    Normal = 0x0000,
    Mica = 0x0001,
    MicaAlt = 0x0002,
    Acrylic=0x0003
};
Q_ENUM_NS(Effect)
QML_NAMED_ELEMENT(EffectType)
}



namespace DisplayType{
Q_NAMESPACE
enum Type {
    IconOnly = 0x0000,
    TextOnly,
    TextBesideIcon,
    IconBesideText,
    TextUnderIcon
};
Q_ENUM_NS(Type)
QML_NAMED_ELEMENT(DisplayType)
}

namespace InputType{
Q_NAMESPACE
enum Type {
    Text= 0x0000,
    Number,
    Decimal,
    Letters
};
Q_ENUM_NS(Type)
QML_NAMED_ELEMENT(InputType)
}

