set(CMARK_SUBMODULE_BASEPATH "${PROJECT_SOURCE_DIR}/3rdparty/cmark")

# Include local submodule
add_subdirectory("${CMARK_SUBMODULE_BASEPATH}" EXCLUDE_FROM_ALL)

# Only build static lib
set_property(TARGET libcmark_static PROPERTY CMARK_STATIC ON)
set_property(TARGET libcmark_static PROPERTY CMARK_SHARED OFF)
set_property(TARGET libcmark_static PROPERTY CMARK_TESTS OFF)

# Alias static lib to namespaced variant
add_library(cmark::cmark ALIAS libcmark_static)
