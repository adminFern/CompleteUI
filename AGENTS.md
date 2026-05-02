# FlaCoreUI

Qt6/QML C++ 库。构建系统：CMake。C++17。

## 构建

构建目录名称取决于 Qt Kit 配置，示例为 `Desktop_Qt_6_11_0_MinGW_64_bit-Debug`。

```bash
cd build/Desktop_Qt_6_11_0_MinGW_64_bit-Debug
cmake --build . --parallel
```

输出：`bin/FlaCoreUI/`（库 + QML 文件），`bin/example.exe`（示例应用）。

## 项目结构

- `FlaCoreUI/` — 库源码（C++ 实现位于 `impl/`、`impl/private/`，QML 文件在根目录）
- `example/` — 示例应用入口（`main.cpp`、`qml/Main.qml`）
- `bin/` — 构建输出目录（已 `.gitignore`）
- `build/` — CMake 构建目录（已 `.gitignore`）

## 关键 CMake 选项

- `FLACOREUI_BUILD_EXAMPLES=ON|OFF` — 是否构建示例应用
- `FLACOREUI_BUILD_STATIC_LIB=ON|OFF` — 构建静态库或共享库

当 `FLACOREUI_BUILD_STATIC_LIB=ON` 时，示例链接 `FlaCoreUIplugin`；否则链接 `FlaCoreUI`。宏 `FLACOREUI_STATIC` 和 `FLACOREUI_LIBRARY` 会根据此选项自动定义。

## 依赖

Qt6 组件：Quick、Qml、Core、QuickControls2。

## 注意事项

- 示例应用运行时需要将 `bin/FlaCoreUI/` 目录通过 `QT_QML_IMPORT_PATH` 指向库 QML 模块位置（已在 CMakeLists.txt 中配置）
- `FlaCoreUI/` 根目录下的 `.qml` 文件会被自动收集进 QML 模块
- 库使用 Qt 的 `qt_add_qml_module` 注册为 QML 插件（URI：`FlaCoreUI`）
- 示例应用 `main.cpp` 中使用 `qrc:/qml/Main.qml` 加载 QML，而非 `engine.loadFromModule`