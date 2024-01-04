# TeaCup
This is a cross-platform C++ library that handles windows and the initialization of Graphics APIs, such as OpenGL while abstracting away the platform specific code
and simplifying a lot of the boilerplate code that comes with it.

It's worth mentioning that it is currently under development; consequently, **eveything is subject to change and may not work as intendent**, furthermore, **the only supported platform currently is Windows**.

Originally, I wrote this library for my game engine, [TeaPot](https://github.com/NextLegacy/Engine), hence the name `TeaCup`. I decided to split it off into its own repository to facilitate its use in future projects of mine.

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
cmake --build build --target ALL_BUILD --config Release
cmake --build build --target INSTALL --config Release
```

afterwards, you can link the library to your project by adding the following to your `CMakeLists.txt`:

```cmake
list(APPEND CMAKE_PREFIX_PATH path/to/TeaCup/install)
find_package(TC REQUIRED)
target_link_libraries(<your-target> PRIVATE TC::TC)
```

## Dependencies

- [GLFW](https://github.com/glfw/glfw)
- [GLEW 2.2.0](https://github.com/nigels-com/glew/releases/tag/glew-2.2.0)
- [GLM](https://github.com/g-truc/glm)
- [ImGui (docking branch)](https://github.com/ocornut/imgui/tree/docking)
- [BoilingHotWater](https://github.com/NextLegacy/BoilingHotWater)

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.