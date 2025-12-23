
-- MH Universal - Configurações
-- by: Miel

local Config = {}

-- ======================
-- AIMBOT
-- ======================
Config.Aimbot = true            -- liga/desliga aimbot ao iniciar
Config.TeamCheck = true         -- não mirar em aliados
Config.WallCheck = true         -- checar paredes
Config.AimPart = "Head"         -- Head / UpperTorso / Torso
Config.AimSmoothness = 0.15     -- quanto menor, mais "grudado"
Config.AutoDisableLobby = true  -- desliga aimbot no lobby/morte

-- ======================
-- FOV
-- ======================
Config.ShowFOV = true           -- mostrar círculo de FOV
Config.FOVSize = 120            -- tamanho inicial do FOV
Config.FOVColor = Color3.fromRGB(128, 0, 128) -- roxo
Config.FOVThickness = 2

-- ======================
-- ESP
-- ======================
Config.ESP = false              -- liga ESP ao iniciar
Config.ESPColor = Color3.fromRGB(170, 0, 255) -- roxo
Config.ShowName = true
Config.ShowDistance = true
Config.ShowHealth = true
Config.MaxESPDistance = 1000

-- ======================
-- FPS BOOST
-- ======================
Config.FPSBoost = false         -- fps boost ao iniciar

-- ======================
-- MISC
-- ======================
Config.Notifications = true     -- mostrar notificações

return Config
