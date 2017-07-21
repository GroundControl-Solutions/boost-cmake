cmake_minimum_required(VERSION 3.1)
include(CheckCXXSourceCompiles)

set(CMAKE_REQUIRED_LIBRARIES)
set(CMAKE_REQUIRED_INCLUDES ${CMAKE_CURRENT_SOURCE_DIR}/../boost/libs/locale/build/)
check_cxx_source_compiles("#include <has_iconv.cpp>" HAS_ICONV_STD)
if (NOT HAS_ICONV_STD)
    set(CMAKE_REQUIRED_LIBRARIES iconv)
    check_cxx_source_compiles("#include <has_iconv.cpp>" HAS_ICONV_LINK)
endif ()

set(CMAKE_REQUIRED_LIBRARIES)
if (FREEBSD)
    check_cxx_source_compiles("#include <boost/libs/local/buid/has_xlocale.cpp>" HAS_XLOCALE)
endif ()

if (HAS_ICONV_LINK)
    list(APPEND boost_link_private iconv)
endif ()

if (HAS_ICONV_STD OR HAS_ICONV_LINK)
    list(APPEND boost_defs_public BOOST_LOCALE_WITH_ICONV=1)
endif ()

# TODO: Do we want ICU support?

set(BOOST_LOCALE_SOURCE_FILES
        ../boost/libs/locale/src/encoding/codepage.cpp
        ../boost/libs/locale/src/shared/date_time.cpp
        ../boost/libs/locale/src/shared/format.cpp
        ../boost/libs/locale/src/shared/formatting.cpp
        ../boost/libs/locale/src/shared/generator.cpp
        ../boost/libs/locale/src/shared/ids.cpp
        ../boost/libs/locale/src/shared/localization_backend.cpp
        ../boost/libs/locale/src/shared/message.cpp
        ../boost/libs/locale/src/shared/mo_lambda.cpp
        ../boost/libs/locale/src/std/codecvt.cpp
        ../boost/libs/locale/src/std/collate.cpp
        ../boost/libs/locale/src/std/converter.cpp
        ../boost/libs/locale/src/std/numeric.cpp
        ../boost/libs/locale/src/std/std_backend.cpp
        ../boost/libs/locale/src/util/codecvt_converter.cpp
        ../boost/libs/locale/src/util/default_locale.cpp
        ../boost/libs/locale/src/util/gregorian.cpp
        ../boost/libs/locale/src/util/info.cpp
        ../boost/libs/locale/src/util/locale_data.cpp
        )


if (WIN32)
    list(APPEND boost_defs_public BOOST_LOCALE_NO_POSIX_BACKEND=1)
    list(APPEND BOOST_LOCALE_SOURCE_FILES
            ../boost/libs/locale/src/win32/collate.cpp
            ../boost/libs/locale/src/win32/converter.cpp
            ../boost/libs/locale/src/win32/lcid.cpp
            ../boost/libs/locale/src/win32/numeric.cpp
            ../boost/libs/locale/src/win32/win_backend.cpp
            )
else ()
    list(APPEND boost_defs_public BOOST_LOCALE_NO_WINAPI_BACKEND=1)
    list(APPEND BOOST_LOCALE_SOURCE_FILES
            ../boost/libs/locale/src/posix/collate.cpp
            ../boost/libs/locale/src/posix/converter.cpp
            ../boost/libs/locale/src/posix/numeric.cpp
            ../boost/libs/locale/src/posix/codecvt.cpp
            ../boost/libs/locale/src/posix/posix_backend.cpp
            )
endif ()

set_source_files_properties(${BOOST_LOCALE_SOURCE_FILES} COMPILE_FLAGS -Wno-deprecated-declarations)

if (BUILD_SHARED_LIBS)
    list(APPEND boost_defs_public BOOST_LOCALE_DYN_LINK=1)
endif ()
