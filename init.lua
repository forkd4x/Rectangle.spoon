local obj = {}
obj.__index = obj

-- Metadata
obj.name = "Rectangle"
obj.version = "0.3"
obj.author = "forkd4x <forkd4x@icloud.com>"
obj.homepage = "https://github.com/forkd4x/Rectangle.spoon"
obj.license = "MIT - https://opensource.org/licenses/MIT"

function obj:init()
  hs.grid.setGrid("16x16")
  self.opts = { margins = 0 }
  return obj
end

function obj:config(opts)
  if opts.margins ~= nil then
    self.opts.margins = opts.margins
    hs.grid.setMargins(opts.margins .. "x" .. opts.margins)
  end
end

function obj:move(cell)
  hs.grid.set(hs.window.focusedWindow(), cell)
end

function obj:left_half() obj:move("0,0 8x16") end
function obj:right_half() obj:move("8,0 8x16") end
function obj:center_half() obj:move("4,0 8x16") end
function obj:top_half() obj:move("0,0 16x8") end
function obj:bottom_half() obj:move("0,8 16x8") end
function obj:top_left() obj:move("0,0 8x8") end
function obj:top_right() obj:move("8,0 8x8") end
function obj:bottom_left() obj:move("0,8 8x8") end
function obj:bottom_right() obj:move("8,8 8x8") end
function obj:maximize() obj:move("0,0 16x16") end
function obj:almost_max() obj:move("2,2 12x12") end

function obj:max_height()
  local cell = hs.grid.get(hs.window.focusedWindow())
  if not cell then return end
  obj:move({
    x = cell.x,
    y = 0,
    w = cell.w,
    h = 16,
  })
end

function obj:resize(delta)
  local win = hs.window.focusedWindow()
  local cell = hs.grid.get(win)
  if not cell then return end
  local fullscreen = (cell == { x = 0, y = 0, w = 16, h = 16 })
  if cell.x > 0 or fullscreen then
    cell.x = cell.x - delta
    cell.w = cell.w + delta
  end
  if cell.x + cell.w < 16 or fullscreen then
    cell.w = cell.w + delta
  end
  if cell.y > 0 or fullscreen then
    cell.y = cell.y - delta
    cell.h = cell.h + delta
  end
  if cell.y + cell.h < 16 or fullscreen then
    cell.h = cell.h + delta
  end
  hs.grid.set(win, cell)
end

function obj:smaller() obj:resize(-1) end
function obj:larger() obj:resize(1) end

function obj:center()
  local grid = hs.grid.getGridFrame(hs.screen.mainScreen())
  hs.window.focusedWindow():centerOnScreen():move({
    x = 0,
    y = math.ceil(grid.y / 2),
  })
end

function obj:focus_left() hs.window.focusedWindow():focusWindowWest(nil, true, true) end
function obj:focus_right() hs.window.focusedWindow():focusWindowEast(nil, true, true) end
function obj:focus_up() hs.window.focusedWindow():focusWindowNorth(nil, true, true) end
function obj:focus_down() hs.window.focusedWindow():focusWindowSouth(nil, true, true) end

-- FIX: Focusing windows not under active window; flashing windows
function obj:focus_under()
  hs.window.focusedWindow():sendToBack()
end

-- TODO: obj:restore()

local function bindSpecIf(bindSpec, pressedfn)
  if not bindSpec then return end
  hs.hotkey.bindSpec(bindSpec, pressedfn)
end

function obj:bindHotkeys(mapping)
  bindSpecIf(mapping.left_half, self.left_half)
  bindSpecIf(mapping.right_half, self.right_half)
  bindSpecIf(mapping.center_half, self.center_half)
  bindSpecIf(mapping.top_half, self.top_half)
  bindSpecIf(mapping.bottom_half, self.bottom_half)
  bindSpecIf(mapping.top_left, self.top_left)
  bindSpecIf(mapping.top_right, self.top_right)
  bindSpecIf(mapping.bottom_left, self.bottom_left)
  bindSpecIf(mapping.bottom_right, self.bottom_right)
  bindSpecIf(mapping.maximize, self.maximize)
  bindSpecIf(mapping.almost_max, self.almost_max)
  bindSpecIf(mapping.max_height, self.max_height)
  bindSpecIf(mapping.smaller, self.smaller)
  bindSpecIf(mapping.larger, self.larger)
  bindSpecIf(mapping.center, self.center)
  bindSpecIf(mapping.focus_left, self.focus_left)
  bindSpecIf(mapping.focus_right, self.focus_right)
  bindSpecIf(mapping.focus_up, self.focus_up)
  bindSpecIf(mapping.focus_down, self.focus_down)
  bindSpecIf(mapping.focus_under, self.focus_under)
  return self
end

return obj
