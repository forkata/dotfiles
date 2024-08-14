local wezterm = require 'wezterm'
local config = wezterm.config_builder()
config.color_scheme = 'Jellybeans'
config.window_decorations = "RESIZE"
config.window_padding = {left = 5, right = 5, top = 5, bottom = 0,}
config.font = wezterm.font 'JetBrains Mono'
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
return config
