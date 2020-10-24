# CMake version configuration
cmake_minimum_required(VERSION 3.2...3.18)
if(${CMAKE_VERSION} VERSION_LESS 3.12)
    cmake_policy(VERSION ${CMAKE_MAJOR_VERSION}.${CMAKE_MINOR_VERSION})
endif()

# Define project
project(cmake-demo-project
    VERSION 0.1
    DESCRIPTION "A demo project to test cmake."
    LANGUAGES CXX)

# Options
option(UNBUNDLE_CMARK "Don't use vendored cmark library." OFF)
option(UNBUNDLE_ALL "Don't use any vendored library." OFF)

# Auto-include current directory
set(CMAKE_INCLUDE_CURRENT_DIR ON)

# Require out-of-source builds
file(TO_CMAKE_PATH "${PROJECT_BINARY_DIR}/CMakeLists.txt" LOC_PATH)
if(EXISTS "${LOC_PATH}")
    message(FATAL_ERROR "You cannot build in a source directory (or any directory with a CMakeLists.txt file). Please make a build subdirectory. Feel free to remove CMakeCache.txt and CMakeFiles.")
endif()

# Pick C++11
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

# Configure module path
set(CMAKE_MODULE_PATH "${PROJECT_SOURCE_DIR}/cmake" ${CMAKE_MODULE_PATH})

# Find Qt
find_package(QT NAMES Qt6 Qt5 COMPONENTS Widgets LinguistTools REQUIRED)
find_package(Qt${QT_VERSION_MAJOR} COMPONENTS Widgets LinguistTools REQUIRED)

# Lib: cmark
find_package(cmark REQUIRED)

# Translations
set(TS_FILES cmake-demo-project_de_CH.ts)

# Add an executable
set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
add_executable(cmake-demo-project
    main.cpp
    mainwindow.cpp
    mainwindow.h
    mainwindow.ui
    ${TS_FILES}
)

target_link_libraries(cmake-demo-project PRIVATE
    Qt${QT_VERSION_MAJOR}::Widgets
    cmark::cmark
)

qt5_create_translation(QM_FILES ${CMAKE_SOURCE_DIR} ${TS_FILES})

