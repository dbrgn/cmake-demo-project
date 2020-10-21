# cmake demo lib

This is a demo project that uses qt + cmake. Its intention is to be used as a
playground for a potential LibrePCB build system migration.


## Structure

The most important file is `CMakeLists.txt`.

In order for `find_package(cmark)` to work, there's a find-file at
`cmake/Findcmark.cmake`.

Submodules are located in the `3rdparty` directory.


## Building

To build the project, either:

    # Configure
    mkdir build
    cd build
    cmake ..

    # Build
    make

...or:

    # Configure
    cmake -S . -B build

    # Build
    cmake --build build


## Linking

For third party libraries, linking should happen as follows:

- If the submodule is found, then that version is used and the library is
  linked statically
- Otherwise, try to find the library as a shared library on the system, link
  against that one

This means that to unbundle a vendored library, you simply delete the
directory.


## Resources

This was the most useful "modern cmake" resource I found so far:

https://cliutils.gitlab.io/modern-cmake/

The `Findcmark.cmake` module was based on this one I found on GitHub:

https://github.com/mujx/nheko/blob/master/cmake/Findcmark.cmake
