#pragma once

#include "TC/input/Input.hpp"
#include <set>

namespace TC
{
    class InputAdapter
    {
    public:
        InputAdapter(TC::Input& input);

        void KeyboardKey(int    key    , int    scancode, int action, int mods);
        void MouseButton(int    button ,                  int action, int mods);
        void MouseScroll(double xoffset, double yoffset                       );
        void MouseMove  (double xpos   , double ypos                          );

        void UpdateKeys();

    private:
        TC::Input& m_input;
        std::set<Key*> m_pressedKeys;
    };
}