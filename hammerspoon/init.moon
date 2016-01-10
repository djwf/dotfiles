-- vim: foldmethod=marker foldenable

-- TODO:
-- * Undo window resizing
-- * Preselecting? (like bspwm)
-- * Move content with mouse
-- * Auto-snapping, WITHOUT pressing a hotkey
-- * Chrome OS-like window resizing, where other windows make room


-- SETTINGS                                                                 {{{1
hs.window.animationDuration = 0

gridWidth = 6
gridHeight = 2
hs.grid.GRIDWIDTH = gridWidth
hs.grid.GRIDHEIGHT = gridHeight
hs.grid.MARGINX = 0
hs.grid.MARGINY = 0

hs.hints.hintChars = {'A', 'S', 'D', 'F', 'J', 'K', 'L', ';'}
hs.hints.showTitleThresh = 0


-- ALIASES                                                                  {{{1
hyper = {'cmd', 'alt', 'ctrl'}
hyperShift = {'cmd', 'alt', 'ctrl', 'shift'}
bind = hs.hotkey.bind
win = hs.window.focusedWindow


-- WINDOW MANAGEMENT                                                        {{{1

-- Move and resize                                                          {{{2

-- Thirds
bind hyper, '1', -> hs.grid.set(win!, hs.geometry(0, 0, 2, 2))
bind hyper, '2', -> hs.grid.set(win!, hs.geometry(2, 0, 2, 2))
bind hyper, '3', -> hs.grid.set(win!, hs.geometry(4, 0, 2, 2))
bind hyper, '4', -> hs.grid.set(win!, hs.geometry(0, 0, 4, 2))
bind hyper, '5', -> hs.grid.set(win!, hs.geometry(2, 0, 4, 2))

-- Halves
bind hyper, 'r', -> hs.grid.set(win!, hs.geometry(0, 0, 3, 2))
bind hyper, 't', -> hs.grid.set(win!, hs.geometry(3, 0, 3, 2))

-- Browser
bind hyper, 'b', -> hs.grid.set(win!, hs.geometry(1, 0, 4, 2))

-- Fullscreen
bind hyper, 'f', -> hs.grid.maximizeWindow!

-- Center
bind hyper, 'c', -> -- {{{
  window = win!
  frame = window\frame!
  max = window\screen!\frame!

  frame.x = (max.w - frame.w) / 2
  frame.y = (max.h - frame.h) / 2

  window\setFrame(frame)
-- }}}

-- Snap to grid
bind hyper, 'g', ->
  hs.grid.GRIDWIDTH = 3
  hs.grid.snap(win!)
  hs.grid.GRIDWIDTH = gridWidth

bind hyperShift, 'g', ->
  hs.grid.GRIDWIDTH = 3
  hs.fnutils.map(hs.window.visibleWindows!, hs.grid.snap)
  hs.grid.GRIDWIDTH = gridWidth

-- Move to next monitor
bind hyper, 'tab', -> win!\moveToScreen(win!\screen!\next!)

-- Focus                                                                    {{{2
drawBorder = -> -- {{{
  decay\stop! unless decay == nil
  window = win!
  if window != nil
    {x:x, y:y} = window\topLeft!
    {w:w, h:h} = window\size!

    border\delete! unless border == nil

    -- export border = hs.drawing.rectangle { x:x, y:y, w:w, h:h, }
    export border = hs.drawing.rectangle(hs.geometry.rect(x, y, w, h))
    border\setLevel 'floating'
    border\setRoundedRectRadii 5, 5
    border\setFill true
    border\setFillColor {
      red:   0
      green: 0
      blue:  1
      -- alpha: 0.1
      alpha: 0
    }
    border\setStroke true
    border\setStrokeWidth 5
    border\setStrokeColor {
      red:   0
      green: 0.5
      blue:  1
      alpha: 1
    }
    border\show!
    export decay = hs.timer.waitUntil((-> return hs.eventtap.checkKeyboardModifiers!.cmd == nil), (-> border\delete!), 0.1)
-- }}}

focus = (direction) -> -- {{{
  win!\focusWindowWest(nil, false, true) if direction == 'west'
  win!\focusWindowSouth(nil, false, true) if direction == 'south'
  win!\focusWindowNorth(nil, false, true) if direction == 'north'
  win!\focusWindowEast(nil, false, true) if direction == 'east'
  drawBorder!
-- }}}

swap = (direction) -> -- {{{
  current = win!
  neighbor = current\windowsToWest(nil, true, true)[1] if direction == 'west'
  neighbor = current\windowsToSouth(nil, true, true)[1] if direction == 'south'
  neighbor = current\windowsToNorth(nil, true, true)[1] if direction == 'north'
  neighbor = current\windowsToEast(nil, true, true)[1] if direction == 'east'

  if neighbor != nil
    ctl = current\topLeft!
    cs = current\size!
    ntl = neighbor\topLeft!
    ns = neighbor\size!

    current\setTopLeft(ntl)
    current\setSize(ns)
    neighbor\setTopLeft(ctl)
    neighbor\setSize(cs)

    drawBorder!
-- }}}

-- Vim HJKL keys
-- Change focus
bind hyper, 'h', -> focus('west')
bind hyper, 'j', -> focus('south')
bind hyper, 'k', -> focus('north')
bind hyper, 'l', -> focus('east')

-- Swap window content without changing window size
bind hyperShift, 'h', -> swap('west')
bind hyperShift, 'j', -> swap('south')
bind hyperShift, 'k', -> swap('north')
bind hyperShift, 'l', -> swap('east')

-- Window hints (lags)
-- bind hyper, 'space', -> hs.hints.windowHints(nil, drawBorder, false)


-- OTHER                                                                    {{{1

-- iTerm
-- bind hyper, 'return', -> hs.application.launchOrFocus 'iTerm'

-- Paste by typing
bind hyper, 'v', -> hs.eventtap.keyStrokes hs.pasteboard.getContents!

-- Change margin size
-- bind hyper, '=', ->
--   unless hs.grid.MARGINX >= 100
--     hs.grid.MARGINX += 10
--     hs.grid.MARGINY += 10
--   hs.alert 'Margin increased to ' .. hs.grid.MARGINX

-- bind hyper, '-', ->
--   unless hs.grid.MARGINX <= 0
--     hs.grid.MARGINX -= 10
--     hs.grid.MARGINY -= 10
--   hs.alert 'Margin decreased to ' .. hs.grid.MARGINX

-- Auto-reload Hammerspoon config
hs.pathwatcher.new(hs.configdir, hs.reload)\start!

-- Manually reload Hammerspoon config
bind hyperShift, 'r', -> hs.reload!

hs.alert 'Hammerspoon config loaded!'
