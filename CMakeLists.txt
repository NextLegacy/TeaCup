cmake_minimum_required(VERSION 3.28.1)

set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

set(CMAKE_INSTALL_PREFIX ${CMAKE_CURRENT_SOURCE_DIR}/install)

project(TC VERSION 0.0.1 LANGUAGES CXX)

include(cmake/dependencies.cmake)
add_subdirectory(TC)

include(GNUInstallDirs)
include(CPack)

install(TARGETS glm-header-only glm glew imgui
    EXPORT TC
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
)

install(TARGETS TC
    EXPORT TC
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
)

install(
    DIRECTORY TC
    DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
    PATTERN "CMakeLists.txt" EXCLUDE
)

install(
    EXPORT TC
    NAMESPACE TC::
    DESTINATION ${CMAKE_INSTALL_DATAROOTDIR}/TC
    FILE TCConfig.cmake
)

include(CMakePackageConfigHelpers)

write_basic_package_version_file(
    ${CMAKE_CURRENT_BINARY_DIR}/TCConfigVersion.cmake
    VERSION ${PROJECT_VERSION}
    COMPATIBILITY AnyNewerVersion
)

install(
    FILES ${CMAKE_CURRENT_BINARY_DIR}/TCConfigVersion.cmake
    DESTINATION ${CMAKE_INSTALL_DATAROOTDIR}/TC
)