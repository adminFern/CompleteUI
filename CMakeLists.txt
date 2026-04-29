cmake_minimum_required(VERSION 3.16)

project(Framework  VERSION 0.1 LANGUAGES CXX)


set(FLACOREUI_DIRECTORY ${CMAKE_SOURCE_DIR})
option(FLACOREUI_BUILD_EXAMPLES "example Build Examples." ON)  #构建案例
option(FLACOREUI_BUILD_STATIC_LIB "FlaCoreUI Build Static Library." ON)  #构建静态库

add_subdirectory(FlaCoreUI)

if (FLACOREUI_BUILD_EXAMPLES)
    add_subdirectory(example)
endif ()

