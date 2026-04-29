#include "DwmSpecialEffect.h"

bool DwmSpecialEffect::isWindow8()
{
    RTL_OSVERSIONINFOW rovi = getRealOSVersion();
    return (rovi.dwMajorVersion > 6) || (rovi.dwMajorVersion == 6 && rovi.dwMinorVersion >= 2);
}

bool DwmSpecialEffect::isWin8OrGreater()
{
    return isWindow8();
}

bool DwmSpecialEffect::isWin8Point1OrGreater()
{
    RTL_OSVERSIONINFOW rovi = getRealOSVersion();
    return (rovi.dwMajorVersion > 6) || (rovi.dwMajorVersion == 6 && rovi.dwMinorVersion >= 3);
}

bool DwmSpecialEffect::isWindow11()
{
    RTL_OSVERSIONINFOW rovi = getRealOSVersion();
    return (rovi.dwMajorVersion > 10) ||
           (rovi.dwMajorVersion == 10 && rovi.dwMinorVersion >= 0 && rovi.dwBuildNumber >= 22000);
}
bool DwmSpecialEffect::isWindow1122H2()
{
    RTL_OSVERSIONINFOW rovi = getRealOSVersion();
    return (rovi.dwMajorVersion > 10) ||
           (rovi.dwMajorVersion == 10 && rovi.dwMinorVersion >= 0 && rovi.dwBuildNumber >= 22621);
}

bool DwmSpecialEffect::isWindow10()
{
    RTL_OSVERSIONINFOW rovi = getRealOSVersion();
    return (rovi.dwMajorVersion > 10) || (rovi.dwMajorVersion == 10 && rovi.dwMinorVersion >= 0);
}

bool DwmSpecialEffect::isWindow101809()
{
    RTL_OSVERSIONINFOW rovi = getRealOSVersion();
    return (rovi.dwMajorVersion > 10) ||
           (rovi.dwMajorVersion == 10 && rovi.dwMinorVersion >= 0 && rovi.dwBuildNumber >= 17763);
}

bool DwmSpecialEffect::isWindow101903O()
{
    RTL_OSVERSIONINFOW rovi = getRealOSVersion();
    return (rovi.dwMajorVersion > 10) ||
           (rovi.dwMajorVersion == 10 && rovi.dwMinorVersion >= 0 && rovi.dwBuildNumber >= 18362);
}

bool DwmSpecialEffect::isWindow7()
{
    RTL_OSVERSIONINFOW rovi = getRealOSVersion();
    return rovi.dwMajorVersion == 7;
}

bool DwmSpecialEffect::isCompositionEnabled()
{
    if (_Init)
    {
        BOOL composition_enabled = false;
        pDwmIsCompositionEnabled(&composition_enabled);
        return composition_enabled;
    }
    return false;
}

void DwmSpecialEffect::setShadow(HWND hwnd)
{
    const MARGINS shadow = {1, 0, 0, 0};
    if (_Init)
    {
        pDwmExtendFrameIntoClientArea(hwnd, &shadow);
    }
    if (isWindow7())
    {
        SetClassLong(hwnd, GCL_STYLE, GetClassLong(hwnd, GCL_STYLE) | CS_DROPSHADOW);
    }
}

bool DwmSpecialEffect::setWindowDarkMode(HWND hwnd)
{
    if (!_Init)
    {
        return false;
    }
    BOOL value = TRUE;
    return bool(pDwmSetWindowAttribute(hwnd, 20, &value, sizeof(BOOL)));
}

bool DwmSpecialEffect::setWindowLightMode(HWND hwnd)
{

    if (!_Init)
    {
        return false;
    }
    BOOL value = FALSE;
    return bool(pDwmSetWindowAttribute(hwnd, 20, &value, sizeof(BOOL)));
}

