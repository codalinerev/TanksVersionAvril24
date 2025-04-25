 updateGame = {}
 require("initGame")
 require("tank")
 ZoneSpoonX = 200
 ZoneSpoonY = 150

 function updateTankEnnemy()
    ValidEnnemies = 0
    for __,v in pairs(listeTE) do
        if v.visible == true then
            ValidEnnemies = ValidEnnemies + 1
            v.cibleX = MyTank.X 
            v.cibleY = MyTank.Y 
            --v.angle = v.angleCible(v.cibleX, v.cibleY)
            local dist = v.distCible(v.cibleX, v.cibleY)
            --v.stateUpdate() --wander/patrol/follow/shoot/nil/changeDir
            v.dx = v.speed * math.cos(v.angle)
            v.dy = v.speed * math.sin(v.angle)
        
            if v.state == nil then v.state = "changeDir"
            elseif v.state == "changeDir" then 
                v.cibleX = math.random(50, 800)
                v.cibleY = math.random(50, 700)
                v.angle = v.angleCible(v.cibleX, v.cibleY)
                v.state = "patrol"
                v.dx = v.speed * math.cos(v.angle)
                v.dy = v.speed * math.sin(v.angle) 
            elseif v.state == "patrol" then  ------wander/patrol/follow/aim/shoot/changeDir          
                if dist <= v.rangeSee then v.state = "follow"
                    v.time = 0
                    v.angle = v.angleCible(v.cibleX, v.cibleY)
                    v.dx = v.speed * math.cos(v.angle)
                    v.dy = v.speed * math.sin(v.angle)
                end
                v.text = v.state
             
            elseif v.state == "follow" then 
                if dist <= v.rangeTir and v.time >= 1 
                    then v.state = "shoot"
                        v.angle = v.angleCible(v.cibleX, v.cibleY)
                        v:tir(v.X, v.Y, v.angle)
                        v.text = "shoot"
                        v.time = 0
                elseif dist > v.rangeSee then v.state = "changeDir"    
                end 
            elseif v.state == "shoot" then 
                    if v.time >= 2 then 
                        v.state = "follow"
                        v.time = 0
                    end
            v.text = "shoot"            
            end

            if v.onmap(v.X + v.dx + 20, v.Y + v.dy + 20 ) then 
                v.X = v.X + v.dx
                v.Y = v.Y + v.dy
                v.text = tostring(v.X)
                v.FirePointX = v.X + 28 + v.turretImgW* math.cos(v.angle)
                v.FirePointY = v.Y + 22 + v.turretImgH/2*math.sin(v.angle)--*v.H/2
            else 
                v.X = 100 + 600 * v.id%2
                v.Y = 150 * v.id
                v.state = "changeDir"
                v.cibleX = 400
                v.cibleY = 200
            end
            v.time = v.time + 1/60
        end
    end
end

function updateTankHero()
    MyTank.dx = 0
    MyTank.dy = 0
    if love.keyboard.isDown("up") then MyTank.dy = -1 end
    if love.keyboard.isDown("down") then MyTank.dy = 1 end
    if love.keyboard.isDown("left") then MyTank.dx = -1 end
    if love.keyboard.isDown("right") then MyTank.dx = 1 end
    --local Cible = 
    local x,y = love.mouse.getPosition()
    MyTank.cibleX = x 
    MyTank.cibleY = y 
    --MyTank.aim(x, y)
    MyTank.angle = math.atan2(y - MyTank.Y, x - MyTank.X)
    MyTank.FirePointX = MyTank.X + 22 + MyTank.turretImgW * math.cos(MyTank.angle)
    MyTank.FirePointY = MyTank.Y + 28 + MyTank.turretImgH/2 * math.sin(MyTank.angle)
    if love.keyboard.isDown("space") then 
        love.audio.play(soundTir)
        MyTank:tir(MyTank.FirePointX, MyTank.FirePointY, MyTank.angle)
    end
    MyTank.text = tostring(MyTank.X).."  "..tostring(MyTank.Y)
    MyTank.X = MyTank.X + MyTank.dx
    MyTank.Y = MyTank.Y + MyTank.dy
end

function updatePV()
    if ValidEnnemies <= 0 then GameOver = true
    for i,v in ipairs(listeSprites) do
        if v.visible == true and v.PV >= 0 then 
            GameOver = false
        elseif v.visible == true and v.PV < 0 then 
            love.audio.play(soundExplosion)
            --table.remove(listeSprites, i)
            v.visible = false            
        end
    end
end

function updateTir() ----X,Y,angle,type, speed=4
    for _,b in pairs(listeBullets) do
        b.X = b.X + 2 * math.cos(b.angle)
        b.Y = b.Y + 2 * math.sin(b.angle)
        for _,v in pairs(listeSprites) do
            if v.visible == true and collideTir(b,v) then v.PV = v.PV - 1 
            --v.text = "collision" end
        end
    end

end

function collideTir(b, v)
    local collision = false
    local dist = math.sqrt((b.X - v.X - 25)^2 + (b.Y - v.X - 25)^2) 
    if dist <= 25 then collision = true end
    return collision
end

function updateState()
end

