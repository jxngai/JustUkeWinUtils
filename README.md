# Overview
This is a C++ Visual Studio project that create a JustUkeWinUtils DLL to be invoked from OBS Lua script.

The JustUkeWinUtils DLL contains API functions
  - to switch to another Window application by specifying the window title of the target application.
  - to find a window title of the current foreground application.
  - to send key strokes to the current foreground applications.

# Installation
- Just download and place the "JustUkeWinUtils.dll".
- The DLL can be placed in OBS installation folder such as "C:\Program Files\obs-studio\bin\64bit".
- It can also be placed anywhere else.
- Download the "jamulus_hotkeys.lua" LUA Plugin script.
- Specify the location of the "JustUkeWinUtils.dll" in the LUA Plugin script.
- Install the Lua PLugin Script onto OBS. (Tools -> Scripts -> +)
<img width="1192" height="593" alt="obs_002" src="https://github.com/user-attachments/assets/51299465-27b2-44ec-939f-72bbde8442d4" />
<img width="1192" height="593" alt="obs_003" src="https://github.com/user-attachments/assets/62fbd16e-7247-414b-b082-e77f3e560170" />

# Important Notes
The "jamulus_hotkeys.lua" is just an example script that implements some hotkey functions. You need to modify the script as per your usage requirement.

This LUA script allows you to assign hotkeys to the functions defined in the script.

<img width="1228" height="710" alt="obs_001" src="https://github.com/user-attachments/assets/94cd3552-2bec-4c1e-9393-71e3d1311aa6" />

