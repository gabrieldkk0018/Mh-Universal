--[[ 
    MH Universal v1 (TESTE)
    by: Miel
]]

-- serviços
local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local LocalPlayer = Players.LocalPlayer

-- ==============================
-- CONFIG (carrega primeiro)
-- ==============================
local Config
pcall(function()
    Config = loadstring(game:HttpGet(
        "https://raw.githubusercontent.com/gabrieldkk0018/Mh-Universal/main/config.lua"
    ))()
end)

Config = Config or {
    Aimbot = true,
    ESP = false,
    FPSBoost = false,
    ShowFOV = true,
    FOVSize = 120
}

-- ==============================
-- NOTIFICAÇÃO DE LOAD
-- ==============================
pcall(function()
    StarterGui:SetCore("SendNotification", {
        Title = "MH Universal",
        Text = "Carregado com sucesso!\nby: Miel",
        Duration = 4
    })
end)

-- ==============================
-- AIMBOT
-- ==============================
local Aimbot
pcall(function()
    Aimbot = loadstring(game:HttpGet(
        "https://raw.githubusercontent.com/gabrieldkk0018/Mh-Universal/main/aimbot/aimbot.lua"
    ))()
end)

if Aimbot and Aimbot.Enable and Config.Aimbot then
    Aimbot:Enable()
end

-- ==============================
-- ESP
-- ==============================
local ESP
pcall(function()
    ESP = loadstring(game:HttpGet(
        "https://raw.githubusercontent.com/gabrieldkk0018/Mh-Universal/main/esp/esp.lua"
    ))()
end)

if ESP and ESP.Enable and Config.ESP then
    ESP:Enable()
end

-- ==============================
-- FPS BOOST (placeholder)
-- ==============================
if Config.FPSBoost then
    pcall(function()
        settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
        for _, v in ipairs(workspace:GetDescendants()) do
            if v:IsA("BasePart") then
                v.Material = Enum.Material.Plastic
                v.Reflectance = 0
            elseif v:IsA("Decal") or v:IsA("Texture") then
                v.Transparency = 1
            end
        end
    end)
end

-- ==============================
-- GUI
-- ==============================
pcall(function()
    loadstring(game:HttpGet(
        "https://raw.githubusercontent.com/gabrieldkk0018/Mh-Universal/main/gui/gui.lua"
    ))()
end)

print("MH Universal v1 carregado com sucesso")
