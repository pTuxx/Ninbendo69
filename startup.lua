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

local funciton readfile(path)
    local file = fs.open(path, "r")
    local contents = file.readAll()
    file.close()
    return contents
end

shell.run('nin69gui')