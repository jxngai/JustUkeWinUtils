-- This is an example hotkey OBS script.
-- Please modify the scripts as per your requirement.

-- This script
--    Loads the "znObsLuaDLL.dll" which provide C functions to
--         Find Foreground window
--         Switch window
--         Send Key Sequence
--
-- Author : Ngai Kim Hoong.
-- Date : 20260211
--
-- Descriptions
--
-- Mainly to interact with the hotkeys generated from the Sayo Keyboard.
-- Provided functions to toggle between OBS full screen view and Adobe acrobat application.
-- Provided functions to interact with Adobe Acrobat to
--     set 1 page view
--     set 2 page view
--     set 2 page view offse4t
--     page down
--     page up

obs = obslua

ffi = require("ffi")

ffi.cdef[[
int printf(const char *fmt, ...);
int MessageBoxA(void *w, const char *txt, const char *cap, int type);
long strlen(const char*);

bool UkerSwitchWindow(const char *);
const char* UkerFindForegroundWindow();

void UkerKeySendDown(short int);
void UkerKeySendUp(short int);
void UkerKeySend(short int);
]]

-- Load the DLL from a specific location.
local obsffi = ffi.load("C:/FB_Live/video/obs/scripts/JustUkeWinUtils.dll")

-- Load the DLL from "C:\Program Files\obs-studio\bin\64bit"
-- local obsffi = ffi.load("JustUkeWinUtils")

local switch_to_obs_window_hotkey_id = obs.OBS_INVALID_HOTKEY_ID
local toggle_obs_adobe_window_hotkey_id = obs.OBS_INVALID_HOTKEY_ID

local desktop_left_hotkey_id = obs.OBS_INVALID_HOTKEY_ID
local desktop_right_hotkey_id = obs.OBS_INVALID_HOTKEY_ID

local acrobat_1_page_hotkey_id = obs.OBS_INVALID_HOTKEY_ID
local acrobat_2_page_hotkey_id = obs.OBS_INVALID_HOTKEY_ID
local acrobat_2_page_offset_hotkey_id = obs.OBS_INVALID_HOTKEY_ID

local acrobat_page_up_hotkey_id = obs.OBS_INVALID_HOTKEY_ID
local acrobat_page_down_hotkey_id = obs.OBS_INVALID_HOTKEY_ID

local acrobat_open_hotkey_id = obs.OBS_INVALID_HOTKEY_ID
local acrobat_close_hotkey_id = obs.OBS_INVALID_HOTKEY_ID

local hide_overlay_groups_hotkey_id = obs.OBS_INVALID_HOTKEY_ID

function script_defaults(settings)
end

function script_description()

    -- print("!!! script_description()")

    return "Jamulus Hotkeys.\nMade by Ngai Kim Hoong.\nVersion 1.0."

end

