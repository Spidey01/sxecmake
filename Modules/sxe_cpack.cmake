# CPack support for SxE modular projects.
# Projects should set the following variables before include:
# - CPACK_PACKAGE_CONTACT
# - SXE_LICENSE_POLICY to set the license for applicable packages.
# - SXE_PACKAGE_RELEASE set to the release number of the package. Defaults to dev.
# - SXE_PACKAGE_DEPENDS set to the package names the package depends on.
#
# ZIP package is always generated as this is my preferred archive format. Debian
# and RPM packages will be generated automatically if the associated tools are
# found using find_program().
#

include_guard(GLOBAL)

set(CPACK_PACKAGE_VERSION_MAJOR ${PROJECT_VERSION_MAJOR})
set(CPACK_PACKAGE_VERSION_MINOR ${PROJECT_VERSION_MINOR})
set(CPACK_PACKAGE_VERSION_PATCH ${PROJECT_VERSION_PATCH})
set(CPACK_RESOURCE_FILE_LICENSE "${CMAKE_CURRENT_SOURCE_DIR}/${sxe_project_license_file}")
set(CPACK_RESOURCE_FILE_README "${CMAKE_CURRENT_SOURCE_DIR}/${sxe_project_readme_file}")
set(CPACK_PACKAGE_DESCRIPTION_FILE "${CMAKE_CURRENT_SOURCE_DIR}/${sxe_project_readme_file}")
if (NOT CPACK_PACKAGE_CONTACT )
    message(AUTHOR_WARNING "CPACK_PACKAGE_CONTACT is not set")
endif()
if (NOT SXE_LICENSE_POLICY)
    message(AUTHOR_WARNING "SXE_LICENSE_POLICY is not set.")
endif()
if (NOT SXE_PACKAGE_RELEASE)
    set(SXE_PACKAGE_RELEASE "dev")
endif()

# Use ncpu threads where applicable. CPACK default is 1 thread.
set(CPACK_THREADS 0)

set(CPACK_GENERATOR "ZIP")
find_program(HAVE_DEB dpkg)
if (HAVE_DEB)
    list(APPEND CPACK_GENERATOR "DEB")
    set(CPACK_DEBIAN_PACKAGE_DEPENDS ${SXE_PACKAGE_DEPENDS})
    set(CPACK_DEBIAN_PACKAGE_RELEASE ${SXE_PACKAGE_RELEASE})
endif()
find_program(HAVE_RPM rpmbuild)
if (HAVE_RPM)
    list(APPEND CPACK_GENERATOR "RPM")
    set(CPACK_RPM_PACKAGE_DEPENDS ${SXE_PACKAGE_DEPENDS})
    set(CPACK_RPM_PACKAGE_LICENSE "${SXE_LICENSE_POLICY}")
    set(CPACK_RPM_PACKAGE_RELEASE ${SXE_PACKAGE_RELEASE})
    # append ${?dist} to CPACK_RPM_PACKAGE_RELEASE.
    set(CPACK_RPM_PACKAGE_RELEASE_DIST ON)
endif()
