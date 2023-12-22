cmake_minimum_required(VERSION 3.13 FATAL_ERROR)
cmake_policy(SET CMP0048 NEW)

set(sxe_project_module_name "SomeModule")
# project(sxeSomeModule
project(sxe${sxe_project_module_name}
    VERSION 1.0.0
    LANGUAGES CXX
    DESCRIPTION "sxecmake testing"
    HOMEPAGE_URL "https://github.com/Spidey01/sxecmake")

set(CPACK_PACKAGE_CONTACT "Terry Poulin")
set(SXE_LICENSE_POLICY "Zlib" CACHE STRING "License reported by SxE packages.")

list(APPEND CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR}/../Modules)
include(sxe_project)
