set(CMARK_SUBMODULE_BASEPATH "${PROJECT_SOURCE_DIR}/3rdparty/cmark")
if(EXISTS "${CMARK_SUBMODULE_BASEPATH}" AND NOT UNBUNDLE_CMARK AND NOT UNBUNDLE_ALL)
    message(STATUS "Using vendored cmark")

    # Only build static lib
    set(CMARK_STATIC ON)
    set(CMARK_DYNAMIC OFF)
    set(CMARK_TESTS OFF)

    # Include local submodule
    add_subdirectory("${CMARK_SUBMODULE_BASEPATH}" EXCLUDE_FROM_ALL)

    # Alias static lib to namespaced variant
    add_library(cmark::cmark ALIAS libcmark_static)

    # Stop here, we're done
    return()
endif()

# Otherwise, try to find shared library on the system

message(STATUS "Using system cmark")
find_package(PkgConfig)
pkg_check_modules(PC_CMARK QUIET cmark)

if(NOT CMARK_INCLUDE_DIR)
    find_path(CMARK_INCLUDE_DIR
        NAMES cmark.h
        PATHS ${PC_CMARK_INCLUDEDIR}
        ${PC_CMARK_INCLUDE_DIRS}
        /usr/include
        /usr/local/include)
endif()

if(NOT CMARK_LIBRARY)
    find_library(CMARK_LIBRARY
        NAMES cmark
        HINTS ${PC_CMARK_LIBDIR}
        ${PC_CMARK_LIBRARY_DIRS}
        /usr/lib
        /usr/local/lib)
endif()

if(NOT TARGET cmark::cmark)
    add_library(cmark::cmark UNKNOWN IMPORTED)
    set_target_properties(cmark::cmark
        PROPERTIES INTERFACE_INCLUDE_DIRECTORIES
        ${CMARK_INCLUDE_DIR})
    set_property(TARGET cmark::cmark APPEND
        PROPERTY IMPORTED_LOCATION ${CMARK_LIBRARY})
endif()

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(cmark
    DEFAULT_MSG
    CMARK_INCLUDE_DIR
    CMARK_LIBRARY)

mark_as_advanced(CMARK_LIBRARY CMARK_INCLUDE_DIR)

set(CMARK_LIBRARIES ${CMARK_LIBRARY})
set(CMARK_INCLUDE_DIRS ${CMARK_INCLUDE_DIR})
