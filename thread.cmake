cmake_minimum_required(VERSION 3.1)

set(BOOST_THREAD_WIN32_SOURCE_FILES
        ../boost/libs/thread/src/future.cpp
        ../boost/libs/thread/src/win32/thread.cpp
        ../boost/libs/thread/src/win32/tss_dll.cpp
        ../boost/libs/thread/src/win32/tss_pe.cpp
)
set(BOOST_THREAD_POSIX_SOURCE_FILES
        ../boost/libs/thread/src/future.cpp
        ../boost/libs/thread/src/pthread/once.cpp
        #../boost/libs/thread/src/pthread/once_atomic.cpp
        ../boost/libs/thread/src/pthread/thread.cpp
)

if (WIN32)
        set(BOOST_THREAD_SOURCE_FILES ${BOOST_THREAD_WIN32_SOURCE_FILES})
else()
        set(BOOST_THREAD_SOURCE_FILES ${BOOST_THREAD_POSIX_SOURCE_FILES})
endif()

if (BUILD_SHARED_LIBS)
        list(APPEND boost_defs_public BOOST_THREAD_BUILD_DLL=1)
        list(APPEND boost_defs_interface BOOST_THREAD_USE_DLL=1)
else()
        list(APPEND boost_defs_public BOOST_THREAD_BUILD_LIB=1)
        list(APPEND boost_defs_interface BOOST_THREAD_USE_LIB=1)
endif()

if (WIN32)
        list(APPEND boost_defs_private BOOST_THREAD_USES_CHRONO)
else()
        list(APPEND boost_defs_public BOOST_THREAD_POSIX)
        list(APPEND boost_defs_private BOOST_THREAD_DONT_USE_CHRONO)
endif()


