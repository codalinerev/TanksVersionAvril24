 updateGame = {}
 require("initGame")
 require("tank")

 function updateTankEnnemy(dt)
    ValidEnnemies = 0
    for __,v in pairs(listeTE) do
        if v.PV > 0 then
            ValidEnnemies = ValidEnnemies + 1           
            v.cibleX = MyTank.X 
            v.cibleY = MyTank.Y
            local dist = v.distCible(v.cibleX, v.cibleY)

            ------v.stateUpdate() --wander/patrol/follow/shoot/changeDir
            if v.state == nil then v.state = "changeDir"
            elseif v.state == "changeDir" then 
                v.cibleX = math.random(50, 800)
                v.cibleY = math.random(50, 700)
                v.angle = v.angleCible(v.cibleX, v.cibleY)
                v.state = "patrol"
                v.dx = v.speed * math.cos(v.angle) * dt
                v.dy = v.speed * math.sin(v.angle) * dt
            elseif v.state == "patrol" then          
                if dist <= v.range then v.state = "follow"
                    v.time = 0
                    v.angle = v.angleCible(v.cibleX, v.cibleY)
                    v.dx = v.speed * math.cos(v.angle) * dt
                    v.dy = v.speed * math.sin(v.angle) * dt
                end
                v.text = v.state
             
            elseif v.state == "follow" then 
                if dist <= v.range and v.time >= 1 
                    then v.state = "shoot"
                        v.angle = v.angleCible(MyTank.X, MyTank.Y)
                        v:tir(v.FirePointX, v.FirePointY, v.angle)
                        v.text = "shoot"
                        v.time = 0
                elseif dist > v.range then v.state = "patrol"    
                end 
            elseif v.state == "shoot" then 
                v:tir(v.FirePointX, v.FirePointY, v.angle)          
                v.time = 0
                v.text = "shoot" 
                v.state = "follow"           
            end

            if v.onmap(v.X + v.dx + 20, v.Y + v.dy + 20 ) then 
                v.X = v.X + v.dx * dt
                v.Y = v.Y + v.dy * dt
                --v.text = tostring(v.X)
                v.FirePointX = v.X + 28 + v.turretImgW* math.cos(v.angle)
                v.FirePointY = v.Y + 22 + v.turretImgH/2*math.sin(v.angle)--*v.H/2
            else ----respawn personnalisé si collision avec le bord d'écran
                v.X = 100 + 600 * v.id%2
                v.Y = 150 * v.id
                v.state = "changeDir"
                v.cibleX = 400
                v.cibleY = 200
            end
            v.time = v.time + dt
        end
    end
end

function updateTankHero(dt)
    MyTank.dx = 0
    MyTank.dy = 0
    if love.keyboard.isDown("up") then MyTank.dy = -1 end
    if love.keyboard.isDown("down") then MyTank.dy = 1 end
    if love.keyboard.isDown("left") then MyTank.dx = -1 end
    if love.keyboard.isDown("right") then MyTank.dx = 1 end
    local x,y = love.mouse.getPosition()
    MyTank.cibleX = x 
    MyTank.cibleY = y 
    MyTank.angle = math.atan2(y - MyTank.Y, x - MyTank.X)
    MyTank.FirePointX = MyTank.X + 22 + MyTank.turretImgW * math.cos(MyTank.angle)
    MyTank.FirePointY = MyTank.Y + 28 + MyTank.turretImgH/2 * math.sin(MyTank.angle)
    if love.keyboard.isDown("space") and MyTank.time > 0.6 then 
        --love.audio.play(soundTir)
        MyTank:tir(MyTank.FirePointX, MyTank.FirePointY, MyTank.angle)
        MyTank.time = 0
    end
    --MyTank.text = tostring(MyTank.X).."  "..tostring(MyTank.Y)
    MyTank.X = MyTank.X + MyTank.dx * MyTank.speed * dt
    MyTank.Y = MyTank.Y + MyTank.dy * MyTank.speed * dt
    MyTank.time = MyTank.time + dt
    --if MyTank.PV <= 0 then GameOver = true end
end

function updatePV()
    
    if GameOver == false then 
        for i,v in ipairs(listeSprites) do
            if v.visible == true and v.PV <= 0 then 
                love.audio.play(soundExplosion)
                v.visible = false            
            end
        end
    end
    if ValidEnnemies <= 0 then GameOver = true end
    if MyTank.PV <= 0 then GameOver = true end
end

function updateTir(dt) ----
    for j,b in pairs(listeBullets) do
        b.X = b.X + b.speed * math.cos(b.angle) * dt
        b.Y = b.Y + b.speed * math.sin(b.angle) * dt
        for _,v in pairs(listeSprites) do
            if v.visible == true and collideTir(b,v) then v.PV = v.PV - 1 
                table.remove(listeBullets, j)
                --love.audio.play(soundTir)
            --v.text = "collision" 
            end
        end
    end
end

function collideTir(b, v)
    local collision = false
    local dist = math.sqrt((b.X - v.X + 25)^2 + (b.Y - v.X + 25)^2) 
    if dist <= 35 then collision = true end
    return collision
end

function updateGameOver()
    if MyTank.PV <= 0 or ValidEnnemies <= 0 then
        GameOver = true
        if MyTank.PV >= 0 then GameOverText = "WIN"
        else GameOverText = "LOSE" 
        end
    end

end

