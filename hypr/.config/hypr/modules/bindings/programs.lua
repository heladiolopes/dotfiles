local mainMod = "SUPER"
local terminal = "kitty"
local fileManager = "dolphin"
local menu = "rofi -show drun"
local internetBrowser = "firefox"

-- Power.
hl.bind(mainMod .. " + SHIFT + SPACE", hl.dsp.exec_cmd("hyprlock"))
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("wlogout"))
hl.bind(mainMod .. " + SHIFT + M", hl.dsp.exit())

-- Program launcher.
hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(internetBrowser))
hl.bind(mainMod .. " + O", hl.dsp.exec_cmd("obsidian -disable-gpu"))

-- Clipboard.
hl.bind(
    mainMod .. " + V",
    hl.dsp.exec_cmd("cliphist list | rofi -dmenu | cliphist decode | wl-copy")
)

-- Screenshots.
hl.bind("PRINT", hl.dsp.exec_cmd("hyprshot -m output -m active"))
hl.bind("SHIFT + PRINT", hl.dsp.exec_cmd("hyprshot -m output -m active --clipboard-only"))
hl.bind(mainMod .. " + PRINT", hl.dsp.exec_cmd("hyprshot -m region"))
hl.bind(mainMod .. " + SHIFT + PRINT", hl.dsp.exec_cmd("hyprshot -m region --clipboard-only"))
