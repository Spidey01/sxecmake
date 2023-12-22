# Doxygen support for SxE modular projects.

include_guard(GLOBAL)
include(GNUInstallDirs)

option(BUILD_DOCS "Build documentation (Doxygen)." ON)

find_package(Doxygen)
if (DOXYGEN_FOUND AND BUILD_DOCS)
    set(DOXYGEN_EXTRACT_ALL YES)
    set(DOXYGEN_STRIP_FROM_INC_PATH ${PROJECT_SOURCE_DIR}/${sxe_project_include_dir})
    set(DOXYGEN_USE_MDFILE_AS_MAINPAGE "${PROJECT_SOURCE_DIR}/${sxe_project_readme_file}")

    # Doxygen will only show these if they are markdown files.
    doxygen_add_docs(docs
        ${PROJECT_SOURCE_DIR}/${sxe_project_include_dir}
        ${PROJECT_SOURCE_DIR}/${sxe_project_changelog_file}
        ${PROJECT_SOURCE_DIR}/${sxe_project_license_file}
        ${PROJECT_SOURCE_DIR}/${sxe_project_readme_file}
        ALL)

    install(DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/html
            DESTINATION ${CMAKE_INSTALL_DOCDIR})
endif (DOXYGEN_FOUND AND BUILD_DOCS)
