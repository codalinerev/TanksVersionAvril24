function initGame()
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
    MyTank = Tank:new(450, 400, 500, 0, imgTank, imgTurret, "hero") 
    MyTank.PV = 30


    listeSprites = {}
    table.insert(listeSprites, MyTank)
    listeTE = {}
    listeBullets = {}

    for i = 1, 4 do -----spawn des ennemies 4 positions 
        local tankE = {}
        tankE = Tank:new( (i%2 + 1) * i * 100,(i%2 + 1 ) * 200 + 100, 0.3, 0, imgCarreJaune, imgTurret, "ennemy")
        tankE.time = math.random(2, 7)
        tankE.id = i
        tankE.speed = 350 + 50 * i
        table.insert(listeTE, tankE)
        table.insert(listeSprites, tankE)
    end
end




 
