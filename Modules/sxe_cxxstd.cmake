# SxE functions for controlling the C++ standard.

include_guard(GLOBAL)

# Values to cmake versions...
# - 98 for C++ 1998/2003, requires cmake >= 3.1
# - 11 for C++ 2011
# - 14 for C++ 2014
# - 17 for C++ 2017, requires cmake >= 3.8
# - 20 for C++ 2020, requires cmake >= 3.12
# - 23 for C++ 2023, requires cmake >= 3.20
# - 26 for C++ 2026, requires cmake >= 3.25
#
# set(CMAKE_CXX_STANDARD 17)
# set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(sxe_cxx_standard 17 CACHE STRING "Set the C++ standard for SxE targets. Values are the same as CMAKE_CXX_STANDARD.")
set_property(CACHE sxe_cxx_standard PROPERTY STRINGS 98 11 14 17 20 23 26)

# usage: sxe_compile_features(<target> <INTERFACE|PUBLIC|PRIVATE>)
#
# Sets compile features expected of SxE targets.
#
# requires cmake >= 3.1. INTERFACE on an imported target requires cmake >= 3.11.
#
function(sxe_compile_features target_name interface_type)
    target_compile_features(${target_name} ${interface_type} cxx_std_${sxe_cxx_standard})
endfunction(sxe_compile_features)
