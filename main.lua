require("initGame")
require("updateGame")
require("drawGame")
require("tank")
sceneStart = love.graphics.newImage("assets/Ecranstart.png")
sceneYouWin = love.graphics.newImage("assets/EcranYouWin.png")
sceneYouLost = love.graphics.newImage("assets/EcranYouLost.png")
love.math.setRandomSeed(love.timer.getTime())
ScreenW = 1000
ScreenH = 800

GameOverText = "PLAY" ---"WIN", "LOSE"
DebugText = "rien"
scene = "Start" ---- "Play", "End"

function love.load() 
    initGame = initGame
    GameOver = false
    --DebugText = DebugText.."init" 
end

function love.update(dt)

    if scene == "Play" and GameOver == false then
        updateGame = updateGame
        updateTankEnnemy()
        updateTankHero()
        updateTir()
        --updatePV() 
        updateGameOver()
        --DebugText = DebugText.." updateLoop"    
    end
end

function love.draw()
    --love.graphics.print(DebugText, 10, 10)
    if scene == "Play" and GameOver == false then
        drawGame() 
        --DebugText = DebugText.."drawGOFalse "
        
    else 
        if scene == "Start" then 
            love.graphics.draw(sceneStart, 10, 10) 
            love.graphics.print("Start", 500, 400)
        elseif scene == "Play" then drawGame()
        end 
        love.graphics.print("GAME OVER", 500, 400)
        -- love.graphics.print(GameOverText, 510, 550)      
        -- DebugText = DebugText.."drawGOTrue"
        
    end
end

function love.keypressed(key)
    if scene == "Start" and key == "p" then scene = "Play"  end
    if scene == "End" and key == "p" then scene = "Play" end
end

