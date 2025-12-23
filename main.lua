-- MH Universal
-- Loader principal

local BASE_URL = "https://raw.githubusercontent.com/gabrieldkk0018/Mh-Universal/main/"

local function load(path)
    local url = BASE_URL .. path
    local src = game:HttpGet(url)
    return loadstring(src)()
end

-- Config
load("config.lua")

-- GUI
load("gui/gui.lua")

-- ESP
load("esp/esp.lua")

-- Aimbot
load("aimbot/aimbot.lua")

print("[MH Universal] Carregado com sucesso")
