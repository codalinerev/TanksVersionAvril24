 scenes = {}

 sceneStart = love.graphics.newImage("assets/Ecranstart.png")
 sceneYouWin = love.graphics.newImage("assets/GOWin.png")
 sceneYouLost = love.graphics.newImage("assets/GOLost.png")
 
function drawGameOver()
    if MyTank.PV <= 0 then 
        love.graphics.draw(sceneYouLost, 20,20)
    else love.graphics.draw(sceneYouWin, 20, 20)
        love.graphics.print("score "..tostring(MyTank.PV), 400, 400)
    end 
    love.graphics.print("press p to play again", 300, 300)
end

