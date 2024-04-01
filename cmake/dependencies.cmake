set(DEPENDENCIES_DIR ${CMAKE_CURRENT_SOURCE_DIR}/dependencies)

# ------------------- BHW -------------------

find_package(BoilingHotWater REQUIRED)

# ------------------- OpenGL -------------------

find_package(OpenGL REQUIRED)

# ------------------- GLEW -------------------

set(GLEW_DIR ${DEPENDENCIES_DIR}/glew-2.2.0)
set(GLEW_INCLUDE_DIR ${GLEW_DIR}/include)
set(GLEW_SOURCE_DIR ${GLEW_DIR}/src)

file(GLOB_RECURSE GLEW_FILES ${GLEW_INCLUDE_DIR}/GL/*.h)
file(GLOB_RECURSE GLEW_SOURCES ${GLEW_SOURCE_DIR}/*.c)

add_library(glew STATIC ${GLEW_FILES} ${GLEW_SOURCES})

target_include_directories(glew PUBLIC
    $<BUILD_INTERFACE:${GLEW_INCLUDE_DIR}>
    $<INSTALL_INTERFACE:include>
)

install(FILES ${GLEW_FILES} DESTINATION include/GL)

# ------------------- GLM -------------------

set(GLM_BUILD_INSTALL ON CACHE BOOL "" FORCE)

add_subdirectory(${DEPENDENCIES_DIR}/glm)

# ------------------- GLFW -------------------

set(GLFW_BUILD_DOCS     OFF CACHE BOOL "" FORCE)
set(GLFW_BUILD_TESTS    OFF CACHE BOOL "" FORCE)
set(GLFW_BUILD_EXAMPLES OFF CACHE BOOL "" FORCE)

set(GLFW_INSTALL        OFF CACHE BOOL "" FORCE)

find_package(Threads REQUIRED)

add_subdirectory(${DEPENDENCIES_DIR}/glfw)

install(DIRECTORY ${DEPENDENCIES_DIR}/glfw/include/GLFW DESTINATION include)

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

install(FILES ${IMGUI_HEADERS} DESTINATION include)
install(FILES ${IMGUI_BACKEND_HEADERS} DESTINATION include)