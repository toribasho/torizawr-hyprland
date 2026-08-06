-- windowrule to avoid idle for fullscreen apps
hl.window_rule({
    name = "apply-something",
    idle_inhibit = "fullscreen",
    match = {
        fullscreen_state_client = 2,
    },
})

hl.window_rule({
    -- Fix some dragging issues with XWayland
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },

    no_focus = true,
})

-- Workspace bind & user fixes
hl.window_rule({
    name = "sublime_workspace",
    match = { class = "^([Ss]ublime_text)$" },
    workspace = 1
})
hl.window_rule({
    name = "tg_workspace",
    match = { class = "^(org.telegram.desktop)$"},
    workspace = 1
})
hl.window_rule({
    name = "firerox_rule" ,
    match = { class = "^([Ff]irefox|org.mozilla.firefox|[Ff]irefox-esr)$"},
    workspace = 2
})
hl.window_rule({
    name = "lutris_rule",
    match = { class = "^(net.lutris.Lutris)$"},
    workspace = 10
})
hl.window_rule({
    name = "bottles_rule",
    match = { class = "^(com.usebottles.bottles)$"},
    workspace = 10
})
hl.window_rule({
    name = "firefox_subwindows",
    match = { class = "^firefox$", title = "^(Library)$"},
    float = 1,
    size = {"monitor_w * 0.7", "monitor_h * 0.7"},
})
hl.window_rule({
    name = "firefox_pwwindow",
    match = { class = "^firefox$", title = "^(Password Required - Mozilla Firefox)$"},
    float = 1,
})
hl.window_rule({
    name = "arcida-launcher",
    match = { class = "^arcadia-launcher.exe"},
    float = 1
})
hl.window_rule({
    name = "gnome-polkit",
    match = { class = "polkit-gnome-authentication-agent-1"},
    float = true,
    center = true,
    workspace = "active"
})
hl.window_rule({
    name = "gnome-polkit",
    match = { class = "xdg-desktop-portal-gtk"},
    float = true,
    center = true,
    workspace = "active"
})
hl.window_rule({
    name = "keybinds-window",
    match = { title = "Active Hyprland Keybindings Map"},
    float = true,
    center = true,
    workspace = "active",
    size = {900, 450}
})
hl.window_rule({
    name = "pavucontrol",
    match = { class = "org.pulseaudio.pavucontrol"},
    float = true,
    center = true,
    workspace = "active"
})
hl.window_rule({
    name = "blueman-manager",
    match = { class = "blueman-manager"},
    float = true,
    -- center = true,
    move = {1815,48},
    size = {600, 800},
    workspace = "active"
})
hl.window_rule({
    name = "gazzele-wifi-tui",
    match = { class = "kitty", title = "gazelle-tui"},
    float = true,
    -- center = true,
    move = {1753,53},
    size = {800, 1000},
    workspace = "active"
})
-- Arch-legion specific rules
if HostMachine == "arch-legion" then
    hl.window_rule({
        name = "arcida-client",
        match = { class = "^aocli.exe"},
        maximize = true
    })
end

-- windowrule - opacity #enable as desired
hl.window_rule({
    opacity = "0.9 0.8",
    match = { class = "^(gnome-disks|evince|wihotspot-gui|org.gnome.baobab)$" },
})
hl.window_rule({
    opacity = "0.9 0.8",
    match = { class = "^(org.gnome.Nautilus)$" },
})
hl.window_rule({
    opacity = "1.0 0.8",
    match = { class = "^(kitty)$" },
})
hl.window_rule({
    opacity = "1.0 1.0",
    match = { class = "^([Ff]irefox|org.mozilla.firefox|[Ff]irefox-esr)$" },
})
hl.window_rule({ 
    opacity = "0.9 0.6",
    match = { class = "^([Rr]ofi)$" },
})
-- windowrule v2 - size
hl.window_rule({ 
    size = {"monitor_w * 0.6", "monitor_h * 0.7"},
    match = { class = "^(file-roller|org.gnome.FileRoller)$"},
})
hl.window_rule({ 
    size = {"monitor_w * 0.7", "monitor_h * 0.7"},
    match = { class = "^(xdg-desktop-portal-gtk)$"},
})
