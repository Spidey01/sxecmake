# SxE install functions.

include_guard(GLOBAL)
include(CMakePackageConfigHelpers)
include(GNUInstallDirs)
include(GenerateExportHeader)

# usage: sxe_install_docs(<options...>)
#   [FILES ...]         -> relative to CMAKE_CURRENT_SOURCE_DIR.
#                          Defaults subject to change.
#   [COMPONENT ...]     -> passed to install(). Default is TBD.
#   [DESTINATION ...]   -> relative to CMAKE_INSTALLDOCDIR.
function(sxe_install_docs)
    cmake_parse_arguments(MY "" "COMPONENT;DESTINATION" "FILES" ${ARGN})
    if (NOT DEFINED MY_COMPONENT)
        set(MY_COMPONENT "") # TBD
    endif()
    if (NOT DEFINED MY_DESTINATION)
        set(MY_DESTINATION "") # CMAKE_INSTALL_DOCDIR is already qualified by name.
    endif()
    if (NOT DEFINED MY_FILES)
        set(MY_FILES 
            README.md
            CHANGELOG.md
            COPYING)
    endif()
    message(TRACE "sxe_install_docs: COMPONENT: ${MY_COMPONENT} DESTINATION: ${MY_DESTINATION} FILES: ${MY_FILES}")
    install(FILES ${MY_FILES}
        COMPONENT ${MY_COMPONENT}
        DESTINATION ${CMAKE_INSTALL_DOCDIR}/${MY_DESTINATION})
endfunction()

# usage: sxe_install_headers(<options...>)
#   [FILES sxe/module/... ...]  -> relative to CMAKE_CURRENT_SOURCE_DIR.
#   [COMPONENT ...]             -> passed to install(). Default is devel.
#   [DESTINATION ...]           -> relative to CMAKE_INCLUDEDIR. Default is sxe.
#
function(sxe_install_headers)
    cmake_parse_arguments(MY "" "COMPONENT;DESTINATION" "FILES" ${ARGN})
    if (NOT DEFINED MY_COMPONENT)
        set(MY_COMPONENT "devel")
    endif()
    if (NOT DEFINED MY_DESTINATION)
        set(MY_DESTINATION sxe)
    endif()
    message(TRACE "sxe_install_headers: COMPONENT: ${MY_COMPONENT} DESTINATION: ${MY_DESTINATION} FILES: ${MY_FILES}")
    install(FILES ${MY_FILES}
        COMPONENT ${MY_COMPONENT}
        DESTINATION ${CMAKE_INCLUDEDIR}/${MY_DESTINATION})
endfunction()

# usage: sxe_install_targets(<target>)
#
# Creates an install(TARGETS ...) command using the expected locations for an
# SxE modular project.
#
function(sxe_install_targets library_target)
    install(TARGETS ${library_target}
        EXPORT ${library_target}Targets
        RUNTIME DESTINATION "${CMAKE_INSTALL_BINDIR}"
        ARCHIVE DESTINATION "${CMAKE_INSTALL_LIBDIR}"
        LIBRARY DESTINATION "${CMAKE_INSTALL_LIBDIR}"
        INCLUDES DESTINATION "${CMAKE_INSTALL_INCLUDEDIR}"
        PUBLIC_HEADER DESTINATION "${CMAKE_INSTALL_INCLUDEDIR}")
endfunction()

# usage: sxe_install_export(<target>)
#
# Creates an install(EXPORT ...) command using the expected values for an SxE
# modular project.
#
function(sxe_install_export library_target)
    install(EXPORT ${library_target}Targets
        FILE ${library_target}Targets.cmake
        NAMESPACE SxE::
        DESTINATION lib/cmake/${library_target})
endfunction()
