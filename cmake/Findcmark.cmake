set(CMARK_SUBMODULE_BASEPATH "${PROJECT_SOURCE_DIR}/3rdparty/cmark")

# Only build static lib
set(CMARK_STATIC ON CACHE BOOL "Build static libcmark library" FORCE)
set(CMARK_SHARED OFF CACHE BOOL "Build shared libcmark library" FORCE)
set(CMARK_TESTS OFF CACHE BOOL "Build cmark tests and enable testing" FORCE)

# Include local submodule
add_subdirectory("${CMARK_SUBMODULE_BASEPATH}" EXCLUDE_FROM_ALL)

# Alias static lib to namespaced variant
add_library(cmark::cmark ALIAS libcmark_static)
