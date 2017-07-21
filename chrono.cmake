cmake_minimum_required(VERSION 3.1)

set(BOOST_CHRONO_SOURCE_FILES
        ../boost/libs/chrono/src/chrono.cpp
        ../boost/libs/chrono/src/process_cpu_clocks.cpp
        ../boost/libs/chrono/src/thread_clock.cpp
)

list(APPEND boost_defs_public BOOST_CHRONO_SOURCE)

boost_link(chrono)

list(APPEND boost_defs_public BOOST_SYSTEM_NO_DEPRECATED)

set_source_files_properties(${BOOST_CHRONO_SOURCE_FILES} COMPILE_FLAGS -UBOOST_CHRONO_SOURCE)


