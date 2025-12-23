-- MH Universal - GUI Titanz (TESTE)
-- Tema: Roxo / Preto

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local Player = Players.LocalPlayer
local Mouse = Player:GetMouse()

-- ================= CONFIG VISUAL =================

local COLORS = {
    Background = Color3.fromRGB(15, 15, 20),
    Surface = Color3.fromRGB(25, 25, 35),
    Accent = Color3.fromRGB(150, 90, 255),
    Text = Color3.fromRGB(235, 235, 235),
    Muted = Color3.fromRGB(160, 160, 160)
}

-- ================= GUI BASE =================

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MH_Universal_GUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game.CoreGui

local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 420, 0, 320)
Main.Position = UDim2.new(0.5, -210, 0.5, -160)
Main.BackgroundColor3 = COLORS.Background
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 14)

-- ================= TOP BAR =================

local Top = Instance.new("Frame", Main)
Top.Size = UDim2.new(1, 0, 0, 42)
Top.BackgroundColor3 = COLORS.Surface
Top.BorderSizePixel = 0
Instance.new("UICorner", Top).CornerRadius = UDim.new(0, 14)

local Title = Instance.new("TextLabel", Top)
Title.Size = UDim2.new(1, -90, 1, 0)
Title.Position = UDim2.new(0, 14, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "MH Universal | Test UI"
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
Content.Size = UDim2.new(1, -20, 1, -60)
Content.Position = UDim2.new(0, 10, 0, 50)
Content.BackgroundTransparency = 1

local Layout = Instance.new("UIListLayout", Content)
Layout.Padding = UDim.new(0, 10)

-- ================= TOGGLE FUNCTION =================

local function createToggle(text, callback)
    local Holder = Instance.new("Frame", Content)
    Holder.Size = UDim2.new(1, 0, 0, 40)
    Holder.BackgroundColor3 = COLORS.Surface
    Holder.BorderSizePixel = 0
    Instance.new("UICorner", Holder).CornerRadius = UDim.new(0, 10)

    local Label = Instance.new("TextLabel", Holder)
    Label.Size = UDim2.new(1, -60, 1, 0)
    Label.Position = UDim2.new(0, 12, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = text
    Label.TextColor3 = COLORS.Text
    Label.Font = Enum.Font.Gotham
    Label.TextSize = 13
    Label.TextXAlignment = Enum.TextXAlignment.Left

    local Button = Instance.new("TextButton", Holder)
    Button.Size = UDim2.new(0, 40, 0, 22)
    Button.Position = UDim2.new(1, -50, 0.5, -11)
    Button.Text = "OFF"
    Button.Font = Enum.Font.GothamBold
    Button.TextSize = 12
    Button.TextColor3 = COLORS.Text
    Button.BackgroundColor3 = Color3.fromRGB(70, 70, 80)
    Button.BorderSizePixel = 0
    Instance.new("UICorner", Button).CornerRadius = UDim.new(0, 6)

    local state = false

    Button.MouseButton1Click:Connect(function()
        state = not state
        Button.Text = state and "ON" or "OFF"
        Button.BackgroundColor3 = state and COLORS.Accent or Color3.fromRGB(70, 70, 80)
        if callback then callback(state) end
    end)
end

-- ================= FOV VISUAL =================

local FOV_ENABLED = true
local FOV_SIZE = 120
local FOV_PRESETS = {60, 90, 120, 160, 200}
local FOV_INDEX = 3

local FOVCircle = Drawing.new("Circle")
FOVCircle.Color = Color3.fromRGB(180, 120, 255) -- ROXO 💜
FOVCircle.Thickness = 2
FOVCircle.NumSides = 100
FOVCircle.Filled = false
FOVCircle.Visible = true
FOVCircle.Radius = FOV_SIZE

RunService.RenderStepped:Connect(function()
    FOVCircle.Position = Vector2.new(Mouse.X, Mouse.Y + 36)
    FOVCircle.Radius = FOV_SIZE
    FOVCircle.Visible = FOV_ENABLED
end)

-- ================= UI CONTROLS =================

createToggle("Show Aimbot FOV", function(v)
    FOV_ENABLED = v
end)

local function createFovSelector()
    local Holder = Instance.new("Frame", Content)
    Holder.Size = UDim2.new(1, 0, 0, 40)
    Holder.BackgroundColor3 = COLORS.Surface
    Holder.BorderSizePixel = 0
    Instance.new("UICorner", Holder).CornerRadius = UDim.new(0, 10)

    local Label = Instance.new("TextLabel", Holder)
    Label.Size = UDim2.new(1, -60, 1, 0)
    Label.Position = UDim2.new(0, 12, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = "FOV Size: "..FOV_SIZE
    Label.TextColor3 = COLORS.Text
    Label.Font = Enum.Font.Gotham
    Label.TextSize = 13
    Label.TextXAlignment = Enum.TextXAlignment.Left

    local Button = Instance.new("TextButton", Holder)
    Button.Size = UDim2.new(0, 40, 0, 22)
    Button.Position = UDim2.new(1, -50, 0.5, -11)
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
        FOV_SIZE = FOV_PRESETS[FOV_INDEX]
        Label.Text = "FOV Size: "..FOV_SIZE
    end)
end

createFovSelector()

-- ================= MINIMIZE =================

local minimized = false
Minimize.MouseButton1Click:Connect(function()
    minimized = not minimized
    Content.Visible = not minimized
    Main.Size = minimized and UDim2.new(0, 420, 0, 50) or UDim2.new(0, 420, 0, 320)
    Minimize.Text = minimized and "+" or "-"
end)

print("[MH Universal] GUI Titanz carregada (teste)")
