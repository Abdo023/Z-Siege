local composer = require( "composer" )
local widget = require( "widget" )

local scene = composer.newScene()
local sceneGroup

local Grid = require( "jumper.grid" )
local Pathfinder = require ("jumper.pathfinder")

local Map = require( "Map" )
local Unit = require( "Unit" )
display.setDefault( "background", 1,1,1 )
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

local tiles = {}
local t = {}
local line 
local player
local nextButton
local currentSelectedUnit = {}
local currentSelectedTile = {}
local foundPath = {}

local isCreatingPath = false

local function createNextButton( func )
    nextButton = widget.newButton( {
        width = 80,
        height = 40,
        x = screen.width - 80,
        y = screen.height - 40,
        shape = roundedRect,
        cornerRadius = 4,
        label = "Next",
        font = "Avenir",
        labelColor = { default={0,1,0}, over={0,1,0}},
        fillColor = color.blue( ),
        onRelease = func
    } )
end

local function createPlayer( listener )
    player = Unit.new( sceneGroup )
    player.x = tiles[4][8].x
    player.y = tiles[4][8].y
    player.pos = tiles[4][8].pos
    player:setFillColor( color.red( ) )
    player:addEventListener( "touch", listener )
end

local function drawMap( listener )
    local m = Map.new( )
    local size = 32
    local offset = size
    local xPos = screen.safeLeft + offset
    local yPos = screen.safeTop + offset 
    for y=1,#m do
        tiles[y] = {}
        t[y] = {}
        for x=1,#m[y] do

            local tile = display.newRect( sceneGroup, 0, 0, size, size )
            tile:setStrokeColor( 0,1,0 )
            tile.strokeWidth = 1
            tile.x = xPos
            tile.y = yPos
            tile.pos = {x=x, y=y}
            tile.walkable = 1
            tiles[y][x] = tile
            
            tile:addEventListener( "touch", listener )
            if (m[y][x] == "base") then
                tile:setFillColor( color.orange( ) )
            elseif (m[y][x] == "road") then
                tile:setFillColor( color.grey( ) )
                tile.walkable = 0
            elseif (m[y][x] == "house") then
                tile:setFillColor( color.yellow( ) ) 
            elseif (m[y][x] == "store") then
                tile:setFillColor( color.green( ) ) 
            elseif (m[y][x] == "policeStation") then
                tile:setFillColor( color.blue( ) ) 
            end            
            t[y][x] = tile.walkable
            xPos = xPos + size
        end
        xPos = screen.safeLeft + offset
        yPos = yPos + size 
        --print( "X: "..x,y )
    end
end

local function getPath( startPos, endPos )
    local walkable = 0
    local grid = Grid(t)
    local myFinder = Pathfinder(grid, 'ASTAR', walkable) 
    myFinder:setMode( "ORTHOGONAL" )
    myFinder:setTunnelling(false)

    local path = myFinder:getPath(startPos.x, startPos.y, endPos.x, endPos.y)

    local tile = tiles[currentSelectedUnit.pos.y][currentSelectedUnit.pos.x]

    if path then
        foundPath = {}

        print(('Path found! Length: %.2f'):format(path:getLength()))
        for node, count in path:nodes() do
            local t = tiles[node:getY()][node:getX()]

           foundPath[#foundPath+1] = t
           player.path = foundPath
        end
    end
    print( "Found Path: "..#foundPath )
end

local function createPath( tile )
    getPath( currentSelectedUnit.pos, tile.pos )

end

local function onTileTouch( event )
    local phase = event.phase
    local tile = event.target

    if ( phase == "began"  ) then
       --createPath( tile )
        currentSelectedTile = tile
        foundPath[#foundPath+1] = tile
       
        print( "Tile touched" )
    elseif ( phase == "moved" ) then
        createPath( tile )
        if line ~= nil then
            line:removeSelf( )
        end
        local t = tiles[currentSelectedUnit.pos.y][currentSelectedUnit.pos.x]
        line = display.newLine( t.x, t.y, t.x+0.1, t.y+0.1 )
        line:setStrokeColor( color.brown( ) )
        line.strokeWidth = 2

        --print( "Unit: "..t.x, t.y )
         
        for i=1,#foundPath do
            line:append( foundPath[i].x,foundPath[i].y )
            print( "Path: "..#foundPath )
        end
    elseif ( phase == "ended" or phase == "cancelled" ) then

    end
end

local function onUnitTouch( event )
    local phase = event.phase
    local unit = event.target

    unit.path = {}
    unit.next = 2

    if ( phase == "began" ) then
        --display.getCurrentStage():setFocus( unit )
        print( "Unit touched" )
        currentSelectedUnit = unit
        isCreatingPath = true
        --return true
    elseif ( phase == "moved" ) then

    elseif ( phase == "ended" or phase == "cancelled" ) then
        currentSelectedUnit = nil
    end
end

local function onNextButton( event )
    local phase = event.phase
    local button = event.target

    if (phase == "ended") then
        local tile = player.path[player.next] 
        player.move( tile.x, tile.y )
        player.next = player.next+1
    end
end

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

    sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen
    --createGrid( sceneGroup, onTileTouch )
    drawMap( onTileTouch )
    createPlayer( onUnitTouch )
    createNextButton( onNextButton )
end



-- show()
function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)

    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen

    end
end


-- hide()
function scene:hide( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)

    elseif ( phase == "did" ) then
        -- Code here runs immediately after the scene goes entirely off screen

    end
end


-- destroy()
function scene:destroy( event )

    local sceneGroup = self.view
    -- Code here runs prior to the removal of scene's view

end


-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------

return scene