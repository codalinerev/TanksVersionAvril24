require("initGame")
require("updateGame")
require("drawGame")
--require("sprite")
require("tank")
--require("sprites")
love.math.setRandomSeed(love.timer.getTime())
ScreenW = 1000
ScreenH = 800

function love.load() 
    initGame = initGame
end

function love.update(dt)
    updateGame = updateGame
    updateTankEnnemy()
    updateTankHero()
    updateTir()
    updatePV()
end

function love.draw()
    drawGame()
end
