#pragma once

#include <string>

#include <windows.h>

class znKeySender
{
public:
    znKeySender();
    ~znKeySender();

    void SendKey(WORD vKey);
    void SendKeyDown(WORD vKey);
    void SendKeyUp(WORD vKey);

    void SendKeySequence(std::string keys);
};