local wezterm = require 'wezterm'
local config = {}

config.default_prog = { 'fish' }
config.window_background_opacity = 0.7
config.window_decorations = "TITLE | RESIZE"
config.hide_tab_bar_if_only_one_tab = true
config.color_scheme = 'Gruvbox dark, hard (base16)' -- Optional: Change the color scheme

return config
