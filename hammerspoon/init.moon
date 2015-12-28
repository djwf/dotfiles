-- vim: foldmethod=marker foldenable

-- TODO:
-- * Undo window resizing
-- * Trade content of windows, but maintain sizing
-- * Move content with mouse
-- * Auto-snapping, without pressing a hotkey
-- * Chrome OS-like window resizing, where other windows make room


-- SETTINGS                                                                 {{{1
hs.window.animationDuration = 0
hs.grid.GRIDWIDTH = 6
hs.grid.GRIDHEIGHT = 2
hs.grid.MARGINX = 0
hs.grid.MARGINY = 0


-- ALIASES                                                                  {{{1
hyper = {'cmd', 'alt', 'ctrl'}
hyperShift = {'cmd', 'alt', 'ctrl', 'shift'}
bind = hs.hotkey.bind
win = hs.window.focusedWindow


-- WINDOW MANAGEMENT                                                        {{{1

-- Move and resize                                                          {{{2
-- Thirds
bind hyper, '1', -> hs.grid.set win!, hs.geometry(0, 0, 2, 2)
bind hyper, '2', -> hs.grid.set win!, hs.geometry(2, 0, 2, 2)
bind hyper, '3', -> hs.grid.set win!, hs.geometry(4, 0, 2, 2)
bind hyper, '4', -> hs.grid.set win!, hs.geometry(0, 0, 4, 2)
bind hyper, '5', -> hs.grid.set win!, hs.geometry(2, 0, 4, 2)
-- Halves
bind hyper, 'r', -> hs.grid.set win!, hs.geometry(0, 0, 3, 2)
bind hyper, 't', -> hs.grid.set win!, hs.geometry(3, 0, 3, 2)
-- Browser
bind hyper, 'b', -> hs.grid.set win!, hs.geometry(1, 0, 4, 2)
-- Fullscreen
bind hyper, 'f', -> hs.grid.maximizeWindow!
-- Snap to grid
bind hyper, 'g', -> hs.grid.snap win!
bind hyper, '\'', -> hs.fnutils.map(hs.window.visibleWindows!, hs.grid.snap)
-- Move to next monitor
bind hyper, 'tab', -> win!\moveToScreen hs.screen.mainScreen!\next!

-- Focus                                                                    {{{2
drawBorder = -> -- {{{
  decay\stop! unless decay == nil
  window = win!
  if window != nil
    {x:x, y:y} = window\topLeft!
    {w:w, h:h} = window\size!

    border\delete! unless border == nil

    export border = hs.drawing.rectangle { x:x, y:y, w:w, h:h, }
    border\setRoundedRectRadii 5, 5
    border\setFill true
    border\setFillColor {
      red:   0
      green: 0
      blue:  1
      alpha: 0.1
    }
    border\setStroke true
    border\setStrokeWidth 5
    border\setStrokeColor {
      red:   0.5
      green: 0.75
      blue:  1
      alpha: 1
    }
    border\show!
    export decay = hs.timer.waitUntil((-> return hs.eventtap.checkKeyboardModifiers!.cmd == nil), (-> border\delete!), 0.1)
-- }}}

focus = (direction) -> -- {{{
  win!\focusWindowWest  nil, true if direction == 'west'
  win!\focusWindowSouth nil, true if direction == 'south'
  win!\focusWindowNorth nil, true if direction == 'north'
  win!\focusWindowEast  nil, true if direction == 'east'
  drawBorder!
-- }}}

-- Vim HJKL keys
bind hyper, 'h', -> focus 'west'
bind hyper, 'j', -> focus 'south'
bind hyper, 'k', -> focus 'north'
bind hyper, 'l', -> focus 'east'


-- OTHER                                                                    {{{1

-- iTerm
bind hyper, 'return', -> hs.application.launchOrFocus 'iTerm'

-- Paste by typing
bind hyper, 'v', -> hs.eventtap.keyStrokes hs.pasteboard.getContents!

-- Reload Hammerspoon config
bind hyper, '0', ->
  hs.reload!
  hs.alert 'Hammerspoon config reloaded'

-- Change margin size
bind hyper, '=', ->
  unless hs.grid.MARGINX >= 100
    hs.grid.MARGINX += 10
    hs.grid.MARGINY += 10
  hs.alert 'Margin increased to ' .. hs.grid.MARGINX

bind hyper, '-', ->
  unless hs.grid.MARGINX <= 0
    hs.grid.MARGINX -= 10
    hs.grid.MARGINY -= 10
  hs.alert 'Margin decreased to ' .. hs.grid.MARGINX
