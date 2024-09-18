#pragma once

#include <cstdint>

#include <BHW/utils/Time.hpp>

#include "TC/input/KeyCode.hpp"

namespace TC
{
    struct Key
    {
    public:
        Key();

        inline ActionCode Action() const { return m_action; }

        inline bool Pressed () const { return m_action == ActionCode::Press  ; }
        inline bool Released() const { return m_action == ActionCode::Release; }
        inline bool Repeated() const { return m_action == ActionCode::Repeat ; }

        inline bool PressedThisFrame () const { return Pressed () && ThisFrame(); }
        inline bool ReleasedThisFrame() const { return Released() && ThisFrame(); }
        inline bool RepeatedThisFrame() const { return Repeated() && ThisFrame(); }

        inline bool ThisFrame() const { return m_thisFrame; }

    private:
        friend class InputAdapter;

        inline void SetAction(ActionCode action) { m_action = action; }

    private:
        ActionCode m_action;
        bool m_thisFrame;
    };
}