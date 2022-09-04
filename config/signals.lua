local awful = require("awful")
local beautiful = require("beautiful")
local naughty = require("naughty")

client.connect_signal("manage", function(c)
  if not awesome.startup then awful.client.setslave(c) end
  if awesome.startup
      and not c.size_hints.user_position
      and not c.size_hints.program_position then
    awful.placement.no_offscreen(c)
  end
end)
client.connect_signal("property::minimized", function(c)
  c.minimized = false
end)
client.connect_signal("property::fullscreen", function(c)
  c.border_width = c.fullscreen and 0 or beautiful.border_width
end)

function manage_tasklsit(c)
  local s = c.screen
  local tag = s.selected_tag

  local max = false
  if tag ~= nil then
    max = tag.layout.name == "max"
  end

  local only_one = #s.tiled_clients == 1

  s.taskbar.visible = max and not only_one
end

client.connect_signal("focus", function(c)
  c.border_color = beautiful.border_focus

  manage_tasklsit(c)
end)
client.connect_signal("unfocus", function(c)
  c.border_color = beautiful.border_normal

  if c.maximized then
    c.maximized = false
  end

  manage_tasklsit(c)
end)
client.connect_signal("mouse::enter", function(c)
end)


tag.connect_signal('property::selected', function(t)
end)
