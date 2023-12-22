
# The big kahuna for this modular project.
sxe_add_module(${sxe_project_module}
    SOURCES lib.cpp
    EXPORT_FILE_NAME ${sxe_project_module}_export.hpp
    COMPONENT blah)

# Something that depends on the big kahuna.
sxe_add_library(${sxe_project_module}foo foo.cpp)
