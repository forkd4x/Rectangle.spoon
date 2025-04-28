local obj = {}
obj.__index = obj

-- Metadata
obj.name = "Rectangle"
obj.version = "0.2"
obj.author = "forkd4x <forkd4x@icloud.com>"
obj.homepage = "https://github.com/forkd4x/Rectangle.spoon"
obj.license = "MIT - https://opensource.org/licenses/MIT"

obj.gap = { p = 0, h = 0, w = 0 }
function obj:addGap(pixels)
  self.gap = {
    p = pixels or 0,
    w = (pixels or 0) / hs.screen.mainScreen():frame().w,
    h = (pixels or 0) / hs.screen.mainScreen():frame().h,
  }
  return self
end

function obj:move(rect)
  hs.window.focusedWindow():moveToUnit({
    rect[1] + self.gap.w,
    rect[2] + self.gap.h,
    rect[3] - self.gap.w * 2,
    rect[4] - self.gap.h * 2,
  })
end

function obj:resize(delta)
  local frame = hs.window.focusedWindow():frame()
  local screen = hs.screen.mainScreen():fullFrame()
  local menubar = hs.menubar.new():frame()
  if frame.w < screen.w - self.gap.p * 2 then
    if frame.x + frame.w + self.gap.p * 2 >= screen.w then
      frame.x = frame.x - delta
    elseif frame.x - self.gap.p > 0 then
      frame.x = frame.x - delta / 2
    end
    frame.w = math.min(frame.w + delta, screen.w - self.gap.p * 2)
  end
  if frame.h < screen.h - menubar.h - self.gap.p * 2 then
    if frame.y + frame.h + self.gap.p * 2 > screen.h - menubar.h then
      frame.y = frame.y - delta
    elseif frame.y - self.gap.p > menubar.h then
      frame.y = frame.y - delta / 2
    end
    frame.h = math.min(frame.h + delta, screen.h - menubar.h - self.gap.p * 2)
  end
  frame.y = math.max(frame.y, menubar.h + self.gap.p)
  hs.window.focusedWindow():setFrame(frame)
end

local function bindSpecIf(bindSpec, pressedfn)
  if bindSpec == nil then return end
  hs.hotkey.bindSpec(bindSpec, pressedfn)
end

function obj:bindHotkeys(mapping)
  bindSpecIf(mapping.left_half,    function() self:move({0.0, 0.0, 0.5, 1.0}) end)
  bindSpecIf(mapping.right_half,   function() self:move({0.5, 0.0, 0.5, 1.0}) end)
  bindSpecIf(mapping.center_half,  function() self:move({0.2, 0.0, 0.6, 1.0}) end)
  bindSpecIf(mapping.top_half,     function() self:move({0.0, 0.0, 1.0, 0.5}) end)
  bindSpecIf(mapping.bottom_half,  function() self:move({0.0, 0.5, 1.0, 0.5}) end)
  bindSpecIf(mapping.top_left,     function() self:move({0.0, 0.0, 0.5, 0.5}) end)
  bindSpecIf(mapping.top_right,    function() self:move({0.5, 0.0, 0.5, 0.5}) end)
  bindSpecIf(mapping.bottom_left,  function() self:move({0.0, 0.5, 0.5, 0.5}) end)
  bindSpecIf(mapping.bottom_right, function() self:move({0.5, 0.5, 0.5, 0.5}) end)
  bindSpecIf(mapping.maximize,     function() self:move({0.0, 0.0, 1.0, 1.0}) end)
  bindSpecIf(mapping.almost_max,   function() self:move({0.1, 0.1, 0.8, 0.8}) end)
  bindSpecIf(mapping.smaller,      function() self:resize(-100) end)
  bindSpecIf(mapping.larger,       function() self:resize(100) end)
  bindSpecIf(mapping.center,
    function()
      hs.window.focusedWindow():centerOnScreen()
      self:resize(0)
    end)
  bindSpecIf(mapping.focus_left,
    function() hs.window.focusedWindow():focusWindowWest(nil, true, true) end)
  bindSpecIf(mapping.focus_right,
    function() hs.window.focusedWindow():focusWindowEast(nil, true, true) end)
  bindSpecIf(mapping.focus_up,
    function() hs.window.focusedWindow():focusWindowNorth(nil, true, true) end)
  bindSpecIf(mapping.focus_down,
    function() hs.window.focusedWindow():focusWindowSouth(nil, true, true) end)
  bindSpecIf(mapping.focus_under,
    function() hs.window.focusedWindow():sendToBack() end)
  return self
end

return obj
