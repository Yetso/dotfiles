local wezterm = require 'wezterm'

local config = wezterm.config_builder()

config.check_for_updates = false

config.font = wezterm.font('CommitMono Nerd Font Mono')
config.font_size = 12

config.color_scheme = "moonfly"

config.default_cursor_style = "SteadyBar"
config.cursor_thickness = "2"

config.initial_rows = 40
config.initial_cols = 140

config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"

config.enable_scroll_bar = false
-- config.scrollback_lines = 3500

config.audible_bell = "Disabled"
-- config.term = "wezterm"
config.term = "xterm-256color"
config.front_end = "WebGpu"

config.window_background_opacity = 0.95

config.animation_fps = 1
config.max_fps = 120
config.use_resize_increments = false

config.use_fancy_tab_bar = false
config.switch_to_last_active_tab_when_closing_tab = true


config.window_frame = {
	border_left_width = '0.2cell',
	border_right_width = '0.2cell',
	border_top_height = '0.5cell',
	border_bottom_height = '0.15cell',

	active_titlebar_bg = "#303030",
	inactive_titlebar_bg = "#303030",
	border_left_color = '#303030',
	border_right_color = '#303030',
	border_bottom_color = '#303030',
	border_top_color = '#303030',
}
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}
config.default_prog = { 'C:/Program Files/PowerShell/7/pwsh.exe', '-NoLogo' }


config.keys = {
	{ key = "1", mods = "CTRL|SHIFT", action = wezterm.action.DisableDefaultAssignment },
	{ key = "!", mods = "CTRL",       action = wezterm.action.DisableDefaultAssignment },
	{ key = "!", mods = "CTRL|SHIFT", action = wezterm.action.DisableDefaultAssignment },
	{ key = "2", mods = "CTRL|SHIFT", action = wezterm.action.DisableDefaultAssignment },
	{ key = "@", mods = "CTRL",       action = wezterm.action.DisableDefaultAssignment },
	{ key = "@", mods = "CTRL|SHIFT", action = wezterm.action.DisableDefaultAssignment },
	{ key = "3", mods = "CTRL|SHIFT", action = wezterm.action.DisableDefaultAssignment },
	{ key = "#", mods = "CTRL",       action = wezterm.action.DisableDefaultAssignment },
	{ key = "#", mods = "CTRL|SHIFT", action = wezterm.action.DisableDefaultAssignment },
	{ key = "4", mods = "CTRL|SHIFT", action = wezterm.action.DisableDefaultAssignment },
	{ key = "$", mods = "CTRL",       action = wezterm.action.DisableDefaultAssignment },
	{ key = "$", mods = "CTRL|SHIFT", action = wezterm.action.DisableDefaultAssignment },
	{ key = "5", mods = "CTRL|SHIFT", action = wezterm.action.DisableDefaultAssignment },
	{ key = "%", mods = "CTRL",       action = wezterm.action.DisableDefaultAssignment },
	{ key = "%", mods = "CTRL|SHIFT", action = wezterm.action.DisableDefaultAssignment },
	{ key = "6", mods = "CTRL|SHIFT", action = wezterm.action.DisableDefaultAssignment },
	{ key = "^", mods = "CTRL",       action = wezterm.action.DisableDefaultAssignment },
	{ key = "^", mods = "CTRL|SHIFT", action = wezterm.action.DisableDefaultAssignment },
	{ key = "7", mods = "CTRL|SHIFT", action = wezterm.action.DisableDefaultAssignment },
	{ key = "&", mods = "CTRL",       action = wezterm.action.DisableDefaultAssignment },
	{ key = "&", mods = "CTRL|SHIFT", action = wezterm.action.DisableDefaultAssignment },
	{ key = "8", mods = "CTRL|SHIFT", action = wezterm.action.DisableDefaultAssignment },
	{ key = "*", mods = "CTRL",       action = wezterm.action.DisableDefaultAssignment },
	{ key = "*", mods = "CTRL|SHIFT", action = wezterm.action.DisableDefaultAssignment },
	{ key = "9", mods = "CTRL|SHIFT", action = wezterm.action.DisableDefaultAssignment },
	{ key = "(", mods = "CTRL",       action = wezterm.action.DisableDefaultAssignment },
	{ key = "(", mods = "CTRL|SHIFT", action = wezterm.action.DisableDefaultAssignment },
	{ key = "0", mods = "CTRL|SHIFT", action = wezterm.action.DisableDefaultAssignment },
	{ key = ")", mods = "CTRL",       action = wezterm.action.DisableDefaultAssignment },
	{ key = ")", mods = "CTRL|SHIFT", action = wezterm.action.DisableDefaultAssignment },
	{ key = "1", mods = "ALT",        action = wezterm.action.ActivateTab(0) },
	{ key = "2", mods = "ALT",        action = wezterm.action.ActivateTab(1) },
	{ key = "3", mods = "ALT",        action = wezterm.action.ActivateTab(2) },
	{ key = "4", mods = "ALT",        action = wezterm.action.ActivateTab(3) },
	{ key = "5", mods = "ALT",        action = wezterm.action.ActivateTab(4) },
	{ key = "6", mods = "ALT",        action = wezterm.action.ActivateTab(5) },
	{ key = "7", mods = "ALT",        action = wezterm.action.ActivateTab(6) },
	{ key = "8", mods = "ALT",        action = wezterm.action.ActivateTab(7) },
	{ key = "9", mods = "ALT",        action = wezterm.action.ActivateTab(8) },
	{ key = "0", mods = "ALT",        action = wezterm.action.ActivateTab(9) },
	{ key = "t", mods = "ALT",        action = wezterm.action.SpawnTab("CurrentPaneDomain") },
	{ key = "c", mods = "ALT",        action = wezterm.action.CopyTo 'Clipboard' },
	{ key = "v", mods = "ALT",        action = wezterm.action.PasteFrom 'Clipboard' },
	{ key = "n", mods = "ALT",        action = wezterm.action.SpawnWindow },
	{
		key = "l",
		mods = "ALT",
		action = wezterm.action_callback(function(window, pane)
			-- scroll to bottom in case you aren't already
			window:perform_action(wezterm.action.ScrollToBottom, pane)

			-- get the current height of the viewport
			local height = pane:get_dimensions().viewport_rows

			-- build a string of new lines equal to the viewport height
			local blank_viewport = string.rep('\r\n', height)

			-- inject those new lines to push the viewport contents into the scrollback
			pane:inject_output(blank_viewport)

			-- send an escape sequence to clear the viewport (CTRL-L)
			pane:send_text('\x0c')
		end)
	},
}

return config
