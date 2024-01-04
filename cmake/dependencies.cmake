set(DEPENDENCIES_DIR ${CMAKE_CURRENT_SOURCE_DIR}/dependencies)

# ------------------- BHW -------------------

add_subdirectory(${DEPENDENCIES_DIR}/BoilingHotWater)

# ------------------- OpenGL -------------------

find_package(OpenGL REQUIRED)

# ------------------- GLEW -------------------

set(GLEW_INCLUDE_DIR ${DEPENDENCIES_DIR}/glew-2.2.0/include)
set(GLEW_LIB_DIR ${DEPENDENCIES_DIR}/glew-2.2.0/lib/Release/Win32)

file(GLOB_RECURSE GLEW_FILES ${GLEW_INCLUDE_DIR}/GL/*.h)

add_library(glew INTERFACE ${GLEW_FILES})

target_include_directories(glew INTERFACE 
    $<BUILD_INTERFACE:${GLEW_INCLUDE_DIR}>
    $<INSTALL_INTERFACE:include>
)

# ------------------- GLM -------------------

add_subdirectory(${DEPENDENCIES_DIR}/glm)

# ------------------- GLFW -------------------

set(GLFW_BUILD_DOCS     OFF CACHE BOOL "" FORCE)
set(GLFW_BUILD_TESTS    OFF CACHE BOOL "" FORCE)
set(GLFW_BUILD_EXAMPLES OFF CACHE BOOL "" FORCE)

add_subdirectory(${DEPENDENCIES_DIR}/glfw)

# ------------------- IMGUI -------------------

file(GLOB IMGUI_SOURCES ${DEPENDENCIES_DIR}/imgui/*.cpp)
file(GLOB IMGUI_HEADERS ${DEPENDENCIES_DIR}/imgui/*.h)

set(IMGUI_BACKENDS_DIR ${DEPENDENCIES_DIR}/imgui/backends)

set(IMGUI_BACKEND_SOURCES
    ${IMGUI_BACKENDS_DIR}/imgui_impl_glfw.cpp
    ${IMGUI_BACKENDS_DIR}/imgui_impl_opengl3.cpp
    #${IMGUI_BACKENDS_DIR}/imgui_impl_vulkan.cpp
)
set(IMGUI_BACKEND_HEADERS
    ${IMGUI_BACKENDS_DIR}/imgui_impl_glfw.h
    ${IMGUI_BACKENDS_DIR}/imgui_impl_opengl3.h
    #${IMGUI_BACKENDS_DIR}/imgui_impl_vulkan.h
)

set(IMGUI_FILES
    ${IMGUI_SOURCES}
    ${IMGUI_HEADERS}
    
    ${IMGUI_BACKEND_SOURCES}
    ${IMGUI_BACKEND_HEADERS}
)

add_library(imgui STATIC ${IMGUI_FILES})

target_include_directories(imgui PUBLIC 
    $<BUILD_INTERFACE:${DEPENDENCIES_DIR}/imgui>
    $<BUILD_INTERFACE:${IMGUI_BACKENDS_DIR}>
    $<INSTALL_INTERFACE:include>
)

target_link_libraries(imgui PUBLIC glfw)