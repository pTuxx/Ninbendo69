local name = "Pong"
local fileUrl = "https://raw.githubusercontent.com/pTuxx/Ninbendo69/main/games/pong.lua"
local versionUrl = "https://raw.githubusercontent.com/pTuxx/Ninbendo69/main/versions/games/pong.txt"

local function run(conf)

    local basalt = require "basalt"
    
    local nin = require "nin69"
    
    local main = basalt.getFrame("mainMon")
        
    local frame = main:addFrame("gameFrame")
        :setPosition(3,3)
        :setSize("parent.w - 4", "parent.h - 4")
        :setBackground(colors.black)
        :setBorder(colors.white)

    local startScreen = frame:addLabel()
        :setSize(20,1)
        :setPosition("parent.w / 2 - 10","parent.h / 2")
        :setText("Press Enter to Start")
        :setBackground(colors.black)
        :setForeground(colors.white)
        
    local paddle1 = frame:addLabel()
        :setPosition(3,"parent.h / 2 - 1")
        :setSize(2,4)
        :setText(" ")
        :setBackground(colors.white)
        :hide()
        
    local paddle2 = frame:addLabel()
        :setPosition("parent.w - 2","parent.h / 2 - 1")
        :setSize(2,4)
        :setText(" ")
        :setBackground(colors.white)
        :hide()
        
    local middleLine = frame:addLabel()
        :setPosition("parent.w / 2", 1)
        :setSize(1, "parent.h")
        :setText(" ")
        :setBackground(colors.white)
        :hide()
        
    local ball = frame:addLabel()
        :setPosition("parent.w - 5","parent.h / 2")
        :setSize(1,1)
        :setText(" ")
        :setBackground(colors.white)
        :hide()

    local deathScreen = frame:addLabel()
        :setSize(9,1)
        :setPosition("parent.w / 2 - 4","parent.h / 2")
        :setText("You Died!")
        :setBackground(colors.black)
        :setForeground(colors.white)
        :hide()

    local winScreen = frame:addLabel()
        :setSize(9,1)
        :setPosition("parent.w / 2 - 4","parent.h / 2")
        :setText("You Won!")
        :setBackground(colors.black)
        :setForeground(colors.white)
        :hide()
    
    local xDir = -1
    local yDir = -1
    local running = false

    parallel.waitForAny(function()
        nin.onKey(0.01, conf.port, function(senderID, message, protocol)

            if running == true then
                local x,y = paddle1:getPosition()
        
                if message == "w" then
                    y = y - 1
                elseif message == "s" then
                    y = y + 1
                end
        
                if y > 0 and y < 18 then
            
                    paddle1:setPosition(x,y)
            
                end
            elseif message == "enter" then
                ball:show()
                paddle1:show()
                paddle2:show()
                middleLine:show()
                startScreen:hide()
                winScreen:hide()
                deathScreen:hide()

                paddle1:setPosition(3,"parent.h / 2 - 1")
                paddle2:setPosition("parent.w - 2","parent.h / 2 - 1")
                ball:setPosition("parent.w - 5","parent.h / 2")

                xDir = -1
                yDir = -1

                running = true
            end
        end)
    end, function()
        nin.fixedUpdate(0.1, function(time)

            local framesx, framesy = ball:getSize()
            local ballx,bally = ball:getPosition()
            local paddle2x,paddle2y = paddle2:getPosition()
            local paddle1x,paddle1y = paddle1:getPosition()

            if running == true then
        
                if ballx <= 0 or ballx >= 54 then

                    if ballx <= 0 then
                        deathScreen:show()
                    elseif ballx >= framesx then
                        winScreen:show()
                    end

                    ball:hide()
                    paddle1:hide()
                    paddle2:hide()
                    middleLine:hide()

                    running = false
                end
        
                if bally == 1 then
                    yDir = 1
                elseif bally == 20 then
                    yDir = -1
                end

                if bally >= paddle1y and bally <= paddle1y + 3 and ballx == paddle1x + 2 then
                    xDir = 1
                end

                if bally >= paddle2y and bally <= paddle2y + 3 and ballx == paddle2x - 1 then
                    xDir = -1
                end

                ball:setPosition(ballx + xDir,bally + yDir)
            
                if (bally - 3) >= 0 and (bally - 3) < 17 then

                    paddle2:setPosition(paddle2x, bally - 2)
            
                end
        
            end

        end)
    end)
end

return { run = run, name = name, fileUrl = fileUrl, versionUrl = versionUrl }