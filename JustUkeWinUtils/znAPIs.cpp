#include "znAPIs.h"
#include "znKeySender.h"
#include "znWinUtils.h"

#include <cstring> // For strlen
#include <iostream> // For std::cout
#include <regex>
#include <locale>
#include <codecvt>
#include <string>
#include <chrono>
#include <thread>

#include <windows.h>

std::string g_result_str;               // Buffer to hold the result string

bool UkerSwitchWindow(const char* a_target_win_title_regex)
{
    std::string win_title = UkerFindForegroundWindow();

    std::smatch m;
    if (std::regex_match(win_title, m, std::regex(a_target_win_title_regex)) == true)
    {
        // The current foreground window matches the target regex.
        // Just return true and do nothing.

        return true;
    }

    // The current foreground window does not match the target regex.

    g_hwnd_found = nullptr;

    if (strlen(a_target_win_title_regex) > 0)
    {
        typedef std::codecvt_utf8<wchar_t> convert_type;
        std::wstring_convert<convert_type, wchar_t> converter;

        const std::wstring target_win_title_regex = converter.from_bytes(a_target_win_title_regex);

        // Enumerate through all windows to find the target window.

        EnumWindows(EnumWindowsProc, (LPARAM)&target_win_title_regex);

        if (g_hwnd_found != nullptr)
        {
            // The target window is found.

            // Simulate ALT key press.
            // This is a hack to bring the current window to the foreground properly.
            // Without this, the OBS "Projector Preview" window does not come to the foreground correctly.
            // Only the OBS icon at the taskbar is highlighted and blinked.

            znKeySender key;

            key.SendKey(VK_MENU);

            ShowWindow(g_hwnd_found, SW_MAXIMIZE);

            SetForegroundWindow(g_hwnd_found);

            SetActiveWindow(g_hwnd_found);

            std::this_thread::sleep_for(std::chrono::milliseconds(200));

            std::string win_title = UkerFindForegroundWindow();

            std::smatch m;
            if (std::regex_match(win_title, m, std::regex(a_target_win_title_regex)) == true)
            {
                return true;
            }
        }
    }
    
    return false;
}

const char* UkerFindForegroundWindow()
{
    g_result_str = "";

    HWND hwnd_foreground = GetForegroundWindow();

    if (hwnd_foreground != nullptr)
    {
        int length = GetWindowTextLength(hwnd_foreground);

        // Allocate buffer for the window title
        wchar_t* buffer = new wchar_t[length + 1];

        // Get the window title
        GetWindowText(hwnd_foreground, buffer, length + 1);
        std::wstring win_title_w(buffer);

        // Free the buffer
        delete[] buffer;

        // Convert wide string to UTF 8 string.

        using convert_type = std::codecvt_utf8<wchar_t>;
        std::wstring_convert<convert_type> converter;

        g_result_str = converter.to_bytes(win_title_w);
    }

    return g_result_str.c_str();
}

void UkerKeySendDown(short int a_key)
{
    znKeySender key;

    key.SendKeyDown(a_key);
}

void UkerKeySendUp(short int a_key)
{
    znKeySender key;

    key.SendKeyUp(a_key);
}

void UkerKeySend(short int a_key)
{
    znKeySender key;

    key.SendKey(a_key);
}


