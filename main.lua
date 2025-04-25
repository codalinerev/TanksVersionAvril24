require("initGame")
require("updateGame")
require("drawGame")
require("menuGameStart")
--require("sprite")
require("tank")
--require("sprites")
love.math.setRandomSeed(love.timer.getTime())
ScreenW = 1000
ScreenH = 800

function love.load() 
    initGame = initGame
    GameOver = false
end

function love.update(dt)
    if GameOver == false then
        updateGame = updateGame
        updateTankEnnemy()
        updateTankHero()
        updateTir()
        updatePV() 
    else choice = menuGameStart() 
        if choice == "play" then 
            initGame = initGame
            GameOver = false
        end       
    end

end

function love.draw()
    if GameOver == false then
        drawGame()
    else love.graphics.print("GAME OVER", 500, 400)
        if MyTank.PV > 0 then love.graphics.print("YOU WIN   PV HERO: "..tostring(MyTank.PV), 500, 650)
        else love.graphics.print("YOU LOSE    PV HERO: "..tostring(MyTank.PV), 500, 550)  end
    end
end
