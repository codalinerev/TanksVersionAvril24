tank = {}


love.graphics.print(tostring(ScreenW), 500, 500)

--imgTurret = love.graphics.newImage("assets/tourelle.png)")

function tank:new(x, y, speed, angle, imgTank, imgTurret, type)
    
    local newt = {}
    newt.X = x 
    newt.Y = y 
    newt.dx = 0
    newt.dy = 0
    newt.speed = speed
    newt.angle = 0 --math.random(0,5) 
    newt.image = imgTank
    newt.time = 1
    newt.turretImg = imgTurret
    newt.turretImgH = newt.turretImg:getHeight()
    newt.turretImgW = newt.turretImg:getWidth()
    newt.W = newt.image:getWidth()
    newt.H = newt.image:getHeight()
    newt.offsetX = newt.W/2
    newt.offsetY = newt.H/2
    newt.type = type
    newt.rangeSee = 300
    newt.rangeTir = 200
    newt.state = "patrol"
    newt.cibleX = 500
    newt.cibleY = 400
    newt.text = "init"
    newt.PV = 10
    newt.id = 0
    newt.visible = true

    newt.FirePointX = newt.X + 20 + newt.turretImgW * math.cos(newt.angle)
    newt.FirePointY = newt.Y + 28 + newt.turretImgH/2 * math.sin(newt.angle)--*newt.H/2

    function newt:draw()
        love.graphics.draw(newt.image, newt.X, newt.Y)
        love.graphics.draw(newt.turretImg, newt.X + 25, newt.Y + 25, newt.angle, 1, 1, 5, 20)--newt.W/2, newt.H/2)
        --love.graphics.rectangle("line", newt.X, newt.Y, 60, 60)
        --love.graphics.rectangle("line", newt.X + 25, newt.Y + 25, 25, 25) --newt.turretImgW, newt.turretImgH)
    end

    function newt:move(dx, dy)
        newt.dx = dx
        newt.dy = dy
    end

    function newt.aim(x, y)
        local angle = math.atan2(math.sin(y - newt.Y), math.cos(x - newt.X))
        newt.FirePointX = newt.X + 25 + newt.turretImgW * math.cos(angle)
        newt.FirePointY = newt.Y + 25 + newt.turretImgH/2*math.sin(angle)--*newt.H/2
        newt.angle = angle
    end


    function newt:update(dt)
        
        if newt.onmap(newt.X + newt.dx + 20, newt.Y + newt.dy + 20 ) then 
            newt.X = newt.X + newt.dx
            newt.Y = newt.Y + newt.dy
            newt.text = tostring(newt.X)
            newt.FirePointX = newt.X + 25 + newt.turretImgW* math.cos(newt.angle)
            newt.FirePointY = newt.Y + 5 + newt.H/2*math.sin(newt.angle)--*newt.H/2
        else newt.angle = math.random(0, 5)
        end
        if newt.type == "hero" then 
            newt.dx = 0
            newt.dy = 0
            if love.keyboard.isDown("up") then newt.dy = -1 end
            if love.keyboard.isDown("down") then newt.dy = 1 end
            if love.keyboard.isDown("left") then newt.dx = -1 end
            if love.keyboard.isDown("right") then newt.dx = 1 end
            --local Cible = 
            local x,y = love.mouse.getPosition()
            --newt.aim(x, y)
            angle = math.atan2(math.sin(y - newt.Y), math.cos(x - newt.X))
            newt.FirePointX = newt.X + 25 + newt.turretImgW * math.cos(angle)
            newt.FirePointY = newt.Y + 25 + newt.turretImgH/2 * math.sin(angle)
            newt.angle = angle
            newt.text = tostring(x).."  "..tostring(y)
        end
    end

   

    function newt:tir(X, Y, angle)
        local bullet = {}
        bullet.X = X
        bullet.Y = Y 
        bullet.angle = angle
        bullet.type = newt.type
        bullet.speed = 4
        --bullet.speed = 4
        table.insert(listeBullets, bullet)
        --table.insert(listeSprites, bullet)
    end

   

    function newt.onmap(x, y)
        local on = true
        
        if x <= 0 or x > ScreenW or y <= 0 or y > ScreenH then on = false end
        return on
    end

    function newt.distCible(x, y)
        local dist = math.sqrt((newt.X - x)^2 + (newt.Y - y)^2)       
        return dist
    end

    function newt:damage(d)
        newt.pv = newt.pv - d
    end


    function newt.angleCible(x, y)
        local angle = math.atan2((y - newt.Y) , (x - newt.X))
        return angle
    end

    function newt:drawBullet()
        love.graphics.circle("fill", newt.FirePointX, newt.FirePointY, 5)
    end

    function newt:stateUpdate()
        if newt.state == "wander" then newt.angle = math.random(0, 5)
            newt.state = "patrol"

        elseif newt.state == "patrol" then  ------wander/patrol/follow/aim/shoot
            local dist = newt.distCible(newt.cibleX, newt.cibleY)
            if dist <= newt.rangeSee then newt.state = "attack"
                newt.angle = newt.angleCible(newt.cibleX, newt.cibleY)
             newt.dx = 1
             newt.dy = 1 
            end
             newt.text = newt.type

        end
    end



    return newt
end



return tank