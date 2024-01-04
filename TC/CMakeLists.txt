file(GLOB_RECURSE TCSources *.cpp)
file(GLOB_RECURSE TCHeaders *.hpp)

add_library(TC STATIC ${TCSources} ${TCHeaders})

target_include_directories(TC PUBLIC 
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/..>
    $<INSTALL_INTERFACE:include>
)

target_link_libraries(TC
    OpenGL::GL
    glfw
    glm::glm
    glew
    imgui
    BHW::BHW
)

add_library(TC::TC ALIAS TC)