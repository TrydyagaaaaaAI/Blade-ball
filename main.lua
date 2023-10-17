local localPlayer = game.Players.LocalPlayer
local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()
local abilitiesFolder = character:WaitForChild("Abilities")

local ChosenAbility = "Raging Deflection"

local function createGUI()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "AbilityChooser"
    screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

    local mainMenuFrame = Instance.new("Frame")
    mainMenuFrame.Size = UDim2.new(0.080, 100, 0.45, 100)
    mainMenuFrame.Position = UDim2.new(0.15, -90, 0.4, -100)
    mainMenuFrame.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
    mainMenuFrame.BorderSizePixel = 0
    mainMenuFrame.Name = "MainMenu"
    mainMenuFrame.Parent = screenGui

    local isDragging = false
    local dragInput
    local dragStart
    local startPos

    local function update(input)
        local delta = input.Position - dragStart
        mainMenuFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end

    mainMenuFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch then
            isDragging = true
            dragStart = input.Position
            startPos = mainMenuFrame.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    isDragging = false
                end
            end)
        end
    end)

    mainMenuFrame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if input == dragInput and isDragging then
            update(input)
        end
    end)

    local abilities = {"Dash", "Forcefield", "Invisibility", "Platform", "Raging Deflection", "Shadow Step", "Super Jump", "Telekinesis", "Thunder Dash", "Freeze", "Infinity", "Pull", "Rapture", "Phase Bypass", "Waypoint"}
    local buttonHeight = 14
    for i, ability in ipairs(abilities) do
        local button = Instance.new("TextButton")
        button.Size = UDim2.new(1, 0, 0, buttonHeight)
        button.Position = UDim2.new(0, 0, 0, (i - 1) * (buttonHeight + 5))
        button.Text = ability
        button.BackgroundColor3 = Color3.fromRGB(37, 63, 96)
        button.TextColor3 = Color3.fromRGB(135, 206, 250)

        button.Parent = mainMenuFrame
        
        button.MouseButton1Click:Connect(function()
            ChosenAbility = ability
            mainMenuFrame.Visible = false
            local abilityMenuFrame = screenGui:FindFirstChild(ability)
            if not abilityMenuFrame then
                abilityMenuFrame = Instance.new("Frame")
                abilityMenuFrame.Size = UDim2.new(0.4, 0, 0.4, 0)
                abilityMenuFrame.Position = UDim2.new(0.3, 0, 0.3, 0)
                abilityMenuFrame.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
                abilityMenuFrame.BorderSizePixel = 0
                abilityMenuFrame.Name = ability
                abilityMenuFrame.Parent = screenGui
                
                -- TODO: Add UI elements specific to the ability menu
                -- Example: Add labels, buttons, etc.
            else
                abilityMenuFrame.Visible = true
            end
        end)
    end
end

local function onCharacterAdded(newCharacter)
    character = newCharacter
    abilitiesFolder = character:WaitForChild("Abilities")
    createGUI()
end

localPlayer.CharacterAdded:Connect(onCharacterAdded)
createGUI()

while task.wait() do
    for _, obj in pairs(abilitiesFolder:GetChildren()) do
        if obj:IsA("LocalScript") then
            if obj.Name == ChosenAbility then
                obj.Disabled = false
            else
                obj.Disabled = true
            end
        end
    end
end
