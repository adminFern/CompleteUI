#include "Frameless.h"
#include "DwmSpecialEffect.h"

#include <QGuiApplication>
#include <QScreen>

Frameless::Frameless(QQuickItem *parent) : QQuickItem{parent} {

    _appbar = nullptr;
    _maximizeButton= nullptr;
    _fixSize = false;
    _topmost = false;
    _current=0;
    _effect = 0;
    _isDarkMode = false;
    _margins = 8; // 默认调整边距;
    _lastWindowState = Qt::WindowNoState;
    _isWindow11=Dwm->isWindow11();
}

Frameless::~Frameless(){
    this->onDestruction();
}
void Frameless::componentComplete() {
    HWND hwnd = reinterpret_cast<HWND>(window()->winId());
    if (!hwnd) {
        return;
    }
    
#ifdef Q_OS_WIN

    if(_effect!=0){
     Dwm->setWindowEffect(hwnd,_effect);
    }
    connect(this, &Frameless::effectChanged, this, [this, hwnd] {
        Dwm->setWindowEffect(hwnd,_effect);
    });

    connect(this, &Frameless::isDarkModeChanged, this,
            [this, hwnd] {
                if (_isDarkMode) {

                    Dwm->setWindowDarkMode(hwnd);
                }else {

                    Dwm->setWindowLightMode(hwnd);
                }
            });
#endif




    int w = window()->width(); //宽度
    int h = window()->height(); //高度
    _current = window()->winId();
    // //安装事件过滤器
    QGuiApplication::instance()->installNativeEventFilter(this);
    if (_maximizeButton) {
        setHitTestVisible(_maximizeButton);
    }
    //获取窗口的样式
    DWORD style = ::GetWindowLongPtr(hwnd, GWL_STYLE);
    //~移除样式但保留WS_MINIMIZEBOX以支持任务栏点击
    style &= ~(WS_MAXIMIZEBOX | WS_SYSMENU);
    if (_fixSize) {
        ::SetWindowLongPtr(hwnd, GWL_STYLE, style | WS_MINIMIZEBOX | WS_THICKFRAME | WS_CAPTION);

        // 修复循环越界问题
        for (int i = 0; i < QGuiApplication::screens().count(); ++i) {
            connect(
                QGuiApplication::screens().at(i), &QScreen::logicalDotsPerInchChanged, this, [=] {
                    SetWindowPos(hwnd, nullptr, 0, 0, 0, 0,
                                 SWP_NOZORDER | SWP_NOOWNERZORDER | SWP_NOMOVE | SWP_FRAMECHANGED);
                });
        }
    } else {
        ::SetWindowLongPtr(hwnd, GWL_STYLE, style | WS_MINIMIZEBOX | WS_MAXIMIZEBOX | WS_THICKFRAME | WS_CAPTION);
    }
    //更新窗口的非客户区
    SetWindowPos(hwnd, nullptr, 0, 0, 0, 0,
                 SWP_NOZORDER | SWP_NOOWNERZORDER | SWP_NOMOVE | SWP_NOSIZE | SWP_FRAMECHANGED);
    //屏幕发生变化立即更新
    connect(window(), &QQuickWindow::screenChanged, this, [hwnd] {
        ::SetWindowPos(hwnd, nullptr, 0, 0, 0, 0,
                       SWP_NOMOVE | SWP_NOSIZE | SWP_NOZORDER | SWP_FRAMECHANGED |
                           SWP_NOOWNERZORDER);
        ::RedrawWindow(hwnd, nullptr, nullptr, RDW_INVALIDATE | RDW_UPDATENOW);
    });
    //基本无边框了
    Dwm->setShadow(hwnd);


    int appBarHeight = 0;

    if(_appbar){
        // 获取标题栏高度
        appBarHeight = _appbar->height();
    }
    h = h + appBarHeight;

    window()->resize(QSize(w, h));

    connect(this, &Frameless::topmostChanged, this, [this] { _setWindowTopmost(topmost()); });
}

