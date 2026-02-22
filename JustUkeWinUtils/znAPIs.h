#pragma once

extern "C" {

    __declspec(dllexport) bool UkerSwitchWindow(const char*);

    __declspec(dllexport) const char* UkerFindForegroundWindow();

    __declspec(dllexport) void UkerKeySendDown(short int);
    __declspec(dllexport) void UkerKeySendUp(short int);
    __declspec(dllexport) void UkerKeySend(short int);
}