function script_load(settings)

    -- print("!!! script_load()")

    local hotkey_save_array

    switch_to_obs_window_hotkey_id = obs.obs_hotkey_register_frontend("switch_to_obs_window", "Jamulus Switch to OBS Projector Window", switch_to_obs_window)
    hotkey_save_array = obs.obs_data_get_array(settings, "switch_to_obs_window")
    obs.obs_hotkey_load(switch_to_obs_window_hotkey_id, hotkey_save_array)
    obs.obs_data_array_release(hotkey_save_array)

    toggle_obs_adobe_window_hotkey_id = obs.obs_hotkey_register_frontend("toggle_obs_adobe_window", "Jamulus Toggle Between OBS and Adobe Windows", toggle_obs_adobe_window)
    hotkey_save_array = obs.obs_data_get_array(settings, "toggle_obs_adobe_window")
    obs.obs_hotkey_load(toggle_obs_adobe_window_hotkey_id, hotkey_save_array)
    obs.obs_data_array_release(hotkey_save_array)

    acrobat_1_page_hotkey_id = obs.obs_hotkey_register_frontend("acrobat_1_page", "Jamulus Configure Adobe 1 Page View", acrobat_1_page)
    hotkey_save_array = obs.obs_data_get_array(settings, "acrobat_1_page")
    obs.obs_hotkey_load(acrobat_1_page_hotkey_id, hotkey_save_array)
    obs.obs_data_array_release(hotkey_save_array)

    acrobat_2_page_hotkey_id = obs.obs_hotkey_register_frontend("acrobat_2_page", "Jamulus Configure Adobe 2 Page View", acrobat_2_page)
    hotkey_save_array = obs.obs_data_get_array(settings, "acrobat_2_page")
    obs.obs_hotkey_load(acrobat_2_page_hotkey_id, hotkey_save_array)
    obs.obs_data_array_release(hotkey_save_array)

    acrobat_2_page_offset_hotkey_id = obs.obs_hotkey_register_frontend("acrobat_2_page_offset", "Jamulus Configure Adobe Page Offset", acrobat_2_page_offset)
    hotkey_save_array = obs.obs_data_get_array(settings, "acrobat_2_page_offset")
    obs.obs_hotkey_load(acrobat_2_page_offset_hotkey_id, hotkey_save_array)
    obs.obs_data_array_release(hotkey_save_array)

    acrobat_page_up_hotkey_id = obs.obs_hotkey_register_frontend("acrobat_page_up", "Jamulus Adobe Page Up", acrobat_page_up)
    hotkey_save_array = obs.obs_data_get_array(settings, "acrobat_page_up")
    obs.obs_hotkey_load(acrobat_page_up_hotkey_id, hotkey_save_array)
    obs.obs_data_array_release(hotkey_save_array)

    acrobat_page_down_hotkey_id = obs.obs_hotkey_register_frontend("acrobat_page_down", "Jamulus Adobe Page Down", acrobat_page_down)
    hotkey_save_array = obs.obs_data_get_array(settings, "acrobat_page_down")
    obs.obs_hotkey_load(acrobat_page_down_hotkey_id, hotkey_save_array)
    obs.obs_data_array_release(hotkey_save_array)

    acrobat_open_hotkey_id = obs.obs_hotkey_register_frontend("acrobat_page_open", "Jamulus Adobe Open", acrobat_page_open)
    hotkey_save_array = obs.obs_data_get_array(settings, "acrobat_page_open")
    obs.obs_hotkey_load(acrobat_open_hotkey_id, hotkey_save_array)
    obs.obs_data_array_release(hotkey_save_array)

    acrobat_close_hotkey_id = obs.obs_hotkey_register_frontend("acrobat_page_close", "Jamulus Adobe Close", acrobat_page_close)
    hotkey_save_array = obs.obs_data_get_array(settings, "acrobat_page_close")
    obs.obs_hotkey_load(acrobat_close_hotkey_id, hotkey_save_array)
    obs.obs_data_array_release(hotkey_save_array)

    desktop_left_hotkey_id = obs.obs_hotkey_register_frontend("desktop_left", "Jamulus Desktop Left", desktop_left)
    hotkey_save_array = obs.obs_data_get_array(settings, "desktop_left")
    obs.obs_hotkey_load(desktop_left_hotkey_id, hotkey_save_array)
    obs.obs_data_array_release(hotkey_save_array)

    desktop_right_hotkey_id = obs.obs_hotkey_register_frontend("desktop_right", "Jamulus Desktop Right", desktop_right)
    hotkey_save_array = obs.obs_data_get_array(settings, "desktop_right")
    obs.obs_hotkey_load(desktop_right_hotkey_id, hotkey_save_array)
    obs.obs_data_array_release(hotkey_save_array)

    hide_overlay_groups_hotkey_id = obs.obs_hotkey_register_frontend("hide_overlay_groups", "Jamulus Hide Overlay Groups", hide_overlay_groups)
    hotkey_save_array = obs.obs_data_get_array(settings, "hide_overlay_groups")
    obs.obs_hotkey_load(hide_overlay_groups_hotkey_id, hotkey_save_array)
    obs.obs_data_array_release(hotkey_save_array)
end

function script_update(settings)
end

function script_properties()
end

