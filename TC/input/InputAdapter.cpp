#include "TC/input/InputAdapter.hpp"
#include <iostream>
#include <set>

namespace TC 
{
    InputAdapter::InputAdapter(TC::Input& input) : m_input(input)
    {
    }

    void InputAdapter::KeyboardKey(int key, int scancode, int action, int mods)
    {
        m_input.Key(static_cast<KeyCode>(key)).SetAction(static_cast<ActionCode>(action));


        m_input.Key(static_cast<KeyCode>(key)).m_thisFrame = true;
        m_pressedKeys.insert(&m_input.Key(static_cast<KeyCode>(key)));
    }
    void InputAdapter::MouseButton(int button , int action, int mods)
    {
        m_input.MouseButton(static_cast<MouseButtonCode>(button)).SetAction(static_cast<ActionCode>(action));
        m_input.MouseButton(static_cast<MouseButtonCode>(button)).m_thisFrame = true;

        m_pressedKeys.insert(&m_input.MouseButton(static_cast<MouseButtonCode>(button)));
    }
    void InputAdapter::MouseScroll(double xoffset, double yoffset)
    {
        m_input.MouseWheel().SetDelta(xoffset, yoffset);
    }

    void InputAdapter::MouseMove  (double xpos, double ypos)
    {
        m_input.Mouse().SetPosition(xpos, ypos);
    }

    void InputAdapter::UpdateKeys()
    {
        for (auto key : m_pressedKeys)
        {
            key->m_thisFrame = false;
        }

        m_pressedKeys.clear();
    }
}