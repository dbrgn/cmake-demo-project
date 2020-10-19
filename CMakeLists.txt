cmake_minimum_required(VERSION 3.5)

project(cmake-demo-project LANGUAGES CXX)

set(CMAKE_INCLUDE_CURRENT_DIR ON)

set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(QT NAMES Qt6 Qt5 COMPONENTS Widgets LinguistTools REQUIRED)
find_package(Qt${QT_VERSION_MAJOR} COMPONENTS Widgets LinguistTools REQUIRED)

set(CMAKE_MODULE_PATH "${PROJECT_SOURCE_DIR}/cmake/modules/")
#find_package(PkgConfig REQUIRED)
#find_package(Cmark MODULE REQUIRED)

set(CMARK_MODULE_BASEPATH "${PROJECT_SOURCE_DIR}/3rdparty/cmark")
ExternalProject_Add(Cmark
	SOURCE_DIR "${CMARK_MODULE_BASEPATH}"
)
set(CMARK_STATIC ON)
set(CMARK_DYNAMIC OFF)
set(CMARK_TESTS OFF)
include_directories("${CMARK_MODULE_BASEPATH}/src")

set(TS_FILES cmake-demo-project_de_CH.ts)

add_executable(cmake-demo-project
    main.cpp
    mainwindow.cpp
    mainwindow.h
    mainwindow.ui
    ${TS_FILES}
)

target_link_libraries(cmake-demo-project PRIVATE
  Qt${QT_VERSION_MAJOR}::Widgets
)
#target_include_directories(cmake-demo-project PUBLIC)
#target_compile_options(cmake-demo-project PUBLIC)

qt5_create_translation(QM_FILES ${CMAKE_SOURCE_DIR} ${TS_FILES})

