# SxE configuration template for config.h support.

include_guard(GLOBAL)
include(CMakePackageConfigHelpers)
include(GNUInstallDirs)
include(GenerateExportHeader)

# must be called here, so that CMAKE_CURRENT_LIST_DIR is set for this file not
# the caller of our functions.
file(RELATIVE_PATH sxe_cmake_templates_dir "${CMAKE_CURRENT_BINARY_DIR}" "${CMAKE_CURRENT_LIST_DIR}/../Templates")

# usage: sxe_cmake_package_config(<library_target> options...)
#   [SOURCE <library_target>Config.cmake.in]
#   [RENAME <library_target>Config.cmake]
#   [DESTINATION where]
#   [COMPATIBILITY ...]
#
function(sxe_cmake_package_config library_target)
    cmake_parse_arguments(PARSE_ARGV 1 MY "" "SOURCE;RENAME;DESTINATION;COMPATIBILITY;TEMPLATE" "" ${ARGN})
    if (NOT DEFINED MY_TEMPLATE)
        set(MY_TEMPLATE "${sxe_cmake_templates_dir}/library-config.cmake.in")
    endif()
    if (NOT DEFINED MY_SOURCE)
        set(MY_SOURCE "${library_target}Config.cmake.in")
        if (NOT EXISTS ${CMAKE_CURRENT_SOURCE_DIR}/${MY_SOURCE})
            set(MY_SOURCE "${MY_TEMPLATE}")
        endif()
    endif()
    if (NOT DEFINED MY_RENAME)
        set(MY_RENAME "${library_target}Config.cmake")
    endif()
    if (NOT DEFINED MY_DESTINATION)
        if (NOT DEFINED CMAKE_INSTALL_LIBDIR)
            message(WARNING "sxe_cmake_package_config: must specify DESTINATION or define CMAKE_INSTALL_LIBDIR")
            message(FATAL_ERROR "sxe_cmake_package_config: CMAKE_INSTALL_LIBDIR not defined!")
        endif()
        set(MY_DESTINATION "${CMAKE_INSTALL_LIBDIR}/cmake/${sxe_project_module}")
    endif()
    if (NOT DEFINED MY_COMPATIBILITY)
        set(MY_COMPATIBILITY "SameMajorVersion")
    endif()
    message(TRACE "sxe_cmake_package_config: library_target: ${library_target} SOURCE: ${MY_SOURCE} RENAME: ${MY_RENAME} DESTINATION: ${MY_DESTINATION} TEMPLATE: ${MY_TEMPLATE} COMPATIBILITY: ${MY_COMPATIBILITY}")

    configure_package_config_file(${MY_SOURCE} ${MY_RENAME}
        INSTALL_DESTINATION ${MY_DESTINATION}
    )
    install(FILES ${CMAKE_CURRENT_BINARY_DIR}/${MY_RENAME}
        DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/${sxe_project_module})

    write_basic_package_version_file(
        ${library_target}ConfigVersion.cmake
        VERSION ${PACKAGE_VERSION}
        COMPATIBILITY ${MY_COMPATIBILITY})
    install(FILES
        ${CMAKE_CURRENT_BINARY_DIR}/${library_target}ConfigVersion.cmake
        DESTINATION ${MY_DESTINATION})
endfunction()

# usage: sxe_generate_export_header(libtgt sxe/modulename/sxemodulename_export.hpp)
#
# Creates the named export header for the library target. The header will be
# created relative to ${CMAKE_CURRENT_BINARY_DIR}/{sxe_project_include_dir}/sxe and installed relative
# to $CMAKE_INSTALL_INCLUDE_DIR}.
#
function(sxe_generate_export_header library_target export_file_name)
    message(TRACE "sxe_generate_export_header: library_target: ${library_target} export_file_name: ${export_file_name} sxe_project_module_prefix: ${sxe_project_module_prefix}")
    generate_export_header(${library_target}
        EXPORT_FILE_NAME ${sxe_project_include_dir}/${sxe_project_module_prefix}/${export_file_name})
    install(FILES ${CMAKE_CURRENT_BINARY_DIR}/${sxe_project_include_dir}/${sxe_project_module_prefix}/${export_file_name}
        DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/${sxe_project_module_prefix})
endfunction()
