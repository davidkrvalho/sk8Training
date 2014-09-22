local storyboard = require ("storyboard")
local scene = storyboard.newScene ()

local function apertarBotao( event )
	storyboard.gotoScene (event.target.destination, {effect = "fade"})
	return true
end

function scene:createScene( event )
	local group = self.view
	local titulo = display.newText("New game", 0, 0, nil, 38)
	titulo.x = centerX
	titulo.y = display.screenOriginY+40
	group:insert(titulo)

	local start = display.newText ("Start Game", 0, 0, nil, 25)
	start.x = centerX
	start.y = centerY
	start.destination = "start"
	start:addEventListener ("tap", apertarBotao)
	group:insert(start)

	local instructionBtn = display.newText ("Instructions", 0, 0, nil, 25)
	instructionBtn.x = centerX
	instructionBtn.y = centerY + 40
	instructionBtn.destination = "instructions"
	instructionBtn:addEventListener ("tap", apertarBotao)
	group:insert(instructionBtn)

	local backBtn = display.newText("Voltar", 40, 0, nil, 25)
	backBtn.y = heightScn - backBtn.height
	backBtn.destination = "menu"
	backBtn:addEventListener ("tap", apertarBotao)
	group:insert(backBtn)
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