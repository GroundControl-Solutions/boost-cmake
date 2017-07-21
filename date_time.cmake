cmake_minimum_required(VERSION 3.1)

set(BOOST_DATE_TIME_SOURCE_FILES
        ../boost/libs/date_time/src/gregorian/greg_month.cpp
        ../boost/libs/date_time/src/gregorian/greg_weekday.cpp
        ../boost/libs/date_time/src/gregorian/date_generators.cpp
)

list(APPEND boost_defs_public DATE_TIME_INLINE)

boost_link(date_time)