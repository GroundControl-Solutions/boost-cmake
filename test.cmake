cmake_minimum_required(VERSION 3.1)
project(boost-test)

set(BOOST_PRG_EXEC_MON_SOURCE_FILES
        ../boost/libs/test/src/execution_monitor.cpp
        ../boost/libs/test/src/debug.cpp
        ../boost/libs/test/src/cpp_main.cpp
        )

set(BOOST_TEST_EXEC_SOURCE_FILES
        ../boost/libs/test/src/compiler_log_formatter.cpp
        ../boost/libs/test/src/debug.cpp
        ../boost/libs/test/src/decorator.cpp
        ../boost/libs/test/src/execution_monitor.cpp
        ../boost/libs/test/src/framework.cpp
        ../boost/libs/test/src/plain_report_formatter.cpp
        ../boost/libs/test/src/progress_monitor.cpp
        ../boost/libs/test/src/results_collector.cpp
        ../boost/libs/test/src/results_reporter.cpp
        ../boost/libs/test/src/test_main.cpp
        ../boost/libs/test/src/test_tools.cpp
        ../boost/libs/test/src/test_tree.cpp
        ../boost/libs/test/src/unit_test_log.cpp
        ../boost/libs/test/src/unit_test_main.cpp
        ../boost/libs/test/src/unit_test_monitor.cpp
        ../boost/libs/test/src/unit_test_parameters.cpp
        ../boost/libs/test/src/xml_log_formatter.cpp
        ../boost/libs/test/src/xml_report_formatter.cpp
        )

set(BOOST_UTF_SOURCE_FILES
        ../boost/libs/test/src/compiler_log_formatter.cpp
        ../boost/libs/test/src/debug.cpp
        ../boost/libs/test/src/decorator.cpp
        ../boost/libs/test/src/execution_monitor.cpp
        ../boost/libs/test/src/framework.cpp
        ../boost/libs/test/src/plain_report_formatter.cpp
        ../boost/libs/test/src/progress_monitor.cpp
        ../boost/libs/test/src/results_collector.cpp
        ../boost/libs/test/src/results_reporter.cpp
        ../boost/libs/test/src/test_tools.cpp
        ../boost/libs/test/src/test_tree.cpp
        ../boost/libs/test/src/unit_test_log.cpp
        ../boost/libs/test/src/unit_test_main.cpp
        ../boost/libs/test/src/unit_test_monitor.cpp
        ../boost/libs/test/src/unit_test_parameters.cpp
        ../boost/libs/test/src/xml_log_formatter.cpp
        ../boost/libs/test/src/xml_report_formatter.cpp
        )

add_library(boost_prg_exec_monitor SHARED ${BOOST_PRG_EXEC_MON_SOURCE_FILES})
add_library(boost_test_exec_monitor STATIC ${BOOST_TEST_EXEC_SOURCE_FILES})
add_library(boost_unit_test_framework SHARED ${BOOST_UTF_SOURCE_FILES})

target_compile_definitions(boost_prg_exec_monitor PUBLIC BOOST_TEST_DYN_LINK INTERFACE BOOST_TEST_NO_AUTO_LINK)
target_compile_definitions(boost_test_exec_monitor PUBLIC BOOST_TEST_DYN_LINK INTERFACE BOOST_TEST_NO_AUTO_LINK)
target_compile_definitions(boost_unit_test_framework PUBLIC BOOST_TEST_DYN_LINK INTERFACE BOOST_TEST_NO_AUTO_LINK)

target_compile_options(boost_prg_exec_monitor PRIVATE -Wno-c99-extensions -Wno-variadic-macros)
target_compile_options(boost_test_exec_monitor PRIVATE -Wno-c99-extensions -Wno-variadic-macros)
target_compile_options(boost_unit_test_framework PRIVATE -Wno-c99-extensions -Wno-variadic-macros)

target_link_libraries(boost_prg_exec_monitor PRIVATE boost)
target_link_libraries(boost_test_exec_monitor PRIVATE boost)
target_link_libraries(boost_unit_test_framework PRIVATE boost)

target_include_directories(boost_prg_exec_monitor PUBLIC ${BOOST_INCLUDES})
target_include_directories(boost_test_exec_monitor PUBLIC ${BOOST_INCLUDES})
target_include_directories(boost_unit_test_framework PUBLIC ${BOOST_INCLUDES})