local bling = require("lib.bling")
local rubato = require("lib.rubato")

local anim_y = rubato.timed {
  pos = -800,
  rate = 60,
  easing = rubato.quadratic,
  intro = 0.1,
  duration = 0.3,
  awestore_compat = true -- This option must be set to true.
}


local term_scratch = bling.module.scratchpad {
  command                 = "obsidian",
  rule                    = { instance = "obsidian" },
  sticky                  = true,
  autoclose               = false,
  floating                = true,
  geometry                = { x = 20, y = 20, height = 600, width = 1000 },
  reapply                 = true,
  dont_focus_before_close = false,
  rubato                  = { y = anim_y }
}

term_scratch:connect_signal("turn_on", function(c)
  c:apply()
end)



return term_scratch
