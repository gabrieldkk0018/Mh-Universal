-- BASE
local BASE_URL = "https://raw.githubusercontent.com/gabrieldkk0018/Mh-Universal/main/"

-- CONFIG
getgenv().Config = loadstring(game:HttpGet(BASE_URL .. "config.lua"))()

-- MODULES
local ESP = loadstring(game:HttpGet(BASE_URL .. "esp/esp.lua"))()
local Aimbot = loadstring(game:HttpGet(BASE_URL .. "aimbot/aimbot.lua"))()
local FPS = loadstring(game:HttpGet(BASE_URL .. "fps/fps.lua"))()

getgenv().Modules = {
    ESP = ESP,
    Aimbot = Aimbot,
    FPS = FPS
}

-- GUI
loadstring(game:HttpGet(BASE_URL .. "gui/gui.lua"))()

-- NOTIFICAÇÃO
pcall(function()
    game.StarterGui:SetCore("SendNotification", {
        Title = "Mh Universal",
        Text = "Carregado com sucesso!\nby: Miel",
        Duration = 5
    })
end)
