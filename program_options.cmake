cmake_minimum_required(VERSION 3.1)

set(BOOST_PROGRAM_OPTIONS_SOURCE_FILES
        ../boost/libs/program_options/src/cmdline.cpp
        ../boost/libs/program_options/src/config_file.cpp
        ../boost/libs/program_options/src/convert.cpp
        ../boost/libs/program_options/src/options_description.cpp
        ../boost/libs/program_options/src/parsers.cpp
        ../boost/libs/program_options/src/positional_options.cpp
        ../boost/libs/program_options/src/split.cpp
        ../boost/libs/program_options/src/utf8_codecvt_facet.cpp
        ../boost/libs/program_options/src/value_semantic.cpp
        ../boost/libs/program_options/src/variables_map.cpp
        ../boost/libs/program_options/src/winmain.cpp
)

boost_link(program_options)

if(BUILD_SHARED_LIBS)
    list(APPEND boost_defs_interface BOOST_PROGRAM_OPTIONS_DYN_LINK=1)
endif()
