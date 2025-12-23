-- WezTerm Configuration (theme-free base)
--
-- To apply a theme, add near the top:
--   local colors = require("colors")
--   config.color_scheme = colors.scheme
--
-- Copy colors.lua from dracula-theme/ or tokyo-night-theme/ to ~/.config/wezterm/

local wezterm = require("wezterm")
local act = wezterm.action
local mux = wezterm.mux

local config = wezterm.config_builder()

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

-- Font settings (Fira Code Nerd Font)
config.font = wezterm.font_with_fallback({
	{ family = "FiraCode Nerd Font", weight = "Regular" },
	{ family = "FiraCode Nerd Font Mono", weight = "Regular" },
	"Symbols Nerd Font",
})
config.font_size = 14.0
config.font_rules = {
	{
		intensity = "Bold",
		font = wezterm.font({ family = "FiraCode Nerd Font", weight = "Bold" }),
	},
	{
		italic = true,
		font = wezterm.font({ family = "FiraCode Nerd Font", style = "Italic" }),
	},
}

-- Terminal type
config.term = "xterm-256color"

-- ============================================================================
-- TAB BAR / STATUS BAR
-- ============================================================================

config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.hide_tab_bar_if_only_one_tab = false
config.tab_max_width = 32
config.show_new_tab_button_in_tab_bar = true

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
		{ Text = "  " .. workspace .. "  " },
	}))

	-- Right status: battery + time
	window:set_right_status(wezterm.format({
		{ Text = " " .. battery .. " " .. date .. " " },
	}))
end)

-- Tab title format
wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local title = tab.tab_title
	if not title or #title == 0 then
		title = tab.active_pane.title
	end
	-- Truncate if needed
	if #title > max_width - 4 then
		title = string.sub(title, 1, max_width - 4) .. "…"
	end
	return string.format(" %d: %s ", tab.tab_index + 1, title)
end)

-- ============================================================================
-- MULTIPLEXING SETTINGS
-- ============================================================================

-- Use WezTerm's native multiplexing
config.unix_domains = {
	{
		name = "unix",
	},
}

-- Mouse support
config.mouse_bindings = {
	-- Right click paste
	{
		event = { Down = { streak = 1, button = "Right" } },
		mods = "NONE",
		action = act.PasteFrom("Clipboard"),
	},
	-- Change pane with mouse click
	{
		event = { Down = { streak = 1, button = "Left" } },
		mods = "NONE",
		action = act.CompleteSelection("ClipboardAndPrimarySelection"),
	},
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

	-- ========== PANE NAVIGATION (vim-tmux-navigator style) ==========
	{
		key = "h",
		mods = "LEADER",
		action = act.ActivatePaneDirection("Left"),
	},
	{
		key = "j",
		mods = "LEADER",
		action = act.ActivatePaneDirection("Down"),
	},
	{
		key = "k",
		mods = "LEADER",
		action = act.ActivatePaneDirection("Up"),
	},
	{
		key = "l",
		mods = "LEADER",
		action = act.ActivatePaneDirection("Right"),
	},
	-- Also with arrow keys
	{
		key = "LeftArrow",
		mods = "LEADER",
		action = act.ActivatePaneDirection("Left"),
	},
	{
		key = "RightArrow",
		mods = "LEADER",
		action = act.ActivatePaneDirection("Right"),
	},
	{
		key = "UpArrow",
		mods = "LEADER",
		action = act.ActivatePaneDirection("Up"),
	},
	{
		key = "DownArrow",
		mods = "LEADER",
		action = act.ActivatePaneDirection("Down"),
	},
	-- CTRL+hjkl for direct navigation (vim-tmux-navigator)
	{
		key = "h",
		mods = "CTRL",
		action = act.ActivatePaneDirection("Left"),
	},
	{
		key = "j",
		mods = "CTRL",
		action = act.ActivatePaneDirection("Down"),
	},
	{
		key = "k",
		mods = "CTRL",
		action = act.ActivatePaneDirection("Up"),
	},
	{
		key = "l",
		mods = "CTRL",
		action = act.ActivatePaneDirection("Right"),
	},

	-- ========== PANE RESIZING ==========
	{
		key = "H",
		mods = "LEADER|SHIFT",
		action = act.AdjustPaneSize({ "Left", 5 }),
	},
	{
		key = "J",
		mods = "LEADER|SHIFT",
		action = act.AdjustPaneSize({ "Down", 5 }),
	},
	{
		key = "K",
		mods = "LEADER|SHIFT",
		action = act.AdjustPaneSize({ "Up", 5 }),
	},
	{
		key = "L",
		mods = "LEADER|SHIFT",
		action = act.AdjustPaneSize({ "Right", 5 }),
	},

	-- ========== TAB/WINDOW MANAGEMENT ==========
	{
		key = "c",
		mods = "LEADER",
		action = act.SpawnTab("CurrentPaneDomain"),
	},
	{
		key = "n",
		mods = "LEADER",
		action = act.ActivateTabRelative(1),
	},
	{
		key = "p",
		mods = "LEADER",
		action = act.ActivateTabRelative(-1),
	},
	{
		key = "x",
		mods = "LEADER",
		action = act.CloseCurrentPane({ confirm = true }),
	},
	{
		key = "&",
		mods = "LEADER|SHIFT",
		action = act.CloseCurrentTab({ confirm = true }),
	},

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

	-- ========== ZOOM/FULLSCREEN PANE ==========
	{
		key = "z",
		mods = "LEADER",
		action = act.TogglePaneZoomState,
	},

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
	{
		key = "[",
		mods = "LEADER",
		action = act.ActivateCopyMode,
	},

	-- ========== COMMAND PALETTE ==========
	{
		key = ":",
		mods = "LEADER|SHIFT",
		action = act.ActivateCommandPalette,
	},

	-- ========== CONFIG RELOAD ==========
	{
		key = "r",
		mods = "LEADER",
		action = act.ReloadConfiguration,
	},

	-- ========== WORKSPACE SWITCHING ==========
	{
		key = "s",
		mods = "LEADER",
		action = act.ShowLauncherArgs({ flags = "FUZZY|WORKSPACES" }),
	},

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
			tab1:set_title("claude.ai")
			local tab2, _, _ = mux_window:spawn_tab({})
			tab2:set_title("nvim")
			local tab3, _, _ = mux_window:spawn_tab({})
			tab3:set_title("testing")
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

	-- tlay-reset: Close all panes except current, close other tabs
	{
		key = "F7",
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
