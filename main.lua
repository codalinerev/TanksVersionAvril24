require("initGame")
require("updateGame")
require("drawGame")
require("tank")
require("scenes")
love.math.setRandomSeed(love.timer.getTime())
ScreenW = 1000
ScreenH = 800

scenes = scenes ---- "Play", "End"

function love.load() 
    initGame() --- module init jeu---------------
    GameOver = false 
    scene = "Start"
end

function love.update(dt)

    if scene == "Play" and GameOver == false then
        updateGame = updateGame -----module update Game --------
        updateTankEnnemy(dt)
        updateTankHero(dt)
        updateTir(dt)
        updatePV(dt) 
        updateGameOver(dt)
    elseif scene == "Start" then
        initGame() ------ début du jeu---------------------------
        GameOver = false
    end
end

function love.draw()
    if (scene == "Play" or scene == "Pause") and GameOver == false then
        drawGame()        
    elseif scene == "Play" and GameOver == true then
        scene = "End"
    elseif scene == "Start" then 
        love.graphics.draw(sceneStart, 10, 10) 
    elseif scene == "End" then 
        drawGameOver() 
    end
end

function love.keypressed(key)
    if (scene == "Start"  or scene == "Pause") and key == "p" then scene = "Play" 
    elseif scene == "Play" and key == "p" then scene = "Pause"
    elseif scene == "End" and key == "p" then 
        scene = "Start" 
        GameOver = false
    end
end

