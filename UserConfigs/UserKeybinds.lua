-- Basic Apps
hl.bind(MainMod .. " + D",          hl.dsp.exec_cmd("pkill rofi || rofi -show drun -modi drun,filebrowser,run,window -dpi 100"))
hl.bind(MainMod .. " + Return",     hl.dsp.exec_cmd(DefaultTerminal))
hl.bind(MainMod .. " + T",          hl.dsp.exec_cmd(FilesManager))
hl.bind(MainMod .. " + ALT + C",    hl.dsp.exec_cmd(UserScripts .. "/RofiCalc.sh"))
hl.bind(MainMod .. " + Z",          hl.dsp.exec_cmd("pypr zoom"))

-- User Defined Binds
if HostMachine == "arch-legion" then
-- Ragnarok Online Binds
    hl.bind(MainMod .. " + X",          hl.dsp.exec_cmd("/home/tori/workspace/tools/ro-support/caller.sh"))
    hl.bind(MainMod .. " + I",          hl.dsp.exec_cmd("/home/tori/workspace/tools/ro-buffer/pot-pitcher.sh"))
    hl.bind(MainMod .. " + O",          hl.dsp.exec_cmd("/home/tori/workspace/tools/ro-buffer/pot-pitcher-3.sh"))
    hl.bind(MainMod .. " + A",          hl.dsp.exec_cmd("/home/tori/workspace/tools/ro-buffer/kim-on.sh"))
    hl.bind(MainMod .. " + U",          hl.dsp.exec_cmd("/home/tori/workspace/tools/ro-buffer/abys-on.sh"))
    hl.bind(MainMod .. " + C",          hl.dsp.exec_cmd("/home/tori/workspace/tools/ro-buffer/kill-all-scripts.sh"))
    hl.bind(MainMod .. " + R",          hl.dsp.exec_cmd(UserScripts .. "/TinyArch_Ro_launcher.sh"))
end
if HostMachine == "tiny-arch" then
-- Ragnarok Online Binds
    hl.bind(MainMod .. " + R",          hl.dsp.exec_cmd("/home/tori/Games/launcher/launcher.sh"))
    hl.bind(MainMod .. " + X",          hl.dsp.exec_cmd("/home/tori/Games/warp_and_move.sh"))
    hl.bind(MainMod .. " + N",          hl.dsp.exec_cmd("/home/tori/Games/warp_and_move_on_spot.sh"))
    hl.bind(MainMod .. " + C",          hl.dsp.exec_cmd("/home/tori/Games//kill-all-scripts.sh"))
end

--bind = $mainMod SHIFT, O, exec, $UserScripts/ZshChangeTheme.sh # Change oh-my-zsh theme
