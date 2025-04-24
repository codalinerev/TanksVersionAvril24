
function SpritesUpdate()

    for __,v in pairs(listeSprites) do
        if v.time >= 0 then
            v.time = v.time - 0.01
            v.X = v.X + v.speed * math.cos(v.angle)
            v.Y = v.Y + v.speed * math.sin(v.angle)
        end

    end
end
