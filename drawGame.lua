require("updateGame")
require("initGame")

function drawGame()

    for __,v in pairs(listeSprites) do
        if v.visible == true then v:draw()    
        love.graphics.print("PV  "..tostring(v.PV), v.X - 10, v.Y - 40)
        end
    end
    for _,b in pairs(listeBullets) do
        love.graphics.circle("fill", b.X, b.Y, 5)
    end
    love.graphics.print("Hero PV "..tostring(MyTank.PV), 850, 80 ) 
    love.graphics.rectangle("line", 850, 100, 100, 20)
    love.graphics.rectangle("fill", 850, 100, MyTank.PV, 20)  
    for i, v in pairs(listeTE) do 
        love.graphics.print(tostring(v.type)..tostring(v.id) .. " PV "..tostring(v.PV), 850, 80 * i + 110)
        love.graphics.rectangle("line", 850, 80 * i + 130, 100, 10)
        if v.PV >= 0 then            
            love.graphics.rectangle("fill", 850, 80 * i + 130, 10*v.PV, 10)
        end
    end
    --love.graphics.print("GameOver: "..tostring(GameOver), 800, 40)
    
    
end