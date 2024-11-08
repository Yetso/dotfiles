local wezterm = require 'wezterm'

local config = wezterm.config_builder()

config.check_for_updates = false

config.font = wezterm.font('CommitMono Nerd Font Mono')
config.font_size = 14

config.color_scheme = "moonfly"

config.default_cursor_style = "SteadyBar"
config.cursor_thickness = "2"

config.initial_rows = 40
config.initial_cols = 140

config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"

config.enable_scroll_bar = false

config.audible_bell = "Disabled"
config.term = "wezterm"
config.front_end = "WebGpu"

config.window_background_opacity = 0.95

config.animation_fps = 1
config.max_fps = 120
config.use_resize_increments = true

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


return config
