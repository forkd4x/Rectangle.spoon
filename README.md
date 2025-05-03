# Rectangle.spoon

Move and resize windows.
Inspired by [Rectangle](https://github.com/rxhanson/Rectangle) app.

## Install
```bash
mkdir -p ~/.hammerspoon/Spoons
git clone https://github.com/forkd4x/Rectangle.spoon.git ~/.hammerspoon/Spoons/Rectangle.spoon
```

## Configure
Add to `~/.hammerspoon/init.lua`
```lua
local mods = { "ctrl", "cmd" }
local rectangle = hs.loadSpoon("Rectangle")
rectangle:bindHotkeys({
  left_half    = { mods, "a" },
  right_half   = { mods, "d" },
  center_half  = { mods, "s" },
  top_half     = { mods, "w" },
  bottom_half  = { mods, "x" },
  top_left     = { mods, "q" },
  top_right    = { mods, "e" },
  bottom_left  = { mods, "z" },
  bottom_right = { mods, "c" },
  maximize     = { mods, "f" },
  almost_max   = { mods, "g" },
  max_height   = { mods, "9" },
  smaller      = { mods, "-" },
  larger       = { mods, "=" },
  center       = { mods, "0" },
  focus_left   = { mods, "h" },
  focus_right  = { mods, "l" },
  focus_up     = { mods, "k" },
  focus_down   = { mods, "j" },
  focus_under  = { mods, "u" },
})
-- Add 10 pixel gap around/between windows (optional)
rectangle:config({ margings = 10 })
```
