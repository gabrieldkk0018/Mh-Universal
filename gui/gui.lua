-- MH Universal - Titanz GUI
-- gui/gui.lua

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local LocalPlayer = Players.LocalPlayer

-- ================= COLORS =================

local COLORS = {
    Background = Color3.fromRGB(15, 15, 20),
    Surface = Color3.fromRGB(25, 25, 35),
    Accent = Color3.fromRGB(180, 120, 255),
    Text = Color3.fromRGB(235, 235, 235)
}

-- ================= UTILS =================

local function tween(obj, info, props)
    TweenService:Create(obj, info, props):Play()
end

local tweenFast = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

-- ================= GUI ROOT =================

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MH_Universal_GUI"
ScreenGui.IgnoreGuiInset = true
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game.CoreGui

local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 340, 0, 300)
Main.Position = UDim2.new(0.5, -170, 0.5, -150)
Main.BackgroundColor3 = COLORS.Background
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = false

Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 14)

-- ================= HEADER =================

local Header = Instance.new("Frame", Main)
Header.Size = UDim2.new(1, 0, 0, 50)
Header.BackgroundColor3 = COLORS.Surface
Header.BorderSizePixel = 0
Instance.new("UICorner", Header).CornerRadius = UDim.new(0, 14)

local Title = Instance.new("TextLabel", Header)
Title.Size = UDim2.new(1, -50, 1, 0)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "MH Universal | Beta"
Title.TextColor3 = COLORS.Accent
Title.Font = Enum.Font.GothamBold
Title.TextSize = 14
Title.TextXAlignment = Left

local MinBtn = Instance.new("TextButton", Header)
MinBtn.Size = UDim2.new(0, 32, 0, 32)
MinBtn.Position = UDim2.new(1, -40, 0.5, -16)
MinBtn.Text = "-"
MinBtn.Font = Enum.Font.GothamBold
MinBtn.TextSize = 22
MinBtn.TextColor3 = COLORS.Text
MinBtn.BackgroundColor3 = COLORS.Surface
MinBtn.BorderSizePixel = 0
Instance.new("UICorner", MinBtn).CornerRadius = UDim.new(0, 8)

-- ================= CONTENT =================

local Content = Instance.new("Frame", Main)
Content.Position = UDim2.new(0, 0, 0, 55)
Content.Size = UDim2.new(1, 0, 1, -55)
Content.BackgroundTransparency = 1

local Layout = Instance.new("UIListLayout", Content)
Layout.Padding = UDim.new(0, 10)
Layout.HorizontalAlignment = Center

-- ================= BUTTON / TOGGLE =================

local function createToggle(text, callback)
    local Holder = Instance.new("Frame", Content)
    Holder.Size = UDim2.new(0.9, 0, 0, 40)
    Holder.BackgroundColor3 = COLORS.Surface
    Holder.BorderSizePixel = 0
    Instance.new("UICorner", Holder).CornerRadius = UDim.new(0, 10)

    local Label = Instance.new("TextLabel", Holder)
    Label.Size = UDim2.new(1, -60, 1, 0)
    Label.Position = UDim2.new(0, 10, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = text
    Label.TextColor3 = COLORS.Text
    Label.Font = Enum.Font.GothamBold
    Label.TextSize = 12
    Label.TextXAlignment = Left

    local Switch = Instance.new("Frame", Holder)
    Switch.Size = UDim2.new(0, 42, 0, 22)
    Switch.Position = UDim2.new(1, -52, 0.5, -11)
    Switch.BackgroundColor3 = Color3.fromRGB(70, 70, 90)
    Switch.BorderSizePixel = 0
    Instance.new("UICorner", Switch).CornerRadius = UDim.new(1, 0)

    local Knob = Instance.new("Frame", Switch)
    Knob.Size = UDim2.new(0, 18, 0, 18)
    Knob.Position = UDim2.new(0, 2, 0.5, -9)
    Knob.BackgroundColor3 = COLORS.Text
    Knob.BorderSizePixel = 0
    Instance.new("UICorner", Knob).CornerRadius = UDim.new(1, 0)

    local Button = Instance.new("TextButton", Holder)
    Button.Size = UDim2.new(1, 0, 1, 0)
    Button.BackgroundTransparency = 1
    Button.Text = ""

    local enabled = false

    Button.MouseButton1Click:Connect(function()
        enabled = not enabled

        tween(Switch, tweenFast, {
            BackgroundColor3 = enabled and COLORS.Accent or Color3.fromRGB(70, 70, 90)
        })

        tween(Knob, tweenFast, {
            Position = enabled and UDim2.new(0, 22, 0.5, -9) or UDim2.new(0, 2, 0.5, -9)
        })

        if callback then
            callback(enabled)
        end
    end)
end

-- ================= TEST TOGGLES =================

createToggle("ESP (TESTE)", function(state)
    print("[GUI] ESP:", state)
end)

createToggle("Aimbot (TESTE)", function(state)
    print("[GUI] Aimbot:", state)
end)

createToggle("FPS Boost (TESTE)", function(state)
    print("[GUI] FPS Boost:", state)
end)

-- ================= MINIMIZE =================

local minimized = false
MinBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    MinBtn.Text = minimized and "+" or "-"

    tween(Main, tweenFast, {
        Size = minimized and UDim2.new(0, 340, 0, 55) or UDim2.new(0, 340, 0, 300)
    })

    Content.Visible = not minimized
end)

-- ================= DRAG =================

local dragging, dragStart, startPos

Header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = Main.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        Main.Position = UDim2.new(
            startPos.X.Scale, startPos.X.Offset + delta.X,
            startPos.Y.Scale, startPos.Y.Offset + delta.Y
        )
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

print("[MH Universal] GUI Titanz carregada")
