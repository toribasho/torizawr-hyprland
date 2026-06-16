-- Basic Apps
hl.bind(MainMod .. " + D",          hl.dsp.exec_cmd("pkill rofi || rofi -show drun -modi drun,filebrowser,run,window -dpi 100"), { description = "Rofi Menu"})
hl.bind(MainMod .. " + Return",     hl.dsp.exec_cmd(DefaultTerminal), { description = "kitty terminal"})
hl.bind(MainMod .. " + T",          hl.dsp.exec_cmd(FilesManager), { description = "Nautilus File Manager"})
hl.bind(MainMod .. " + ALT + C",    hl.dsp.exec_cmd(UserScripts .. "/RofiCalc.sh"), { description = "Simple RofiCalc"})
hl.bind(MainMod .. " + Z",          hl.dsp.exec_cmd("pypr zoom"), { description = "Zoom"})
hl.bind(MainMod .. " + code:49",    hl.dsp.exec_cmd("ags run ~/.config/ags/app/app.js -g 3"), { description = "Keybind viewer"})

-- User Defined Binds
if HostMachine == "arch-legion" then
-- Ragnarok Online Binds
    hl.bind(MainMod .. " + X",          hl.dsp.exec_cmd("/home/tori/workspace/tools/ro-support/caller.sh"), { description = "Call RO support bot"})
--    hl.bind(MainMod .. " + I",          hl.dsp.exec_cmd("/home/tori/workspace/tools/ro-buffer/pot-pitcher.sh"), { description = ""})
--    hl.bind(MainMod .. " + O",          hl.dsp.exec_cmd("/home/tori/workspace/tools/ro-buffer/pot-pitcher-3.sh"), { description = "here"})
    hl.bind(MainMod .. " + A",          hl.dsp.exec_cmd("/home/tori/workspace/tools/ro-buffer/kim-on.sh"), { description = "Turn On: Kim"})
    hl.bind(MainMod .. " + U",          hl.dsp.exec_cmd("/home/tori/workspace/tools/ro-buffer/abys-on.sh"), { description = "Turn On: Abys on timer"})
    hl.bind(MainMod .. " + C",          hl.dsp.exec_cmd("/home/tori/workspace/tools/ro-buffer/kill-all-scripts.sh"), { description = "Stop all bot scripts on tiny-arch"})
    hl.bind(MainMod .. " + R",          hl.dsp.exec_cmd(UserScripts .. "/TinyArch_Ro_launcher.sh"), { description = "Call RO launcher for tiny-arch"})
end
if HostMachine == "tiny-arch" then
-- Ragnarok Online Binds
    hl.bind(MainMod .. " + R",          hl.dsp.exec_cmd("/home/tori/Games/launcher/launcher.sh"), { description = "Call RO launcher"})
    hl.bind(MainMod .. " + X",          hl.dsp.exec_cmd("/home/tori/Games/warp_and_move.sh"), { description = "Call RO warp_and_move script"})
    hl.bind(MainMod .. " + N",          hl.dsp.exec_cmd("/home/tori/Games/warp_and_move_on_spot.sh"), { description = "Call RO Move-on-spot script"})
    hl.bind(MainMod .. " + C",          hl.dsp.exec_cmd("/home/tori/Games//kill-all-scripts.sh"), { description = "Stop all bot scripts"})
end

--bind = $mainMod SHIFT, O, exec, $UserScripts/ZshChangeTheme.sh # Change oh-my-zsh theme
