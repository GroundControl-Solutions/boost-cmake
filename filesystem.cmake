cmake_minimum_required(VERSION 3.1)

set(BOOST_FILESYSTEM_SOURCE_FILES
        ../boost/libs/filesystem/src/codecvt_error_category.cpp
        ../boost/libs/filesystem/src/operations.cpp
        ../boost/libs/filesystem/src/path.cpp
        ../boost/libs/filesystem/src/path_traits.cpp
        ../boost/libs/filesystem/src/portability.cpp
        ../boost/libs/filesystem/src/unique_path.cpp
        ../boost/libs/filesystem/src/utf8_codecvt_facet.cpp
        ../boost/libs/filesystem/src/windows_file_codecvt.cpp
        ../boost/libs/filesystem/src/windows_file_codecvt.hpp
)

boost_link(filesystem)

list(APPEND boost_defs_private BOOST_FILESYSTEM_SOURCE)

set_source_files_properties(${BOOST_FILESYSTEM_SOURCE_FILES} COMPILE_FLAGS -UBOOST_FILESYSTEM_SOURCE)
# Setting source file properties overwrites previous properties, so this special case needs to duplicate the undef
set_source_files_properties(../boost/libs/filesystem/src/operations.cpp COMPILE_FLAGS "-UBOOST_FILESYSTEM_SOURCE -Wno-parentheses-equality")

