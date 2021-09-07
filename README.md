# CMakeInstallExample

Installation example for a C++ project (Windows) with Cmake.

<p align="center">
  <a href="https://opensource.org/licenses/MIT">
    <img src="https://img.shields.io/badge/License-MIT-red.svg" alt="License MIT">
  </a>
  <a href="https://github.com/DeveloperPaul123/MHWDatabase/stargazers">
    <img src="https://img.shields.io/badge/Say%20Thanks-👍-1EAEDB.svg" alt="Say thanks">
  </a>
  <a href="https://discord.gg/yNQ9dW4">
    <img alt="Discord" src="https://discordapp.com/api/guilds/652515194572111872/widget.png">
  </a>
</p>

## Contents

This project demonstrates how to use cmake with cpack to generate an installer that can be used to redistribute software/libraries. See my [blog](https://developerpaul123.github.io/blog) for the full [write up](https://developerpaul123.github.io/programming/creating-an-installer-with-cmake/).

### Requirements

To build this project you will need:

- A relatively recent C++ compiler
- [CMake](https://cmake.org) `3.14+`
- [NSIS](https://nsis.sourceforge.io/Download) `3.0.0+`

### Building

Configure and build using CMake and your favorite build tools. I've tested using Visual Studio Community Edition 2019

```cmake
cmake -B build
```

To build an installer simply run:

```cmake
cmake --build ./build --config Release --target package
```

## Author

| [<img src="https://avatars0.githubusercontent.com/u/6591180?s=460&v=4" width="100"><br><sub>@DeveloperPaul123</sub>](https://github.com/DeveloperPaul123) |
|:----:|

## License

All the code available under the MIT license. See [LICENSE](LICENSE).
