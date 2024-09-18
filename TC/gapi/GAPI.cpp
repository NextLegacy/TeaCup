#include "TC/gapi/GAPI.hpp"

namespace TC
{
    GAPI::GAPI() : m_size(1280, 720), m_input(TC::Input()), m_inputAdapter(m_input)
    {
    }
}