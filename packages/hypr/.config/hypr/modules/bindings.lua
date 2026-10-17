-- Reference: wiki.hypr.land/configuring/core/binds/

-- todo: see mouse buttons https://wiki.hypr.land/configuring/core/binds/devices/mouse/

local mod = "SUPER"

local function described(kind, description, flags)
	local options = { description = kind .. ": " .. description }
	for key, value in pairs(flags or {}) do
		options[key] = value
	end
	return options
end

hl.bind("SUPER + SHIFT + R", function()
	hl.exec_cmd("hyprctl reload")

	hl.notification.create({
		text = "Hyprland config reloaded",
		timeout = 1000,
		icon = "ok",
	})
end, described("System", "Reload Hyprland configuration"))

--------------------------------------------------------------------------------
---- PROGRAMS ------------------------------------------------------------------
--------------------------------------------------------------------------------

-- Power.
hl.bind(mod .. " + SHIFT + SPACE", hl.dsp.exec_cmd("hyprlock"), described("System", "Lock screen"))
hl.bind(mod .. " + M", hl.dsp.exec_cmd("wlogout"), described("System", "Open power menu"))
-- hl.bind(mod .. " + SHIFT + M", hl.dsp.exit())

-- Program launcher.
hl.bind(mod .. " + RETURN", hl.dsp.exec_cmd("kitty"), described("App", "Open terminal"))
hl.bind(mod .. " + SPACE", hl.dsp.exec_cmd("rofi -show drun"), described("App", "Open app launcher"))
hl.bind(mod .. " + E", hl.dsp.exec_cmd("dolphin"), described("App", "Open file manager"))
hl.bind(mod .. " + B", hl.dsp.exec_cmd("firefox"), described("App", "Open Firefox"))
hl.bind(mod .. " + O", hl.dsp.exec_cmd("obsidian -disable-gpu"), described("App", "Open Obsidian"))
hl.bind(mod .. " + C", hl.dsp.exec_cmd("code"), described("App", "Open VSCode"))

-- Idle Inhibitor Toggle Selection
hl.bind(mod .. " + I", function()
	hl.exec_cmd("$HOME/.local/bin/idle-inhibitor toggle")

	hl.notification.create({
		text = "Idle Inhibitor Toggled",
		timeout = 1000,
		icon = "ok",
	})
end, described("System", "Toggle idle inhibitor"))

-- Open web application in separate Firefox windows.
hl.bind(
	mod .. " + ALT + W",
	hl.dsp.exec_cmd("firefox --new-window https://web.whatsapp.com/"),
	described("Web", "Open WhatsApp Web")
)
hl.bind(
	mod .. " + ALT + C",
	hl.dsp.exec_cmd("firefox --new-window https://chatgpt.com/"),
	described("Web", "Open ChatGPT")
)
hl.bind(
	mod .. " + ALT + Y",
	hl.dsp.exec_cmd("firefox --new-window https://www.youtube.com/"),
	described("Web", "Open YouTube")
)
-- Clipboard.
hl.bind(mod .. " + V", hl.dsp.exec_cmd("$HOME/.local/bin/clipboard-menu"), described("Clipboard", "Open history"))

-- Theme selector.
hl.bind(mod .. " + T", hl.dsp.exec_cmd("$HOME/.local/bin/theme-switch"), described("Theme", "Choose theme"))

-- Background selector.
hl.bind(
	mod .. " + SHIFT + B",
	hl.dsp.exec_cmd("$HOME/.local/bin/background-switch"),
	described("Background", "Choose background")
)

-- Keyboard shortcut reference.
hl.bind(
	mod .. " + SHIFT + slash",
	hl.dsp.exec_cmd("$HOME/.local/bin/keybindings-menu"),
	described("Help", "Show keyboard shortcuts")
)

-- Screenshots.
hl.bind(
	mod .. "+ SHIFT + backslash ",
	hl.dsp.exec_cmd("$HOME/.local/bin/screenshot-menu"),
	described("Screenshot", "Open menu")
)
hl.bind("PRINT", hl.dsp.exec_cmd("hyprshot -m output -m active"), described("Screenshot", "Capture active monitor"))
hl.bind(
	"SHIFT + PRINT",
	hl.dsp.exec_cmd("hyprshot -m output -m active --clipboard-only"),
	described("Screenshot", "Copy active monitor")
)
hl.bind(mod .. " + PRINT", hl.dsp.exec_cmd("hyprshot -m region"), described("Screenshot", "Capture region"))
hl.bind(
	mod .. " + SHIFT + PRINT",
	hl.dsp.exec_cmd("hyprshot -m region --clipboard-only"),
	described("Screenshot", "Copy region")
)

--------------------------------------------------------------------------------
---- MEDIA ---------------------------------------------------------------------
--------------------------------------------------------------------------------

-- Only display the OSD on the currently focused monitor.
local osdclient = [[swayosd-client --monitor "$(hyprctl monitors -j | jq -r '.[] | select(.focused == true).name')"]]
local repeating_locked = { repeating = true, locked = true }
local locked = { locked = true }

