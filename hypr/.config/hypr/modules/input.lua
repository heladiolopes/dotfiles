-- https://wiki.hyprland.org/Configuring/Variables/#input
hl.config({
    input = {
        kb_layout = "us",
        kb_variant = "intl",
        kb_model = "",
        kb_options = "nodeadkeys,ctrl:nocaps,compose:ralt",
        kb_rules = "",
        follow_mouse = 1,
        sensitivity = 0,
        touchpad = {
            natural_scroll = false,
        },
    },
})

-- Scroll nicely in terminals.
hl.window_rule({
    match = { class = "(Alacritty|kitty)" },
    scroll_touchpad = 1.5,
})
hl.window_rule({
    match = { class = "com.mitchellh.ghostty" },
    scroll_touchpad = 0.2,
})

-- Enable touchpad gestures for changing workspaces.
hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })

-- Per-device input configuration.
hl.device({
    name = "logitech-g502-hero-gaming-mouse",
    sensitivity = -0.5,
})
