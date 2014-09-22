local storyboard = require ("storyboard")
local scene = storyboard.newScene()

local function apertarBotao( event )
	storyboard.gotoScene (event.target.destination, {effect = "fade"})
	return true
end

function scene:createScene( event )
	local group = self.view

	local titulo = display.newText("Sk8 Training", 0, 0, nil, 38)
	titulo.x = centerX
	titulo.y = display.screenOriginY+40
	group:insert(titulo)

	local playBtn = display.newText("New game", 0, 0, nil, 25)
	playBtn.x = centerX
	playBtn.y = centerY
	playBtn.destination = "newgame"
	playBtn:addEventListener ("tap", apertarBotao)
	group:insert(playBtn)

	local creditsBtn = display.newText("Credits", 0, 0, nil, 25)
	creditsBtn.x = centerX
	creditsBtn.y = centerY + 40
	creditsBtn.destination = "gamecredits"
	creditsBtn:addEventListener("tap", apertarBotao)
	group:insert(creditsBtn)
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