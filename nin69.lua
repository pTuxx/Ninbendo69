local folder = "nin69"
local name = "Ninbendo 69"
local screen = peripheral.find("monitor")
screen.setBackgroundColor(colors.black)
screen.setTextColor(colors.white)
screen.clear()
screen.setTextScale(0.5)
screen.setCursorPos(1,1)

local function split(s, delim)
    local result = {}
    for match in (s..delim):gmatch("(.-)"..delim) do
        table.insert(result, match)
    end
    return result
end

local function readconf()
    local file = fs.open(folder .. "/conf.json", "r")
    local contents = file.readAll()
    file.close()
    return textutils.unserialiseJSON(contents)
end

local function writeconf(contents)
    local file = fs.open(folder .. "/conf.json", "w")
    file.write(textutils.serialiseJSON(contents))
    file.close()
end

local function printCentered(onX, onY, xOff, yOff, string)

    local x,y = screen.getCursorPos()
    local w,h = screen.getSize()
    
    if onX == true then
        x = math.floor((w - string.len(string)) / 2)
    end
   
    if onY == true then
        y = math.floor(h / 2)
    end
    
    x = x + xOff
    y = y + yOff
    
    screen.setCursorPos(x,y)
    screen.write(string)
    
end

local function draw(topLeftX,topLeftY,fileName,color0,color1,color2)

    local file = fs.open(fileName, "r")
    local contentstring = file.readAll()
    file.close()
    contents = split(contentstring,",")
    screen.setCursorPos(topLeftX,topLeftY)
    for i = 1,contentstring.len(contentstring),1
    do
        if tonumber(contents[i]) == 1 then
            screen.setBackgroundColor(color1)
            screen.write(" ")
        elseif tonumber(contents[i]) == 0 then
            screen.setBackgroundColor(color0)
            screen.write(" ")
        elseif contents[i] == "n" then
            local newX, newY = screen.getCursorPos()
            screen.setCursorPos(topLeftX,newY + 1)
        elseif contents[i] ~= nil then
            term.write(contents[i])
        end
    end

    screen.setBackgroundColor(color2)
end

local function regController(conf)
    rednet.CHANNEL_BROADCAST = conf.port
    
    peripheral.find("modem", rednet.open)
    
    local senderID, message, protocol = rednet.receive()
    
    rednet.close()
    
    return senderID, message, protocol
end

local function onKey(time, port,callback)
    rednet.CHANNEL_BROADCAST = port
    
    peripheral.find("modem", rednet.open)
    
    while true do
        local senderID, message, protocol = rednet.receive()
        
        callback(senderID, message, protocol)
        
        os.sleep(time)
    end
    
    rednet.close()
end

local function fixedUpdate(time, callback)
    while true do
        callback()
        
        os.sleep(time)
    end
end

local function install(url, path)
    local content = http.get(url).readAll()

    if content then
        file = fs.open(path, "w")
        file.write(content)
        file.close()
        print("Installed " .. url .. " to \"" .. path .. "\"")
    else
        print("Failed to download script!")
    end
end

local function url(url)
    return http.get(url).readAll()
end

local function readfile(path)
    local file = fs.open(path, "r")
    local contents = file.readAll()
    file.close()
    return contents
end

return { readFile = readFile, url = url, install = install, onKey = onKey, fixedUpdate = fixedUpdate, folder = folder, name = name, regController = regController, split = split, writeconf = writeconf, readconf = readconf, printCentered = printCentered, draw = draw }