function script_save(settings)

    local hotkey_save_array

    hotkey_save_array = obs.obs_hotkey_save(switch_to_obs_window_hotkey_id)
    obs.obs_data_set_array(settings, "switch_to_obs_window", hotkey_save_array)
    obs.obs_data_array_release(hotkey_save_array)

    hotkey_save_array = obs.obs_hotkey_save(toggle_obs_adobe_window_hotkey_id)
    obs.obs_data_set_array(settings, "toggle_obs_adobe_window", hotkey_save_array)
    obs.obs_data_array_release(hotkey_save_array)

    hotkey_save_array = obs.obs_hotkey_save(acrobat_1_page_hotkey_id)
    obs.obs_data_set_array(settings, "acrobat_1_page", hotkey_save_array)
    obs.obs_data_array_release(hotkey_save_array)

    hotkey_save_array = obs.obs_hotkey_save(acrobat_2_page_hotkey_id)
    obs.obs_data_set_array(settings, "acrobat_2_page", hotkey_save_array)
    obs.obs_data_array_release(hotkey_save_array)

    hotkey_save_array = obs.obs_hotkey_save(acrobat_2_page_offset_hotkey_id)
    obs.obs_data_set_array(settings, "acrobat_2_page_offset", hotkey_save_array)
    obs.obs_data_array_release(hotkey_save_array)

    hotkey_save_array = obs.obs_hotkey_save(acrobat_page_up_hotkey_id)
    obs.obs_data_set_array(settings, "acrobat_page_up", hotkey_save_array)
    obs.obs_data_array_release(hotkey_save_array)

    hotkey_save_array = obs.obs_hotkey_save(acrobat_page_down_hotkey_id)
    obs.obs_data_set_array(settings, "acrobat_page_down", hotkey_save_array)
    obs.obs_data_array_release(hotkey_save_array)

    hotkey_save_array = obs.obs_hotkey_save(acrobat_open_hotkey_id)
    obs.obs_data_set_array(settings, "acrobat_page_open", hotkey_save_array)
    obs.obs_data_array_release(hotkey_save_array)

    hotkey_save_array = obs.obs_hotkey_save(acrobat_close_hotkey_id)
    obs.obs_data_set_array(settings, "acrobat_page_close", hotkey_save_array)
    obs.obs_data_array_release(hotkey_save_array)

    hotkey_save_array = obs.obs_hotkey_save(desktop_left_hotkey_id)
    obs.obs_data_set_array(settings, "desktop_left", hotkey_save_array)
    obs.obs_data_array_release(hotkey_save_array)

    hotkey_save_array = obs.obs_hotkey_save(desktop_right_hotkey_id)
    obs.obs_data_set_array(settings, "desktop_right", hotkey_save_array)
    obs.obs_data_array_release(hotkey_save_array)

    hotkey_save_array = obs.obs_hotkey_save(hide_overlay_groups_hotkey_id)
    obs.obs_data_set_array(settings, "hide_overlay_groups", hotkey_save_array)
    obs.obs_data_array_release(hotkey_save_array)
end


function switch_to_obs_window(pressed)
    if not pressed then
        return false
    end

    local flag = obsffi.UkerSwitchWindow("Projector - Preview")

    obs.os_sleep_ms(100)

    return true
end

function toggle_obs_adobe_window(pressed)
    if not pressed then
        return false
    end

    local win_title_tmp = obsffi.UkerFindForegroundWindow()

    local win_title = ffi.string(win_title_tmp, ffi.C.strlen(win_title_tmp))

    -- print("Found foreground windows == " .. win_title)

    if win_title == "Projector - Preview" then
        helper_switch_to_adobe_acrobat()
    else
        local flag = obsffi.UkerSwitchWindow("Projector - Preview")
    end

    obs.os_sleep_ms(100)

    return true
end

function acrobat_1_page(pressed)
    if not pressed then
        return false
    end

    if helper_switch_to_adobe_acrobat() then

        -- Adobe Acrobat application is the top most application.
        -- Send the key sequence.

        -- It is problematic when need to invoke menu items using
        -- "alt + v". Delays can be essential.

        obs.os_sleep_ms(100)

        obsffi.UkerKeySendDown(0x12)     -- VK_MENU
        obs.os_sleep_ms(20)
        obsffi.UkerKeySend(86)           -- V
        -- obs.os_sleep_ms(10)
        obsffi.UkerKeySend(80)           -- P
        -- obs.os_sleep_ms(10)
        obsffi.UkerKeySend(83)           -- S
        -- obs.os_sleep_ms(10)
        obsffi.UkerKeySendUp(0x12)       -- VK_MENU

        obs.os_sleep_ms(200)
    end

    return true
end

function acrobat_2_page(pressed)
    if not pressed then
        return false
    end

    if helper_switch_to_adobe_acrobat() then

        -- Adobe Acrobat application is the top most application.
        -- Send the key sequence.

        obs.os_sleep_ms(100)

        obsffi.UkerKeySendDown(0x12)     -- VK_MENU
        obs.os_sleep_ms(20)
        obsffi.UkerKeySend(86)           -- V
        -- obs.os_sleep_ms(10)
        obsffi.UkerKeySend(80)           -- P
        -- obs.os_sleep_ms(10)
        obsffi.UkerKeySend(80)           -- P
        -- obs.os_sleep_ms(10)
        obsffi.UkerKeySendUp(0x12)       -- VK_MENU

        obs.os_sleep_ms(200)
    end

    return true
end

function acrobat_2_page_offset(pressed)
    if not pressed then
        return true
    end

    if helper_switch_to_adobe_acrobat() then

        -- Adobe Acrobat application is the top most application.
        -- Send the key sequence.

        obs.os_sleep_ms(100)

        obsffi.UkerKeySendDown(0x12)     -- VK_MENU
        obs.os_sleep_ms(20)
        obsffi.UkerKeySend(86)           -- V
        -- obs.os_sleep_ms(10)
        obsffi.UkerKeySend(80)           -- P
        -- obs.os_sleep_ms(10)
        obsffi.UkerKeySend(86)           -- V
        -- obs.os_sleep_ms(10)
        obsffi.UkerKeySendUp(0x12)       -- VK_MENU

        obs.os_sleep_ms(200)
    end

    return true
