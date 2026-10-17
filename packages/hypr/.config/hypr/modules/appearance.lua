-- Reference: https://wiki.hypr.land/configuring/core/config-options/

hl.config({
	general = {
		gaps_in = 1,
		gaps_out = 2,
		border_size = 2,
		col = {
			active_border = "#2979FF",
			inactive_border = "#F8F8F8",
		},
		resize_on_border = true,
		allow_tearing = false,
		layout = "dwindle",
	},
	decoration = {
		rounding = 5,
		active_opacity = 1.0,
		inactive_opacity = 1.0,
		shadow = { enabled = false },
		blur = { enabled = true, size = 4, passes = 1, vibrancy = 0.17 },
	},
	animations = {
		enabled = true,
	},
	dwindle = {
		preserve_split = true,
		force_split = 2,
	},
	misc = {
		disable_hyprland_logo = true,
		disable_splash_rendering = true,
		focus_on_activate = true,
	},
	xwayland = {
		force_zero_scaling = true,
	},
})

-- Reference: https://wiki.hypr.land/configuring/core/animations/

hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1.00 }, { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0.00, 0.00 }, { 1.00, 1 } } })
hl.curve("almostLinear", { type = "bezier", points = { { 0.50, 0.50 }, { 0.75, 1 } } })
hl.curve("quick", { type = "bezier", points = { { 0.15, 0.00 }, { 0.10, 1 } } })

-- hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })

hl.animation({ leaf = "windows", enabled = true, speed = 5, bezier = "easeOutQuint", style = "popin 80%" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 5, bezier = "easeOutQuint", style = "popin 80%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 5, bezier = "linear", style = "popin 80%" })

hl.animation({ leaf = "layers", enabled = true, speed = 2, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 2, bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 2, bezier = "linear", style = "fade" })

hl.animation({ leaf = "fade", enabled = true, speed = 3, bezier = "quick" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 2, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 2, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 2, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 2, bezier = "almostLinear" })

hl.animation({ leaf = "border", enabled = true, speed = 5, bezier = "easeOutQuint" })

hl.animation({ leaf = "workspaces", enabled = false })
-- hl.animation({ leaf = "workspaces",    enabled = true, speed = 0.5, bezier = "almostLinear", style = "fade" })
-- hl.animation({ leaf = "workspacesIn",  enabled = true, speed = 0.5, bezier = "almostLinear", style = "fade" })
-- hl.animation({ leaf = "workspacesOut", enabled = true, speed = 0.5, bezier = "almostLinear", style = "fade" })
