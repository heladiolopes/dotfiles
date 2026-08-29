-- Ref: https://wiki.hyprland.org/Configuring/Window-Rules
-- Ref: https://wiki.hyprland.org/Configuring/Workspace-Rules

-- Ignore maximize requests from apps.
hl.window_rule({
    match = { class = ".*" },
    suppress_event = "maximize",
})

-- Float and center settings and previews.
local settings_class = "^(blueberry.py|Impala|Btop|org.gnome.NautilusPreviewer)$"
hl.window_rule({ match = { class = settings_class }, float = true })
hl.window_rule({ match = { class = settings_class }, center = true })
hl.window_rule({ match = { class = settings_class }, size = { 1000, 800 } })

-- Float and center file pickers.
local file_picker_match = {
    class = "xdg-desktop-portal-gtk",
    title = "^(Open.*Files?|Save.*Files?|All Files|Save)",
}
hl.window_rule({ match = file_picker_match, float = true })
hl.window_rule({ match = file_picker_match, center = true })

-- Float Steam.
hl.window_rule({ match = { class = "steam" }, float = true })
hl.window_rule({ match = { class = "steam", title = "Steam" }, center = true })
hl.window_rule({ match = { class = "steam" }, opacity = "1 1" })
hl.window_rule({ match = { class = "steam", title = "Steam" }, size = { 1100, 700 } })
hl.window_rule({ match = { class = "steam", title = "Friends List" }, size = { 460, 800 } })
hl.window_rule({ match = { class = "steam" }, idle_inhibit = "fullscreen" })

-- Pavucontrol floating.
local pavucontrol_class = "(.*org.pulseaudio.pavucontrol.*)"
hl.window_rule({ match = { class = pavucontrol_class }, float = true })
hl.window_rule({ match = { class = pavucontrol_class }, size = { 700, 600 } })
hl.window_rule({ match = { class = pavucontrol_class }, center = true })
-- hl.window_rule({ match = { class = pavucontrol_class }, pin = true })

-- Fix some dragging issues with XWayland.
hl.window_rule({
    match = {
        class = "^$",
        title = "^$",
        xwayland = true,
        float = true,
        fullscreen = false,
        pin = false,
    },
    no_focus = true,
})
