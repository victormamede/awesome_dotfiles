local awful = require("awful")

awful.spawn.with_shell("picom -b --config ~/.config/picom/picom.conf")
