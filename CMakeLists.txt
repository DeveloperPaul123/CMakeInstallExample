
cmake_minimum_required(VERSION 3.0)

project(CMakeInstallExample LANGUAGES C CXX)

# set the project version. 
set(PROJECT_VER_PATCH 0)
set(PROJECT_VER_MINOR 1)
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

#installer rules. 
SET(CPACK_PACKAGE_DESCRIPTION_SUMMARY "Example cmake installation.")
SET(CPACK_PACKAGE_VENDOR "My Fake Companay, Inc.")
SET(CPACK_PACKAGE_VERSION ${PROJECT_VER})
SET(CPACK_PACKAGE_VERSION_MAJOR ${PROJECT_VER_MAJOR})
SET(CPACK_PACKAGE_VERSION_MINOR ${PROJECT_VER_MINOR})
SET(CPACK_PACKAGE_VERSION_PATCH ${PROJECT_VER_PATCH})
SET(CPACK_NSIS_ENABLE_UNINSTALL_BEFORE_INSTALL OFF)
SET(CPACK_NSIS_MODIFY_PATH ON)
#if you have an icon set the path here 
# SET(CPACK_NSIS_MUI_ICON "${CMAKE_CURRENT_SOURCE_DIR}/my_cool_icon.ico")
SET(CPACK_PACKAGE_INSTALL_DIRECTORY "MyFakeCompany\\\\CMakeInstallExample")
SET(CPACK_NSIS_INSTALLED_ICON_NAME "bin\\\\CMakeInstallExample.exe")
SET(CPACK_NSIS_DISPLAY_NAME "CMakeInstallExample ${PROJECT_VER}")
set(CPACK_RESOURCE_FILE_LICENSE "${CMAKE_CURRENT_SOURCE_DIR}/EULA.txt")

# set component installation rules 
SET(CPACK_COMPONENT_BINARIES_DISPLAY_NAME "Main application")
SET(CPACK_COMPONENT_BINARIES_DESCRIPTION "This will install the main application.")
SET(CPACK_COMPONENT_DATA_FILES_DISPLAY_NAME "Data files for this fake application.")
SET(CPACK_COMPONENT_DATA_FILES_DESCRIPTION "This will install random data files.")
SET(CPACK_ALL_INSTALL_TYPES Full Upgrade) #set installation types
SET(CPACK_COMPONENT_BINARIES_INSTALL_TYPES Full Upgrade)
SET(CPACK_COMPONENT_DATA_FILES_INSTALL_TYPES Full)
SET(CPACK_COMPONENTS_ALL binaries data_files)
if (CMAKE_CL_64)
	set(CPACK_NSIS_INSTALL_ROOT "$PROGRAMFILES64")
else (CMAKE_CL_64)
	set(CPACK_NSIS_INSTALL_ROOT "$PROGRAMFILES")
endif (CMAKE_CL_64)
include(CPACK)