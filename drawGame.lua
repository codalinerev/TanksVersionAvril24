require("updateGame")
require("initGame")

function drawGame()

    for __,v in pairs(listeSprites) do
        if v.visible == true then 
            v:draw() 
            if v.type == "ennemy" then 
                love.graphics.print(tostring(v.id), v.X, v.Y) 
                love.graphics.print(v.text, v.X, v.Y) 
            end
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
        if v.PV >= 0 and v.visible == true then 
            love.graphics.print(tostring(v.id), v.X, v.Y)           
            love.graphics.rectangle("line", 850, 80 * i + 130, 100, 10)     
            love.graphics.rectangle("fill", 850, 80 * i + 130, 10*v.PV, 10)
        else love.graphics.print("destroyed", 850, 80 * i + 130)  
        end        
    end
    love.graphics.print("Press p for pause", 900, 700)    
end