# Include this in ./CMakeLists.txt when creating a new SxE project.

# Used by all the things.
include(GNUInstallDirs)

# Cache variables for the various common files and folders to an SxE project.

set(sxe_project_module_target "${PROJECT_NAME}" CACHE STRING "Primary library target for ${PROJECT_NAME}.")
set(sxe_project_module_prefix "sxe/SomeModule" CACHE STRING "Directory prefix for ${PROJECT_NAME}.")
set(sxe_project_module "${PROJECT_NAME}" CACHE STRING "Primary library target for ${PROJECT_NAME}.")

if (NOT sxe_project_readme_file)
    set(sxe_project_readme_file README.md CACHE STRING "Readme filename for ${PROJECT_NAME}.")
endif()
if (NOT sxe_project_license_file)
    set(sxe_project_license_file LICENSE.md CACHE STRING "License filename for ${PROJECT_NAME}.")
endif()
if (NOT sxe_project_copying_file)
    set(sxe_project_copying_file COPYING CACHE STRING "Copyright filename for ${PROJECT_NAME}.")
endif()
if (NOT sxe_project_changelog_file)
    set(sxe_project_changelog_file CHANGELOG.md CACHE STRING "Change log filename for ${PROJECT_NAME}.")
endif()
if (NOT sxe_project_include_dir)
    set(sxe_project_include_dir include CACHE STRING "Directory containing headers for ${PROJECT_NAME}")
endif()
if (NOT sxe_project_library_dir)
    if (EXISTS ${PROJECT_SOURCE_DIR}/lib/CMakeLists.txt)
        set(libdir lib)
    elseif(EXISTS ${PROJECT_SOURCE_DIR}/library/CMakeLists.txt)
        set(libdir library)
    endif()
    set(sxe_project_library_dir ${libdir} CACHE STRING "Directory containing library sources for ${PROJECT_NAME}")
endif()
if (NOT sxe_project_source_dir)
    if (EXISTS ${PROJECT_SOURCE_DIR}/src/CMakeLists.txt)
        set(sourcedir src)
    elseif(EXISTS ${PROJECT_SOURCE_DIR}/source/CMakeLists.txt)
        set(sourcedir source)
    endif()
    set(sxe_project_source_dir ${sourcedir} CACHE STRING "Directory containing application sources for ${PROJECT_NAME}")
endif()

include(sxe_cxxstd)
include(sxe_doxygen)
include(sxe_install)
include(sxe_library)
include(sxe_cpack)
include(CPack)

if (sxe_project_include_dir)
    message(TRACE "add_subdirectory(${sxe_project_include_dir})")
    add_subdirectory(${sxe_project_include_dir})
endif()
if (sxe_project_library_dir)
    message(TRACE "add_subdirectory(${sxe_project_library_dir})")
    add_subdirectory(${sxe_project_library_dir})
endif()
if (sxe_project_source_dir)
    message(TRACE "add_subdirectory(${sxe_project_source_dir})")
    add_subdirectory(${sxe_project_source_dir})
endif()
