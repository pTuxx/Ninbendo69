local nin = require "nin69"
local basalt = require "basalt"

local conf = nin.readconf()

local mainFrame = basalt.createFrame()

local mainMon = basalt.createFrame("mainMon")
    :setMonitor(conf.side)
    :setBackground(colors.black)

local frame = mainFrame:addFrame()
    :setPosition(3,3)
    :setSize("parent.w - 4", "parent.h - 4")
    :setBorder(colors.black)
    
frame:addLabel()
    :setText(nin.name)
    :setSize("parent.w", 1)
    :setBackground(colors.black)
    :setForeground(colors.white)
    
local nogame = frame:addLabel()
    :setText("No Game")
    :setSize(7,1)
    :setBackground(colors.gray)
    :setForeground(colors.white)
    :setPosition("parent.w / 2 - 4", "parent.h / 2")

local nin69text = mainMon:addLabel()
    :setText("Ninbendo 69")
    :setPosition("parent.w / 2 - 6", "parent.h / 2 + 7")
    :setSize(11,1)
    :setBackground(colors.black)
    :setForeground(colors.white)

mainMon:addImage():loadImage("nin69/logo.nfp")
    :setPosition("parent.w / 2 - 9", "parent.h / 2 - 4")
    :setSize(17,7)

--[[
frame:addButton()
    :setText("/")
    :setAnchor("bottomRight")
    :setPosition(1,1)
    :setSize(1,1)
    :onDrag(function (self, button, x, y, xoffset, yoffset)
        local w, h = frame:getSize()
        if(w-xoffset>5)and(h-yoffset>3)then
            frame:setSize(-xoffset,-yoffset,true)
        end
    end)
]]--

local noDisk = true
local gameOpen = false

local function main()

    while true do
    
        if noDisk then
        
            if fs.exists("/disk/game.lua") then

                local game = require "/disk/game"

                local gameButton = frame:addButton("gameButton")
                    :setText(game.name)
                    :setSize(10,5)
                    :setBackground(colors.lightGray)
                    :setForeground(colors.white)
                    :setBorder(colors.black)
                    :setPosition("parent.w / 2 - 5", "parent.h / 2 - 2")                    

                gameButton:onClick(basalt.schedule(function(self,event,button,x,y)
                    if event == "mouse_click" and button==1 then
                        if gameOpen == false then
                            gameOpen = true
                            if tonumber(nin.url(game.versionUrl)) > tonumber(nin.readfile("/disk/version.txt")) then
                                fs.delete("/disk/game.lua")
                                fs.delete("/disk/version.txt")
                                nin.install(game.fileUrl, "/disk.game.lua")
                                nin.install(game.versionUrl, "/disk/version.txt")
                            end
                            game.run(nin.readconf())
                        elseif gameOpen == true then
                            gameOpen = false
                            mainMon:removeObject("gameFrame")
                        end
                    end
                end))

                nogame:hide()

                noDisk = false
            end
        
        else
            if fs.exists("/disk/game.lua") ~= true then

                mainMon:removeObject("gameFrame")
                frame:removeObject("gameButton")

                nogame:show()
                
                noDisk = true
            end
        end
    
        os.sleep(0.01)
        
    end

end

parallel.waitForAny(main, basalt.autoUpdate)