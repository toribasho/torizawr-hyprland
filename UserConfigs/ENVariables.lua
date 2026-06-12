-- Multi-GPU setup
hl.env("AQ_DRM_DEVICES","/dev/dri/intel-igpu-card:/dev/dri/nvidia-dgpu-card")

-- Environment vars
hl.env("CLUTTER_BACKEND","wayland")
hl.env("GDK_BACKEND","wayland,x11")
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR","1")
hl.env("QT_QPA_PLATFORM","wayland;xcb")
hl.env("QT_QPA_PLATFORMTHEME","gtk3")
hl.env("QT_SCALE_FACTOR","1")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION","1")
hl.env("XDG_CURRENT_DESKTOP","Hyprland")
hl.env("XDG_SESSION_DESKTOP","Hyprland")
hl.env("XDG_SESSION_TYPE","wayland")

-- firefox
hl.env("MOZ_ENABLE_WAYLAND","1")

-- electron >28 apps (may help)
hl.env("ELECTRON_OZONE_PLATFORM_HINT","auto")

-- NVIDIA
hl.env("LIBVA_DRIVER_NAME","nvidia") 
hl.env("__GLX_VENDOR_LIBRARY_NAME","nvidia")
hl.env("NVD_BACKEND","direct")

-- Some unset nvidia vars
--env = GBM_BACKEND,nvidia-drm 
--env = __NV_PRIME_RENDER_OFFLOAD,1 
--env = __VK_LAYER_NV_optimus,NVIDIA_only
--env = WLR_DRM_NO_ATOMIC,1