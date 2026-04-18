#pragma once
#include <QObject>
#include <QtQml/qqml.h>
// namespace EffectType{
// Q_NAMESPACE
// enum Effect {
//     Normal = 0x0000,
//     Mica = 0x0001,
//     MicaAlt = 0x0002,
//     Acrylic=0x0003
// };
// Q_ENUM_NS(Effect)
// QML_NAMED_ELEMENT(EffectType)
// }
// enum displayType {
//     IconOnly = 0,
//     TextOnly = 1,
//     TextBesideIcon = 2,
//     IconBesideText=3,
//     TextUnderIcon = 4
// }
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



// // 定义结构体
// struct PersonData {
//     Q_GADGET
//     Q_PROPERTY(QString name MEMBER name)
//     Q_PROPERTY(int age MEMBER age)

// public:
//     QString name;
//     int age;
// };
// QML_DECLARE_TYPE(PersonData)