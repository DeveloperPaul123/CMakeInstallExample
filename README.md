# CMakeInstallExample
Installation example for a C++ project (Windows) with Cmake.

## Contents
This project demonstrates how to use cmake with cpack to install a project (and it's necessary libraries) onto a client's computer. This readme will serve as an explanation of what exactly is going on and what different things are happening in the cmake. 

### CPack
CPack is a packaging tool included with CMake that allows you to create packages of targets or files. You can generate a variety of packages (7zp, zip, NSIS). For this example we want to generate an example so we'll use NSIS.

[NSIS](http://nsis.sourceforge.net/Main_Page) is a scripting language/system to create windows installers. It's extremely versatile and flexible, making it a powerful back end to Cpack. 

### How To Do It
So let's get right too it. First things first, let's set up the main project and our fake library.

Top level `CMakeLists.txt`

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

Nothing too crazy going on here. First we set the minimum required version of cmake, set the project name and languages and then create a version variable. Next we add our sub-directory with the library we want to include (see [here](https://rix0r.nl/blog/2015/08/13/cmake-guide/) for details on how this project is set up). Finally, we add our executable and then link it to the library we just added. 

So now when we open our solution (if you're using Visual Studio) we're going to have 6 targets:

* `ALL_BUILD`
* `CMakeInstallExample`
* `foo`
* `INSTALL`
* `PACKAGE`
* `ZERO_CHECK`

The `CMakeInstallExample` target will build our main executable. Since `foo` is linked to the `CMakeInstallExample` target, it will be built as well if necessary.

To build an installer, all you have to do is build the `CMakeInstallerExample` in Release mode, then **BUILD** the `PACKAGE` target. Once the build has finished, you should have an installer in your build directory called `CMakeInstallerExample-${PROJECT_VER}-win64`.

So how does this work exactly? 

Well there are a few things happening at once here, but the beauty is the most of it is obscured to the user. Instead Cmake, along with Cpack, is doing most of the work for us. 

### Install Rules
In the top level Cmake there are what are known as install rules. Again these can be found in the top level `CMakeLists.txt` file:

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

So first we tell cmake to install the main executable target to the `bin` folder of the installation directory. Next, we install the target file (note the use of [generator expressions](https://cmake.org/cmake/help/v3.3/manual/cmake-generator-expressions.7.html) here) of the foo library to the `bin` folder as well. This is because we want this `.dll` (on windows at least) to be in the same folder as our executable. Finally we install a dummy data file `data.txt` in the `data` file of our installation directory. 

So when we install the application, whether using the installer or by building the `INSTALL` package, the output directory structure will look like this:

````
${PROGRAM_INSTALL_DIRECTORY}/
|--bin/
|    CMakeInstallExample.exe
|    foo.dll
|--data/
|    data.txt
````

Additionally, because we specified the `COMPONENT` the different items we're installing belong to, we'll get the option in the installer to install `binaries` and `data_files`. If we uncheck `binaries` in the installer, then everything under the `bin` folder above will *not* be installer. Similarly if we uncheck the `data_files` option in the installer, everything under the `data` folder will *not* be installed.

### CPack Configuration
The last thing we have to do is give Cpack all the information it needs to generate the installer. Cpack will pass on all this information to the installer generator (NSIS if you're on windows) and then a install-able package will be generated. 

All the cpack configuration is under `cmake/CpackConfig.cmake`. Most of the fields are self explanatory, but I'll explain the ones that are a bit less obvious:

* `CPACK_NSIS_ENABLE_UNINSTALL_BEFORE_INSTALL` This tells the installer to uninstall the previous version of the program we're installing first, before proceeding with the current install.
* `CPACK_NSIS_MODIFY_PATH` On windows this allows the installer to modify the `PATH` environment variable.
* `CPACK_PACKAGE_INSTALL_DIRECTORY` Tells the installer where to install the program. 

In the last section we set up the different components of the installer:

````
# set component installation rules 
set(CPACK_COMPONENT_BINARIES_DISPLAY_NAME "Main application")
set(CPACK_COMPONENT_BINARIES_DESCRIPTION "This will install the main application.")
set(CPACK_COMPONENT_DATA_FILES_DISPLAY_NAME "Data files for this fake application.")
set(CPACK_COMPONENT_DATA_FILES_DESCRIPTION "This will install random data files.")
set(CPACK_ALL_INSTALL_TYPES Full Upgrade) #set installation types
set(CPACK_COMPONENT_BINARIES_INSTALL_TYPES Full Upgrade)
set(CPACK_COMPONENT_DATA_FILES_INSTALL_TYPES Full)
set(CPACK_COMPONENTS_ALL binaries data_files)
````

We have 2 components, `binaries` and `data_files`. So in the section of cmake above, we set the readable names of the components and a brief description. Then we tell Cpack which components to include in the installer. 

And that's it! You a fully functional, full featured installer. Obviously this is just the basic. If you're really advanced you can take a gander at writing your own NSIS script instead of the default one that Cpack uses. 

If you have any questions feel free to [ask](mailto:developer.paul.123@gmail.com). 