#include "znKeySender.h"

znKeySender::znKeySender()
{

}

znKeySender::~znKeySender()
{

}

void znKeySender::SendKey(WORD vKey)
{
    INPUT ip[2];

    // Key down event
    ip[0].type = INPUT_KEYBOARD;
    ip[0].ki.wVk = vKey; // Virtual key code, e.g., VK_F5, 'A' (as a char/WORD)
    ip[0].ki.wScan = 0;
    ip[0].ki.dwFlags = 0;
    ip[0].ki.time = 0;
    ip[0].ki.dwExtraInfo = 0;

    // Key up event
    ip[1].type = INPUT_KEYBOARD;
    ip[1].ki.wVk = vKey;
    ip[1].ki.wScan = 0;
    ip[1].ki.dwFlags = KEYEVENTF_KEYUP; // Flag for key release
    ip[1].ki.time = 0;
    ip[1].ki.dwExtraInfo = 0;

    // Send the two events (key down and key up)
    SendInput(2, ip, sizeof(INPUT));
}

void znKeySender::SendKeyDown(WORD vKey)
{
    INPUT ip[1];

    VK_F5;

    // Key down event

    ip[0].type = INPUT_KEYBOARD;
    ip[0].ki.wVk = vKey; // Virtual key code, e.g., VK_F5, 'A' (as a char/WORD)
    ip[0].ki.wScan = 0;
    ip[0].ki.dwFlags = 0;
    ip[0].ki.time = 0;
    ip[0].ki.dwExtraInfo = 0;

    // Send the two events (key down and key up)
    SendInput(1, ip, sizeof(INPUT));
}

void znKeySender::SendKeyUp(WORD vKey)
{
    INPUT ip[1];

    // Key down event

    // Key up event
    ip[0].type = INPUT_KEYBOARD;
    ip[0].ki.wVk = vKey;
    ip[0].ki.wScan = 0;
    ip[0].ki.dwFlags = KEYEVENTF_KEYUP; // Flag for key release
    ip[0].ki.time = 0;
    ip[0].ki.dwExtraInfo = 0;

    // Send the two events (key down and key up)
    SendInput(1, ip, sizeof(INPUT));
}

void znKeySender::SendKeySequence(std::string keys)
{
    short flag_vk_menu_state = 0;
    short flag_vk_shift_state = 0;
    short flag_vk_control_state = 0;

    for (int ix = 0; ix < keys.size(); ix++)
    {
        OutputDebugStringW(L"ix = ");
        OutputDebugStringW(std::to_wstring(ix).c_str());
        OutputDebugStringW(L"\n");

        SendKey(keys[ix]);
    }
}