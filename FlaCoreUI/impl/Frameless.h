#pragma once
#include <QObject>
#include <QQuickItem>
#include <QAbstractNativeEventFilter>
#include <QQuickWindow>
#include "stdafx.h"
class Frameless : public QQuickItem, QAbstractNativeEventFilter {
    Q_OBJECT
    Q_PROPERTY_AUTO_P(QQuickItem *, appbar)
    Q_PROPERTY_AUTO_P(QQuickItem *, maximizeButton)
    Q_PROPERTY_AUTO(int, effect)
    Q_PROPERTY_AUTO(bool, topmost)
    Q_PROPERTY_AUTO(bool, fixSize)
    Q_PROPERTY_AUTO(bool, isDarkMode)
    Q_PROPERTY_AUTO(bool, isWindow11)
    QML_ELEMENT

public:
    explicit Frameless(QQuickItem *parent = nullptr);
    ~Frameless()override;
    void componentComplete() override;
    //设置命中对象可见
    Q_INVOKABLE void setHitTestVisible(QQuickItem * val);
    [[maybe_unused]] Q_INVOKABLE void onDestruction();

private:
    bool nativeEventFilter(const QByteArray &eventType, void *message,
                           qintptr *result) override;

    //设置置顶
    void _setWindowTopmost(bool topmost);
    bool containsCursorToItem(QQuickItem *item);
    bool isFullScreen();
    bool isMaximized();
    bool _hitAppBar();
    bool _hitMaximizeButton();
    void _setMaximizePressed(bool val);
    void _setMaximizeHovered(bool val);


private:
    quint64 _current = 0;
    QList<QPointer<QQuickItem>> _hitTestList;//命中对象测试列表
    int _margins = 8;
    Qt::WindowState _lastWindowState = Qt::WindowNoState; // 记录上一个窗口状态

};
