cmake_minimum_required(VERSION 3.1)

set(BOOST_LOG_SOURCE_FILES
        ../boost/libs/log/src/alignment_gap_between.hpp
        ../boost/libs/log/src/attribute_name.cpp
        ../boost/libs/log/src/attribute_set.cpp
        ../boost/libs/log/src/attribute_set_impl.hpp
        ../boost/libs/log/src/attribute_value_set.cpp
        ../boost/libs/log/src/code_conversion.cpp
        ../boost/libs/log/src/core.cpp
        ../boost/libs/log/src/date_time_format_parser.cpp
        ../boost/libs/log/src/default_attribute_names.cpp
        ../boost/libs/log/src/default_sink.cpp
        ../boost/libs/log/src/default_sink.hpp
        ../boost/libs/log/src/dump.cpp
        ../boost/libs/log/src/event.cpp
        ../boost/libs/log/src/exceptions.cpp
        ../boost/libs/log/src/format_parser.cpp
        ../boost/libs/log/src/global_logger_storage.cpp
        ../boost/libs/log/src/id_formatting.hpp
        ../boost/libs/log/src/named_scope.cpp
        ../boost/libs/log/src/named_scope_format_parser.cpp
        ../boost/libs/log/src/once_block.cpp
        ../boost/libs/log/src/process_id.cpp
        ../boost/libs/log/src/process_name.cpp
        ../boost/libs/log/src/record_ostream.cpp
        ../boost/libs/log/src/severity_level.cpp
        ../boost/libs/log/src/spirit_encoding.cpp
        ../boost/libs/log/src/spirit_encoding.hpp
        ../boost/libs/log/src/stateless_allocator.hpp
        ../boost/libs/log/src/syslog_backend.cpp
        ../boost/libs/log/src/text_file_backend.cpp
        ../boost/libs/log/src/text_multifile_backend.cpp
        ../boost/libs/log/src/text_ostream_backend.cpp
        ../boost/libs/log/src/thread_id.cpp
        ../boost/libs/log/src/thread_specific.cpp
        ../boost/libs/log/src/threadsafe_queue.cpp
        ../boost/libs/log/src/timer.cpp
        ../boost/libs/log/src/timestamp.cpp
        ../boost/libs/log/src/trivial.cpp
        ../boost/libs/log/src/unhandled_exception_count.cpp
        ../boost/libs/log/src/unique_ptr.hpp
        ../boost/libs/log/src/windows_version.hpp
)

if (AVX2_EXISTS)
        list(APPEND BOOST_LOG_SOURCE_FILES ../boost/libs/log/src/dump_avx2.cpp)
endif ()

if (SSE3_EXISTS)
        list(APPEND BOOST_LOG_SOURCE_FILES ../boost/libs/log/src/dump_ssse3.cpp)
endif ()

set(MC_OUTPUT_DIR ${CMAKE_CURRENT_BINARY_DIR}/mc)
set(MC_FILE_PREFIX simple_event_log)

file(MAKE_DIRECTORY ${MC_OUTPUT_DIR})

add_custom_command(
        OUTPUT ${MC_OUTPUT_DIR}/${MC_FILE_PREFIX}.h
        OUTPUT ${MC_OUTPUT_DIR}/${MC_FILE_PREFIX}.rc
        COMMAND windmc -r ${MC_OUTPUT_DIR} -h ${MC_OUTPUT_DIR} ../boost/libs/log/src/${MC_FILE_PREFIX}.mc
        MAIN_DEPENDENCY ../boost/libs/log/src/${MC_FILE_PREFIX}.mc
        WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
        COMMENT "Generating mc headers"
        VERBATIM
)

include_directories(${MC_OUTPUT_DIR})

if (WIN32)
        list(APPEND BOOST_LOG_SOURCE_FILES
                ../boost/libs/log/src/debug_output_backend.cpp
                ../boost/libs/log/src/event_log_backend.cpp
                ../boost/libs/log/src/event_log_registry.hpp
                ../boost/libs/log/src/light_rw_mutex.cpp
                ${MC_OUTPUT_DIR}/${MC_FILE_PREFIX}.h
        )
endif ()

#Avoid depending on boost::regex
list(APPEND boost_defs_private BOOST_LOG_USE_STD_REGEX=1)

# We can omit BOOST_THREAD_DONT_USE_CHRONO=1 because we already use chrono, so the false dependency doesn't hurt us
list(APPEND boost_defs_private  BOOST_SPIRIT_USE_PHOENIX_V3=1 BOOST_LOG_BUILDING_THE_LIB)

if (WIN32)
        list(APPEND boost_link_private ws2_32 mswsock psapi)
	# ASIO initializes winsock, and we don't want that.  Syslog is broken without ASIO, so we disable that too.
	list(APPEND boost_defs_public BOOST_LOG_NO_ASIO BOOST_LOG_WITHOUT_SYSLOG)

else()
        list(APPEND boost_defs_private BOOST_LOG_WITHOUT_EVENT_LOG BOOST_LOG_USE_NATIVE_SYSLOG)
endif()

if(BUILD_SHARED_LIBS)
                list(APPEND boost_defs_private BOOST_LOG_DLL)
                list(APPEND boost_defs_interface BOOST_LOG_DYN_LINK=1)
endif()

# filesystem::path defines rbegin and rend wrong, so don't error when we get to them
set_source_files_properties(../boost/libs/log/src/process_name.cpp COMPILE_FLAGS -Wno-ignored-attributes)
set_source_files_properties(../boost/libs/log/src/core.cpp COMPILE_FLAGS -Wno-ignored-attributes)
set_source_files_properties(../boost/libs/log/src/text_multifile_backend.cpp COMPILE_FLAGS -Wno-ignored-attributes)
set_source_files_properties(../boost/libs/log/src/text_file_backend.cpp COMPILE_FLAGS -Wno-ignored-attributes)
set_source_files_properties(../boost/libs/log/src/event_log_backend.cpp COMPILE_FLAGS -Wno-ignored-attributes)

set(BOOST_LOG_SETUP_SOURCE_FILES
        ../boost/libs/log/src/attribute_set_impl.hpp
        ../boost/libs/log/src/default_filter_factory.cpp
        ../boost/libs/log/src/default_formatter_factory.cpp
        ../boost/libs/log/src/filter_parser.cpp
        ../boost/libs/log/src/formatter_parser.cpp
        ../boost/libs/log/src/init_from_settings.cpp
        ../boost/libs/log/src/init_from_stream.cpp
        ../boost/libs/log/src/matches_relation_factory.cpp
        ../boost/libs/log/src/parser_utils.cpp
        ../boost/libs/log/src/settings_parser.cpp
)

#TODO: What even is boost_log_setup?