-- Laptop power profiles (requires tlp-pd).
hl.bind(
	"XF86PerformanceMode",
	hl.dsp.exec_cmd([[sh -c '
profile=$(tlpctl get) || exit
case "$profile" in
	balanced) tlpctl set performance ;;
	performance) tlpctl set power-saver ;;
	power-saver) tlpctl set balanced ;;
esac
']]),
	described("System", "Cycle power profile", locked)
)

-- Laptop multimedia keys for volume.
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd(osdclient .. " --output-volume raise"),
	described("Audio", "Raise volume", repeating_locked)
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd(osdclient .. " --output-volume lower"),
	described("Audio", "Lower volume", repeating_locked)
)
hl.bind(
	"XF86AudioMute",
	hl.dsp.exec_cmd(osdclient .. " --output-volume mute-toggle"),
	described("Audio", "Toggle speaker mute", locked)
)
hl.bind(
	"XF86AudioMicMute",
	hl.dsp.exec_cmd(osdclient .. " --input-volume mute-toggle"),
	described("Audio", "Toggle microphone mute", locked)
)

-- Laptop multimedia keys for LCD brightness.
hl.bind(
	"XF86MonBrightnessUp",
	hl.dsp.exec_cmd(osdclient .. " --brightness raise"),
	described("Display", "Raise brightness", repeating_locked)
)
hl.bind(
	"XF86MonBrightnessDown",
	hl.dsp.exec_cmd(osdclient .. " --brightness lower"),
	described("Display", "Lower brightness", repeating_locked)
)

-- Requires playerctl.
hl.bind("XF86AudioNext", hl.dsp.exec_cmd(osdclient .. " --playerctl next"), described("Media", "Next track", locked))
hl.bind(
	"XF86AudioPause",
	hl.dsp.exec_cmd(osdclient .. " --playerctl play-pause"),
	described("Media", "Play or pause", locked)
)
hl.bind(
	"XF86AudioPlay",
	hl.dsp.exec_cmd(osdclient .. " --playerctl play-pause"),
	described("Media", "Play or pause", locked)
)
hl.bind(
	"XF86AudioPrev",
	hl.dsp.exec_cmd(osdclient .. " --playerctl previous"),
	described("Media", "Previous track", locked)
)

--------------------------------------------------------------------------------
---- TILLING -------------------------------------------------------------------
--------------------------------------------------------------------------------

-- Control tiling.
hl.bind(mod .. " + X", hl.dsp.window.close(), described("Window", "Close"))
hl.bind(mod .. " + W", hl.dsp.window.float({ action = "toggle" }), described("Window", "Toggle floating"))
hl.bind(mod .. " + F", hl.dsp.window.fullscreen({ mode = "maximized" }), described("Window", "Maximize"))
hl.bind(mod .. " + SHIFT + F", hl.dsp.window.fullscreen({ mode = "fullscreen" }), described("Window", "Fullscreen"))

-- todo: check if arrows also work
-- Move focus/windows in the same workspace with arrow and vim keys.
local directions = { H = "left", J = "down", K = "up", L = "right" }
for key, direction in pairs(directions) do
	hl.bind(mod .. " + " .. key, hl.dsp.focus({ direction = direction }), described("Window", "Focus " .. direction))
	hl.bind(
		mod .. " + SHIFT + " .. key,
		hl.dsp.window.move({ direction = direction }),
		described("Window", "Move " .. direction)
	)
end

-- Switch workspaces or move the active window with mod + [0-9].
for workspace = 1, 10 do
	local key = workspace % 10
	hl.bind(mod .. " + " .. key, hl.dsp.focus({ workspace = workspace }), described("Workspace", "Go to " .. workspace))
	hl.bind(
		mod .. " + SHIFT + " .. key,
		hl.dsp.window.move({ workspace = workspace }),
		described("Workspace", "Move window to " .. workspace)
	)
end

-- Resize active window.
hl.bind(
	mod .. " + SHIFT + U",
	hl.dsp.window.resize({ x = -50, y = 0, relative = true }),
	described("Window", "Shrink width")
)
hl.bind(
	mod .. " + SHIFT + I",
	hl.dsp.window.resize({ x = 0, y = 50, relative = true }),
	described("Window", "Increase height")
)
hl.bind(
	mod .. " + SHIFT + O",
	hl.dsp.window.resize({ x = 0, y = -50, relative = true }),
	described("Window", "Decrease height")
)
hl.bind(
	mod .. " + SHIFT + P",
	hl.dsp.window.resize({ x = 50, y = 0, relative = true }),
	described("Window", "Increase width")
)

-- Special workspace (scratchpad).
hl.bind(mod .. " + S", hl.dsp.workspace.toggle_special("magic"), described("Workspace", "Toggle scratchpad"))
hl.bind(
	mod .. " + SHIFT + S",
	hl.dsp.window.move({ workspace = "special:magic" }),
	described("Workspace", "Move window to scratchpad")
)

-- Scroll through existing workspaces.
hl.bind(mod .. " + mouse_up", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mod .. " + mouse_down", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mod + LMB/RMB and dragging.
hl.bind(mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })
