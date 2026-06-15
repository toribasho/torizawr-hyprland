local wallust_colors = {}
local file = io.open(os.getenv("HOME") .. "/.config/hypr/wallust/wallust-hyprland.conf", "r")

if file then
    for line in file:lines() do
        -- Match strings like: $background = rgb(01050A)
        local key, val = line:match("^%s*%$(%w+)%s*=%s*(.-)%s*$")
        if key and val then
            wallust_colors[key] = val
        end
    end
    file:close()
end

hl.config({
    general = {
        gaps_in = 6,
        gaps_out = 8,
        border_size = 2,
        resize_on_border = false,

        col = {
            active_border = wallust_colors.color12,
            inactive_border = wallust_colors.background,
        },

        layout = "dwindle",
    },
    decoration = {
        rounding = 10,
                
        active_opacity = 1.0,
        inactive_opacity = 1.0,
        fullscreen_opacity = 1.0,

        dim_inactive = true,
        dim_strength = 0.1,
        dim_special = 0.8,

        blur = {
            enabled = true,
            size = 6,
            passes = 2,
            ignore_opacity = true,
            new_optimizations = true,
            special = true,
        },
        shadow = {
            enabled = true,
        }
    },
    animations = {
        enabled = true,
    },
    dwindle = {
        preserve_split = true,
        special_scale_factor = 0.8,
    },
    master = {
        new_on_top=1,
        mfact = 0.5,
    },
    group = {
        col = { border_active = wallust_colors.color15 },
    },
    input = {
        kb_layout="us,ru",
        kb_options="grp:caps_toggle",
        repeat_rate=50,
        repeat_delay=300,
        numlock_by_default=false,
        left_handed=false,
        follow_mouse=true,
        float_switch_override_focus=false,
        accel_profile="adaptive",
        sensitivity=1.0,

        touchpad = {
            disable_while_typing=true,
            natural_scroll=true,
            clickfinger_behavior=false,
            middle_button_emulation=true,
            tap_to_click=true,
            drag_lock=false,
        },
    },
    misc = {
        disable_hyprland_logo = true,
        disable_splash_rendering = true,
        vrr = 2,
        mouse_move_enables_dpms = true,
        enable_swallow = true,
        focus_on_activate = false,
        swallow_regex = "^(kitty)$",
    },
    binds = {
        workspace_back_and_forth=true,
        allow_workspace_cycles=true,
        pass_mouse_when_bound=false,
    },
    -- Could help when scaling and not pixelating
    xwayland = {
        enabled = true,
        force_zero_scaling = true,
    },
    -- render section for Hyprland >= v0.42.0
    render = {
        direct_scanout = false,
    },
    cursor = {
        sync_gsettings_theme = true,
        no_hardware_cursors = 2,
        enable_hyprcursor = true,
        warp_on_change_workspace = 2,
        no_warps = true,
    },
})

hl.curve( "wind",     { type = "bezier", points = { {0.05, 0.9}, {0.1, 1.05} } })
hl.curve( "winIn",    { type = "bezier", points = { {0.1, 1.1}, {0.1, 1.1} } })
hl.curve( "winOut",   { type = "bezier", points = { {0.3, -0.3}, {0, 1} } })
hl.curve( "liner",    { type = "bezier", points = { {1, 1}, {1, 1} } })

--hl.animation({ leaf = "global",        enabled = true,  speed = 6,   bezier = "default" })
hl.animation({ leaf = "windows",        enabled = true,  speed = 6,     bezier = "wind",    style = "slide" })
hl.animation({ leaf = "windowsIn",      enabled = true,  speed = 6,     bezier = "winIn",   style = "slide" })
hl.animation({ leaf = "windowsOut",     enabled = true,  speed = 5,     bezier = "winOut",  style = "slide" })
hl.animation({ leaf = "windowsMove",    enabled = true,  speed = 5,     bezier = "wind",    style = "slide" })
hl.animation({ leaf = "border",         enabled = true,  speed = 1,     bezier = "liner" })
hl.animation({ leaf = "borderangle",    enabled = true,  speed = 18,    bezier = "liner",   style = "loop"})
hl.animation({ leaf = "fade",           enabled = true,  speed = 10,    bezier = "default"})
hl.animation({ leaf = "workspaces",     enabled = true,  speed = 5,     bezier = "wind",    style = "slide"})