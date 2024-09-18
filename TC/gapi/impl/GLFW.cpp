#include "TC/gapi/impl/GLFW.hpp"

namespace TC
{
    int GLFW::InitializeWindow()
    {
        glfwSetErrorCallback([](int error, const char* description)
        {
            std::cout << "GLFW Error: " << error << " - " << description << std::endl;
        });

        if (!glfwInit())
            return 1;

        SetWindowHints();

        //GLFWmonitor* monitor = glfwGetPrimaryMonitor();

        m_window = glfwCreateWindow(m_size.x, m_size.y, "TeaCup", nullptr, nullptr);

        MakeCentered();

        if (m_window == nullptr)
            return 1;

        return 0;
    }

    void GLFW::InitializeInput()
    {
        glfwSetWindowUserPointer(m_window, &this->m_inputAdapter);

        glfwSetKeyCallback(m_window, [](GLFWwindow* window, int key, int scancode, int action, int mods)
        {
            InputAdapter& inputAdapter = *static_cast<InputAdapter*>(glfwGetWindowUserPointer(window));
            inputAdapter.KeyboardKey(key, scancode, action, mods);
        });

        glfwSetMouseButtonCallback(m_window, [](GLFWwindow* window, int button, int action, int mods)
        {
            InputAdapter& inputAdapter = *static_cast<InputAdapter*>(glfwGetWindowUserPointer(window));

            inputAdapter.MouseButton(button, action, mods);
        });

        glfwSetCursorPosCallback(m_window, [](GLFWwindow* window, double xpos, double ypos)
        {
            InputAdapter& inputAdapter = *static_cast<InputAdapter*>(glfwGetWindowUserPointer(window));

            inputAdapter.MouseMove(xpos, ypos);
        });

        glfwSetScrollCallback(m_window, [](GLFWwindow* window, double xoffset, double yoffset)
        {
            InputAdapter& inputAdapter = *static_cast<InputAdapter*>(glfwGetWindowUserPointer(window));

            inputAdapter.MouseScroll(xoffset, yoffset);
        });

        glfwSetWindowRefreshCallback(m_window, [](GLFWwindow* window)
        {
            //GLFW& glfw = *static_cast<GLFW*>(glfwGetWindowUserPointer(window));

            //glfwSwapBuffers(glfw.m_window);
            //glfw.RenderFrame();
        });
    }

    void GLFW::ProcessEvents()
    {
        glfwWaitEvents();
    }

    void GLFW::RenderFrame()
    {
        glfwGetFramebufferSize(m_window, &m_size.x, &m_size.y);
        glfwGetWindowPos(m_window, &m_position.x, &m_position.y);

        Frame();

        glfwSwapBuffers(m_window);
        m_inputAdapter.UpdateKeys();
    }

    void GLFW::TerminateWindow()
    {
        glfwDestroyWindow(m_window);
        glfwTerminate();
    }

    bool GLFW::IsWindowOpen()
    {
        return !glfwWindowShouldClose(m_window);
    }

    void GLFW::SetTitle(const std::string& title)
    {
        glfwSetWindowTitle(m_window, title.c_str());
    }
    
    void GLFW::SetSize(const glm::ivec2& size)
    {
        m_size = size;

        if (!m_window) return;

        glfwSetWindowSize(m_window, m_size.x, m_size.y);
    }

    void GLFW::SetPosition(const glm::ivec2& position)
    {
        m_position = position;

        if (!m_window) return;

        glfwSetWindowPos(m_window, position.x, position.y);
    }

    void GLFW::SetFullscreen(bool fullscreen)
    {
        m_fullscreen = fullscreen;
        if (!m_window) return;

        if (!fullscreen)
        {
            glfwSetWindowMonitor(m_window, nullptr, m_position_before_fullscreen.x, m_position_before_fullscreen.y, m_size_before_fullscreen.x, m_size_before_fullscreen.y, 0);

            return;
        }

        m_size_before_fullscreen = m_size;
        m_position_before_fullscreen = m_position;

        GLFWmonitor*       monitor = glfwGetPrimaryMonitor();
        const GLFWvidmode* mode    = glfwGetVideoMode(monitor);

        glfwWindowHint(GLFW_RED_BITS    , mode->redBits    );
        glfwWindowHint(GLFW_GREEN_BITS  , mode->greenBits  );
        glfwWindowHint(GLFW_BLUE_BITS   , mode->blueBits   );
        glfwWindowHint(GLFW_REFRESH_RATE, mode->refreshRate);
        
        glfwSetWindowMonitor(m_window, monitor, 0, 0, mode->width, mode->height, mode->refreshRate);
    }

    void GLFW::MakeCentered()
    {
        const GLFWvidmode* mode = glfwGetVideoMode(glfwGetPrimaryMonitor());

        SetPosition(glm::ivec2((mode->width - m_size.x) / 2, (mode->height - m_size.y) / 2));
    }
    
}