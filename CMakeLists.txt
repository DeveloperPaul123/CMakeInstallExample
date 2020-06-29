
cmake_minimum_required(VERSION 3.14)

project(CMakeInstallExample LANGUAGES C CXX)

list(APPEND CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR}/cmake)

# set the project version. 
set(PROJECT_VER_PATCH 0)
set(PROJECT_VER_MINOR 2)
set(PROJECT_VER_MAJOR 1)

set(PROJECT_VER "${PROJECT_VER_MAJOR}.${PROJECT_VER_MINOR}.${PROJECT_VER_PATCH}")

add_subdirectory(foo)

add_executable(CMakeInstallExample src/main.cpp)

target_link_libraries(CMakeInstallExample foo)

# set install rules (windows only)
if(WIN32)
    if(MSVC)
        install(TARGETS CMakeInstallExample
            DESTINATION bin COMPONENT binaries)
        # install the target file since the foo target isn't built in this context.
        install(FILES $<TARGET_FILE:foo>
            DESTINATION bin COMPONENT binaries)
        install(FILES data/data.txt
            DESTINATION data COMPONENT data_files)
    endif(MSVC)
endif(WIN32)

include(CpackConfig)
