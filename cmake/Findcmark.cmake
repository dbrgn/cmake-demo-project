set(CMARK_SUBMODULE_BASEPATH "${PROJECT_SOURCE_DIR}/3rdparty/cmark")

# Only build static lib
set(CMARK_STATIC ON)
set(CMARK_SHARED OFF)
set(CMARK_TESTS OFF)

# Include local submodule
add_subdirectory("${CMARK_SUBMODULE_BASEPATH}" EXCLUDE_FROM_ALL)

# Alias static lib to namespaced variant
add_library(cmark::cmark ALIAS libcmark_static)
