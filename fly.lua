-- Fly Script (LocalScript)

local player = game.Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local flying = false
local speed = 60

local bodyGyro
local bodyVelocity

local function startFly()
	local character = player.Character
	if not character then return end

	local hrp = character:WaitForChild("HumanoidRootPart")
	local humanoid = character:WaitForChild("Humanoid")
	humanoid.PlatformStand = true

	bodyGyro = Instance.new("BodyGyro")
	bodyGyro.P = 9e4
	bodyGyro.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
	bodyGyro.CFrame = hrp.CFrame
	bodyGyro.Parent = hrp

	bodyVelocity = Instance.new("BodyVelocity")
	bodyVelocity.MaxForce = Vector3.new(9e9, 9e9, 9e9)
	bodyVelocity.Velocity = Vector3.zero
	bodyVelocity.Parent = hrp
end

local function stopFly()
	local character = player.Character
	if not character then return end

	local humanoid = character:FindFirstChild("Humanoid")
	if humanoid then
		humanoid.PlatformStand = false
	end

	if bodyGyro then bodyGyro:Destroy() end
	if bodyVelocity then bodyVelocity:Destroy() end
end

UIS.InputBegan:Connect(function(input, gp)
	if gp then return end

	if input.KeyCode == Enum.KeyCode.Q then  -- сменили F на Q
		flying = not flying
		if flying then
			startFly()
		else
			stopFly()
		end
	end
end)


RunService.RenderStepped:Connect(function()
	if not flying or not bodyVelocity or not bodyGyro then return end

	local camera = workspace.CurrentCamera
	bodyGyro.CFrame = camera.CFrame

	local moveDir = Vector3.zero

	if UIS:IsKeyDown(Enum.KeyCode.W) then
		moveDir += camera.CFrame.LookVector
	end
	if UIS:IsKeyDown(Enum.KeyCode.S) then
		moveDir -= camera.CFrame.LookVector
	end
	if UIS:IsKeyDown(Enum.KeyCode.A) then
		moveDir -= camera.CFrame.RightVector
	end
	if UIS:IsKeyDown(Enum.KeyCode.D) then
		moveDir += camera.CFrame.RightVector
	end
	if UIS:IsKeyDown(Enum.KeyCode.Space) then
		moveDir += Vector3.new(0,1,0)
	end
	if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then
		moveDir -= Vector3.new(0,1,0)
	end

	if moveDir.Magnitude > 0 then
		bodyVelocity.Velocity = moveDir.Unit * speed
	else
		bodyVelocity.Velocity = Vector3.zero
	end
end)
