#pragma once

// version 1.00.00
//   20260223 ::: Initial creation
//
// This DLL provides the following functions
//   - to switch to another Window application by specifying the window title of the target application.
//   - to find a window title of the current foreground application.
//   - functions to send key strokes to the current foreground applications.

extern "C" {

    __declspec(dllexport) bool UkerSwitchWindow(const char*);

    __declspec(dllexport) const char* UkerFindForegroundWindow();

    __declspec(dllexport) void UkerKeySendDown(short int);
    __declspec(dllexport) void UkerKeySendUp(short int);
    __declspec(dllexport) void UkerKeySend(short int);
}
