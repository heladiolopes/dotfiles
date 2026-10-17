-- Reference: https://wiki.hypr.land/configuring/core/config-options/#input

hl.config({
  input = {
    kb_layout = "us",
    kb_variant = "intl",
    kb_options = "nodeadkeys,ctrl:nocaps,compose:ralt",
    follow_mouse = 1,
    sensitivity = 0,
    touchpad = { natural_scroll = false },
  },
})

-- Scroll nicely in terminals.
hl.window_rule({ match = { class = "(Alacritty|kitty)" }, scroll_touchpad = 1.5 })
hl.window_rule({ match = { class = "com.mitchellh.ghostty" }, scroll_touchpad = 0.2 })

-- This rule is ignored when the named mouse is absent.
hl.device({ name = "logitech-g502-hero-gaming-mouse", sensitivity = -0.5 })
hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })
