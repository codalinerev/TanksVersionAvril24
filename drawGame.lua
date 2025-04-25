require("updateGame")
require("initGame")
--drawGame = {}
setColorDanger = {(0.9), (0.1), (0.1)}

function drawGame()
    -- function drawTir(liste) ----x, y, angle, type
    --     for _,v in liste do
    --         love.graphics.circle("fill", v.X, v.Y)
    --     end

    -- end
    for __,v in pairs(listeSprites) do
        if v.visible == true then v:draw() 
        --v:drawBullet()
        
        love.graphics.print(v.text, v.X + 20, v.Y - 30)
        love.graphics.print("PV  "..tostring(v.PV), v.X - 10, v.Y - 40)
        love.graphics.print(v.state, v.X + 20, v.Y - 10)
        --love.graphics.print(tostring(v.W), v.X + 20, v.Y - 10)
        end
    end
    for _,b in pairs(listeBullets) do
        love.graphics.circle("fill", b.X, b.Y, 5)
    end

    for i, v in pairs(listeSprites) do
        
        --love.graphics.push() 
        --if v.PV <= 5 then  love.graphics.setColor(setColorDanger)  end  
        love.graphics.print(tostring(v.type)..tostring(v.id) .. " PV "..tostring(v.PV), 850, 100 * i)
        if v.PV >= 0 then 
            love.graphics.rectangle("line", 850, 100 * i + 30, 100, 10)
            love.graphics.rectangle("fill", 850, 100 * i + 30, 10*v.PV, 10)
        end
        --love.graphics.pop()
    end
    love.graphics.print("GameOver: "..tostring(GameOver), 800, 40)
    
end