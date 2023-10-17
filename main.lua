local localPlayer = game.Players.LocalPlayer
local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()
local abilitiesFolder = character:WaitForChild("Abilities")

local ChosenAbility = "Raging Deflection"

local function createGUI()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "AbilityChooser"
    screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0.080, 100, 0.45, 100)
    frame.Position = UDim2.new(0.15, -90, 0.4, -100)
    frame.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
    frame.BorderSizePixel = 0
    frame.Parent = screenGui

    local minimizeButton = Instance.new("TextButton")
    minimizeButton.Size = UDim2.new(0.1, 0, 0.05, 0)
    minimizeButton.Position = UDim2.new(0.9, 0, 0, 0)
    minimizeButton.BackgroundColor3 = Color3.fromRGB(37, 63, 96)
    minimizeButton.Text = "-"
    minimizeButton.Parent = frame

    local isDragging = false
    local dragInput
    local dragStart
    local startPos

    local function update(input)
        local delta = input.Position - dragStart
        frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end

    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch then
            isDragging = true
            dragStart = input.Position
            startPos = frame.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    isDragging = false
                end
            end)
        end
    end)

    frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if input == dragInput and isDragging then
            update(input)
        end
    end)

    minimizeButton.MouseButton1Click:Connect(function()
        frame.Visible = not frame.Visible
    end)

    -- Ability function
    local function Ability(abilityName)
        ChosenAbility = abilityName
        frame.Visible = false
        local abilityMenuFrame = screenGui:FindFirstChild(abilityName)
        if not abilityMenuFrame then
            abilityMenuFrame = Instance.new("Frame")
            abilityMenuFrame.Size = UDim2.new(0.4, 0, 0.4, 0)
            abilityMenuFrame.Position = UDim2.new(0.3, 0, 0.3, 0)
            abilityMenuFrame.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
            abilityMenuFrame.BorderSizePixel = 0
            abilityMenuFrame.Name = abilityName
            abilityMenuFrame.Parent = screenGui

            -- TODO: Add UI elements specific to the ability menu
            -- Example: Add labels, buttons, etc.
            local abilityButton = Instance.new("TextButton")
            abilityButton.Size = UDim2.new(0.5, 0, 0.2, 0)
            abilityButton.Position = UDim2.new(0.25, 0, 0.4, 0)
            abilityButton.BackgroundColor3 = Color3.fromRGB(37, 63, 96)
            abilityButton.TextColor3 = Color3.fromRGB(135, 206, 250)
            abilityButton.Text = "Use Ability"
            abilityButton.Parent = abilityMenuFrame

            abilityButton.MouseButton1Click:Connect(function()
                print("Ability used:", abilityName)
            end)
        else
            abilityMenuFrame.Visible = true
        end
    end

    local abilities = {"Dash", "Forcefield", "Invisibility", "Platform", "Raging Deflection", "Shadow Step", "Super Jump", "Telekinesis", "Thunder Dash", "Freeze", "Infinity", "Pull", "Rapture", "Phase Bypass", "Waypoint"}
    local buttonHeight = 14
    for i, ability in ipairs(abilities) do
        local button = Instance.new("TextButton")
        button.Size = UDim2.new(1, 0, 0, buttonHeight)
        button.Position = UDim2.new(0, 0, 0, (i - 1) * (buttonHeight + 5))
        button.Text = ability
        button.BackgroundColor3 = Color3.fromRGB(37, 63, 96)
        button.TextColor3 = Color3.fromRGB(135, 206, 250)
        button.Parent = frame

        button.MouseButton1Click:Connect(function()
            Ability(ability)
        end)
    end
end

local function onCharacterAdded(newCharacter)
    character = newCharacter
    abilitiesFolder = character:WaitForChild("Abilities")
    createGUI()
end

localPlayer.CharacterAdded:Connect(onCharacterAdded
