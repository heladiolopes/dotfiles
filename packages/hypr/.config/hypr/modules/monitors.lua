-- Reference: https://wiki.hypr.land/configuring/core/monitors/

-- List current monitors and resolutions possible: hyprctl monitors
-- You must relaunch Hyprland after changing any monitor environment variables.

-- The unnamed rule is a portable fallback. Named rules refine the known workstation.
hl.monitor({ output = "", mode = "preferred", position = "auto", scale = "auto" })
hl.monitor({ output = "eDP-1", mode = "1920x1080@120", position = "0x0", scale = 1 })
hl.monitor({ output = "HDMI-A-1", mode = "1920x1080@60", position = "1920x0", scale = 1 })

-- This Samsung display advertises 720p as its native HDMI mode.
hl.monitor({ output = "desc:Samsung Electric Company SAMSUNG", mode = "1280x720@60", position = "1920x0", scale = 1 })
