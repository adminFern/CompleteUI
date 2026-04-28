#ifndef APPHELPER_H
#define APPHELPER_H

#include <QObject>
#include <QQmlEngine>
#include "stdafx.h"

class AppHelper : public QObject
{
    Q_OBJECT
    QML_SINGLETON
    QML_ELEMENT

public:
    explicit AppHelper(QObject *parent = nullptr);
    SINGLETON(AppHelper)

    Q_INVOKABLE void setOverrideCursor(int shape);
    Q_INVOKABLE void restoreOverrideCursor();
};

#endif // APPHELPER_H
