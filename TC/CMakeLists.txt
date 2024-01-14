file(GLOB_RECURSE TeaCupSources *.cpp)
file(GLOB_RECURSE TeaCupHeaders *.hpp)

add_library(TeaCup STATIC ${TeaCupSources} ${TeaCupHeaders})

target_include_directories(TeaCup PUBLIC 
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/..>
    $<INSTALL_INTERFACE:include>
)

target_link_libraries(TeaCup
    OpenGL::GL
    glfw
    glm::glm
    glew
    imgui
    implot
    BoilingHotWater::BoilingHotWater
)

add_library(TeaCup::TeaCup ALIAS TeaCup)