bool Frameless::nativeEventFilter(const QByteArray &eventType, void *message, qintptr *result)
{
    if ((eventType != "windows_generic_MSG") || !message)
    {
        return false;
    }
    const auto msg = static_cast<const MSG *>(message);
    auto hwnd = msg->hwnd;
    if (!hwnd) {
        return false;
    }
    const quint64 wid = reinterpret_cast<qint64>(hwnd);
    if (wid != _current) {
        return false;
    }
    
    const auto uMsg = msg->message;
    const auto wParam = msg->wParam;
    const auto lParam = msg->lParam;


    if (uMsg == WM_WINDOWPOSCHANGING){
        auto *wp = reinterpret_cast<WINDOWPOS *>(lParam);
        if (wp != nullptr && (wp->flags & SWP_NOSIZE) == 0)
        {
            wp->flags |= SWP_NOCOPYBITS;
            *result = ::DefWindowProcW(hwnd, uMsg, wParam, lParam);
            return 1;
        }
        return false;
    }else if(uMsg == WM_NCCALCSIZE && wParam == TRUE){

        const auto clientRect =
            ((wParam == FALSE) ? reinterpret_cast<LPRECT>(lParam)
                               : &(reinterpret_cast<LPNCCALCSIZE_PARAMS>(lParam))->rgrc[0]);
        bool isMax =Dwm->isMaximized(hwnd);
        bool isFull =Dwm->isFullScreen(hwnd);
        if (isMax && !isFull) {
            auto ty =Dwm->getResizeBorderThickness(hwnd, false, window()->devicePixelRatio());
            clientRect->top += ty;
            clientRect->bottom -= ty;
            auto tx =Dwm->getResizeBorderThickness(hwnd, true, window()->devicePixelRatio());
            clientRect->left += tx;
            clientRect->right -= tx;
        }
        if (isMax || isFull){
            APPBARDATA abd;
            SecureZeroMemory(&abd, sizeof(abd));
            abd.cbSize = sizeof(abd);
            const UINT taskbarState = ::SHAppBarMessage(ABM_GETSTATE, &abd);
            if (taskbarState & ABS_AUTOHIDE) {
                bool top = false, bottom = false, left = false, right = false;
                int edge = -1;
                APPBARDATA abd2;
                SecureZeroMemory(&abd2, sizeof(abd2));
                abd2.cbSize = sizeof(abd2);
                abd2.hWnd = ::FindWindowW(L"Shell_TrayWnd", nullptr);
                if (abd2.hWnd) {
                    const HMONITOR windowMonitor =
                        ::MonitorFromWindow(hwnd, MONITOR_DEFAULTTONEAREST);
                    if (windowMonitor) {
                        const HMONITOR taskbarMonitor =
                            ::MonitorFromWindow(abd2.hWnd, MONITOR_DEFAULTTOPRIMARY);
                        if (taskbarMonitor) {
                            if (taskbarMonitor == windowMonitor) {
                                ::SHAppBarMessage(ABM_GETTASKBARPOS, &abd2);
                                edge = abd2.uEdge;
                            }
                        }
                    }
                }
                top = (edge == ABE_TOP);
                bottom = (edge == ABE_BOTTOM);
                left = (edge == ABE_LEFT);
                right = (edge == ABE_RIGHT);
                if (top) {
                    clientRect->top += 1;
                } else if (bottom) {
                    clientRect->bottom -= 1;
                } else if (left) {
                    clientRect->left += 1;
                } else if (right) {
                    clientRect->right -= 1;
                } else {
                    clientRect->bottom -= 1;
                }
            } else {
                clientRect->bottom += 1;
            }
        }
        *result = 0;
        return true;
    } else if (uMsg == WM_NCHITTEST){

        if (Dwm->isWindow11()) {
            if (_hitMaximizeButton()) {
                if (*result == HTNOWHERE) {
                    *result = HTZOOM;
                }
                _setMaximizeHovered(true);
                return true;
            }
            _setMaximizeHovered(false);
            _setMaximizePressed(false);
        }

        *result = 0;
        POINT nativeGlobalPos{GET_X_LPARAM(lParam), GET_Y_LPARAM(lParam)};
        POINT nativeLocalPos = nativeGlobalPos;
        ::ScreenToClient(hwnd, &nativeLocalPos);
        RECT clientRect{0, 0, 0, 0};
        ::GetClientRect(hwnd, &clientRect);
        auto clientWidth = clientRect.right - clientRect.left;
        auto clientHeight = clientRect.bottom - clientRect.top;
        bool left = nativeLocalPos.x < _margins;
        bool right = nativeLocalPos.x > clientWidth - _margins;
        bool top = nativeLocalPos.y < _margins;
        bool bottom = nativeLocalPos.y > clientHeight - _margins;
        *result = 0;

        if (!_fixSize && !isFullScreen() && !isMaximized()) {
            if (left && top) {
                *result = HTTOPLEFT;
            } else if (left && bottom) {
                *result = HTBOTTOMLEFT;
            } else if (right && top) {
                *result = HTTOPRIGHT;
            } else if (right && bottom) {
                *result = HTBOTTOMRIGHT;
            } else if (left) {
                *result = HTLEFT;
            } else if (right) {
                *result = HTRIGHT;
            } else if (top) {
                *result = HTTOP;
            } else if (bottom) {
                *result = HTBOTTOM;
            }
        }
        if (0 != *result) {

            return true;
        }
        if (_hitAppBar()) {
            *result = HTCAPTION;
            return true;
        }
        *result = HTCLIENT;
        return true;

    }else if (uMsg == WM_NCPAINT){

        if (Dwm->isCompositionEnabled() && !this->isFullScreen()) {
            return false;
        }
        *result = FALSE;
        return true;
    }else if (uMsg == WM_NCACTIVATE){
        if (Dwm->isCompositionEnabled()) {
            return false;
        }
        *result = true;
        return true;
    }else if (uMsg == WM_SYSCOMMAND){
        // 完全重构的任务栏点击处理逻辑
        if (wParam == SC_MINIMIZE) {
            // 记录最小化前的状态
            _lastWindowState = static_cast<Qt::WindowState>(window()->windowState());
            return false; // 让系统处理最小化
        }
        else if (wParam == SC_RESTORE) {
            // 任务栏点击恢复 - 核心逻辑
            HWND foregroundWnd = ::GetForegroundWindow();
            bool isMinimized = ::IsIconic(hwnd);
            bool isVisible = ::IsWindowVisible(hwnd);
            bool isForeground = (foregroundWnd == hwnd);
            
            if (isMinimized) {
                // 情况1: 窗口最小化 -> 恢复显示
                if (_lastWindowState == Qt::WindowMaximized) {
                    // 直接恢复到最大化状态，避免中间的正常尺寸闪烁
                    ::ShowWindow(hwnd, SW_MAXIMIZE);
                    window()->setWindowState(Qt::WindowMaximized);
                } else {
                    // 恢复到正常状态
                    ::ShowWindow(hwnd, SW_RESTORE);
                    window()->setWindowState(Qt::WindowNoState);
                }
                ::SetForegroundWindow(hwnd);
            } else if (isVisible && isForeground) {
                // 情况2: 窗口可见且在前台 -> 最小化
                _lastWindowState = static_cast<Qt::WindowState>(window()->windowState());
                window()->setWindowState(Qt::WindowMinimized);
            } else {
                // 情况3: 窗口可见但不在前台 -> 激活到前台
                window()->show();
                window()->raise();
                window()->requestActivate();
            }
            return true;
        }
        return false;
    }else if (Dwm->isWindow11() && (uMsg == WM_NCLBUTTONDBLCLK || uMsg == WM_NCLBUTTONDOWN)){
        if (_hitMaximizeButton()) {
            QMouseEvent event = QMouseEvent(QEvent::MouseButtonPress, QPoint(), QPoint(),
                                            Qt::LeftButton, Qt::LeftButton, Qt::NoModifier);
            QGuiApplication::sendEvent(_maximizeButton, &event);
            _setMaximizePressed(true);
            return true;
        }
    }else if (Dwm->isWindow11() && (uMsg == WM_NCLBUTTONUP || uMsg == WM_NCRBUTTONUP)){
        if (_hitMaximizeButton()) {
            QMouseEvent event = QMouseEvent(QEvent::MouseButtonRelease, QPoint(), QPoint(),
                                            Qt::LeftButton, Qt::LeftButton, Qt::NoModifier);
            QGuiApplication::sendEvent(_maximizeButton, &event);
            _setMaximizePressed(false);
            return true;
        }
    }
    return false;
}


