local Sprite = {}

--Sprite.__index = Sprite

function Sprite.createSprite(x, y, img)
    local self = setmetatable ({}, Sprite)
    self.X = x 
    self.Y = y 
    self.dx = 0
    self.dy = 0
    self.angle = 0
    --self.cible = {x=100, y=100}
    --self.type = "ennemy"
    --self.state = "wander"
    self.visible = true 
    self.offset = {x = self.X, y = self.Y}
    self.image = img
    self.W = self.img:getWidth()
    self.H = self.image:getHeight()
    return self 
end

function Sprite:move(dx, dy)
    Sprite.dx = dx
    Sprite.dy = dy 
end

function Sprite:draw()
end

function Sprite:update()
    for __,v in pairs(listeSprites) do
    if v.time >= 0 then
        v.time = v.time - 0.01
        v.X = v.X + v.speed * math.cos(v.angle)
        v.Y = v.Y + v.speed * math.sin(v.angle)
    end
end

end

return Sprite

