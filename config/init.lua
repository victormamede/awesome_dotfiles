pcall(require, "luarocks.loader")

local awful = require("awful")
require("awful.autofocus")
local beautiful = require("beautiful")
local naughty = require("naughty")
local menubar = require("menubar")
local bling = require("lib.bling")

if awesome.startup_errors then
  naughty.notify({ preset = naughty.config.presets.critical,
    title = "Oops, there were errors during startup!",
    text = awesome.startup_errors })
end

do
  local in_error = false
  awesome.connect_signal("debug::error", function(err)
    -- Make sure we don't go into an endless error loop
    if in_error then return end
    in_error = true

    naughty.notify({ preset = naughty.config.presets.critical,
      title = "Oops, an error happened!",
      text = tostring(err) })
    in_error = false
  end)
end

beautiful.init(os.getenv("HOME") .. "/.config/awesome/theme.lua")

local l = awful.layout.suit
awful.layout.layouts = {
  l.tile,
  l.fair,
  l.max
}

terminal = "alacritty"
tags = { "TERM", "WWW", "CODE", "CHAT", "5", "6", "7", "8", "9" }
layouts = { l.tile, l.max, l.max, l.tile, l.tile, l.tile, l.tile, l.tile, l.tile }
modkey = "Mod4"

menubar.utils.terminal = terminal

kbdcfg = {}
kbdcfg.cmd = "setxkbmap"
kbdcfg.layout = { { "us", "" }, { "br", "" } }
kbdcfg.current = 2
kbdcfg.set = function()
  local t = kbdcfg.layout[kbdcfg.current]
  os.execute(kbdcfg.cmd .. " " .. t[1] .. " " .. t[2])
  awesome.emit_signal('keyboard_layout_changed', t)
end
kbdcfg.switch = function()
  kbdcfg.current = kbdcfg.current % #(kbdcfg.layout) + 1
  kbdcfg.set()
end

kbdcfg.set()

local term_scratch = require("config.helpers.scratchpad")
term_scratch:turn_off()
