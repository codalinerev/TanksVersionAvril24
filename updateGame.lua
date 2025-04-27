 updateGame = {}
 require("initGame")
 require("tank")

---- machine à état des ennemis:    "patrol/follow/shoot/changeDir"
 function updateTankEnnemy(dt)
---- on compte les ennemis valides en ValidEnnemies  
    ValidEnnemies = 0
    for __,v in pairs(listeTE) do
        if v.PV > 0 then
            ValidEnnemies = ValidEnnemies + 1           
            ---- distance jusqu'au héro
            local dist = v.distCible(MyTank.X, MyTank.Y)       
            --- debug:
            if v.state == nil then v.state = "changeDir"            
            ---"changeDir": au début du jeu ou quand le héro est perdu de vue---
            ----            ou timer dépassé------------------------------------   
            elseif v.state == "changeDir" then 
                v.cibleX = math.random(50, 800)
                v.cibleY = math.random(50, 700)
                v.angle = v.angleCible(v.cibleX, v.cibleY)
                v.state = "patrol"
                v.time = 0

            --- "patrol": cherche le héro pendant 3s: sinon, à nouveau changeDir---
            --- si le héro a été trouvé dans la portée, passage au "follow"
            elseif v.state == "patrol" then          
                if dist <= v.range then v.state = "follow"
                    v.time = 0
                    v.angle = v.angleCible(MyTank.X, MyTank.Y)
                elseif v.time > 3 then v.state = "changeDir"    
                end
                v.text = v.state --- util pour debug
             
            ---"follow" cible suivi pendant 1s avant de tirer
            --- si cible perdue: repassage en mode "patrol" , garde la même direction    
            elseif v.state == "follow" then 
                if dist <= v.range and v.time >= 1 
                    then v.state = "shoot"
                        v.angle = v.angleCible(MyTank.X, MyTank.Y)
                        --v:tir(v.FirePointX, v.FirePointY, v.angle)
                        --v.text = "shoot"
                        --v.time = 0
                elseif dist > v.range then v.state = "patrol"    
                end 

            --- "shoot" tire sur la cible, puis passage en mode "follow"    
            elseif v.state == "shoot" then 
                v:tir(v.FirePointX, v.FirePointY, v.angle)          
                v.time = 0
                --v.text = "shoot" 
                v.state = "follow"           
            end

            v.dx = v.speed * math.cos(v.angle) * dt
            v.dy = v.speed * math.sin(v.angle) * dt
            posX = v:newPositionX(v.dx, v.angle, dt) 
            posY = v:newPositionY(v.dy, v.angle, dt) 

            --- test si la nouvelle position sort de l'écran:
            --- sinon: update position et update FirePoint
            --- si oui: changeDir
            if v.onmap(posX, posY) then
                v.X = posX
                v.Y = posY               
                v.FirePointX = v.X + 28 + v.turretImgW* math.cos(v.angle)
                v.FirePointY = v.Y + 22 + v.turretImgH/2*math.sin(v.angle)--*v.H/2
            else
                 ----respawn personnalisé si collision avec le bord d'écran
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

---- update héro----------
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
    if love.keyboard.isDown("space") and MyTank.time > 0.3 then 
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
            ----- test si le sprite est détruit--------
            if v.visible == true and v.PV <= 0 then 
                love.audio.play(soundExplosion)
                v.visible = false            
            end
        end
    end
    if ValidEnnemies <= 0 then GameOver = true end
    if MyTank.PV <= 0 then GameOver = true end
end

---- Teste pour chaque balle et sa position actualisée si elle touche un sprite.
---- Le soundTir est désactivé dans cette version; play au moment de la collision;
---- la balle explose à l'impact (enlevée de la listeBullets).
---- Le text "collision" a servi au debugage.
function updateTir(dt) ----
    j = #listeBullets
    for k = j, 1, -1 do
        b = listeBullets[k]
        
        for _,v in pairs(listeSprites) do
            if v.visible == true and collideTir(b,v) then v.PV = v.PV - 1 
                table.remove(listeBullets, k)
                --love.audio.play(soundTir)
            --v.text = "collision" 
            end
        end
        b.X = b.X + b.speed * math.cos(b.angle) * dt
        b.Y = b.Y + b.speed * math.sin(b.angle) * dt
    end
end

----teste collision entre la balle b et le sprite v
function collideTir(b, v)
    local collision = false
    local dist = math.sqrt((b.X - v.X - 25)^2 + (b.Y - v.Y - 25)^2) 
    if dist <= 30 then collision = true end
    return collision
end

---   si le héro n'a plus de vies ou si tous les ennemies sont détruits,
----- GameOver devient "true"
----- la variable GameOverText contient "win" ou "lose"
function updateGameOver()
    if MyTank.PV <= 0 or ValidEnnemies <= 0 then
        GameOver = true
        if MyTank.PV >= 0 then GameOverText = "WIN"
        else GameOverText = "LOSE" 
        end
    end

end

