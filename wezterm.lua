-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
-- config.color_scheme = 'AdventureTime'
-- config.color_scheme = 'Batman'
-- config.color_scheme = 'Onedark'
config.color_scheme = 'Nord'

config.font_size = 13.0

-- config.window_background_opacity = 0.8
-- config.macos_window_background_blur = 54

config.harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' }

function tab_title(tab_info)
  local pane = tab_info.active_pane
  local workdir_url = pane.current_working_dir
  local file_path = workdir_url.path;
  local dir_name = file_path:match('[^/]+$')
  return dir_name
end

-- The filled in variant of the < symbol
local SOLID_LEFT_ARROW = wezterm.nerdfonts.pl_right_hard_divider

-- The filled in variant of the > symbol
-- local SOLID_RIGHT_ARROW = wezterm.nerdfonts.pl_left_hard_divider
local SOLID_RIGHT_ARROW = wezterm.nerdfonts.ple_upper_left_triangle

-- require("tabs").setup(config)

wezterm.on(
  'format-tab-title',
  function(tab, tabs, panes, config, hover, tab_max_width)
    local edge_background = '#0b0022'
    local background = '#1b1032'
    local foreground = '#808080'

    if tab.is_active then
      background = '#2b2042'
      foreground = '#c0c0c0'
    elseif hover then
      background = '#3b3052'
      foreground = '#909090'
    end

    local edge_foreground = background
    local title = tab_title(tab)
    if tab.is_active then
      return {
        -- { Background = { Color = edge_background } },
        -- { Foreground = { Color = edge_foreground } },
        { Text = "  " .. (tab.tab_index + 1) .. ": "},
        -- { Background = { Color = background } },
        -- { Foreground = { Color = foreground } },
        { Text = title },
        -- { Background = { Color = edge_background } },
        -- { Foreground = { Color = edge_foreground } },
        { Text = "  " },
      }
      -- return {
      --   { Text = ' ' .. (tab.tab_index + 1) .. ': ' .. title .. ' ' },
      -- }
    end
    return "  " .. (tab.tab_index + 1) .. ": " .. title .. "  "
  end
)

config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
-- config.hide_tab_bar_if_only_one_tab = true
config.tab_max_width = 32
config.unzoom_on_switch_pane = true

-- and finally, return the configuration to wezterm
return config
