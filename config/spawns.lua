local awful = require("awful")

awful.spawn.with_shell("picom -b --experimental-backends --config ~/.config/picom/picom.conf")
awful.spawn.with_shell("thunar --daemon")
awful.spawn.with_shell("autorandr --change")
