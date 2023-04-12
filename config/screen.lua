local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")
local wibox = require("wibox")
local naughty = require("naughty")

local battery_widget = require("awesome-wm-widgets.battery-widget.battery")
local brightness_widget = require("awesome-wm-widgets.brightness-widget.brightness")
local cpu_widget = require("awesome-wm-widgets.cpu-widget.cpu-widget")
local cmus_widget = require('awesome-wm-widgets.cmus-widget.cmus')
local fs_widget = require("awesome-wm-widgets.fs-widget.fs-widget")
local ram_widget = require("awesome-wm-widgets.ram-widget.ram-widget")
local spotify_widget = require("awesome-wm-widgets.spotify-widget.spotify")
local volume_widget = require('awesome-wm-widgets.volume-widget.volume')
local ip_widget = require('awesome-wm-widgets.ip-widget.ip')

local function set_wallpaper(s)
  if beautiful.wallpaper then
    local wallpaper = beautiful.wallpaper
    if type(wallpaper) == "function" then
      wallpaper = wallpaper(s)
    end
    gears.wallpaper.maximized(wallpaper, s, false)
  end
end

local ip = ip_widget({ adapter = 'wlp3s0' })
local battery = battery_widget({ display_notification = true })
local brightness = brightness_widget({ base = 50 })
local cpu = cpu_widget()
local cmus = cmus_widget()
local fs = fs_widget()
local ram = ram_widget()
local spotify = spotify_widget()
local volume = volume_widget({
  device = "default",
  widget_type = "arc",
  with_icon = true
})
local text_clock = wibox.widget {
  format = '%a %b %d, %H:%M',
  widget = wibox.widget.textclock
}
local separator = wibox.widget.separator({ forced_width = 8 })
local keyboard_layout = wibox.widget {
  text    = kbdcfg.layout[kbdcfg.current][1],
  align   = 'center',
  valign  = 'center',
  buttons = awful.button({}, 1, function() kbdcfg.switch() end),
  widget  = wibox.widget.textbox
}
awesome.connect_signal('keyboard_layout_changed', function(l)
  keyboard_layout.text = l[1]
end)

screen.connect_signal("property::geometry", set_wallpaper)
awful.screen.connect_for_each_screen(function(s)
  set_wallpaper(s)

  awful.tag(tags, s, layouts)

  s.tag_list = awful.widget.taglist {
    screen          = s,
    filter          = awful.widget.taglist.filter.all,
    widget_template = {
      {
        {
          {
            id     = 'text_role',
            widget = wibox.widget.textbox,
          },
          layout  = wibox.layout.fixed.horizontal,
          spacing = 4
        },
        left   = 12,
        right  = 12,
        widget = wibox.container.margin
      },
      id     = 'background_role',
      widget = wibox.container.background,
    },
  }
  s.mywibox = awful.wibar({
    position = "top",
    screen = s,
    opacity = 0.90,
  })
  s.mywibox:setup {
    layout = wibox.layout.align.horizontal,
    expand = "none",
    {
      layout = wibox.layout.fixed.horizontal,
      s.tag_list,
    },
    {
      layout = wibox.layout.fixed.horizontal,
      spacing = 8,
      text_clock,
    },
    {
      layout = wibox.layout.fixed.horizontal,
      spacing = 8,
      expand = "none",
      keyboard_layout,
      ip,
      battery,
      separator,
      brightness,
      volume,
      separator,
      fs,
      ram,
      cpu,
      separator,
      cmus,
      spotify,
      wibox.widget.systray(),
    },
  }

  s.taskbar = awful.wibar({ position = "bottom", screen = s, opacity = 0.90 })

  s.task_list = awful.widget.tasklist {
    screen          = s,
    filter          = awful.widget.tasklist.filter.currenttags,
    layout          = {
      spacing = 4,
      layout  = wibox.layout.flex.horizontal
    },
    widget_template = {
      {
        {
          {
            {
              id     = 'icon_role',
              widget = wibox.widget.imagebox,
            },
            margins = 2,
            widget  = wibox.container.margin,
          },
          {
            id     = 'text_role',
            widget = wibox.widget.textbox,
          },
          layout = wibox.layout.fixed.horizontal,
        },
        left   = 10,
        right  = 10,
        widget = wibox.container.margin
      },
      id     = 'background_role',
      widget = wibox.container.background,
    },
  }


  s.taskbar:setup {
    layout = wibox.layout.align.horizontal,
    expand = "none",
    nil,
    s.task_list,
    nil
  }

  s.prompt_box = awful.popup {
      widget = {
        text = '',
        widget = wibox.widget.textbox,
      },
      screen = s,
      placement    = awful.placement.centered,
      ontop = true,
  }
end)
