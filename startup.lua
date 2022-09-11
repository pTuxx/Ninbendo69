local nin = require "nin69" 

if tonumber(nin.url("https://raw.githubusercontent.com/pTuxx/Ninbendo69/main/versions/nin69.txt")) > tonumber(nin.readfile("/versions/nin69.txt")) then
    fs.delete("/nin69.lua")
    fs.delete("/versions/nin69.txt")
    nin.install("https://raw.githubusercontent.com/pTuxx/Ninbendo69/main/nin69.lua", "/nin69.lua")
    nin.install("https://raw.githubusercontent.com/pTuxx/Ninbendo69/main/versions/nin69.txt", "/versions/nin69.txt")
end

if tonumber(nin.url("https://raw.githubusercontent.com/pTuxx/Ninbendo69/main/versions/nin69gui.txt")) > tonumber(nin.readfile("/versions/nin69gui.txt")) then
    fs.delete("/nin69gui.lua")
    fs.delete("/versions/nin69gui.txt")
    nin.install("https://raw.githubusercontent.com/pTuxx/Ninbendo69/main/nin69gui.lua", "/nin69gui.lua")
    nin.install("https://raw.githubusercontent.com/pTuxx/Ninbendo69/main/versions/nin69gui.txt", "/versions/nin69gui.txt")
end

if tonumber(nin.url("https://raw.githubusercontent.com/pTuxx/Ninbendo69/main/versions/startup.txt")) > tonumber(nin.readfile("/versions/startup.txt")) then
    fs.delete("/startup.lua")
    fs.delete("/versions/startup.txt")
    nin.install("https://raw.githubusercontent.com/pTuxx/Ninbendo69/main/startup.lua", "/startup.lua")
    nin.install("https://raw.githubusercontent.com/pTuxx/Ninbendo69/main/versions/startup.txt", "/versions/startup.txt")
    os.reboot()
end

local filePath = "basalt.lua"
if not(fs.exists(filePath))then
    shell.run("pastebin run ESs1mg7P packed true "..filePath:gsub(".lua", ""))
end
local basalt = require(filePath:gsub(".lua", ""))

shell.run('nin69gui')