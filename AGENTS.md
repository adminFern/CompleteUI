# FlaCoreUI

Qt6 + QML Fluent Design UI 库。

## 构建

```bash
cmake -B build
cmake --build build
```

- 输出：`bin/FlaCoreUI/`（QML 模块）、`bin/example.exe`（示例）
- 静态库选项：`-DFLACOREUI_BUILD_STATIC_LIB=ON`
- 示例选项：`-DFLACOREUI_BUILD_EXAMPLES=ON`

## QML 模块

- URI：`FlaCoreUI`
- 导入：`import FlaCoreUI`
- 入口组件：`FlaWindow`

## 关键文件

- `FlaCoreUI/CMakeLists.txt`：库构建配置
- `example/CMakeLists.txt`：示例构建配置
- `example/main.cpp`：示例入口，使用 `QQmlApplicationEngine` + `qrc:/qml/Main.qml`
- `FlaCoreUI/Controls/`：UI 组件目录
- `FlaCoreUI/impl/`：C++ 私有实现（Frameless、Theme、Colors 等）

## Qt6 CMake 规范

已自动配置：
```cmake
set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_CXX_STANDARD 17)
```

使用 `qt_add_qml_module` 注册 QML 模块，禁止手动调用 `qmlRegisterType`。
