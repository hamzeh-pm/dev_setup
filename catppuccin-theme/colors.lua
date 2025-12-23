-- Catppuccin Theme Colors for WezTerm
-- Usage in wezterm.lua:
--   local colors = require("colors")
--   config.color_scheme = colors.scheme
--   -- Use colors.palette for status bar customization

local M = {}

-- Available: "Catppuccin Mocha", "Catppuccin Macchiato", "Catppuccin Frappe", "Catppuccin Latte"
M.scheme = "Catppuccin Macchiato"

-- Macchiato palette
M.palette = {
	rosewater = "#f4dbd6",
	flamingo = "#f0c6c6",
	pink = "#f5bde6",
	mauve = "#c6a0f6",
	red = "#ed8796",
	maroon = "#ee99a0",
	peach = "#f5a97f",
	yellow = "#eed49f",
	green = "#a6da95",
	teal = "#8bd5ca",
	sky = "#91d7e3",
	sapphire = "#7dc4e4",
	blue = "#8aadf4",
	lavender = "#b7bdf8",
	text = "#cad3f5",
	subtext1 = "#b8c0e0",
	subtext0 = "#a5adcb",
	overlay2 = "#939ab7",
	overlay1 = "#8087a2",
	overlay0 = "#6e738d",
	surface2 = "#5b6078",
	surface1 = "#494d64",
	surface0 = "#363a4f",
	base = "#24273a",
	mantle = "#1e2030",
	crust = "#181926",
	-- Accent color for status bar highlights
	accent = "#a6da95", -- green
}

-- All catppuccin accent colors for tab cycling
M.accents = {
	M.palette.rosewater,
	M.palette.flamingo,
	M.palette.pink,
	M.palette.mauve,
	M.palette.red,
	M.palette.maroon,
	M.palette.peach,
	M.palette.yellow,
	M.palette.green,
	M.palette.teal,
	M.palette.sky,
	M.palette.sapphire,
	M.palette.blue,
	M.palette.lavender,
}

-- Status bar color formatting helper
function M.status_colors()
	return {
		left_bg = M.palette.green,
		left_fg = M.palette.base,
		right_bg = M.palette.surface0,
		right_fg = M.palette.text,
		right_accent_bg = M.palette.blue,
		right_accent_fg = M.palette.base,
	}
end

-- Helper to adjust brightness
function M.adjust_brightness(color, amount)
	local r, g, b = color:match("#(%x%x)(%x%x)(%x%x)")
	r, g, b = tonumber(r, 16), tonumber(g, 16), tonumber(b, 16)
	local function clamp(val)
		return math.min(255, math.max(0, val))
	end
	return string.format("#%02x%02x%02x", clamp(r + amount), clamp(g + amount), clamp(b + amount))
end

return M
