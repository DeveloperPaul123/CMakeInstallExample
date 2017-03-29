# CMakeInstallExample
Installation example for a C++ project (Windows) with Cmake.

## Contents
This project demonstrates how to use cmake with cpack to install a project (and it's necessary libraries) onto a client's computer. This readme will serve as an explanation of what exactly is going on and what different things are happening in the cmake. 

### CPack
CPack is a packaging tool included with CMake that allows you to create packages of targets or files. You can generate a variety of packages (7zp, zip, NSIS). For this example we want to generate an example so we'll use NSIS.

[NSIS](http://nsis.sourceforge.net/Main_Page) is a scripting language/system to create windows installers. It's extremely versatile and flexible, making it a powerful backend to cpack. 

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

So now when we open our solution we're going to have 6 targets:

* `ALL_BUILD`
* `CMakeInstallExample`
* `foo`
* `INSTALL`
* `PACKAGE`
* `ZERO_CHECK`

The `CMakeInstallExample` target will build our main executable. Since `foo` is linked to the `CMakeInstallExample` target, it will be built as well if necessary.

To build an installer, all you have to do is build the `CMakeInstallerExample` in Release mode, then **BUILD** the `PACKAGE` target. Once the build has finished, you should have an installer in your build directory called `CMakeInstallerExample-${PROJECT_VER}-win64`.

So how does this work exactly?


