cmake_minimum_required(VERSION 3.1)

set(BOOST_TIMER_SOURCE_FILES
        ../boost/libs/timer/src/auto_timers_construction.cpp
        ../boost/libs/timer/src/cpu_timer.cpp
        )

set_source_files_properties(${BOOST_TIMER_SOURCE_FILES})

if (BUILD_SHARED_LIBS)
    list(APPEND boost_defs_public BOOST_TIMER_DYN_LINK=1)
endif ()
