-- Basic Apps
hl.bind(MainMod .. " + D",          hl.dsp.exec_cmd("pkill rofi || rofi -show drun -modi drun,filebrowser,run,window -dpi 100"), { description = "Rofi Menu"})
hl.bind(MainMod .. " + Return",     hl.dsp.exec_cmd(DefaultTerminal), { description = "kitty terminal"})
hl.bind(MainMod .. " + T",          hl.dsp.exec_cmd(FilesManager), { description = "Nautilus File Manager"})
hl.bind(MainMod .. " + ALT + C",    hl.dsp.exec_cmd(UserScripts .. "/RofiCalc.sh"), { description = "Simple RofiCalc"})
hl.bind(MainMod .. " + ALT + Z",    hl.dsp.exec_cmd("pypr zoom"), { description = "Zoom"})
hl.bind(MainMod .. " + code:49",    hl.dsp.exec_cmd("ags run ~/.config/ags/app/app.js -g 3"), { description = "Keybind viewer"})

-- User Defined Binds
if HostMachine == "arch-legion" then
-- Ragnarok Online Binds
    hl.bind(MainMod .. " + X",          hl.dsp.exec_cmd("/home/tori/workspace/tools/ro-support/caller.sh"), { description = "Call RO support assistant"})
    hl.bind(MainMod .. " + C",          hl.dsp.exec_cmd("/home/tori/workspace/tools/ro-buffer/kill-all-scripts.sh"), { description = "Stop all bot scripts on tiny-arch"})

    hl.bind(MainMod .. " + I",          hl.dsp.exec_cmd("/home/tori/workspace/gemini-code/ro-python-helper/songs-picker/start-solo-songs.sh"), { description = "Turn On: Songs on timer"})
    hl.bind(MainMod .. " + U",          hl.dsp.exec_cmd("/home/tori/workspace/gemini-code/ro-python-helper/songs-picker/start-concert-song.sh"), { description = "Turn On: Concert on timer"})
    hl.bind(MainMod .. " + M",          hl.dsp.exec_cmd("/home/tori/workspace/tools/ro-support/buffer/call-fortune-mayor.sh"), { description = "Call dancer support"})
    hl.bind(MainMod .. " + SHIFT + I",  hl.dsp.exec_cmd("ags run /home/tori/workspace/gemini-code/ro-python-helper/songs-picker/config.ts"), { description = "Songs on timer. Configuration window"})
    
    hl.bind(MainMod .. " + O",          hl.dsp.exec_cmd("/home/tori/workspace/tools/ro-support/caller.sh reload"), { description = "Call ROaD reload"})
    hl.bind(MainMod .. " + SHIFT + O",  hl.dsp.exec_cmd("/home/tori/workspace/tools/ro-support/caller.sh update"), { description = "Call ROaD update"})

    hl.bind(MainMod .. " + R",          hl.dsp.exec_cmd(UserScripts .. "/TinyArch_Ro_launcher.sh"), { description = "Call RO launcher for tiny-arch"})
    
    hl.bind(MainMod .. " + J",          hl.dsp.exec_cmd("/home/tori/workspace/tools/ro-support/buffer/call-follow.sh"), { description = "Make prof autofollow"})
    -- hl.bind(MainMod .. " + A",          hl.dsp.exec_cmd("/home/tori/workspace/tools/ro-buffer/kim-on.sh"), { description = "Turn On: Kim"})

    -- Thanatos dialog actrions
    hl.bind(MainMod .. " + code:34",    hl.dsp.exec_cmd("/home/tori/workspace/tools/ro-support/buffer/call-thana-enter.sh"), { description = "Call thana enter script"})
    hl.bind(MainMod .. " + code:35",    hl.dsp.exec_cmd("/home/tori/workspace/tools/ro-support/buffer/call-thana-black-key.sh"), { description = "Call thana black key getter script"})
    hl.bind(MainMod .. " + code:20",    hl.dsp.exec_cmd("/home/tori/workspace/tools/ro-support/buffer/call-6floor.sh"), { description = "Call thana 6 floor script"})
    hl.bind(MainMod .. " + code:21",    hl.dsp.exec_cmd("/home/tori/workspace/tools/ro-support/buffer/call-top-floor.sh"), { description = "Call thana top floor script"})
end
if HostMachine == "tiny-arch" then
-- Ragnarok Online Binds
    hl.bind(MainMod .. " + R",          hl.dsp.exec_cmd("/home/tori/Games/launcher/launcher.sh"), { description = "Call RO launcher"})
    hl.bind(MainMod .. " + X",          hl.dsp.exec_cmd("/home/tori/Games/warp_and_move.sh"), { description = "Call RO warp_and_move script"})
    hl.bind(MainMod .. " + N",          hl.dsp.exec_cmd("/home/tori/Games/warp_and_move_on_spot.sh"), { description = "Call RO Move-on-spot script"})
    hl.bind(MainMod .. " + C",          hl.dsp.exec_cmd("/home/tori/Games//kill-all-scripts.sh"), { description = "Stop all bot scripts"})
end

--bind = $mainMod SHIFT, O, exec, $UserScripts/ZshChangeTheme.sh # Change oh-my-zsh theme
