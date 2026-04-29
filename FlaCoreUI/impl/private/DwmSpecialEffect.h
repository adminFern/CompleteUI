#pragma once
#include <QQmlEngine>
#pragma comment(lib, "user32.lib")
#pragma comment(lib, "dwmapi.lib")
#include <windows.h>
#include <windowsx.h>
#include <dwmapi.h>
class DwmSpecialEffect
{   QML_SINGLETON
public:
    //系统判断

    bool isWindow11();
    bool isWindow10();
    bool isWindow8();
    bool isWindow7();
    // 公共接口方法
    bool isCompositionEnabled();
    void setShadow(HWND hwnd);
    bool setWindowDarkMode(const HWND hwnd);
    bool setWindowLightMode(const HWND hWnd); // 设置窗口浅色模式
    bool setWindowEffect(HWND hwnd,const int key);
    quint32 getResizeBorderThickness(const HWND hwnd, const bool horizontal,
                                     const qreal devicePixelRatio);
    bool isFullScreen(const HWND hwnd);
    bool isMaximized(const HWND hwnd);
    DwmSpecialEffect();
    ~DwmSpecialEffect();
private:
    bool _Init=false;
    HMODULE _ntdllhMod=nullptr;
    HMODULE _dwmapiMod=nullptr;
    HMODULE _user32Mod=nullptr;

    enum WINDOWCOMPOSITIONATTRIB {
        WCA_UNDEFINED = 0,
        WCA_NCRENDERING_ENABLED = 1,
        WCA_NCRENDERING_POLICY = 2,
        WCA_TRANSITIONS_FORCEDISABLED = 3,
        WCA_ALLOW_NCPAINT = 4,
        WCA_CAPTION_BUTTON_BOUNDS = 5,
        WCA_NONCLIENT_RTL_LAYOUT = 6,
        WCA_FORCE_ICONIC_REPRESENTATION = 7,
        WCA_EXTENDED_FRAME_BOUNDS = 8,
        WCA_HAS_ICONIC_BITMAP = 9,
        WCA_THEME_ATTRIBUTES = 10,
        WCA_NCRENDERING_EXILED = 11,
        WCA_NCADORNMENTINFO = 12,
        WCA_EXCLUDED_FROM_LIVEPREVIEW = 13,
        WCA_VIDEO_OVERLAY_ACTIVE = 14,
        WCA_FORCE_ACTIVEWINDOW_APPEARANCE = 15,
        WCA_DISALLOW_PEEK = 16,
        WCA_CLOAK = 17,
        WCA_CLOAKED = 18,
        WCA_ACCENT_POLICY = 19,
        WCA_FREEZE_REPRESENTATION = 20,
        WCA_EVER_UNCLOAKED = 21,
        WCA_VISUAL_OWNER = 22,
        WCA_HOLOGRAPHIC = 23,
        WCA_EXCLUDED_FROM_DDA = 24,
        WCA_PASSIVEUPDATEMODE = 25,
        WCA_USEDARKMODECOLORS = 26,
        WCA_CORNER_STYLE = 27,
        WCA_PART_COLOR = 28,
        WCA_DISABLE_MOVESIZE_FEEDBACK = 29,
        WCA_LAST = 30
    };

    // Accent state definitions for dwm-blur effect
    enum ACCENT_STATE {
        ACCENT_DISABLED = 0,
        ACCENT_ENABLE_GRADIENT = 1,
        ACCENT_ENABLE_TRANSPARENTGRADIENT = 2,
        ACCENT_ENABLE_BLURBEHIND = 3,
        ACCENT_ENABLE_ACRYLICBLURBEHIND = 4,
        ACCENT_ENABLE_HOSTBACKDROP = 5,
        ACCENT_INVALID_STATE = 6
    };

    enum ACCENT_FLAGS {
        ACCENT_NONE = 0,
        ACCENT_DRAW_LEFT_BORDER = 0x20,
        ACCENT_DRAW_TOP_BORDER = 0x40,
        ACCENT_DRAW_RIGHT_BORDER = 0x80,
        ACCENT_DRAW_BOTTOM_BORDER = 0x100,
        ACCENT_DRAW_ALL_BORDERS = (ACCENT_DRAW_LEFT_BORDER | ACCENT_DRAW_TOP_BORDER | ACCENT_DRAW_RIGHT_BORDER | ACCENT_DRAW_BOTTOM_BORDER)
    };

    struct ACCENT_POLICY {
        DWORD dwAccentState;
        DWORD dwAccentFlags;
        DWORD dwGradientColor;
        DWORD dwAnimationId;
    };



    struct WINDOWCOMPOSITIONATTRIBDATA {
        WINDOWCOMPOSITIONATTRIB Attrib;
        PVOID pvData;
        SIZE_T cbData;
    };
    using PWINDOWCOMPOSITIONATTRIBDATA = WINDOWCOMPOSITIONATTRIBDATA *;

    // 函数指针类型定义
    typedef HRESULT(WINAPI *DwmSetWindowAttributeFunc)(HWND hwnd, DWORD dwAttribute,
                                                       LPCVOID pvAttribute, DWORD cbAttribute);
    typedef HRESULT(WINAPI *DwmExtendFrameIntoClientAreaFunc)(HWND hwnd, const MARGINS *pMarInset);
    typedef HRESULT(WINAPI *DwmIsCompositionEnabledFunc)(BOOL *pfEnabled);
    typedef HRESULT(WINAPI *DwmEnableBlurBehindWindowFunc)(HWND hWnd,
                                                           const DWM_BLURBEHIND *pBlurBehind);
    typedef BOOL(WINAPI *SetWindowCompositionAttributeFunc)(HWND hwnd,
                                                            const WINDOWCOMPOSITIONATTRIBDATA *);
    typedef UINT(WINAPI *GetDpiForWindowFunc)(HWND hWnd);
    typedef int(WINAPI *GetSystemMetricsForDpiFunc)(int nIndex, UINT dpi);
    // 函数指针成员变量
    DwmSetWindowAttributeFunc pDwmSetWindowAttribute = nullptr;
    DwmExtendFrameIntoClientAreaFunc pDwmExtendFrameIntoClientArea = nullptr;
    DwmIsCompositionEnabledFunc pDwmIsCompositionEnabled = nullptr;
    DwmEnableBlurBehindWindowFunc pDwmEnableBlurBehindWindow = nullptr;
    SetWindowCompositionAttributeFunc pSetWindowCompositionAttribute = nullptr;
    GetDpiForWindowFunc pGetDpiForWindow = nullptr;
    GetSystemMetricsForDpiFunc pGetSystemMetricsForDpi = nullptr;
    bool Initialization();
    // 私有方法
    bool isWindow1122H2();
    bool isWin8OrGreater();
    bool isWin8Point1OrGreater();
    bool isWindow101809();
    bool isWindow101903O();
    RTL_OSVERSIONINFOW getRealOSVersionImpl();
    RTL_OSVERSIONINFOW getRealOSVersion();
    std::optional<MONITORINFOEXW> getMonitorForWindow(const HWND hwnd);
    quint32 getDpiForWindow(const HWND hwnd, const bool horizontal);
    int getSystemMetrics(const HWND hwnd, const int index, const bool horizontal);
};
Q_GLOBAL_STATIC(DwmSpecialEffect,Dwm)

