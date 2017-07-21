cmake_minimum_required(VERSION 3.1)
project(boost)

include(CheckSymbolExists)
check_symbol_exists(__AVX2__ "" AVX2_EXISTS)
check_symbol_exists(__SSE3__ "" SSE3_EXISTS)

set(BOOST_INCLUDES
        ${CMAKE_CURRENT_SOURCE_DIR}/../boost
        )

function(boost_link type)
    set(upper_type type)
    set(lower_type type)
    string(TOUPPER ${type} upper_type)
    string(TOLOWER ${type} lower_type)

    if (BUILD_SHARED_LIBS)
        set(link_type DYN)
    else ()
        set(link_type STATIC)
    endif ()

    list(APPEND boost_defs_public BOOST_${upper_type}_${link_type}_LINK=1)
endfunction()

set(boost_defs_public)
set(boost_defs_private)
set(boost_defs_interface)

set(boost_link_public)
set(boost_link_private)
set(boost_link_interface)

if (BUILD_SHARED_LIBS)
    list(APPEND boost_defs_public BOOST_ALL_DYN_LINK)
endif ()
if (WIN32)
    list(APPEND boost_defs_public BOOST_WINDOWS BOOST_USE_WINDOWS_H)
endif ()
list(APPEND boost_defs_public BOOST_OPTIONAL_USE_SINGLETON_DEFINITION_OF_NONE)

include(atomic.cmake)
include(chrono.cmake)
include(date_time.cmake)
include(filesystem.cmake)
include(log.cmake)
include(program_options.cmake)
include(system.cmake)
include(thread.cmake)
include(locale.cmake)
include(timer.cmake)
include(random.cmake)
include(test.cmake)

add_library(boost
        ${version_rc}
        ${BOOST_ATOMIC_SOURCE_FILES}
        ${BOOST_CHRONO_SOURCE_FILES}
        ${BOOST_DATE_TIME_SOURCE_FILES}
        ${BOOST_FILESYSTEM_SOURCE_FILES}
        ${BOOST_LOG_SOURCE_FILES}
        ${BOOST_PROGRAM_OPTIONS_SOURCE_FILES}
        ${BOOST_SYSTEM_SOURCE_FILES}
        ${BOOST_THREAD_SOURCE_FILES}
        ${BOOST_LOCALE_SOURCE_FILES}
        ${BOOST_TIMER_SOURCE_FILES}
        ${BOOST_RANDOM_SOURCE_FILES}
        )

target_compile_definitions(boost
        PUBLIC ${boost_defs_public}
        PRIVATE ${boost_defs_private}
        INTERFACE ${boost_defs_interface}
        )

target_link_libraries(boost
        PUBLIC ${boost_link_public}
        PRIVATE ${boost_link_private}
        INTERFACE ${boost_link_interface}
        )

target_include_directories(boost
        PUBLIC ${BOOST_INCLUDES}
        )

if(APPLE)
    target_compile_options(boost PRIVATE -Wno-deprecated-declarations)
else()
    target_compile_options(boost PRIVATE -fvisibility=hidden)
endif()
