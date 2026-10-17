-- Reference: https://wiki.hypr.land/configuring/core/rules/window-rules/

-- Ignore maximize requests from apps.
hl.window_rule({ name = "suppress-maximize", match = { class = ".*" }, suppress_event = "maximize" })

-- Float and center settings and previews.
local utility = "^(blueman-manager|nm-connection-editor|Btop|org.pulseaudio.pavucontrol)$"
hl.window_rule({ name = "float-utilities", match = { class = utility }, float = true })
hl.window_rule({ name = "center-utilities", match = { class = utility }, center = true })
hl.window_rule({ name = "size-utilities", match = { class = utility }, size = { 1100, 900 } })
hl.window_rule({ name = "pin-utilities", match = { class = utility }, pin = true })

-- Float and center file pickers.
hl.window_rule({
	name = "float-file-pickers",
	match = { class = "xdg-desktop-portal-gtk", title = "^(Open.*Files?|Save.*Files?|All Files|Save).*" },
	float = true,
	center = true,
	size = { "60%", "60%" },
})

-- Steam.
local steam = "^steam$"
hl.window_rule({ name = "steam-main", match = { class = steam, title = "^Steam$" }, float = false })
hl.window_rule({
	name = "steam-friends",
	match = { class = steam, title = "^Friends List$" },
	float = true,
	center = true,
	size = { 460, 800 },
})
hl.window_rule({
	name = "steam-offers",
	match = { class = steam, title = "^Special Offers$" },
	float = true,
	center = true,
	size = { 900, 700 },
})
hl.window_rule({
	name = "steam-dialogs",
	match = { class = steam, title = "^(?!Steam$).+" },
	float = true,
	center = true,
})

hl.window_rule({ name = "steam-opacity", match = { class = steam }, opacity = "1 1" })
hl.window_rule({ name = "steam-idle", match = { class = steam }, idle_inhibit = "fullscreen" })

-- Fix some dragging issues with XWayland.
hl.window_rule({
	name = "xwayland-drag-fix",
	match = { class = "^$", title = "^$", xwayland = true, float = true, fullscreen = false, pin = false },
	no_focus = true,
})

-- Reference: https://wiki.hypr.land/configuring/core/rules/workspace-rules/

-- Persistent workspaces.
for i = 1, 5 do
	hl.workspace_rule({
		workspace = tostring(i),
		persistent = true,
	})
end
