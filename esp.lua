local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer

local function addHighlight(player)
    if player == localPlayer then return end

    local function onCharacter(character)
        -- удаляем старый Highlight если есть
        if character:FindFirstChild("ESPHighlight") then
            character.ESPHighlight:Destroy()
        end

        local highlight = Instance.new("Highlight")
        highlight.Name = "ESPHighlight"
        highlight.Adornee = character
        highlight.FillColor = Color3.fromRGB(0, 255, 0)
        highlight.FillTransparency = 0.5
        highlight.OutlineTransparency = 1
        highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        highlight.Parent = character
    end

    if player.Character then
        onCharacter(player.Character)
    end

    player.CharacterAdded:Connect(onCharacter)
end

-- для всех текущих игроков
for _, player in ipairs(Players:GetPlayers()) do
    addHighlight(player)
end

-- для новых
Players.PlayerAdded:Connect(addHighlight)