end

function acrobat_page_up(pressed)
    if not pressed then
        return false
    end

    if helper_switch_to_adobe_acrobat() then

        -- Adobe Acrobat application is the top most application.
        -- Send the key sequence.

        obsffi.UkerKeySend(0x21)           -- VK_PRIOR

        obs.os_sleep_ms(100)
    end

    return true
end

function acrobat_page_down(pressed)
    if not pressed then
        return false
    end

    if helper_switch_to_adobe_acrobat() then

        -- Adobe Acrobat application is the top most application.
        -- Send the key sequence.

        obsffi.UkerKeySend(0x22)           -- VK_NEXT

        obs.os_sleep_ms(100)
    end

    return true
end

function acrobat_page_open(pressed)
    if not pressed then
        return false
    end

    if helper_switch_to_adobe_acrobat() then

        -- Adobe Acrobat application is the top most application.
        -- Send the key sequence.

        obsffi.UkerKeySendDown(0x11)     -- VK_CONTROL
        obs.os_sleep_ms(10)
        obsffi.UkerKeySend(79)           -- O
        obs.os_sleep_ms(10)
        obsffi.UkerKeySendUp(0x11)       -- VK_CONTROL

        obs.os_sleep_ms(100)
    end

    return true
end

function acrobat_page_close(pressed)
    if not pressed then
        return false
    end

    if helper_switch_to_adobe_acrobat() then

        -- Adobe Acrobat application is the top most application.
        -- Send the key sequence.

        obsffi.UkerKeySendDown(0x11)     -- VK_CONTROL
        obs.os_sleep_ms(10)
        obsffi.UkerKeySend(87)           -- W
        obs.os_sleep_ms(10)
        obsffi.UkerKeySendUp(0x11)       -- VK_CONTROL

        obs.os_sleep_ms(100)
    end

    return true
end

function desktop_left(pressed)
    if not pressed then
        return false
    end
	
	obs.os_sleep_ms(200)

    obsffi.UkerKeySendDown(0x11)     -- VK_CONTROL
	obs.os_sleep_ms(10)
    obsffi.UkerKeySendDown(0x5B)     -- VK_LWIN
	obs.os_sleep_ms(10)
    obsffi.UkerKeySend(0x25)         -- VK_LEFT
	obs.os_sleep_ms(10)
    obsffi.UkerKeySendUp(0x5B)       -- VK_LWIN
	obs.os_sleep_ms(10)
    obsffi.UkerKeySendUp(0x11)       -- VK_CONTROL

    obs.os_sleep_ms(200)

    return true
end

function desktop_right(pressed)
    if not pressed then
        return false
    end

    obs.os_sleep_ms(200)
	
    obsffi.UkerKeySendDown(0x11)     -- VK_CONTROL
	obs.os_sleep_ms(10)
    obsffi.UkerKeySendDown(0x5B)     -- VK_LWIN
	obs.os_sleep_ms(10)
    obsffi.UkerKeySend(0x27)         -- VK_RIGHT
	obs.os_sleep_ms(10)
    obsffi.UkerKeySendUp(0x5B)       -- VK_LWIN
	obs.os_sleep_ms(10)
    obsffi.UkerKeySendUp(0x11)       -- VK_CONTROL

    obs.os_sleep_ms(200)

    return true
end

function hide_overlay_groups()
    hide_overlay_group("Group - Butterfly")
    hide_overlay_group("Group - Leaves")
    hide_overlay_group("Group - Snow")
    hide_overlay_group("Group - Applause")
end


function hide_overlay_group(group_name_to_hide)
    -- Get the current active scene

    local scene = obs.obs_get_scene_by_name("Assets - Overlay Effects")

    if (scene ~= nil) then

        local group_item = obs.obs_scene_find_source(scene, group_name_to_hide)

        if group_item ~= nil then
            -- Set the visibility of the group item to false (hidden)

            obs.obs_sceneitem_set_visible(group_item, false)

            -- Release the scene item reference
            -- obs.obs_sceneitem_release(group_item)
        end

    end

    -- Release the scene source reference
    obs.obs_scene_release(scene)
end

function helper_switch_to_adobe_acrobat()

    win_title_target = ".* - Adobe Acrobat Reader \\(64-bit\\)$"

    local rcode = obsffi.UkerSwitchWindow(win_title_target)

    -- print("!!! helper_switch_to_adobe_acrobat .. " .. rcode)

    return rcode
end
