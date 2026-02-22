#include "znWinUtils.h"

#include <string>
#include <regex>

HWND g_hwnd_found;

// Callback function prototype (must match WNDENUMPROC)

BOOL CALLBACK EnumWindowsProc(HWND hWnd, LPARAM lParam)
{
    // Get the window title length

    int length = GetWindowTextLength(hWnd);

    // Check if the window is visible and has a title
    if (IsWindowVisible(hWnd) && length != 0)
    {
        // Allocate buffer for the window title
        wchar_t* buffer = new wchar_t[length + 1];

        // Get the window title
        GetWindowText(hWnd, buffer, length + 1);
        std::wstring window_title_ix(buffer);

        // Free the buffer
        delete[] buffer;

        std::wstring target_win_title = *(std::wstring*)lParam;

        if (target_win_title.size() > 0)
        {
            std::wsmatch m;
            if (std::regex_match(window_title_ix, m, std::wregex(target_win_title)) == true)
            {
                g_hwnd_found = hWnd;

                // Windows found. Return false to stop the subsequent enumeration.
                return false;
            }
        }
    }

    // Return true to continue the enumeration.
    return true;
}

