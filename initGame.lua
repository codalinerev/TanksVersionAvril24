initGame = {}
require("tank")
imgTank = love.graphics.newImage("assets/tankP.png")
imgCarreJaune = love.graphics.newImage("assets/carreJaune.png")
imgTurret = love.graphics.newImage("assets/tourelle2.png")
imgChenilles = love.graphics.newImage("assets/chenilles.png")
soundExplosion = love.audio.newSource("assets/explosion.wav", "static")
soundTir = love.audio.newSource("assets/bruit.wav", "static")

love.window.setMode(1000, 800)
love.graphics.setBackgroundColor(0.3, 0.5, 0.5)

love.graphics.print("init game", 100, 100)
-----tank:new(x, y, speed, angle, imgTank, imgTurret, type)

Tank = tank
MyTank = Tank:new(950, 800, 2, 0, imgTank, imgTurret, "hero") 
MyTank.PV = 100

--MyTank.cibleX, MyTank.cibleY = love.mouse.getPosition()

listeSprites = {}
table.insert(listeSprites, MyTank)
listeTE = {}
listeBullets = {}

for i = 1, 4 do
    local tankE = {}
    tankE = Tank:new( (i%2 + 1) * 400,(i%2 + 1 ) * 200 + 100, 0.3, 0, imgCarreJaune, imgTurret, "ennemy")
    tankE.time = math.random(2, 7)
    tankE.id = i
    tankE.speed = 0.2 * i
    table.insert(listeTE, tankE)
    table.insert(listeSprites, tankE)
end




 
