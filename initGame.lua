function initGame()
    require("tank")
    --- chargement des assets images et sons--------
    imgTank = love.graphics.newImage("assets/tankP.png")
    imgCarreJaune = love.graphics.newImage("assets/carreJaune.png")
    imgTurret = love.graphics.newImage("assets/tourelle2.png")
    imgChenilles = love.graphics.newImage("assets/chenilles.png")
    soundExplosion = love.audio.newSource("assets/explosion.wav", "static")
    soundTir = love.audio.newSource("assets/bruit.wav", "static")

   
    love.graphics.setBackgroundColor(0.3, 0.5, 0.5)

    love.graphics.print("init game", 100, 100)
    -----tank:new(x, y, speed, angle, imgTank, imgTurret, type)

    Tank = tank
    -----création du hero ------------------------
    MyTank = Tank:new(450, 400, 500, 0, imgTank, imgTurret, "hero") 
    MyTank.PV = 30
    ------ initialise les 3 listes des sprites, des ennemis, des balles-----------
    listeSprites = {}
    table.insert(listeSprites, MyTank)
    listeTE = {}
    listeBullets = {}

    ----- création de 4 ennemis spawn dans 4 positions-------
    ----- id , time, speed différent ------------------------
    for i = 1, 4 do
        local tankE = {}
        tankE = Tank:new( (i%2 + 1) * i * 100,(i%2 + 1 ) * 200 + 100, 3, 0, imgCarreJaune, imgTurret, "ennemy")
        tankE.id = i
        tankE.range = 200 + i* 50
        tankE.speed = 70 + 30 * i
        table.insert(listeTE, tankE)
        table.insert(listeSprites, tankE)
    end
end




 
