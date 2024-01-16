set(DEPENDENCIES_DIR ${CMAKE_CURRENT_SOURCE_DIR}/dependencies)

# ------------------- BHW -------------------

if (NOT TARGET BoilingHotWater::BoilingHotWater)
    add_subdirectory(${DEPENDENCIES_DIR}/BoilingHotWater)
endif()

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

install(TARGETS glew EXPORT glewTargets)

install(EXPORT glewTargets
    FILE glewTargets.cmake
    NAMESPACE glew::
    DESTINATION lib/cmake/glew
)

install(FILES ${GLEW_FILES} DESTINATION include/GL)

# ------------------- GLM -------------------

add_subdirectory(${DEPENDENCIES_DIR}/glm)

install(TARGETS glm glm-header-only
    EXPORT glmTargets
    DESTINATION lib
)

install(EXPORT glmTargets
    FILE glmTargets.cmake
    NAMESPACE glm::
    DESTINATION lib/cmake/glm
)

install(DIRECTORY ${DEPENDENCIES_DIR}/glm/glm
    DESTINATION include
)

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

install(TARGETS imgui
    EXPORT imguiTargets
    DESTINATION lib
)

install(EXPORT imguiTargets
    FILE imguiTargets.cmake
    NAMESPACE imgui::
    DESTINATION lib/cmake/imgui
)

install(FILES ${IMGUI_HEADERS} ${IMGUI_BACKEND_HEADERS} DESTINATION include)


# ------------------- IMPLOT -------------------

set(IMPLOT_FILES
    ${DEPENDENCIES_DIR}/implot/implot.cpp
    ${DEPENDENCIES_DIR}/implot/implot.h
    ${DEPENDENCIES_DIR}/implot/implot_internal.h
    ${DEPENDENCIES_DIR}/implot/implot_items.cpp
)

add_library(implot STATIC ${IMPLOT_FILES})

target_include_directories(implot PUBLIC 
    $<BUILD_INTERFACE:${DEPENDENCIES_DIR}/implot>
    $<INSTALL_INTERFACE:include>
)

target_link_libraries(implot PUBLIC imgui)

install(TARGETS imgui
    EXPORT implotTargets
    DESTINATION lib
)

install(EXPORT implotTargets
    FILE implotTargets.cmake
    NAMESPACE implot::
    DESTINATION lib/cmake/implot
)

install(FILES ${IMPLOT_FILES} DESTINATION include)