local Players = game:GetService("Players")
local player = Players.LocalPlayer

local character = player.Character or player.CharacterAdded:Wait()
local hrp = character:WaitForChild("HumanoidRootPart")

-- правильный путь
local spawnPart = workspace:WaitForChild("Criminals Spawn")
    :WaitForChild("SpawnLocation")

-- телепорт
hrp.CFrame = spawnPart.CFrame + Vector3.new(0, 3, 0)

