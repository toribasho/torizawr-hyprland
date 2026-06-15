-- Multi-GPU setup
hl.env("AQ_DRM_DEVICES","/dev/dri/intel-igpu-card:/dev/dri/nvidia-dgpu-card")

-- Wayland variables
hl.env("OZONE_PLATFORM", "wayland")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "wayland")
hl.env("DESKTOP_SESSION", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")

-- Qt related environment variables
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR","1")
hl.env("QT_SCALE_FACTOR","1")

-- XDG Desktop Portal
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")

-- GDK
hl.env("GDK_SCALE", "1")

-- Toolkit Backend
hl.env("GDK_BACKEND", "wayland,x11,*")
hl.env("CLUTTER_BACKEND", "wayland")

-- Mozilla
hl.env("MOZ_ENABLE_WAYLAND", "1")

-- Set the cursor size for xcursor
hl.env("XCURSOR_THEME", "Bibata-Modern-Ice")
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

-- SDL version
hl.env("SDL_VIDEODRIVER", "wayland")

-- Quickshell debug
hl.env("QS_NO_RELOAD_POPUP", "1")

-- NVIDIA
hl.env("LIBVA_DRIVER_NAME","nvidia") 
hl.env("__GLX_VENDOR_LIBRARY_NAME","nvidia")
hl.env("NVD_BACKEND","direct")

-- Some unset nvidia vars
--env = GBM_BACKEND,nvidia-drm 
--env = __NV_PRIME_RENDER_OFFLOAD,1 
--env = __VK_LAYER_NV_optimus,NVIDIA_only
--env = WLR_DRM_NO_ATOMIC,1