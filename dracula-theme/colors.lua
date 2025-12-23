-- Dracula Theme Colors for WezTerm
-- Usage in wezterm.lua:
--   local colors = require("colors")
--   config.color_scheme = colors.scheme
--   -- Use colors.palette for status bar customization

local M = {}

M.scheme = "Dracula (Official)"

M.palette = {
	bg = "#282a36",
	bg_dark = "#21222c",
	bg_highlight = "#44475a",
	fg = "#f8f8f2",
	fg_dark = "#6272a4",
	red = "#ff5555",
	orange = "#ffb86c",
	yellow = "#f1fa8c",
	green = "#50fa7b",
	cyan = "#8be9fd",
	blue = "#6272a4",
	purple = "#bd93f9",
	pink = "#ff79c6",
	-- Accent color for status bar highlights
	accent = "#bd93f9",
}

-- Accent colors for tabs (dict - order is random)
M.accents = {
	red = M.palette.red,
	orange = M.palette.orange,
	yellow = M.palette.yellow,
	green = M.palette.green,
	cyan = M.palette.cyan,
	purple = M.palette.purple,
	pink = M.palette.pink,
}

-- Status bar color formatting helper
function M.status_colors()
	return {
		left_bg = M.palette.accent,
		left_fg = M.palette.bg,
		battery_bg = M.palette.green,
		battery_fg = M.palette.bg,
		date_bg = M.palette.purple,
		date_fg = M.palette.bg,
	}
end

return M
