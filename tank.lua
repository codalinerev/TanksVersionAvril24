tank = {}

function tank:new(x, y, speed, angle, imgTank, imgTurret, type)
    
    local newt = {}
    newt.X = x 
    newt.Y = y 
    newt.dx = 1
    newt.dy = 1
    newt.speed = speed
    newt.angle = 0 --math.random(0,5) 
    newt.image = imgTank
    newt.time = 0
    newt.turretImg = imgTurret
    newt.turretImgH = newt.turretImg:getHeight()
    newt.turretImgW = newt.turretImg:getWidth()
    newt.W = newt.image:getWidth()
    newt.H = newt.image:getHeight()
    newt.offsetX = newt.W/2
    newt.offsetY = newt.H/2
    newt.type = type
    newt.range = 300
    newt.state = "patrol"
    newt.cibleX = 500
    newt.cibleY = 400
    newt.text = "init"
    newt.PV = 10
    newt.id = 0
    newt.visible = true

    newt.FirePointX = newt.X + 20 + newt.turretImgW * math.cos(newt.angle)
    newt.FirePointY = newt.Y + 28 + newt.turretImgH/2 * math.sin(newt.angle)

    function newt:draw()
        love.graphics.draw(newt.image, newt.X, newt.Y)
        love.graphics.draw(newt.turretImg, newt.X + 25, newt.Y + 25, newt.angle, 1, 1, 5, 20)
      
    end

    function newt.aim(x, y)
        local angle = math.atan2(math.sin(y - newt.Y), math.cos(x - newt.X))
        newt.FirePointX = newt.X + 25 + newt.turretImgW * math.cos(angle)
        newt.FirePointY = newt.Y + 25 + newt.turretImgH/2*math.sin(angle)
        newt.angle = angle
    end

    function newt:newPositionX(dx)
        local x = dx + newt.X
        return x
    end

    function newt:newPositionY(dy)
        local y = dy + newt.Y
        return y
    end


    function newt:update(dt)
        
        if newt.onmap(newt.X + newt.dx * dt + 20, newt.Y + newt.dy * dt + 20 ) then 
            newt.X = newt.X + newt.dx * dt
            newt.Y = newt.Y + newt.dy * dt
            newt.text = tostring(newt.X)
            newt.FirePointX = newt.X + 25 + newt.turretImgW* math.cos(newt.angle)
            newt.FirePointY = newt.Y + 5 + newt.H/2*math.sin(newt.angle)
        else newt.angle = math.random(0, 5)
        end
        if newt.type == "hero" then 
            newt.dx = 0
            newt.dy = 0
            if love.keyboard.isDown("up") then newt.dy = -1 end
            if love.keyboard.isDown("down") then newt.dy = 1 end
            if love.keyboard.isDown("left") then newt.dx = -1 end
            if love.keyboard.isDown("right") then newt.dx = 1 end
           
            local x,y = love.mouse.getPosition()
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
        bullet.speed = 400
        table.insert(listeBullets, bullet)
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

    function newt.angleCible(x, y)
        local angle = math.atan2((y - newt.Y) , (x - newt.X))
        return angle
    end

    function newt:drawBullet()
        love.graphics.circle("fill", newt.FirePointX, newt.FirePointY, 5)
    end

    return newt
end

return tank