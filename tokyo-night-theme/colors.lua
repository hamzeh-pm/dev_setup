-- Tokyo Night Theme Colors for WezTerm
-- Usage in wezterm.lua:
--   local colors = require("colors")
--   config.color_scheme = colors.scheme
--   -- Use colors.palette for status bar customization

local M = {}

M.scheme = "Tokyo Night"

M.palette = {
	bg = "#1a1b26",
	bg_dark = "#16161e",
	bg_highlight = "#292e42",
	fg = "#c0caf5",
	fg_dark = "#a9b1d6",
	red = "#f7768e",
	orange = "#ff9e64",
	yellow = "#e0af68",
	green = "#9ece6a",
	cyan = "#7dcfff",
	blue = "#7aa2f7",
	magenta = "#bb9af7",
	-- Accent color for status bar highlights
	accent = "#7aa2f7",
}

-- Accent colors for tabs (dict - order is random)
M.accents = {
	red = M.palette.red,
	orange = M.palette.orange,
	yellow = M.palette.yellow,
	green = M.palette.green,
	cyan = M.palette.cyan,
	blue = M.palette.blue,
	magenta = M.palette.magenta,
}

-- Status bar color formatting helper
function M.status_colors()
	return {
		left_bg = M.palette.accent,
		left_fg = M.palette.bg,
		right_bg = M.palette.bg_highlight,
		right_fg = M.palette.fg,
		right_accent_bg = M.palette.accent,
		right_accent_fg = M.palette.bg,
	}
end

return M
