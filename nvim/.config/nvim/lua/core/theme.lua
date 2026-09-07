local fallback = {
  colorscheme = "material",
  material_style = "deep ocean",
  lualine = "material",
}

local theme_file = vim.fn.stdpath("config") .. "/lua/current-theme.lua"
local ok, selected = pcall(dofile, theme_file)

if ok and type(selected) == "table" then
  return vim.tbl_extend("force", fallback, selected)
end

return fallback
