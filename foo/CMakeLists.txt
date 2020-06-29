
cmake_minimum_required(VERSION 3.2 FATAL_ERROR)
project(foo VERSION 0.1 LANGUAGES CXX)

add_library(foo
	include/foo/foo.h 
	src/foo.cpp)

if(BUILD_SHARED_LIBS)
  include(GenerateExportHeader)
  generate_export_header(foo BASE_NAME FOO EXPORT_FILE_NAME ${CMAKE_CURRENT_SOURCE_DIR}/include/foo/foo_export.h)
endif(BUILD_SHARED_LIBS)

target_include_directories(foo
  PUBLIC
  "$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>"
  "$<INSTALL_INTERFACE:include>"
  PRIVATE src
)

install(TARGETS foo EXPORT fooConfig
  ARCHIVE DESTINATION lib
  LIBRARY DESTINATION lib
  RUNTIME DESTINATION bin)

install(DIRECTORY include/ DESTINATION include)

install(EXPORT fooConfig DESTINATION share/fooConfig/cmake)

# This makes the project importable from the build directory
export(TARGETS foo FILE fooConfig.cmake)
