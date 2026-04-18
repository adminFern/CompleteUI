cmake_minimum_required(VERSION 3.16)

project(CompleteUI VERSION 0.1 LANGUAGES CXX)
#QT通用设置
set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

#QML输出目录
set(QUICKUI_OUTPUT_DIRECTORY ${COMPLETEUI_DIRECTORY}/bin/${PROJECT_NAME})
if (COMPLETEUI_BUILD_STATIC_LIB)
    set(LIB_TYPE "STATIC")
     set(PLUGIN_TARGET_NAME "")
else ()
    set(LIB_TYPE "SHARED")
     set(PLUGIN_TARGET_NAME ${PROJECT_NAME})
endif ()

#查找文件
file(GLOB_RECURSE PROJECT_SOURCES *.h *.cpp)
file(GLOB_RECURSE ORIGIN_QML_FILES "${CMAKE_CURRENT_SOURCE_DIR}/*.qml")

message("QML:${ORIGIN_QML_FILES}")
foreach (filepath ${ORIGIN_QML_FILES})
    string(REPLACE "${CMAKE_CURRENT_SOURCE_DIR}/" "" filename ${filepath})
    list(APPEND Q_QML_FILES ${filename})
endforeach (filepath)


set(RES_PATHS
  Controls/Font/FluentIcons.ttf
  Controls/qmldir
  #qmldir
)
#查找库
find_package(Qt6 REQUIRED COMPONENTS Quick Qml Core QuickControls2)

qt_add_library(${PROJECT_NAME} ${LIB_TYPE}
        ${PROJECT_SOURCES}
)
qt_policy(SET QTP0004 NEW)
qt_add_qml_module(${PROJECT_NAME}
    VERSION 1.0
    URI "CompleteUI"
    TYPEINFO "plugins.qmltypes"
    QML_FILES ${Q_QML_FILES}
    SOURCES ${PROJECT_SOURCES}
    RESOURCES ${RES_PATHS}
    RESOURCE_PREFIX "/"
    PLUGIN_TARGET ${PLUGIN_TARGET_NAME} #插件目标
    OUTPUT_DIRECTORY ${QUICKUI_OUTPUT_DIRECTORY}
  )


target_link_libraries(${PROJECT_NAME} PRIVATE
     Qt6::Quick
     Qt6::Core
     Qt6::Qml
     Qt6::QuickControls2
)
# # # 设置包含目录
target_include_directories(${PROJECT_NAME} PRIVATE
    "${CMAKE_CURRENT_SOURCE_DIR}/impl/private"
    "${CMAKE_CURRENT_SOURCE_DIR}/impl"
)

if(COMPLETEUI_BUILD_STATIC_LIB)
    target_compile_definitions(${PROJECT_NAME} PUBLIC COMPLETEUI_STATIC)#静态库
else()
    target_compile_definitions(${PROJECT_NAME} PUBLIC COMPLETEUI_LIBRARY) #//动态库
endif()