#!/bin/sh
# export sxelog_DIR to the path to sxelogConfig.cmake.

rm -rf build
cmake \
    --log-level TRACE \
    -S . \
    -B build \
    $*
