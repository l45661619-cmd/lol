local Players = game:GetService("Players")
local player = Players.LocalPlayer

local character = player.Character or player.CharacterAdded:Wait()
local hrp = character:WaitForChild("HumanoidRootPart")

local tpPart = workspace.Bench.Part

hrp.CFrame = tpPart.CFrame + Vector3.new(0, 3, 0)
