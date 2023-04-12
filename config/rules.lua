local awful = require("awful")
local beautiful = require("beautiful")

root.keys(globalkeys)

awful.rules.rules = {
  { rule = {},
    properties = {
      border_width = beautiful.border_width,
      border_color = beautiful.border_normal,
      focus = awful.client.focus.filter,
      raise = true,
      keys = clientkeys,
      buttons = clientbuttons,
      screen = awful.screen.preferred,
      placement = awful.placement.no_overlap + awful.placement.no_offscreen
    }
  },

  { rule_any = {
    instance = {
      "DTA",
      "copyq",
      "pinentry",
    },
    class = {
      "Arandr",
      "Blueman-manager",
      "Gpick",
      "Kruler",
      "MessageWin",
      "Sxiv",
      "Tor Browser",
      "Wpa_gui",
      "veromix",
      "feh",
      "xtightvncviewer"
    },

    name = {
      "Event Tester",
      "Picture in Picture",
      "Android Emulator.*"
    },

    role = {
      "AlarmWindow",
      "ConfigManager",
      "pop-up",
    }
  }, properties = {
    floating = true,
    placement = awful.placement.centered
  } },

  {
    rule_any = { type = { "normal", "dialog" } },
    properties = { titlebars_enabled = false }
  },

  {
    rule = { class = "Alacritty" },
    properties = { tag = tags[1] }
  },
  {
    rule_any = { class = { "Opera", "Brave-browser" } },
    properties = { tag = tags[2] }
  },
  {
    rule_any = { class = { "Code", "Emacs" } },
    properties = { tag = tags[3] }
  },
  {
    rule = { class = "obsidian" },
    properties = {
      floating = true,
      placement = awful.placement.centered
    }
  },
}
