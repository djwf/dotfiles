-- vim: foldmethod=marker foldenable

-- SETTINGS {{{1
hs.window.animationDuration = 0

hs.grid.GRIDWIDTH = 3
hs.grid.GRIDHEIGHT = 2
hs.grid.MARGINX = 0
hs.grid.MARGINY = 0

hyper = {"cmd", "alt", "ctrl", "shift"}


-- WINDOW MANAGEMENT {{{1
hs.hotkey.bind(hyper, '1', function() hs.window.focusedWindow():moveToUnit(hs.layout.left30) end)
hs.hotkey.bind(hyper, '3', function() hs.window.focusedWindow():moveToUnit(hs.layout.right30) end)
hs.hotkey.bind(hyper, '4', function() hs.window.focusedWindow():moveToUnit(hs.layout.left70) end)
hs.hotkey.bind(hyper, '5', function() hs.window.focusedWindow():moveToUnit(hs.layout.right70) end)
hs.hotkey.bind(hyper, 'R', function() hs.window.focusedWindow():moveToUnit(hs.layout.left50) end)
hs.hotkey.bind(hyper, 'T', function() hs.window.focusedWindow():moveToUnit(hs.layout.right50) end)
hs.hotkey.bind(hyper, 'F', function() hs.window.focusedWindow():moveToUnit(hs.layout.maximized) end)

-- Move to next screen
hs.hotkey.bind(hyper, "tab", function()
  local focus = hs.window.focusedWindow()
  local next = hs.screen.mainScreen():next()

  focus:moveToScreen(next)
end)

-- Browser size
hs.hotkey.bind(hyper, "B", function()
  local win = hs.window.focusedWindow()
  local frame = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  frame.x = max.x + (max.w / 8)
  frame.y = max.y
  frame.w = (max.w / 4) * 3
  frame.h = max.h

  win:setFrame(frame)
end)

-- Perfect size
hs.hotkey.bind(hyper, "2", function()
  local win = hs.window.focusedWindow()
  local frame = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  frame.x = max.x + (max.w / 5)
  frame.y = max.y
  frame.w = (max.w / 5) * 3
  frame.h = max.h

  win:setFrame(frame)
end)

-- hs.hotkey.bind(hyper, 'h', hs.grid.pushWindowLeft)
-- hs.hotkey.bind(hyper, 'j', hs.grid.pushWindowDown)
-- hs.hotkey.bind(hyper, 'k', hs.grid.pushWindowUp)
-- hs.hotkey.bind(hyper, 'l', hs.grid.pushWindowRight)


-- MISCELLANEOUS {{{1
-- Auto-reload config
function reloadConfig(files)
  doReload = false
  for _,file in pairs(files) do
    if file:sub(-4) == ".lua" then
      doReload = true
    end
  end
  if doReload then
    hs.reload()
  end
end
hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()

hs.notify.new({
  title = "Hammerspoon",
  informativeText = "Config reloaded automatically"
}):send():release()

-- Paste by typing
hs.hotkey.bind(hyper, "V", function() hs.eventtap.keyStrokes(hs.pasteboard.getContents()) end)


