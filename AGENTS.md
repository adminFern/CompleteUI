# CompleteUI — AGENTS.md

Qt6 / Qt Quick Fluent Design 组件库。QML 组件在 `CompleteUI/Controls/`，C++ 后端在 `CompleteUI/impl/`，示例应用在 `example/`。

## 构建

```bash
cmake -S . -B build -G "MinGW Makefiles" -DCMAKE_BUILD_TYPE=Debug
cmake --build build
```

- 依赖：Qt6（Quick, Qml, QuickControls2, Sql），MinGW toolchain 需在 PATH 中
- 输出：`bin/CompleteUI/`（QML 模块 + DLL）、`bin/example.exe`
- **静态库链接目标名为 `CompleteUIplugin`，动态库为 `CompleteUI`**（`COMPLETEUI_BUILD_STATIC_LIB=ON` 切换）
- 已有 `build/` 目录，配置错误需清空后重新 cmake
- 运行 example 需将 DLL 复制到 `bin/` 与 exe 同目录

## QML 模块结构

| 路径 | 说明 |
|------|------|
| `CompleteUI/Controls/` | 所有 QML 组件（ComButton, ComWindow, ComNavigationView 等） |
| `CompleteUI/Controls/qmldir` | QML 模块描述，仅注册 `FluentIcon` 为 singleton |
| `CompleteUI/Controls/Font/FluentIcons.ttf` | Fluent 图标字体（1400+ 图标） |
| `CompleteUI/impl/` | C++ 后端（Theme, Colors, Frameless, Def.h 等） |
| `CompleteUI/Objects.qml` | `QtObject` 带 `default property list<QtObject> children`，用于 `items`/`footerItems` 嵌套包裹 |
| `CompleteUI/PaneItem*.qml` | 导航项定义（PaneItem / PaneItemExpander / PaneItemHeader / PaneItemSeparator） |
| `CompleteUI/Shadow.qml` | 可复用的阴影组件 |
| `CompleteUI/CMakeLists.txt` | 使用 `file(GLOB_RECURSE)` 自动收集 `impl/*.h *.cpp` 和根目录 `*.qml`，新增文件自动包含 |
| `QTableView.qml`（仓库根目录） | **非项目文件**（imports QuickUI），忽略即可 |

- 所有组件通过 `qt_add_qml_module` 注册为 `CompleteUI` URI，QML 中 `import CompleteUI`
- `qt_policy(SET QTP0004 NEW)`：QML 文件从源目录直接加载，不复制到构建目录
- `FluentIcon` 是 singleton，图标属性命名 `ico_*`（如 `FluentIcon.ico_GlobalNavButton`）
- `ComNavigationView` 的导航结构：
  ```qml
  items: Objects {
      PaneItem { title:"首页"; icon:FluentIcon.ico_Home; page:"qrc:/..." }
      PaneItemSeparator {}
      PaneItemExpander { title:"分组"; icon:"..."; PaneItem { ... } }
  }
  footerItems: Objects { PaneItemHeader { ... } }
  ```
  - 仅 `PaneItemExpander` 继承 `Objects`（支持嵌套子项），其他 PaneItem* 均为普通 `QtObject`
  - `PaneItem.page` 属性驱动 StackView 页面切换
- 示例页面文件位于 `example/qml/T_*.qml`，通过 `qrc:/qml/` 前缀引用，需在 `resources.qrc` 中注册

## C++ 后端关键类

| 类 | 文件 | 作用 |
|----|------|------|
| `Theme` | `impl/Theme.h/.cpp` | 主题单例（QML_SINGLETON），暴露 ThemeType(Light/Dark/System)、SpecialEffect、颜色属性 |
| `Colors` | `impl/Colors.h/.cpp` | 颜色表单例（QML_SINGLETON），含 Grey 色阶和 AccentColor 系列 |
| `AccentColor` | `impl/Colors.h` | 颜色分量对象（darkest/darker/dark/normal/light/lighter/lightest），Theme 和 Colors 各持有一个 |
| `EffectType` | `impl/Def.h` | QML namespace 枚举：Normal/Mica/MicaAlt/Acrylic |
| `DisplayType` | `impl/Def.h` | QML namespace 枚举：IconOnly/TextOnly/TextBesideIcon/IconBesideText/TextUnderIcon |
| `Frameless` | `impl/Frameless.h/.cpp` | 无边框窗口（QQuickItem），实现 DWM 特效、窗口拖拽/缩放、最大化等 |
| `DwmSpecialEffect` | `impl/private/` | `Q_GLOBAL_STATIC`，非 QML 类型，由 `Frameless` 内部调用实现 Windows DWM 特效 |

- `stdafx.h` 定义了项目专用宏，所有 C++ 类均使用：
  - `SINGLETON(ClassName)` — 注册为 QML singleton 的工厂方法 + `create()`
  - `Q_PROPERTY_AUTO(TYPE, NAME)` — 自动生成 property + getter + setter + signal（含 `_##NAME` 成员）
  - `Q_PROPERTY_AUTO_P(TYPE, NAME)` — 指针版本（成员初始化为 `nullptr`）
  - `Q_PROPERTY_READONLY_AUTO(TYPE, NAME)` — 只读属性
- 新增 C++ 类型放在 `impl/` 目录自动包含，需加 `QML_ELEMENT` / `QML_NAMED_ELEMENT` 注册到 QML
- `COM_EXPORT` 宏根据 `COMPLETEUI_STATIC` / `COMPLETEUI_LIBRARY` 宏自动做 dllimport/dllexport

## example 应用

- 入口：`example/main.cpp`（`QQmlApplicationEngine` 加载 `qrc:/qml/Main.qml`）
- Main.qml 使用 `ComWindow` + `ComAppBar` 导航结构
- `ComWindow` 继承自 `Window`（非 ApplicationWindow）；`ComAppBar` 继承自 `Rectangle`
- `appBar.buttonMaximized` 被 `Frameless` 引用，用于最大化按钮状态判定；`appBar.buttonClose/Minimized` 同样可访问
- 资源通过 `example/resources.qrc` 注册（所有 `qml/T_*.qml` 需逐一列出）

## 已知约束

- Windows 平台专用（依赖 DWM API, `windows.h`, `dwmapi.lib`）
- 部分组件使用 `Qt5Compat.GraphicalEffects`（ComButton, ComDelayButton, ComFloatButton, ComProgressBar, ComCircularProgressBar），需安装 `qt5compat` 模块
- 无 CI / 测试套件，仅通过编译验证
