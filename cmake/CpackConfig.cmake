# installer rules. 
set(CPACK_PACKAGE_DESCRIPTION_SUMMARY "Example cmake installation.")
set(CPACK_PACKAGE_VENDOR "DeveloperPaul123")
set(CPACK_PACKAGE_VERSION ${PROJECT_VER})
set(CPACK_PACKAGE_VERSION_MAJOR ${PROJECT_VER_MAJOR})
set(CPACK_PACKAGE_VERSION_MINOR ${PROJECT_VER_MINOR})
set(CPACK_PACKAGE_VERSION_PATCH ${PROJECT_VER_PATCH})
set(CPACK_NSIS_ENABLE_UNINSTALL_BEFORE_INSTALL OFF)
set(CPACK_NSIS_MODIFY_PATH ON)

# if you have an icon set the path here 
# SET(CPACK_NSIS_MUI_ICON "${CMAKE_CURRENT_SOURCE_DIR}/my_cool_icon.ico")
set(CPACK_PACKAGE_INSTALL_DIRECTORY "DeveloperPaul123\\\\CMakeInstallExample")
set(CPACK_NSIS_INSTALLED_ICON_NAME "bin\\\\CMakeInstallExample.exe")
set(CPACK_NSIS_DISPLAY_NAME "CMakeInstallExample ${PROJECT_VER}")
set(CPACK_RESOURCE_FILE_LICENSE "${CMAKE_CURRENT_SOURCE_DIR}/EULA.txt")

include(CPackComponent)

cpack_add_install_type(Full DISPLAY_NAME "Install Everything")
cpack_add_install_type(Upgrade DISPLAY_NAME "Upgrade Only")

cpack_add_component(binaries
    DISPLAY_NAME "Main application"
    DESCRIPTION "This will install the main application."
    REQUIRED
    INSTALL_TYPES Full Upgrade
)

cpack_add_component(data_files
    DISPLAY_NAME "Data files"
    DESCRIPTION "Fake data files for this example."
    INSTALL_TYPES Full
)

set(CPACK_COMPONENTS_ALL binaries data_files)
if (CMAKE_CL_64)
    set(CPACK_NSIS_INSTALL_ROOT "$PROGRAMFILES64")
else (CMAKE_CL_64)
    set(CPACK_NSIS_INSTALL_ROOT "$PROGRAMFILES")
endif (CMAKE_CL_64)
include(CPack)
