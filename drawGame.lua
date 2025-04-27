require("updateGame")
require("initGame")

function drawGame()
   ----- dessine tous les tanks , héro et ennemis
    for __,v in pairs(listeSprites) do
        if v.visible == true then 
            v:draw() 
            if v.type == "ennemy" then 
                love.graphics.print(tostring(v.id), v.X, v.Y-15) 
                love.graphics.print(v.text, v.X, v.Y) 
            end
        end
    end
    ---- dessine les balles
    for _,b in pairs(listeBullets) do
        love.graphics.circle("fill", b.X, b.Y, 5)
    end
    love.graphics.print("Hero PV "..tostring(MyTank.PV), 850, 80 ) 
    love.graphics.rectangle("line", 850, 100, 100, 20)
    love.graphics.rectangle("fill", 850, 100, MyTank.PV * 3, 20)  
    
    ---- affiche la barre d'état et les PV
    for i, v in pairs(listeTE) do 
        love.graphics.print(tostring(v.type)..tostring(v.id) .. " PV "..tostring(v.PV), 850, 80 * i + 110)      
        if v.PV >= 0 and v.visible == true then 
            love.graphics.print(tostring(v.id), v.X, v.Y)           
            love.graphics.rectangle("line", 850, 80 * i + 130, 100, 10)     
            love.graphics.rectangle("fill", 850, 80 * i + 130, 10*v.PV, 10)
        else love.graphics.print("destroyed", 850, 80 * i + 130)  
        end        
    end

    ---option de pause
    love.graphics.print("Press p for pause", 850, 700)  
    if scene == "Pause" then love.graphics.print("PAUSED", 850, 600)  end
end