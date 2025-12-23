--==============================
-- ESP UNIVERSAL ROXO
--==============================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local ESP_ENABLED = false
local ESP_Objects = {}

local ESP_COLOR = Color3.fromRGB(170, 90, 255) -- ROXO MH

--==============================
-- CREATE ESP
--==============================

local function createESP(player)
	if player == LocalPlayer then return end
	if ESP_Objects[player] then return end

	local function onCharacter(char)
		task.wait(0.2)
		if not char or not char:FindFirstChild("Head") then return end

		local billboard = Instance.new("BillboardGui")
		billboard.Name = "MH_ESP"
		billboard.Adornee = char.Head
		billboard.Size = UDim2.new(0, 200, 0, 50)
		billboard.StudsOffset = Vector3.new(0, 2.5, 0)
		billboard.AlwaysOnTop = true

		local text = Instance.new("TextLabel", billboard)
		text.Size = UDim2.new(1, 0, 1, 0)
		text.BackgroundTransparency = 1
		text.TextStrokeTransparency = 0
		text.TextStrokeColor3 = Color3.new(0,0,0)
		text.Font = Enum.Font.GothamBold
		text.TextSize = 13
		text.TextColor3 = ESP_COLOR
		text.TextWrapped = true

		billboard.Parent = char
		ESP_Objects[player] = {Gui = billboard, Label = text}
	end

	if player.Character then
		onCharacter(player.Character)
	end

	player.CharacterAdded:Connect(onCharacter)
end

--==============================
-- REMOVE ESP
--==============================

local function removeESP(player)
	if ESP_Objects[player] then
		pcall(function()
			ESP_Objects[player].Gui:Destroy()
		end)
		ESP_Objects[player] = nil
	end
end

--==============================
-- UPDATE LOOP
--==============================

RunService.RenderStepped:Connect(function()
	if not ESP_ENABLED then return end

	for player, data in pairs(ESP_Objects) do
		local char = player.Character
		local hum = char and char:FindFirstChild("Humanoid")
		local head = char and char:FindFirstChild("Head")

		if hum and head then
			local dist = math.floor((Camera.CFrame.Position - head.Position).Magnitude)
			local hp = math.floor(hum.Health)

			data.Label.Text =
				player.Name ..
				"\n" .. dist .. "m" ..
				"\nHP: " .. hp
		end
	end
end)

--==============================
-- PUBLIC FUNCTIONS
--==============================

local ESP = {}

function ESP.Enable()
	if ESP_ENABLED then return end
	ESP_ENABLED = true

	for _, plr in pairs(Players:GetPlayers()) do
		createESP(plr)
	end

	Players.PlayerAdded:Connect(createESP)
end

function ESP.Disable()
	ESP_ENABLED = false
	for plr,_ in pairs(ESP_Objects) do
		removeESP(plr)
	end
end

return ESP
