
# Executable that depends on the module's libraries.
add_executable(main main.cpp)
target_link_libraries(main ${sxe_project_module}foo)
