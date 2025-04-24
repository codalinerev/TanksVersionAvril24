require("updateGame")
require("initGame")
--drawGame = {}

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
    
        love.graphics.print(tostring(v.type)..tostring(v.id) .. " PV "..tostring(v.PV), 900, 50 * i)
    end
    
end