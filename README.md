This is a C++ Visual Studio project that create a JustUkeWinUtils DLL to be invoked from OBS Lua script.

The JustUkeWinUtils DLL contains API functions to
  - to switch to another Window application by specifying the window title of the target application.
  - to find a window title of the current foreground application.
  - functions to send key strokes to the current foreground applications.

Installation
- Just download and place the "JustUkeWinUtils.dll".
- The DLL can be placed in OBS installation folder such as "C:\Program Files\obs-studio\bin\64bit".
- It can also be placed anywhere else.
- Download the "jamulus_hotkeys.lua" LUA script.
- Specify the location of the "JustUkeWinUtils.dll" in the LUA script.

Important Notes
The "jamulus_hotkeys.lua" is just an example script that implements some hotkey functions. You need to modify the script as per your usage requirement.
