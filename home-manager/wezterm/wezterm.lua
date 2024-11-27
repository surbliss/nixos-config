local wezterm = require("wezterm")
local config = wezterm.config_builder()
local act = wezterm.action

config.color_scheme = "Catppuccin Mocha"
config.font = wezterm.font_with_fallback({
  "0xProto",
  "Symbols Nerd Font Mono",
  { family = "Font Awesome 6 Free", weight = "Black" },
  { family = "Font Awesome 6 Free", weight = "Regular" },
  -- "Noto Color Emoji",
  -- "DejaVu Sans Mono",
  -- "Symbols Nerd Font",
  -- -- "Inconsolata",
  -- "Nerd Font Symbols",
  -- "Noto Fonts Emoji",
})
-- config.font = wezterm.font_with_fallback {
--     { family = "0xProto", weight = "Bold" },
--     "Inconsolata" }
-- 45678901234567890123456789012345678901234567890123456789012345678901234567890
-- TODO: Make font size larger, but make new layout in Xmonad to work with
-- higher font-size
config.font_size = 12.0
-- config.cell_width = 0.9

-- config.font_size = 10.0
-- config.cell_width = 1.0
config.hide_tab_bar_if_only_one_tab = true
config.adjust_window_size_when_changing_font_size = false
config.use_fancy_tab_bar = false

-- Try to reduce battery usage
config.front_end = "WebGpu"
config.animation_fps = 1
config.cursor_blink_rate = 0

config.keys = {
  { key = "n",     mods = "ALT",         action = act.ActivateTabRelative(1) },
  { key = "p",     mods = "ALT",         action = act.ActivateTabRelative(-1) },
  { key = "n",     mods = "SHIFT|ALT",   action = act.MoveTabRelative(1) },
  { key = "p",     mods = "SHIFT|ALT",   action = act.MoveTabRelative(-1) },
  { key = "1",     mods = "ALT",         action = act.ActivateTab(0) },
  { key = "2",     mods = "ALT",         action = act.ActivateTab(1) },
  { key = "3",     mods = "ALT",         action = act.ActivateTab(2) },
  { key = "4",     mods = "ALT",         action = act.ActivateTab(3) },
  { key = "5",     mods = "ALT",         action = act.ActivateTab(4) },
  { key = "6",     mods = "ALT",         action = act.ActivateTab(5) },
  { key = "7",     mods = "ALT",         action = act.ActivateTab(6) },
  { key = "8",     mods = "ALT",         action = act.ActivateTab(7) },
  { key = "9",     mods = "ALT",         action = act.ActivateTab(8) },
  { key = "t",     mods = "ALT",         action = act.SpawnTab("CurrentPaneDomain") },
  { key = "t",     mods = "SHIFT|ALT",   action = act.ShowTabNavigator },
  { key = "w",     mods = "ALT",         action = act.CloseCurrentTab({ confirm = true }) },

  { key = "Enter", mods = "SHIFT|SUPER", action = act.SpawnWindow },

  {
    key = '"',
    mods = "SHIFT|ALT",
    action = act.SplitVertical({ domain = "CurrentPaneDomain" }),
  },
  {
    key = "%",
    mods = "SHIFT|ALT",
    action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
  },
  { key = "x", mods = "ALT",       action = act.CloseCurrentPane({ confirm = true }) },
  { key = "h", mods = "ALT",       action = act.ActivatePaneDirection("Left") },
  { key = "h", mods = "SHIFT|ALT", action = act.AdjustPaneSize({ "Left", 1 }) },
  { key = "l", mods = "ALT",       action = act.ActivatePaneDirection("Right") },
  { key = "l", mods = "SHIFT|ALT", action = act.AdjustPaneSize({ "Right", 1 }) },
  { key = "k", mods = "ALT",       action = act.ActivatePaneDirection("Up") },
  { key = "k", mods = "SHIFT|ALT", action = act.AdjustPaneSize({ "Up", 1 }) },
  { key = "j", mods = "ALT",       action = act.ActivatePaneDirection("Down") },
  { key = "j", mods = "SHIFT|ALT", action = act.AdjustPaneSize({ "Down", 1 }) },
  {
    key = "r",
    mods = "ALT",
    action = act.PromptInputLine({
      description = "Enter a new name for tab",
      action = wezterm.action_callback(function(window, _, line)
        if line then
          window:active_tab():set_title(line)
        end
      end),
    }),
  },
  {
    key = "Enter",
    mods = "CTRL",
    action = act.SendString("\x1b[13;5u")
  },
}

return config
-- vim: ts=2 sts=4 sw=2 et
