local awful = require("awful")
local beautiful = require("beautiful")

client.connect_signal("manage", function(c)
  if not awesome.startup then awful.client.setslave(c) end
  if awesome.startup
      and not c.size_hints.user_position
      and not c.size_hints.program_position then
    awful.placement.no_offscreen(c)
  end
end)

client.connect_signal("property::maximized", function(c)
  c.maximized = false
end)
client.connect_signal("property::fullscreen", function(c)
  c.border_width = 0
end)

function set_border_width(c)

  local s = c.screen
  local tag = s.selected_tag

  local max = false
  if tag ~= nil then
    max = tag.layout.name == "max"
  end

  local only_one = #s.tiled_clients == 1
  if (max or only_one) and not c.floating or c.maximized then
    c.border_width = 0
  else
    c.border_width = beautiful.border_width
  end
end

client.connect_signal("focus", function(c)
  c.border_color = beautiful.border_focus
  set_border_width(c)

end)
client.connect_signal("unfocus", function(c)
  c.border_color = beautiful.border_normal

  set_border_width(c)
end)

client.connect_signal("property::minimized", function(c)
  c.minimized = false
end)
client.connect_signal("mouse::enter", function(c)
  c:emit_signal("request::activate", "mouse_enter", { raise = false })
end)
