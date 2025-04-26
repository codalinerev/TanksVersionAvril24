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
    initGame()
    GameOver = false
    scene = "Start"
end

function love.update(dt)

    if scene == "Play" and GameOver == false then
        updateGame = updateGame
        updateTankEnnemy(dt)
        updateTankHero(dt)
        updateTir(dt)
        updatePV(dt) 
        updateGameOver(dt)
    elseif scene == "Start" then
        initGame()
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
        --love.graphics.print("Start", 500, 400) 
        --love.graphics.print("GAME OVER", 500, 600) 
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

