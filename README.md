# SxE CMake Support

Common cmake build system support that is shared across the various modularized
projects of SxE.

## Setting up a new SxE project module

Create your new project module.

```sh
git init sxeNewModule
cd sxeNewModule
```

Now add this repo as a submodule.

```sh
git submodule add git@github.com:Spidey01/sxecmake.git sxecmake
# if readonly: https://github.com/Spidey01/sxecmake.git
git submodule init
git submodule update
```

Now setup a CMakeLists.txt to use the submodule.

```cmake
project(sxeNewModule ...)
list(APPEND CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR}/sxecmake/Modules)
include(sxe_cmake)
```

Now create the applicable project directories and files.

```sh
mkdir src               # or source
mkdir lib               # or library
mkdir -p include/sxe
mkdir tests             # or testing
touch CHANGELOG.md COPYING LICENSE.md README.md
```

See Examples for what a module might do with this.