bool DwmSpecialEffect::setWindowEffect(HWND hwnd, const int key)
{

    if (isWindow11() && _Init && key>=0 && key<=3) {
        const MARGINS margins{-1, -1, -1, -1};
        if (key==1) {
            pDwmExtendFrameIntoClientArea(hwnd, &margins);
            if (isWindow1122H2())
            {
                const DWORD backdropType = 2; // DWMSBT_MAINWINDOW
                return SUCCEEDED(pDwmSetWindowAttribute(hwnd, 38, &backdropType, sizeof(backdropType)));
            }
            else
            {
                const BOOL enableMica = TRUE;
                return SUCCEEDED(pDwmSetWindowAttribute(hwnd, 1029, &enableMica, sizeof(enableMica)));
            }
        }

        if(key==2){
            pDwmExtendFrameIntoClientArea(hwnd, &margins);
            const DWORD backdropType = 4; // DWMSBT_TRANSIENTWINDOW
            return SUCCEEDED(pDwmSetWindowAttribute(hwnd, 38, &backdropType, sizeof(backdropType)));
        }
        if(key==3){

            pDwmExtendFrameIntoClientArea(hwnd, &margins);
            const DWORD backdropType = 3; // DWMSBT_TABBEDWINDOW
            return SUCCEEDED(pDwmSetWindowAttribute(hwnd, 38, &backdropType, sizeof(backdropType)));
        }
    }

    // if (key == 4) {
    //     if ((isWindow7() && !isCompositionEnabled()) || !_Init) {
    //         return false;
    //     }
    //     if (isWin8OrGreater()) {
    //         ACCENT_POLICY policy{};
    //         policy.dwAccentState = ACCENT_ENABLE_BLURBEHIND;
    //         policy.dwAccentFlags = ACCENT_NONE;
    //         WINDOWCOMPOSITIONATTRIBDATA wcad{};
    //         wcad.Attrib = WCA_ACCENT_POLICY;
    //         wcad.pvData = &policy;
    //         wcad.cbData = sizeof(policy);
    //         return pSetWindowCompositionAttribute(hwnd, &wcad);
    //     } else {
    //         DWM_BLURBEHIND bb{};
    //         bb.fEnable = TRUE;
    //         bb.dwFlags = DWM_BB_ENABLE;
    //         return SUCCEEDED(pDwmEnableBlurBehindWindow(hwnd, &bb));
    //     }
    // }
    return false;
}

bool DwmSpecialEffect::isFullScreen(const HWND hwnd)
{
    RECT windowRect = {};
    if (::GetWindowRect(hwnd, &windowRect) == FALSE)
    {
        return false;
    }
    const std::optional<MONITORINFOEXW> mi = getMonitorForWindow(hwnd);
    if (!mi.has_value())
    {
        return false;
    }
    RECT rcMonitor = mi.value().rcMonitor;
    return windowRect.top == rcMonitor.top && windowRect.left == rcMonitor.left &&
           windowRect.right == rcMonitor.right && windowRect.bottom == rcMonitor.bottom;
}

bool DwmSpecialEffect::isMaximized(const HWND hwnd)
{
    WINDOWPLACEMENT wp;
    ::GetWindowPlacement(hwnd, &wp);
    return wp.showCmd == SW_MAXIMIZE;
}

DwmSpecialEffect::DwmSpecialEffect()
{

    if (_Init == false)
    {
        _Init = this->Initialization();
    }
}

DwmSpecialEffect::~DwmSpecialEffect()
{
    // 注意：ntdll.dll 是通过 GetModuleHandle 获取的，不需要 FreeLibrary
    // 只释放通过 LoadLibrary 加载的库
    if (_dwmapiMod != nullptr)
    {
        ::FreeLibrary(_dwmapiMod);
        _dwmapiMod = nullptr;
    }
    if (_user32Mod != nullptr)
    {
        ::FreeLibrary(_user32Mod);
        _user32Mod = nullptr;
    }
    // _ntdllhMod 不需要释放，因为它是系统模块
}

