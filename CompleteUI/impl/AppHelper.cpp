#include "AppHelper.h"
#include <QGuiApplication>
#include <QCursor>

AppHelper::AppHelper(QObject *parent)
    : QObject(parent)
{
}

void AppHelper::setOverrideCursor(int shape)
{
    QGuiApplication::setOverrideCursor(QCursor(static_cast<Qt::CursorShape>(shape)));
}

void AppHelper::restoreOverrideCursor()
{
    QGuiApplication::restoreOverrideCursor();
}
