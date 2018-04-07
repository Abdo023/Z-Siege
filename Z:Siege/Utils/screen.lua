local screen = {}

 screen.cX  = display.contentCenterX
 screen.cY  = display.contentCenterY

 screen.width    = display.actualContentWidth + display.screenOriginX
 screen.height   = display.actualContentHeight
 screen.left     = display.screenOriginX 
 screen.right    = screen.cX + (screen.width * 0.5)
 screen.top      = display.screenOriginY
 screen.bottom   = screen.cY + (screen.height * 0.5)
 screen.safeLeft = display.safeScreenOriginX
 screen.safeTop = display.safeScreenOriginY

return screen