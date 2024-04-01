file(GLOB_RECURSE TeaCupSources *.cpp)
file(GLOB_RECURSE TeaCupHeaders *.hpp)

add_library(TeaCup STATIC ${TeaCupSources} ${TeaCupHeaders})

target_include_directories(TeaCup PUBLIC 
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/..>
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/../dependencies/glew-2.2.0/include>
    $<INSTALL_INTERFACE:include>
)

target_link_libraries(TeaCup PUBLIC
    OpenGL::GL
    glfw
    Threads::Threads
    glm::glm
    imgui
    BoilingHotWater::BoilingHotWater
    glew
)