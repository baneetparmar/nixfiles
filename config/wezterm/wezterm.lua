local wezterm = require 'wezterm'

local config = {}

config.colors = require('lua/rose-pine').colors()
config.window_frame = require('lua/rose-pine').window_frame()
config.enable_tab_bar = false

return config
