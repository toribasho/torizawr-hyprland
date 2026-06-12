-- Basic
hl.bind(mainMod .. " + Q",          hl.dsp.window.close())
hl.bind(mainMod .. " + F",          hl.dsp.window.fullscreen("maximized","toggle"))
hl.bind(mainMod .. " + SHIFT + Q",  hl.dsp.exec_cmd(scriptsDir .. "/KillActiveProcess.sh"))
hl.bind(mainMod .. " + SHIFT + F",  hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + L",          hl.dsp.exec_cmd(scriptsDir .. "/LockScreen.sh"))
hl.bind(mainMod .. " + P",          hl.dsp.window.pseudo())
--bind = $mainMod ALT, F, exec, hyprctl dispatch workspaceopt allfloat

-- FEATURES / EXTRAS
hl.bind(mainMod .. " + SHIFT + G",  hl.dsp.exec_cmd(scriptsDir .. "/GameMode.sh"))
hl.bind(mainMod .. " + ALT + V",    hl.dsp.exec_cmd(scriptsDir .. "/ClipManager.sh"))
hl.bind(mainMod .. " + E",          hl.dsp.exec_cmd(UserScripts .. "/QuickEdit.sh"))
--bind = $mainMod, W, exec, $UserScripts/WallpaperSelect.sh # Select wallpaper to apply
--bind = $mainMod SHIFT, W, exec, $UserScripts/WallpaperEffects.sh # Wallpaper Effects by imagemagickWW
--bind = CTRL ALT, W, exec, $UserScripts/WallpaperRandom.sh # Random wallpapers

-- Waybar / Bar related
hl.bind(mainMod .. " + B",          hl.dsp.exec_cmd("killall -SIGUSR1 waybar"))

-- To switch between windows in a floating workspace:

-- Special Keys / Hot Keys
hl.bind("XF86AudioRaiseVolume",     hl.dsp.exec_cmd(scriptsDir .. "/Volume.sh --inc"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume",     hl.dsp.exec_cmd(scriptsDir .. "/Volume.sh --dec"), { locked = true, repeating = true })
hl.bind("XF86AudioMute",            hl.dsp.exec_cmd(scriptsDir .. "/Volume.sh --toggle"))
hl.bind("XF86AudioMicMute",         hl.dsp.exec_cmd(scriptsDir .. "/Volume.sh --toggle-mic"))
hl.bind("xf86Sleep",                hl.dsp.exec_cmd("systemctl suspend"))
hl.bind("xf86Rfkill",               hl.dsp.exec_cmd(scriptsDir .. "/AirplaneMode.sh"))

-- Media controls using keyboards
hl.bind("xf86AudioPlayPause",       hl.dsp.exec_cmd(scriptsDir .. "MediaCtrl.sh --pause"), { locked = true })
hl.bind("XF86AudioPlay",            hl.dsp.exec_cmd(scriptsDir .. "MediaCtrl.sh --pause"), { locked = true })
hl.bind("XF86AudioPause",           hl.dsp.exec_cmd(scriptsDir .. "MediaCtrl.sh --pause"), { locked = true })
hl.bind("XF86AudioNext",            hl.dsp.exec_cmd(scriptsDir .. "/MediaCtrl.sh --nxt"), { locked = true })
hl.bind("XF86AudioPrev",            hl.dsp.exec_cmd(scriptsDir .. "/MediaCtrl.sh --prv"), { locked = true })
hl.bind("xf86audiostop",            hl.dsp.exec_cmd(scriptsDir .. "/MediaCtrl.sh --stop"), { locked = true })

-- Screenshots
hl.bind(mainMod .. " + Print",              hl.dsp.exec_cmd(scriptsDir .. "/ScreenShot.sh --swappy"))
hl.bind(mainMod .. " + SHIFT + Print",      hl.dsp.exec_cmd(scriptsDir .. "/ScreenShot.sh --area"))
hl.bind(mainMod .. " + ACTRLLT + Print",    hl.dsp.exec_cmd(scriptsDir .. "/ScreenShot.sh --in5"))
hl.bind("ALT + Print",                      hl.dsp.exec_cmd(scriptsDir .. "/ScreenShot.sh -active "))
hl.bind(mainMod .. " + SHIFT + S",          hl.dsp.exec_cmd(scriptsDir .. "/ScreenShot.sh --swappy"))

-- Windows operations
-- Focus
hl.bind(mainMod .. " + left",               hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right",              hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",                 hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",               hl.dsp.focus({ direction = "down" }))
-- Reszie
hl.bind(mainMod .. " + SHIFT + left",       hl.dsp.window.resize({ x = -50, y = 0,      relative = true }))
hl.bind(mainMod .. " + SHIFT + right",      hl.dsp.window.resize({ x = 50,  y = 0,      relative = true }))
hl.bind(mainMod .. " + SHIFT + up",         hl.dsp.window.resize({ x = 0,   y = -50,    relative = true }))
hl.bind(mainMod .. " + SHIFT + down",       hl.dsp.window.resize({ x = 0,   y = 50,     relative = true }))
-- Local Move
hl.bind(mainMod .. " + CTRL + left",        hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + CTRL + right",       hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + CTRL + up",          hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + CTRL + down",        hl.dsp.window.move({ direction = "down" }))
-- Workspace & windows operations
-- lua (x and b or c) == c++ (a?b:c)
for i = 1, 20 do
local key = (i <= 10) and (i % 10) or ("F" .. (i - 10)) 
    hl.bind(mainMod .. " + " .. key,             hl.dsp.focus({ workspace = i}))
    hl.bind(mainMod .. " + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i, follow = true }))
    hl.bind(mainMod .. " + CTRL + " .. key,      hl.dsp.window.move({ workspace = i, follow = false }))
end
-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down",         hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",           hl.dsp.focus({ workspace = "e-1" }))
-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272",          hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273",          hl.dsp.window.resize(), { mouse = true })