void Frameless::setHitTestVisible(QQuickItem *val)
{
    if (!_hitTestList.contains(val)) {
        _hitTestList.append(val);
    }
}

void Frameless::onDestruction()
{
    QGuiApplication::instance()->removeNativeEventFilter(this);
}

void Frameless::_setWindowTopmost(bool topmost)
{
#ifdef Q_OS_WIN
    HWND hwnd = reinterpret_cast<HWND>(window()->winId());
    if (topmost) {
        ::SetWindowPos(hwnd, HWND_TOPMOST, 0, 0, 0, 0, SWP_NOMOVE | SWP_NOSIZE);
    } else {
        ::SetWindowPos(hwnd, HWND_NOTOPMOST, 0, 0, 0, 0, SWP_NOMOVE | SWP_NOSIZE);
    }
#endif

}

bool Frameless::containsCursorToItem(QQuickItem *item)
{
    if (!item || !item->isVisible()) {
        return false;
    }
    auto point = item->window()->mapFromGlobal(QCursor::pos());
    auto rect = QRectF(item->mapToItem(item->window()->contentItem(), QPointF(0, 0)), item->size());
    if (rect.contains(point)) {
        return true;
    }
    return false;
}


bool Frameless::isFullScreen()
{
    return window()->visibility() == QWindow::FullScreen;
}

bool Frameless::isMaximized()
{
    return window()->visibility() == QWindow::Maximized;
}

bool Frameless::_hitAppBar()
{
    // 修复数组越界问题
    for (int i = 0; i < _hitTestList.size(); ++i) {
        auto item = _hitTestList.at(i);
        if (containsCursorToItem(item)) {
            return false;
        }
    }
    // 添加空指针检查
    if (_appbar && containsCursorToItem(_appbar)) {
        return true;
    }
    return false;
}

bool Frameless::_hitMaximizeButton()
{
    // 添加空指针检查
    if (_maximizeButton && containsCursorToItem(_maximizeButton)) {
        return true;
    }
    return false;
}

void Frameless::_setMaximizePressed(bool val)
{
    if (_maximizeButton) {
        _maximizeButton->setProperty("down", val);
    }
}

void Frameless::_setMaximizeHovered(bool val)
{
    if (_maximizeButton) {
        _maximizeButton->setProperty("hover", val);
    }
}

