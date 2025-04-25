 function menuGameStart()
    input = ""

    if love.keyboard.isDown("p") then input = "play"
    elseif love.keyboard.isDown("x") then input = "quit"
    end
    return input
end


