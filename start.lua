local storyboard = require ("storyboard")
local scene = storyboard.newScene ()

local baseline = 280

local function apertarBotao( event )
	storyboard.gotoScene (event.target.destination, {effect = "fade"})
	return true
end

function scene:createScene( event )
	--> add physics
	local physics = require( "physics" )
	physics.start()
	physics.setGravity(0, 9.8)
	--system.activate( "multitouch" )
	--physics.setDrawMode( "hybrid" )

	--> add background
	local background = display.newImage( "img/bkg3.png" )
	background:scale(display.contentWidth/background.contentWidth, 
		display.contentHeight/background.contentHeight)         
	background.x = centerX         
	background.y = centerY
	local background2 = display.newImage( "img/bkg3.png" )
	background2:scale(display.contentWidth/background2.contentWidth, 
		display.contentHeight/background2.contentHeight)         
	background2.x = centerX + display.contentWidth         
	background2.y = centerY

	--> Adciona o chão do jogo
	local floor = display.newImage( "img/floor.png" )
	floor:scale(display.contentWidth/floor.contentWidth, display.contentHeight/10/floor.contentHeight)         
	floor.x = display.contentWidth - floor.contentWidth/2
	floor.y = display.contentHeight - floor.contentHeight/2
	physics.addBody( floor,"static",{bounce = 0.1, friction =1.0} )

--[[
	--A sprite sheet with a green dude
	local person = graphics.newImageSheet( "greenman.png", { width=128, height=128, numFrames=15 } )

	--play 15 frames every 500 ms
	local instance = display.newSprite( person, { name="man", start=1, count=15, time=500 } )
	instance.x = display.contentWidth/2 - 150
	instance.y = baseline - 30
	instance:play()
]]
	--> Adicionar personagem no jogo
	local person = display.newImage( "img/person.png" )
	person.x = display.contentWidth/2 - 120
	person.y = 200
	physics.addBody( person, {bounce = 0.1, radius = 35, friction =1.0} )
	person.isFixedRotation = true

	-- -------------------------------------
	-- ADD LIMITS
	-- -------------------------------------
	local leftWall = display.newRect(0, 0, 0.1, display.contentHeight)
	leftWall.x = 0
	leftWall.y = display.contentHeight/2
	physics.addBody( leftWall, "static", {density = 1.0, friction = 0.3, bounce = 0.2} )

	local topWall = display.newRect(0, 0, display.contentWidth, 0.1)
	topWall.x = display.contentWidth / 2
	topWall.y = 19
	physics.addBody( topWall, "static", {density = 1.0, friction = 0.6, bounce = 0.2} )

	-- -------------------------------------
	-- CREATE  FUNCTION EVENT
	-- -------------------------------------
	local function onScreenTouch( event )
		if event.phase == "began" then
			--if event.xStart == person.x then
				person:applyForce( 0, -15, event.x, event.y )
			--end
		end
		return true
	end

	--> aplica animação no cenario do jogo
	local tPrevious = system.getTimer()
	
	local function move(event)
    	local tDelta = event.time - tPrevious
    	tPrevious = event.time
 
    	local xOffset = ( 0.15 * tDelta )
 
    	background.x = background.x - xOffset
    	background2.x = background2.x - xOffset
 
    	if (background.x + background.contentWidth) < centerX  then
        	background:translate( centerX + display.contentWidth * 1.50, 0)
    	end
    	if (background2.x + background2.contentWidth) < centerX  then
        	background2:translate( centerX + display.contentWidth * 1.50, 0)
        end
    end

	-- -------------------------------------
	-- CREATE EVENT LISTENERS
	-- -------------------------------------
	Runtime:addEventListener( "touch", onScreenTouch )
	Runtime:addEventListener( "enterFrame", move );
	
end

function scene:enterScene( event )
	local group = self.view
	-- Usado pra inicializar contadores, musicas, afins logo ao entrar na cena.
end

function scene:exitScene( event )
	local group = self.view
	-- Usado pra remover músicas, contadores e afins logo ao sair da cena.
end

function scene:destroyScene( event )
	local group = self.view
	-- Usado para remover do grupo "view" os audios, contadores e afins para liberarem memoria.
end

scene:addEventListener ("createScene", scene)
scene:addEventListener ("enterScene", scene)
scene:addEventListener ("exitScene", scene)
scene:addEventListener ("destroyScene", scene)

return scene