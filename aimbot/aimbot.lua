-- MH Universal | Aimbot Test
-- by: Miel

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera

local LocalPlayer = Players.LocalPlayer

-- CONFIG
local AIMBOT_ON = true
local FOV = 120
local SMOOTH = 0.18
local MAX_DISTANCE = 500
local TEAM_CHECK = true
local WALL_CHECK = true
local AIM_PART = "Head"

-- FOV CIRCLE
local FOVCircle = Drawing.new("Circle")
FOVCircle.Color = Color3.fromRGB(180, 0, 255) -- roxo
FOVCircle.Thickness = 2
FOVCircle.Filled = false
FOVCircle.Radius = FOV
FOVCircle.Visible = true

local function getCenter()
	return Vector2.new(
		Camera.ViewportSize.X / 2,
		Camera.ViewportSize.Y / 2
	)
end

local function isVisible(targetPart)
	if not WALL_CHECK then return true end

	local params = RaycastParams.new()
	params.FilterType = Enum.RaycastFilterType.Blacklist
	params.FilterDescendantsInstances = {LocalPlayer.Character}

	local result = workspace:Raycast(
		Camera.CFrame.Position,
		targetPart.Position - Camera.CFrame.Position,
		params
	)

	return result and result.Instance:IsDescendantOf(targetPart.Parent)
end

local function getTarget()
	local closest
	local shortest = math.huge

	for _, plr in pairs(Players:GetPlayers()) do
		if plr ~= LocalPlayer and plr.Character then
			local hum = plr.Character:FindFirstChild("Humanoid")
			local part = plr.Character:FindFirstChild(AIM_PART)

			if hum and part and hum.Health > 0 then
				if TEAM_CHECK and plr.Team == LocalPlayer.Team then
					continue
				end

				local pos, onScreen = Camera:WorldToViewportPoint(part.Position)
				if not onScreen then continue end

				local dist2D = (Vector2.new(pos.X, pos.Y) - getCenter()).Magnitude
				local dist3D = (part.Position - Camera.CFrame.Position).Magnitude

				if dist2D <= FOV and dist3D <= MAX_DISTANCE and dist2D < shortest then
					if isVisible(part) then
						shortest = dist2D
						closest = part
					end
				end
			end
		end
	end

	return closest
end

RunService.RenderStepped:Connect(function()
	FOVCircle.Position = getCenter()
	FOVCircle.Radius = FOV

	if AIMBOT_ON then
		local target = getTarget()
		if target then
			local cf = CFrame.new(Camera.CFrame.Position, target.Position)
			Camera.CFrame = Camera.CFrame:Lerp(cf, SMOOTH)
		end
	end
end)
