-- vim: foldmethod=marker foldenable

-- ALIASES {{{1
hyper = {"cmd", "alt", "ctrl", "shift"}


-- HELPERS {{{1

function half(region)
  local win = hs.window.focusedWindow()
  local frame = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  if region == "left" then
    frame.x = max.x
  elseif region == "right" then
    frame.x = max.x + (max.w / 2)
  else
    hs.alert.show("Invalid region")
  end

  frame.y = max.y
  frame.w = max.w / 2
  frame.h = max.h

  win:setFrame(frame)
end

function third(region)
  local win = hs.window.focusedWindow()
  local frame = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  frame.y = max.y
  frame.w = max.w / 3
  frame.h = max.h

  if region == "1" then
    frame.x = max.x
  elseif region == "2" then
    frame.x = max.x + (max.w / 3)
  elseif region == "3" then
    frame.x = max.x + 2 * (max.w / 3)
  elseif region == "4" then
    frame.x = max.x
    frame.w = frame.w * 2
  elseif region == "5" then
    frame.x = max.x + (max.w / 3)
    frame.w = frame.w * 2
  else
    hs.alert.show("Invalid region")
  end

  win:setFrame(frame)
end


-- WINDOW SIZE PRESETS {{{1

hs.hotkey.bind(hyper, "1", function() third("1") end)    -- Left third
hs.hotkey.bind(hyper, "2", function() third("2") end)    -- Middle third
hs.hotkey.bind(hyper, "3", function() third("3") end)    -- Right third
hs.hotkey.bind(hyper, "4", function() third("4") end)    -- Left and middle thirds
hs.hotkey.bind(hyper, "5", function() third("5") end)    -- Middle and right thirds
hs.hotkey.bind(hyper, "R", function() half("left") end)  -- Left half
hs.hotkey.bind(hyper, "T", function() half("right") end) -- Right half
hs.hotkey.bind(hyper, "B", function()                    -- Browser
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
hs.hotkey.bind(hyper, "P", function()                    -- Perfect
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
hs.hotkey.bind(hyper, "F", function()                    -- Fullscreen
  local win = hs.window.focusedWindow()
  local frame = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  frame.x = max.x
  frame.y = max.y
  frame.w = max.w
  frame.h = max.h

  win:setFrame(frame)
end)


-- MOVE WINDOW FOCUS {{{1

function moveFocus(direction)
  local focus = hs.window.focusedWindow()

  if direction == "up" then focus:focusWindowNorth()
  elseif direction == "down" then focus:focusWindowSouth()
  elseif direction == "right" then focus:focusWindowEast()
  elseif direction == "left" then focus:focusWindowWest()
  end
end

hs.hotkey.bind(hyper, "H", function() moveFocus("left") end)
hs.hotkey.bind(hyper, "J", function() moveFocus("down") end)
hs.hotkey.bind(hyper, "K", function() moveFocus("up") end)
hs.hotkey.bind(hyper, "L", function() moveFocus("right") end)


-- MISCELLANEOUS {{{1

hs.hotkey.bind(hyper, "0", function()
  hs.reload()
end)

hs.alert.show("Config loaded!")

hs.hotkey.bind(hyper, "tab", function()                  -- Move to next screen
  local focus = hs.window.focusedWindow()
  local next = hs.screen.mainScreen():next()

  focus:moveToScreen(next)
end)
