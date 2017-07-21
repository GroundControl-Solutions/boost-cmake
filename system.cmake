cmake_minimum_required(VERSION 3.1)

set(BOOST_SYSTEM_SOURCE_FILES
        ../boost/libs/system/src/error_code.cpp
)

boost_link(system)

list(APPEND boost_defs_private BOOST_SYSTEM_SOURCE)

# BOOST_SYSTEM_SOURCE needs to be defined to link properly, but error_code.cpp already defines it, so undefine it to avoid redefintion warnings
set_source_files_properties(${BOOST_SYSTEM_SOURCE_FILES} COMPILE_FLAGS -UBOOST_SYSTEM_SOURCE)