RTL_OSVERSIONINFOW DwmSpecialEffect::getRealOSVersionImpl()
{
    HMODULE ntdllMod = ::GetModuleHandleW(L"ntdll.dll");
    if (!ntdllMod)
    {
        // 如果无法获取 ntdll.dll 句柄，返回默认值
        RTL_OSVERSIONINFOW rovi{};
        rovi.dwOSVersionInfoSize = sizeof(rovi);
        return rovi;
    }

    using RtlGetVersionPtr = NTSTATUS(WINAPI *)(PRTL_OSVERSIONINFOW);
    auto pRtlGetVersion =
        reinterpret_cast<RtlGetVersionPtr>(::GetProcAddress(ntdllMod, "RtlGetVersion"));

    RTL_OSVERSIONINFOW rovi{};
    rovi.dwOSVersionInfoSize = sizeof(rovi);

    if (pRtlGetVersion)
    {
        pRtlGetVersion(&rovi);
    }

    return rovi;
}

RTL_OSVERSIONINFOW DwmSpecialEffect::getRealOSVersion()
{
    static const auto result = getRealOSVersionImpl();
    return result;
}

std::optional<MONITORINFOEXW> DwmSpecialEffect::getMonitorForWindow(const HWND hwnd)
{
    Q_ASSERT(hwnd);
    if (!hwnd)
    {
        return std::nullopt;
    }
    const HMONITOR monitor = ::MonitorFromWindow(hwnd, MONITOR_DEFAULTTONEAREST);
    if (!monitor)
    {
        return std::nullopt;
    }
    MONITORINFOEXW monitorInfo;
    ::SecureZeroMemory(&monitorInfo, sizeof(monitorInfo));
    monitorInfo.cbSize = sizeof(monitorInfo);
    if (::GetMonitorInfoW(monitor, &monitorInfo) == FALSE)
    {
        return std::nullopt;
    }
    return monitorInfo;
}

quint32 DwmSpecialEffect::getDpiForWindow(const HWND hwnd, const bool horizontal)
{
    if (const UINT dpi = pGetDpiForWindow(hwnd))
    {
        return dpi;
    }
    if (const HDC hdc = ::GetDC(hwnd))
    {
        bool valid = false;
        const int dpiX = ::GetDeviceCaps(hdc, LOGPIXELSX);
        const int dpiY = ::GetDeviceCaps(hdc, LOGPIXELSY);
        if ((dpiX > 0) && (dpiY > 0))
        {
            valid = true;
        }
        ::ReleaseDC(hwnd, hdc);
        if (valid)
        {
            return (horizontal ? dpiX : dpiY);
        }
    }
    return 96;
}

int DwmSpecialEffect::getSystemMetrics(const HWND hwnd, const int index, const bool horizontal)
{
    const UINT dpi = getDpiForWindow(hwnd, horizontal);
    if (const int result = pGetSystemMetricsForDpi(index, dpi); result > 0)
    {
        return result;
    }
    return ::GetSystemMetrics(index);
}

quint32 DwmSpecialEffect::getResizeBorderThickness(const HWND hwnd, const bool horizontal, const qreal devicePixelRatio)
{
    auto frame = horizontal ? SM_CXSIZEFRAME : SM_CYSIZEFRAME;
    auto result =
        getSystemMetrics(hwnd, frame, horizontal) + getSystemMetrics(hwnd, 92, horizontal);
    if (result > 0)
    {
        return result;
    }
    int thickness = isCompositionEnabled() ? 8 : 4;
    return qRound(thickness * devicePixelRatio);
}

