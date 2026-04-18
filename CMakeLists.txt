cmake_minimum_required(VERSION 3.16)

project(CompleteUI VERSION 0.1 LANGUAGES CXX)

#设置程序输出目录
#set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/bin)

set(COMPLETEUI_DIRECTORY ${CMAKE_SOURCE_DIR})

#set(QT_QML_GENERATE_QMLLS_INI ON)

option(COMPLETEUI_BUILD_EXAMPLES "example Build Examples." ON)  #构建案例
option(COMPLETEUI_BUILD_STATIC_LIB "CompleteUI Build Static Library." OFF)  #构建静态库


# 设置静态库文件输出目录
#set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/bin)
#set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
add_subdirectory(CompleteUI)

add_subdirectory(example)


