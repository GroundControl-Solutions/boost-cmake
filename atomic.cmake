cmake_minimum_required(VERSION 3.1)

set(BOOST_ATOMIC_SOURCE_FILES
        ../boost/libs/atomic/src/lockpool.cpp
)

boost_link(atomic)

list(APPEND boost_defs_private BOOST_ATOMIC_SOURCE)