bool DwmSpecialEffect::Initialization()
{

    // 加载 dwmapi.dll
    _dwmapiMod = LoadLibraryW(L"dwmapi.dll");
    if (_dwmapiMod)
    {
        if (!pDwmSetWindowAttribute)
        {
            pDwmSetWindowAttribute = reinterpret_cast<DwmSetWindowAttributeFunc>(
                GetProcAddress(_dwmapiMod, "DwmSetWindowAttribute"));
            if (!pDwmSetWindowAttribute)
            {
                FreeLibrary(_dwmapiMod);
                _dwmapiMod = nullptr;
                return false;
            }
        }
        if (!pDwmExtendFrameIntoClientArea)
        {
            pDwmExtendFrameIntoClientArea = reinterpret_cast<DwmExtendFrameIntoClientAreaFunc>(
                GetProcAddress(_dwmapiMod, "DwmExtendFrameIntoClientArea"));
            if (!pDwmExtendFrameIntoClientArea)
            {
                FreeLibrary(_dwmapiMod);
                _dwmapiMod = nullptr;
                return false;
            }
        }
        if (!pDwmIsCompositionEnabled)
        {
            pDwmIsCompositionEnabled = reinterpret_cast<DwmIsCompositionEnabledFunc>(
                GetProcAddress(_dwmapiMod, "DwmIsCompositionEnabled"));
            if (!pDwmIsCompositionEnabled)
            {
                FreeLibrary(_dwmapiMod);
                _dwmapiMod = nullptr;
                return false;
            }
        }
        if (!pDwmEnableBlurBehindWindow)
        {
            pDwmEnableBlurBehindWindow = reinterpret_cast<DwmEnableBlurBehindWindowFunc>(
                GetProcAddress(_dwmapiMod, "DwmEnableBlurBehindWindow"));
            if (!pDwmEnableBlurBehindWindow)
            {
                FreeLibrary(_dwmapiMod);
                _dwmapiMod = nullptr;
                return false;
            }
        }
    }
    else
    {
        return false;
    }

    // 加载 user32.dll
    _user32Mod = LoadLibraryW(L"user32.dll");
    if (_user32Mod)
    {
        if (!pSetWindowCompositionAttribute)
        {
            pSetWindowCompositionAttribute = reinterpret_cast<SetWindowCompositionAttributeFunc>(
                GetProcAddress(_user32Mod, "SetWindowCompositionAttribute"));
            if (!pSetWindowCompositionAttribute)
            {
                FreeLibrary(_user32Mod);
                _user32Mod = nullptr;
                return false;
            }
        }

        if (!pGetDpiForWindow)
        {
            pGetDpiForWindow =
                reinterpret_cast<GetDpiForWindowFunc>(GetProcAddress(_user32Mod, "GetDpiForWindow"));
            if (!pGetDpiForWindow)
            {
                FreeLibrary(_user32Mod);
                _user32Mod = nullptr;
                return false;
            }
        }

        if (!pGetSystemMetricsForDpi)
        {
            pGetSystemMetricsForDpi = reinterpret_cast<GetSystemMetricsForDpiFunc>(
                GetProcAddress(_user32Mod, "GetSystemMetricsForDpi"));
            if (!pGetSystemMetricsForDpi)
            {
                FreeLibrary(_user32Mod);
                _user32Mod = nullptr;
                return false;
            }
        }
    }
    else
    {
        // 如果 user32.dll 加载失败，清理已加载的 dwmapi.dll
        if (_dwmapiMod)
        {
            FreeLibrary(_dwmapiMod);
            _dwmapiMod = nullptr;
        }
        return false;
    }

    // 获取 ntdll.dll 句柄（不需要 LoadLibrary，因为它总是已加载的）
    _ntdllhMod = GetModuleHandleW(L"ntdll.dll");
    if (!_ntdllhMod)
    {
        // 清理已加载的库
        if (_dwmapiMod)
        {
            FreeLibrary(_dwmapiMod);
            _dwmapiMod = nullptr;
        }
        if (_user32Mod)
        {
            FreeLibrary(_user32Mod);
            _user32Mod = nullptr;
        }
        return false;
    }

    return true;
}
