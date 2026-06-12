-- Basic
hl.bind(MainMod .. " + Q",          hl.dsp.window.close())
hl.bind(MainMod .. " + F",          hl.dsp.window.fullscreen("maximized","toggle"))
hl.bind(MainMod .. " + SHIFT + Q",  hl.dsp.exec_cmd(ScriptsDir .. "/KillActiveProcess.sh"))
hl.bind(MainMod .. " + SHIFT + F",  hl.dsp.window.float({ action = "toggle" }))
hl.bind(MainMod .. " + L",          hl.dsp.exec_cmd(ScriptsDir .. "/LockScreen.sh"))
hl.bind(MainMod .. " + P",          hl.dsp.window.pseudo())
--bind = $mainMod ALT, F, exec, hyprctl dispatch workspaceopt allfloat

-- FEATURES / EXTRAS
hl.bind(MainMod .. " + SHIFT + G",  hl.dsp.exec_cmd(ScriptsDir .. "/GameMode.sh"))
hl.bind(MainMod .. " + ALT + V",    hl.dsp.exec_cmd(ScriptsDir .. "/ClipManager.sh"))
hl.bind(MainMod .. " + E",          hl.dsp.exec_cmd(UserScripts .. "/QuickEdit.sh"))
--bind = $mainMod, W, exec, $UserScripts/WallpaperSelect.sh # Select wallpaper to apply
--bind = $mainMod SHIFT, W, exec, $UserScripts/WallpaperEffects.sh # Wallpaper Effects by imagemagickWW
--bind = CTRL ALT, W, exec, $UserScripts/WallpaperRandom.sh # Random wallpapers

-- Waybar / Bar related
hl.bind(MainMod .. " + B",          hl.dsp.exec_cmd("killall -SIGUSR1 waybar"))

-- To switch between windows in a floating workspace:

-- Special Keys / Hot Keys
hl.bind("XF86AudioRaiseVolume",     hl.dsp.exec_cmd(ScriptsDir .. "/Volume.sh --inc"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume",     hl.dsp.exec_cmd(ScriptsDir .. "/Volume.sh --dec"), { locked = true, repeating = true })
hl.bind("XF86AudioMute",            hl.dsp.exec_cmd(ScriptsDir .. "/Volume.sh --toggle"))
hl.bind("XF86AudioMicMute",         hl.dsp.exec_cmd(ScriptsDir .. "/Volume.sh --toggle-mic"))
hl.bind("xf86Sleep",                hl.dsp.exec_cmd("systemctl suspend"))
hl.bind("xf86Rfkill",               hl.dsp.exec_cmd(ScriptsDir .. "/AirplaneMode.sh"))

-- Media controls using keyboards
--hl.bind("xf86AudioPlayPause",       hl.dsp.exec_cmd(ScriptsDir .. "MediaCtrl.sh --pause"), { locked = true })
hl.bind("XF86AudioPlay",            hl.dsp.exec_cmd(ScriptsDir .. "MediaCtrl.sh --pause"), { locked = true })
hl.bind("XF86AudioPause",           hl.dsp.exec_cmd(ScriptsDir .. "MediaCtrl.sh --pause"), { locked = true })
hl.bind("XF86AudioNext",            hl.dsp.exec_cmd(ScriptsDir .. "/MediaCtrl.sh --nxt"), { locked = true })
hl.bind("XF86AudioPrev",            hl.dsp.exec_cmd(ScriptsDir .. "/MediaCtrl.sh --prv"), { locked = true })
hl.bind("xf86audiostop",            hl.dsp.exec_cmd(ScriptsDir .. "/MediaCtrl.sh --stop"), { locked = true })

-- Screenshots
hl.bind(MainMod .. " + Print",              hl.dsp.exec_cmd(ScriptsDir .. "/ScreenShot.sh --swappy"))
hl.bind(MainMod .. " + SHIFT + Print",      hl.dsp.exec_cmd(ScriptsDir .. "/ScreenShot.sh --area"))
hl.bind(MainMod .. " + CTRL + Print",       hl.dsp.exec_cmd(ScriptsDir .. "/ScreenShot.sh --in5"))
hl.bind("ALT + Print",                      hl.dsp.exec_cmd(ScriptsDir .. "/ScreenShot.sh -active "))
hl.bind(MainMod .. " + SHIFT + S",          hl.dsp.exec_cmd(ScriptsDir .. "/ScreenShot.sh --swappy"))

-- Windows operations
-- Focus
hl.bind(MainMod .. " + left",               hl.dsp.focus({ direction = "left" }))
hl.bind(MainMod .. " + right",              hl.dsp.focus({ direction = "right" }))
hl.bind(MainMod .. " + up",                 hl.dsp.focus({ direction = "up" }))
hl.bind(MainMod .. " + down",               hl.dsp.focus({ direction = "down" }))
-- Reszie
hl.bind(MainMod .. " + SHIFT + left",       hl.dsp.window.resize({ x = -50, y = 0,      relative = true }))
hl.bind(MainMod .. " + SHIFT + right",      hl.dsp.window.resize({ x = 50,  y = 0,      relative = true }))
hl.bind(MainMod .. " + SHIFT + up",         hl.dsp.window.resize({ x = 0,   y = -50,    relative = true }))
hl.bind(MainMod .. " + SHIFT + down",       hl.dsp.window.resize({ x = 0,   y = 50,     relative = true }))
-- Local Move
hl.bind(MainMod .. " + CTRL + left",        hl.dsp.window.move({ direction = "left" }))
hl.bind(MainMod .. " + CTRL + right",       hl.dsp.window.move({ direction = "right" }))
hl.bind(MainMod .. " + CTRL + up",          hl.dsp.window.move({ direction = "up" }))
hl.bind(MainMod .. " + CTRL + down",        hl.dsp.window.move({ direction = "down" }))
-- Workspace & windows operations
-- lua (x and b or c) == c++ (a?b:c)
for i = 1, 20 do
local key = (i <= 10) and (i % 10) or ("F" .. (i - 10)) 
    hl.bind(MainMod .. " + " .. key,             hl.dsp.focus({ workspace = i}))
    hl.bind(MainMod .. " + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i, follow = true }))
    hl.bind(MainMod .. " + CTRL + " .. key,      hl.dsp.window.move({ workspace = i, follow = false }))
end
-- Scroll through existing workspaces with mainMod + scroll
hl.bind(MainMod .. " + mouse_down",         hl.dsp.focus({ workspace = "e+1" }))
hl.bind(MainMod .. " + mouse_up",           hl.dsp.focus({ workspace = "e-1" }))
-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(MainMod .. " + mouse:272",          hl.dsp.window.drag(),   { mouse = true })
hl.bind(MainMod .. " + mouse:273",          hl.dsp.window.resize(), { mouse = true })

--Kb Brightness. DO i need this?
--hl.bind("xf86KbdBrightnessDown",            hl.dsp.exec_cmd(scriptsDir .. "/BrightnessKbd.sh --dec"), { locked = true, repeating = true })
--hl.bind("xf86KbdBrightnessUp",              hl.dsp.exec_cmd(scriptsDir .. "/BrightnessKbd.sh --inc"), { locked = true, repeating = true })
-- Touchpad script. Oo i need this?
--bind = , xf86TouchpadToggle, exec, $scriptsDir/TouchPad.sh #disable touchpad
