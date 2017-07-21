cmake_minimum_required(VERSION 3.1)

set(BOOST_RANDOM_SOURCE_FILES
        ../boost/libs/random/src/random_device.cpp
        )

boost_link(atomic)

if (BUILD_SHARED_LIBS)
    list(APPEND boost_defs_public BOOST_RANDOM_DYN_LINK=1)
endif ()