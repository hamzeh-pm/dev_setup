-- WezTerm Configuration (theme-free base)
--
-- To apply a theme, copy colors.lua from a theme directory to ~/.config/wezterm/
-- Then add near the top:
--   local colors = require("colors")
--   config.color_scheme = colors.scheme

local wezterm = require("wezterm")
local act = wezterm.action
local mux = wezterm.mux

local config = wezterm.config_builder()

-- Try to load theme colors (optional)
local colors_ok, colors = pcall(require, "colors")
if not colors_ok then
	colors = nil
end

-- Default accent palette (used if no theme loaded)
local default_accents = {
	peach = "#f5a97f",
	green = "#a6da95",
	blue = "#8aadf4",
	mauve = "#c6a0f6",
	pink = "#f5bde6",
	teal = "#8bd5ca",
	yellow = "#eed49f",
	red = "#ed8796",
}

-- Get accent color by tab index (picks from dict keys pseudo-randomly)
local function get_accent_for_tab(tab_index)
	local accents = (colors and colors.accents) or default_accents
	-- Collect keys into array
	local keys = {}
	for k, _ in pairs(accents) do
		table.insert(keys, k)
	end
	-- Use tab_index to pick a key (consistent per tab, but unordered)
	local idx = (tab_index % #keys) + 1
	return accents[keys[idx]]
end

-- ============================================================================
-- APPEARANCE
-- ============================================================================

-- Window settings
config.initial_cols = 150
config.initial_rows = 50
config.window_padding = {
	left = 10,
	right = 10,
	top = 10,
	bottom = 10,
}
config.window_decorations = "TITLE | RESIZE"
config.window_background_opacity = 0.85
config.macos_window_background_blur = 20

-- Font settings
config.font = wezterm.font_with_fallback({
	{ family = "JetBrainsMono Nerd Font Mono", weight = "Regular" },
	{ family = "FiraCode Nerd Font", weight = "Regular" },
	"Symbols Nerd Font",
})
config.font_size = 14.0
config.font_rules = {
	{
		intensity = "Bold",
		font = wezterm.font({ family = "JetBrainsMono Nerd Font Mono", weight = "Bold" }),
	},
	{
		italic = true,
		font = wezterm.font({ family = "JetBrainsMono Nerd Font Mono", style = "Italic" }),
	},
}

-- Terminal type
config.term = "xterm-256color"

-- Helper function to get the folder name
local function get_current_working_dir(tab)
	local current_dir = tab.active_pane.current_working_dir or ""
	if current_dir.file_path then
		current_dir = current_dir.file_path
	end
	local function url_decode(str)
		return str:gsub("%%(%x%x)", function(h)
			return string.char(tonumber(h, 16))
		end)
	end
	current_dir = url_decode(current_dir)
	return string.match(current_dir, "[^/\\]+$") or current_dir
end

-- ============================================================================
-- TAB BAR / STATUS BAR
-- ============================================================================

config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.hide_tab_bar_if_only_one_tab = false
config.tab_max_width = 32
config.show_new_tab_button_in_tab_bar = true

config.window_frame = {
	font_size = 14.0,
}

-- Status bar with system info (battery, time)
wezterm.on("update-status", function(window, pane)
	local date = wezterm.strftime("%H:%M:%S")

	-- Get battery info (if available)
	local battery = ""
	for _, b in ipairs(wezterm.battery_info()) do
		local charge = b.state_of_charge * 100
		local icon = "♥"
		if charge > 80 then
			icon = "󰁹"
		elseif charge > 60 then
			icon = "󰂀"
		elseif charge > 40 then
			icon = "󰁾"
		elseif charge > 20 then
			icon = "󰁻"
		else
			icon = "󰁺"
		end
		battery = string.format("%s %.0f%% ", icon, charge)
	end

	-- Left status: workspace name
	local workspace = window:active_workspace()
	window:set_left_status(wezterm.format({
		{ Text = "  " .. workspace .. " " },
	}))

	-- Right status: battery + time
	window:set_right_status(wezterm.format({
		{ Text = " " .. battery .. " " .. date .. " " },
	}))
end)

-- Tab title format with accent colors
wezterm.on("format-tab-title", function(tab, tabs, panes, cfg, hover, max_width)
	local title = tab.tab_title
	if not title or #title == 0 then
		title = get_current_working_dir(tab)
	end
	if not title or #title == 0 then
		title = tab.active_pane.title
	end
	-- Truncate if needed
	if #title > max_width - 6 then
		title = string.sub(title, 1, max_width - 6) .. "…"
	end

	local accent = get_accent_for_tab(tab.tab_index)
	local tab_text = string.format(" %d: %s ", tab.tab_index + 1, title)

	-- Get background color from palette or use defaults
	local bg = "#1e2030"
	local fg = "#cad3f5"
	if colors and colors.palette then
		bg = colors.palette.mantle or colors.palette.bg_dark or bg
		fg = colors.palette.text or colors.palette.fg or fg
	end

	if tab.is_active then
		return {
			{ Background = { Color = accent } },
			{ Foreground = { Color = bg } },
			{ Text = tab_text },
		}
	elseif hover then
		return {
			{ Background = { Color = bg } },
			{ Foreground = { Color = accent } },
			{ Text = tab_text },
		}
	else
		return {
			{ Background = { Color = bg } },
			{ Foreground = { Color = fg } },
			{ Attribute = { Intensity = "Half" } },
			{ Text = tab_text },
		}
	end
end)

-- ============================================================================
-- MULTIPLEXING SETTINGS
-- ============================================================================

config.unix_domains = {
	{
		name = "unix",
	},
}

-- Mouse support
config.mouse_bindings = {
	{
		event = { Down = { streak = 1, button = "Right" } },
		mods = "NONE",
		action = act.PasteFrom("Clipboard"),
	},
	{
		event = { Down = { streak = 1, button = "Left" } },
		mods = "NONE",
		action = act.CompleteSelection("ClipboardAndPrimarySelection"),
	},
}

-- ============================================================================
-- PANE VISIBILITY
-- ============================================================================

config.underline_thickness = "2px"

config.colors = {
	split = "#f5f5f5",
}

config.inactive_pane_hsb = {
	saturation = 0.9,
	brightness = 0.7,
}

-- ============================================================================
-- KEYBINDINGS (tmux-style with CTRL+B as leader)
-- ============================================================================

config.leader = { key = "b", mods = "CTRL", timeout_milliseconds = 1500 }

config.keys = {
	-- ========== PANE SPLITTING ==========
	{
		key = "|",
		mods = "LEADER|SHIFT",
		action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "-",
		mods = "LEADER",
		action = act.SplitVertical({ domain = "CurrentPaneDomain" }),
	},

	-- ========== PANE NAVIGATION ==========
	{ key = "h", mods = "LEADER", action = act.ActivatePaneDirection("Left") },
	{ key = "j", mods = "LEADER", action = act.ActivatePaneDirection("Down") },
	{ key = "k", mods = "LEADER", action = act.ActivatePaneDirection("Up") },
	{ key = "l", mods = "LEADER", action = act.ActivatePaneDirection("Right") },
	{ key = "LeftArrow", mods = "LEADER", action = act.ActivatePaneDirection("Left") },
	{ key = "RightArrow", mods = "LEADER", action = act.ActivatePaneDirection("Right") },
	{ key = "UpArrow", mods = "LEADER", action = act.ActivatePaneDirection("Up") },
	{ key = "DownArrow", mods = "LEADER", action = act.ActivatePaneDirection("Down") },

	-- ========== PANE RESIZING ==========
	{ key = "H", mods = "LEADER|SHIFT", action = act.AdjustPaneSize({ "Left", 5 }) },
	{ key = "J", mods = "LEADER|SHIFT", action = act.AdjustPaneSize({ "Down", 5 }) },
	{ key = "K", mods = "LEADER|SHIFT", action = act.AdjustPaneSize({ "Up", 5 }) },
	{ key = "L", mods = "LEADER|SHIFT", action = act.AdjustPaneSize({ "Right", 5 }) },

	-- ========== TAB/WINDOW MANAGEMENT ==========
	{ key = "c", mods = "LEADER", action = act.SpawnTab("CurrentPaneDomain") },
	{ key = "n", mods = "LEADER", action = act.ActivateTabRelative(1) },
	{ key = "p", mods = "LEADER", action = act.ActivateTabRelative(-1) },
	{ key = "p", mods = "ALT", action = act.ActivateTabRelative(-1) },
	{ key = "n", mods = "ALT", action = act.ActivateTabRelative(1) },
	{ key = "x", mods = "LEADER", action = act.CloseCurrentPane({ confirm = true }) },
	{ key = "&", mods = "LEADER|SHIFT", action = act.CloseCurrentTab({ confirm = true }) },
	{ key = "w", mods = "ALT", action = act.ShowTabNavigator },

	-- Direct tab switching (1-9)
	{ key = "1", mods = "LEADER", action = act.ActivateTab(0) },
	{ key = "2", mods = "LEADER", action = act.ActivateTab(1) },
	{ key = "3", mods = "LEADER", action = act.ActivateTab(2) },
	{ key = "4", mods = "LEADER", action = act.ActivateTab(3) },
	{ key = "5", mods = "LEADER", action = act.ActivateTab(4) },
	{ key = "6", mods = "LEADER", action = act.ActivateTab(5) },
	{ key = "7", mods = "LEADER", action = act.ActivateTab(6) },
	{ key = "8", mods = "LEADER", action = act.ActivateTab(7) },
	{ key = "9", mods = "LEADER", action = act.ActivateTab(8) },
	{ key = "1", mods = "ALT", action = act.ActivateTab(0) },
	{ key = "2", mods = "ALT", action = act.ActivateTab(1) },
	{ key = "3", mods = "ALT", action = act.ActivateTab(2) },
	{ key = "4", mods = "ALT", action = act.ActivateTab(3) },
	{ key = "5", mods = "ALT", action = act.ActivateTab(4) },
	{ key = "6", mods = "ALT", action = act.ActivateTab(5) },
	{ key = "7", mods = "ALT", action = act.ActivateTab(6) },
	{ key = "8", mods = "ALT", action = act.ActivateTab(7) },
	{ key = "9", mods = "ALT", action = act.ActivateTab(8) },

	-- ========== ZOOM/FULLSCREEN PANE ==========
	{ key = "z", mods = "LEADER", action = act.TogglePaneZoomState },

	-- ========== RENAME TAB ==========
	{
		key = ",",
		mods = "LEADER",
		action = act.PromptInputLine({
			description = "Enter new tab name:",
			action = wezterm.action_callback(function(window, pane, line)
				if line then
					window:active_tab():set_title(line)
				end
			end),
		}),
	},

	-- ========== COPY MODE ==========
	{ key = "[", mods = "LEADER", action = act.ActivateCopyMode },

	-- ========== COMMAND PALETTE ==========
	{ key = ":", mods = "LEADER|SHIFT", action = act.ActivateCommandPalette },

	-- ========== CONFIG RELOAD ==========
	{ key = "r", mods = "LEADER", action = act.ReloadConfiguration },

	-- ========== WORKSPACE SWITCHING ==========
	{ key = "s", mods = "LEADER", action = act.ShowLauncherArgs({ flags = "FUZZY|WORKSPACES" }) },

	-- ========== LAYOUT PRESETS ==========

	-- tlay-focus: Two stacked left, full horizontal right
	{
		key = "F1",
		mods = "LEADER",
		action = wezterm.action_callback(function(window, pane)
			local tab = window:active_tab()
			tab:set_title("focus")
			pane:split({ direction = "Right", size = 0.35 })
			window:perform_action(act.ActivatePaneDirection("Left"), pane)
			local left_pane = window:active_pane()
			left_pane:split({ direction = "Bottom", size = 0.30 })
			window:perform_action(act.ActivatePaneDirection("Up"), window:active_pane())
		end),
	},

	-- tlay-grid: 2x2 equal grid
	{
		key = "F2",
		mods = "LEADER",
		action = wezterm.action_callback(function(window, pane)
			local tab = window:active_tab()
			tab:set_title("grid")
			pane:split({ direction = "Right", size = 0.5 })
			local right_pane = window:active_pane()
			right_pane:split({ direction = "Bottom", size = 0.5 })
			window:perform_action(act.ActivatePaneDirection("Left"), window:active_pane())
			local left_pane = window:active_pane()
			left_pane:split({ direction = "Bottom", size = 0.5 })
			window:perform_action(act.ActivatePaneDirection("Up"), window:active_pane())
		end),
	},

	-- tlay-wide: Top wide, two bottom panes
	{
		key = "F3",
		mods = "LEADER",
		action = wezterm.action_callback(function(window, pane)
			local tab = window:active_tab()
			tab:set_title("wide")
			pane:split({ direction = "Bottom", size = 0.5 })
			local bottom_pane = window:active_pane()
			bottom_pane:split({ direction = "Right", size = 0.5 })
			window:perform_action(act.ActivatePaneDirection("Up"), window:active_pane())
		end),
	},

	-- tlay-v55: Simple vertical split 55/45
	{
		key = "F4",
		mods = "LEADER",
		action = wezterm.action_callback(function(window, pane)
			local tab = window:active_tab()
			tab:set_title("55/45")
			pane:split({ direction = "Right", size = 0.45 })
			window:perform_action(act.ActivatePaneDirection("Left"), window:active_pane())
		end),
	},

	-- tlay-mobile: Multiple windows for mobile dev
	{
		key = "F5",
		mods = "LEADER",
		action = wezterm.action_callback(function(window, pane)
			local mux_window = window:mux_window()
			local tab1 = window:active_tab()
			tab1:set_title("ai")
			local tab2, _, _ = mux_window:spawn_tab({})
			tab2:set_title("nvim")
			local tab3, _, _ = mux_window:spawn_tab({})
			tab3:set_title("term")
			local tab4, pane4, _ = mux_window:spawn_tab({})
			tab4:set_title("services")
			pane4:split({ direction = "Right", size = 0.5 })
			window:perform_action(act.ActivateTab(0), pane)
		end),
	},

	-- tlay-desk: Code layout with services window
	{
		key = "F6",
		mods = "LEADER",
		action = wezterm.action_callback(function(window, pane)
			local mux_window = window:mux_window()
			local tab1 = window:active_tab()
			tab1:set_title("code")
			pane:split({ direction = "Right", size = 0.35 })
			window:perform_action(act.ActivatePaneDirection("Left"), window:active_pane())
			local left_pane = window:active_pane()
			left_pane:split({ direction = "Bottom", size = 0.30 })
			window:perform_action(act.ActivatePaneDirection("Up"), window:active_pane())
			local tab2, pane2, _ = mux_window:spawn_tab({})
			tab2:set_title("services")
			pane2:split({ direction = "Right", size = 0.5 })
			window:perform_action(act.ActivateTab(0), window:active_pane())
		end),
	},

	-- tlay-nvim: Code layout with nvim terminal and services windows
	{
		key = "F7",
		mods = "LEADER",
		action = wezterm.action_callback(function(window, pane)
			local mux_window = window:mux_window()
			local tab1 = window:active_tab()
			tab1:set_title("code")
			pane:split({ direction = "Right", size = 0.35 })
			window:perform_action(act.ActivatePaneDirection("Left"), window:active_pane())
			window:perform_action(act.ActivatePaneDirection("Up"), window:active_pane())
			local tab2, pane2, _ = mux_window:spawn_tab({})
			tab2:set_title("services")
			pane2:split({ direction = "Right", size = 0.5 })
			window:perform_action(act.ActivateTab(0), window:active_pane())
		end),
	},

	-- tlay-reset: Close all panes except current, close other tabs
	{
		key = "F8",
		mods = "LEADER",
		action = wezterm.action_callback(function(window, pane)
			local tab = window:active_tab()
			local mux_window = window:mux_window()
			for _, p in ipairs(tab:panes()) do
				if p:pane_id() ~= pane:pane_id() then
					p:activate()
					window:perform_action(act.CloseCurrentPane({ confirm = false }), p)
				end
			end
			local tabs = mux_window:tabs()
			local current_tab_id = tab:tab_id()
			for _, t in ipairs(tabs) do
				if t:tab_id() ~= current_tab_id then
					t:activate()
					window:perform_action(act.CloseCurrentTab({ confirm = false }), window:active_pane())
				end
			end
			tab:set_title("")
		end),
	},
}

-- ============================================================================
-- KEY TABLES
-- ============================================================================

config.key_tables = {
	resize_pane = {
		{ key = "h", action = act.AdjustPaneSize({ "Left", 1 }) },
		{ key = "j", action = act.AdjustPaneSize({ "Down", 1 }) },
		{ key = "k", action = act.AdjustPaneSize({ "Up", 1 }) },
		{ key = "l", action = act.AdjustPaneSize({ "Right", 1 }) },
		{ key = "Escape", action = "PopKeyTable" },
		{ key = "Enter", action = "PopKeyTable" },
	},
}

-- ============================================================================
-- SHELL CONFIGURATION
-- ============================================================================

config.default_prog = { "/bin/zsh", "-l" }

-- ============================================================================
-- PERFORMANCE / MISC
-- ============================================================================

config.scrollback_lines = 10000
config.enable_scroll_bar = false
config.adjust_window_size_when_changing_font_size = false
config.use_ime = true
config.window_close_confirmation = "NeverPrompt"

-- ============================================================================
-- STARTUP BEHAVIOR
-- ============================================================================

wezterm.on("gui-startup", function(cmd)
	local args = cmd and cmd.args or {}
	local tab, pane, window = mux.spawn_window({
		workspace = "main",
		args = args,
	})
end)

return config
