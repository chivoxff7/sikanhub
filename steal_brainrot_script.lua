-- SIKAN HUB - Script personalizado para robar Brainrots en Steal a Brainrot

-- Función para teletransportarse a la base del enemigo
local function teleportToEnemyBase(player)
    local enemyBase = player.Character:FindFirstChild("Base")
    if enemyBase then
        game.Players.LocalPlayer.Character:SetPrimaryPartCFrame(enemyBase.CFrame + Vector3.new(0, 5, 0)) -- Ajusta la posición para estar dentro de la base
    end
end

-- Función para activar NoClip
local function toggleNoClip(enabled)
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoid = character:WaitForChild("Humanoid")

    local function onStep()
        if enabled then
            humanoid.PlatformStand = true
        else
            humanoid.PlatformStand = false
        end
    end

    humanoid.Changed:Connect(function(property)
        if property == "FloorMaterial" then
            onStep()
        end
    end)

    onStep()
end

-- Función para robar un Brainrot
local function stealBrainrot(player)
    local brainrot = player.Character:FindFirstChild("Brainrot")
    if brainrot then
        brainrot.Parent = game.Players.LocalPlayer.Backpack
    end
end

-- Función principal para robar un Brainrot de la base del enemigo
local function main()
    for _, player in ipairs(game.Players:GetPlayers()) do
        if player ~= game.Players.LocalPlayer and player.Character and player.Character:FindFirstChild("Base") then
            teleportToEnemyBase(player)
            toggleNoClip(true)
            wait(0.5) -- Espera un momento para asegurarse de que el teletransporte funcione
            stealBrainrot(player)
            toggleNoClip(false)
            break
        end
    end
end

-- Ejecutar la función principal
main()
