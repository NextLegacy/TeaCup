cmake_minimum_required(VERSION 3.28.1)

set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

set(CMAKE_INSTALL_PREFIX ${CMAKE_CURRENT_SOURCE_DIR}/install)

project(TeaCup VERSION 0.0.1 LANGUAGES CXX)

include(cmake/dependencies.cmake)
add_subdirectory(TC)

include(GNUInstallDirs)
include(CPack)

install(TARGETS glm-header-only glm glew implot imgui
    EXPORT TeaCup
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
)

install(TARGETS TeaCup
    EXPORT TeaCup
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
)

install(
    DIRECTORY TC
    DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
    PATTERN "CMakeLists.txt" EXCLUDE
    PATTERN "*.cpp" EXCLUDE
)

install(
    EXPORT TeaCup
    NAMESPACE TeaCup::
    DESTINATION ${CMAKE_INSTALL_DATAROOTDIR}/TeaCup
    FILE TeaCupConfig.cmake
)

include(CMakePackageConfigHelpers)

write_basic_package_version_file(
    ${CMAKE_CURRENT_BINARY_DIR}/TeaCupConfigVersion.cmake
    VERSION ${PROJECT_VERSION}
    COMPATIBILITY AnyNewerVersion
)

install(
    FILES ${CMAKE_CURRENT_BINARY_DIR}/TeaCupConfigVersion.cmake
    DESTINATION ${CMAKE_INSTALL_DATAROOTDIR}/TeaCup
)