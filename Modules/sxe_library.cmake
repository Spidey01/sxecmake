# SxE functions for modular libraries.

include_guard(GLOBAL)
include(GNUInstallDirs)
include(sxe_config)

# usage: sxe_add_module(library_target options...)
# SOURCES ...
# [COMPONENT <libs>]
# [EXPORT_FILE_NAME <${library_target}_export.hpp>]
# [PUBLIC_INCLUDES ...]
#
# Adds the project's main library 'module'.
#
# Using the above options, library_target will be defined using add_library(),
# then configured using sxe_include_directories(), an export header will be
# added using sxe_generate_export_header(). Appropriate install commands will be
# generated for all the things. The provided options can be used to modify the
# behavior, but in most cases only SOURCES is necessary.
#
function(sxe_add_module library_target)
    set(options "")
    set(one_value_keywords "EXPORT_FILE_NAME;COMPONENT")
    set(multi_value_keywords "SOURCES;PUBLIC_INCLUDES")
    cmake_parse_arguments(PARSE_ARGV 1 MY "${options}" "${one_value_keywords}" "${multi_value_keywords}")
    if (NOT MY_COMPONENT)
        set(MY_COMPONENT "libs")
    endif()
    if (NOT MY_EXPORT_FILE_NAME)
        set(MY_EXPORT_FILE_NAME ${library_target}_export.hpp)
    endif()
    message(TRACE "sxe_add_module: library_target: ${library_target} SOURCES: ${MY_SOURCES} COMPONENT: ${MY_COMPONENT} EXPORT_FILE_NAME: ${MY_EXPORT_FILE_NAME}")

    add_library(${library_target} ${MY_SOURCES})
    sxe_compile_features(${library_target} PUBLIC)
    sxe_include_directories(${library_target} PUBLIC)
    if (MY_PUBLIC_INCLUDES)
        target_include_directories(${library_target} PUBLIC ${MY_PUBLIC_INCLUDES})
    endif()
    if (MY_EXPORT_FILE_NAME)
        sxe_generate_export_header(${library_target} ${MY_EXPORT_FILE_NAME})
    endif()
    sxe_cmake_package_config(${library_target})
    sxe_install_targets(${library_target})
    sxe_install_export(${library_target})
endfunction(sxe_add_module)

# usage: sxe_add_library(<...>)
#
# Adds the project's main library 'module'. All arguments are passed to
# add_library(). The first argument is used to generate calls to ...
#
function(sxe_add_library)
    add_library(${ARGV})
    target_link_libraries(${ARGV0} ${sxe_project_module})
endfunction(sxe_add_library)

# usage: sxe_add_executable(<...>)
#
# Adds the project's main library 'module'. All arguments are passed to
# add_executable(). The first argument is used to generate calls to ...
#
function(sxe_add_executable)
    add_executable(${ARGV})
    target_link_libraries(${ARGV0} ${sxe_project_module})
endfunction(sxe_add_executable)

# usage: sxe_include_directories(target_name options...)
# [AFTER|BEFORE]
# <INTERFACE|PUBLIC|PRIVATE>
#
# Adds the standard project include dir to the specified target.
#
# The default is to add these as PUBLIC, but options may be used to modify the
# target_include_directories() command that will be generated.
#
function(sxe_include_directories target_name)
    set(options "AFTER;BEFORE;INTERFACE;PUBLIC;PRIVATE")
    set(one_value_keywords "")
    set(multi_value_keywords "")
    cmake_parse_arguments(PARSE_ARGV 1 MY "${options}" "${one_value_keywords}" "${multi_value_keywords}")
    if (MY_AFTER)
        set(maybe_before_or_after "AFTER")
    elseif (MY_BEFORE)
        set(maybe_before_or_after "BEFORE")
    endif()
    if (MY_PUBLIC)
        set(which_interface "PUBLIC")
    elseif(MY_PRIVATE)
        set(which_interface "PRIVATE")
    elseif(MY_INTERFACE)
        set(which_interface "INTERFACE")
    else()
        set(which_interface "PUBLIC")
    endif()
    target_include_directories(${target_name}
        ${maybe_before_or_after}
        ${which_interface}
        # Add the project include dir from source
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/../${sxe_project_include_dir}>
        # ditto if generated from this binary dir.
        $<BUILD_INTERFACE:${CMAKE_CURRENT_BINARY_DIR}/${sxe_project_include_dir}>
        # ditto for find_package() when installed.
        $<INSTALL_INTERFACE:${sxe_project_include_dir}>)
endfunction()
