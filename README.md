# TeaCup
This is a cross-platform C++ library that handles windows and the initialization of Graphics APIs, such as OpenGL while abstracting away the platform specific code
and simplifying a lot of the boilerplate code that comes with it.

It's worth mentioning that it is currently under development; consequently, **eveything is subject to change and may not work as intendent**, furthermore, **the only supported platform currently is Windows**.

Originally, I wrote this library for my game engine, [TeaPot](https://github.com/NextLegacy/Engine), hence the name `TeaCup`. I decided to split it off into its own repository to facilitate its use in future projects of mine.

This is pretty much just here so that I can get my hand on various concepts and algorithms and implement them by myself to get a good look and understanding of how they work; I thought: before I throw in a bunch of libraris on my projects, I may as well, for the sake of learning a thing or two, reinvent the wheel in the process.

Feel free to grab code snippets or the whole library if you find it useful, but keep in mind that it is still under development and may not be suitable for production use.

## Table of Contents
- [TeaCup](#teacup)
  - [Table of Contents](#table-of-contents)
  - [Currently Supported Platforms](#currently-supported-platforms)
  - [Features](#features)
  - [Examples](#examples)
  - [Build and Install](#build-and-install)
    - [CMake](#cmake)
  - [Dependencies](#dependencies)
  - [License](#license)

## Currently Supported Platforms
- [X] Windows
- [ ] Linux
- [ ] MacOS

## Features

A quick overview of partially implemented and planed features:

- [X] Imgui integration
- [X] OpenGL support
- [X] GLFW support
- [X] Input handling
- [ ] Vulkan support  
- [ ] DirectX support
- [ ] ... and more to come!

## Examples
  
There are currently no examples, apart from my game engine [TeaPot](https://github.com/NextLegacy/Engine), that utilizes this library.

## Build and Install

### CMake

This library uses [CMake](https://cmake.org/) as its build system.

To build and Install the library, you can run the following commands:

```bash	
# Explicitly specify a build directory.
cmake -B build

# Optionally, you can specify the install directory. By default this will be set to "/usr/local" on UNIX, and "<SystemDrive>/Program Files/<ProjectName>" on Windows
cmake -B build -D CMAKE_INSTALL_PREFIX=PATH_TO_INSTALL_DIR

# Build the library in Release mode. You will find the built library in the `install` directory.
cmake --build build --target INSTALL --config Release
```

afterwards, you can link the library to your project by adding the following to your `CMakeLists.txt`:

```cmake
find_package(TeaCup REQUIRED)
target_link_libraries(<your-target> PUBLIC TeaCup::TeaCup)
```

make sure to set the TeaCup_DIR to the install directory if you have specified a custom install directory. You may do this trough the folwing ways:

```bash
# Set the TeaCup_DIR environment variable to the install directory
cmake -D TeaCup_DIR=PATH_TO_INSTALL_DIR
```
  
or

```cmake
set(TeaCup_DIR PATH_TO_INSTALL_DIR)
```

or

```cmake
list(APPEND CMAKE_PREFIX_PATH path/to/TeaCup/install)
```
## Dependencies

- [GLFW](https://github.com/glfw/glfw)
- [GLEW 2.2.0](https://github.com/nigels-com/glew/releases/tag/glew-2.2.0)
- [GLM](https://github.com/g-truc/glm)
- [ImGui (docking branch)](https://github.com/ocornut/imgui/tree/docking)
- [BoilingHotWater](https://github.com/NextLegacy/BoilingHotWater)

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.