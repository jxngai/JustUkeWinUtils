#pragma once

#include <Windows.h>

// Global variables.

extern HWND g_hwnd_found;

BOOL CALLBACK EnumWindowsProc(HWND hWnd, LPARAM lParam);
