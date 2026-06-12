local lock = ScriptsDir .. "/LockScreen.sh"
local wallDIR=os.getenv("HOME") .. "/Pictures/wallpapers"
local SwwwRandom = UserScripts .. "/WallpaperAutoChange.sh"

hl.on("hyprland.start", function ()
-- wallpaper
  hl.exec_cmd("awww-daemon --format xrgb")
-- random wp
  --hl.exec_cmd(SwwwRandom .. wallDIR)
-- Startup
  hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP XDG_SESSION_TYPE")
  hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP") -- Execute waybar, hyprpaper, firefox
-- Polkit (Polkit Gnome / KDE)  
  hl.exec_cmd(ScriptsDir .. "/Polkit.sh")
-- DE apps  
  hl.exec_cmd("waybar")
  hl.exec_cmd("swaync")
  hl.exec_cmd("ags")
-- clipboard manager  
  hl.exec_cmd("wl-paste --type text --watch cliphist store")
  hl.exec_cmd("wl-paste --type image --watch cliphist store")
-- Rainbow borders  
  --hl.exec_cmd(UserScripts .. "/RainbowBorders.sh")
-- Starting hypridle to start hyprlock  
  hl.exec_cmd("hypridle")
-- pyprland daemon  
  hl.exec_cmd("pypr")
-- User Defined Apps  
-- NoGUI apps  
  hl.exec_cmd("syncthing-gtk")
  hl.exec_cmd("input-remapper-control --command autoload")
  hl.exec_cmd("easyeffects --gapplication-service")
  hl.exec_cmd("/usr/bin/hyprland-per-window-layout")
  hl.exec_cmd(UserScripts .. "/BatteryChecker.sh")
  hl.exec_cmd(UserScripts .. "/MouseBatChecker.sh")
  hl.exec_cmd("/usr/bin/rquickshare")
-- GUI Apps
  --hl.exec_cmd( "subl",              { workspace = "1", follow = false} )
  --hl.exec_cmd( "telegram-desktop",  { workspace = "1", follow = false} )
  --hl.exec_cmd( "obsidian --use-gl=desktop --enable-features=UseOzonePlatform --ozone-platform=wayland",              { workspace = "1", follow = false} )
  --hl.exec_cmd( "firefox",           { workspace = "2", follow = false} )
  --hl.exec_cmd( "/usr/bin/flatpak run --branch=stable --arch=x86_64 --command=bottles --file-forwarding com.usebottles.bottles ",           { workspace = "2", follow = false} )
  hl.exec_cmd("subl")
  hl.exec_cmd("telegram-desktop")
  hl.exec_cmd("obsidian --use-gl=desktop --enable-features=UseOzonePlatform --ozone-platform=wayland")
  hl.exec_cmd("firefox")
  hl.exec_cmd("/usr/bin/flatpak run --branch=stable --arch=x86_64 --command=bottles --file-forwarding com.usebottles.bottles")
end)