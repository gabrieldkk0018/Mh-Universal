-- MH Universal - Titanz GUI (BASE COMPLETA)
-- Apenas Interface | Sem lógica de cheat

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local Player = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- ================= VISUAL =================

local COLORS = {
    Background = Color3.fromRGB(14, 14, 18),
    Surface = Color3.fromRGB(25, 25, 35),
    Accent = Color3.fromRGB(160, 95, 255),
    Text = Color3.fromRGB(235, 235, 235),
    Disabled = Color3.fromRGB(90, 90, 100)
}

-- ================= SCREEN GUI =================

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MH_Universal_GUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game.CoreGui

-- ================= MAIN =================

local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 420, 0, 360)
Main.Position = UDim2.new(0.5, -210, 0.5, -180)
Main.BackgroundColor3 = COLORS.Background
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 14)

-- ================= TOP =================

local Top = Instance.new("Frame", Main)
Top.Size = UDim2.new(1, 0, 0, 44)
Top.BackgroundColor3 = COLORS.Surface
Top.BorderSizePixel = 0
Instance.new("UICorner", Top).CornerRadius = UDim.new(0, 14)

local Title = Instance.new("TextLabel", Top)
Title.Size = UDim2.new(1, -80, 1, 0)
Title.Position = UDim2.new(0, 14, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "MH Universal | Titanz UI"
Title.TextColor3 = COLORS.Text
Title.Font = Enum.Font.GothamBold
Title.TextSize = 14
Title.TextXAlignment = Enum.TextXAlignment.Left

local Minimize = Instance.new("TextButton", Top)
Minimize.Size = UDim2.new(0, 32, 0, 32)
Minimize.Position = UDim2.new(1, -40, 0.5, -16)
Minimize.Text = "-"
Minimize.Font = Enum.Font.GothamBold
Minimize.TextSize = 22
Minimize.TextColor3 = COLORS.Text
Minimize.BackgroundColor3 = COLORS.Accent
Minimize.BorderSizePixel = 0
Instance.new("UICorner", Minimize).CornerRadius = UDim.new(0, 8)

-- ================= CONTENT =================

local Content = Instance.new("Frame", Main)
Content.Size = UDim2.new(1, -20, 1, -64)
Content.Position = UDim2.new(0, 10, 0, 54)
Content.BackgroundTransparency = 1

local Layout = Instance.new("UIListLayout", Content)
Layout.Padding = UDim.new(0, 10)

-- ================= TOGGLE =================

local function createToggle(text, callback)
    local Holder = Instance.new("Frame", Content)
    Holder.Size = UDim2.new(1, 0, 0, 40)
    Holder.BackgroundColor3 = COLORS.Surface
    Holder.BorderSizePixel = 0
    Instance.new("UICorner", Holder).CornerRadius = UDim.new(0, 10)

    local Label = Instance.new("TextLabel", Holder)
    Label.Size = UDim2.new(1, -70, 1, 0)
    Label.Position = UDim2.new(0, 12, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = text
    Label.TextColor3 = COLORS.Text
    Label.Font = Enum.Font.Gotham
    Label.TextSize = 13
    Label.TextXAlignment = Enum.TextXAlignment.Left

    local Button = Instance.new("TextButton", Holder)
    Button.Size = UDim2.new(0, 44, 0, 22)
    Button.Position = UDim2.new(1, -54, 0.5, -11)
    Button.Text = "OFF"
    Button.Font = Enum.Font.GothamBold
    Button.TextSize = 12
    Button.TextColor3 = COLORS.Text
    Button.BackgroundColor3 = COLORS.Disabled
    Button.BorderSizePixel = 0
    Instance.new("UICorner", Button).CornerRadius = UDim.new(0, 6)

    local state = false

    Button.MouseButton1Click:Connect(function()
        state = not state
        Button.Text = state and "ON" or "OFF"
        Button.BackgroundColor3 = state and COLORS.Accent or COLORS.Disabled
        if callback then callback(state) end
    end)
end

-- ================= FOV VISUAL =================

local FOV_ENABLED = true
local FOV_PRESETS = {60, 90, 120, 160, 200}
local FOV_INDEX = 3
local FOV_RADIUS = FOV_PRESETS[FOV_INDEX]

local FOV = Drawing.new("Circle")
FOV.Color = Color3.fromRGB(180, 120, 255) -- ROXO
FOV.Thickness = 2
FOV.NumSides = 100
FOV.Filled = false
FOV.Visible = true

RunService.RenderStepped:Connect(function()
    local center = Camera.ViewportSize / 2
    FOV.Position = Vector2.new(center.X, center.Y)
    FOV.Radius = FOV_RADIUS
    FOV.Visible = FOV_ENABLED
end)

-- ================= FOV SIZE =================

local function createFovSize()
    local Holder = Instance.new("Frame", Content)
    Holder.Size = UDim2.new(1, 0, 0, 40)
    Holder.BackgroundColor3 = COLORS.Surface
    Holder.BorderSizePixel = 0
    Instance.new("UICorner", Holder).CornerRadius = UDim.new(0, 10)

    local Label = Instance.new("TextLabel", Holder)
    Label.Size = UDim2.new(1, -70, 1, 0)
    Label.Position = UDim2.new(0, 12, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = "FOV Size: "..FOV_RADIUS
    Label.TextColor3 = COLORS.Text
    Label.Font = Enum.Font.Gotham
    Label.TextSize = 13
    Label.TextXAlignment = Enum.TextXAlignment.Left

    local Button = Instance.new("TextButton", Holder)
    Button.Size = UDim2.new(0, 44, 0, 22)
    Button.Position = UDim2.new(1, -54, 0.5, -11)
    Button.Text = ">"
    Button.Font = Enum.Font.GothamBold
    Button.TextSize = 16
    Button.TextColor3 = COLORS.Text
    Button.BackgroundColor3 = COLORS.Accent
    Button.BorderSizePixel = 0
    Instance.new("UICorner", Button).CornerRadius = UDim.new(0, 6)

    Button.MouseButton1Click:Connect(function()
        FOV_INDEX += 1
        if FOV_INDEX > #FOV_PRESETS then
            FOV_INDEX = 1
        end
        FOV_RADIUS = FOV_PRESETS[FOV_INDEX]
        Label.Text = "FOV Size: "..FOV_RADIUS
    end)
end

-- ================= OPTIONS =================

createToggle("Aimbot", function(v) end)
createToggle("ESP", function(v) end)
createToggle("FPS Boost", function(v) end)
createToggle("Show FOV", function(v)
    FOV_ENABLED = v
end)

createFovSize()

-- ================= MINIMIZE =================

local minimized = false
Minimize.MouseButton1Click:Connect(function()
    minimized = not minimized
    Content.Visible = not minimized
    Main.Size = minimized and UDim2.new(0, 420, 0, 52) or UDim2.new(0, 420, 0, 360)
    Minimize.Text = minimized and "+" or "-"
end)

print("[MH Universal] Titanz GUI carregada com sucesso")
