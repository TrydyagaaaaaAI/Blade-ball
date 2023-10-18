local localPlayer = game.Players.LocalPlayer
local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()
local abilitiesFolder = character:WaitForChild("Abilities")

local ChosenAbility = ""

local function createGUI()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "AbilityChooser"
    screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

    local menuFrame = Instance.new("Frame")
    menuFrame.Size = UDim2.new(0.1, 100, 0.05, 50)
    menuFrame.Position = UDim2.new(0, 0, 0, 0)
    menuFrame.BackgroundColor3 = Color3.fromRGB(37, 63, 96)
    menuFrame.BorderSizePixel = 0
    menuFrame.Parent = screenGui

    local abilitiesFrame = Instance.new("Frame")
    abilitiesFrame.Size = UDim2.new(0.2, 200, 0.2, 200)
    abilitiesFrame.Position = UDim2.new(1, 0, 0, 0)
    abilitiesFrame.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
    abilitiesFrame.BorderSizePixel = 0
    abilitiesFrame.Visible = false
    abilitiesFrame.Parent = screenGui

    local abilitiesText = Instance.new("TextLabel")
    abilitiesText.Size = UDim2.new(1, 0, 0, 30)
    abilitiesText.BackgroundColor3 = Color3.fromRGB(37, 63, 96)
    abilitiesText.Text = "Choose an ability:"
    abilitiesText.TextColor3 = Color3.new(1, 1, 1)
    abilitiesText.Parent = abilitiesFrame

    local abilityButton1 = Instance.new("TextButton")
    abilityButton1.Size = UDim2.new(1, 0, 0, 30)
    abilityButton1.BackgroundColor3 = Color3.fromRGB(37, 63, 96)
    abilityButton1.Text = "Raging Deflection"
    abilityButton1.TextColor3 = Color3.new(1, 1, 1)
    abilityButton1.Parent = abilitiesFrame

    abilityButton1.MouseButton1Click:Connect(function()
        ChosenAbility = "Raging Deflection"
        abilitiesFrame.Visible = false
    end)

    local minimizeButton = Instance.new("TextButton")
    minimizeButton.Size = UDim2.new(0.05, 0, 0.05, 0)
    minimizeButton.Position = UDim2.new(1, -20, 0, 0)
    minimizeButton.BackgroundColor3 = Color3.fromRGB(37, 63, 96)
    minimizeButton.Text = "-"
    minimizeButton.TextColor3 = Color3.new(1, 1, 1)
    minimizeButton.Parent = menuFrame

    minimizeButton.MouseButton1Click:Connect(function()
        abilitiesFrame.Visible = not abilitiesFrame.Visible
    end)

    local isDragging = false
    local dragInput
    local dragStart
    local startPos

    local function update(input)
        local delta = input.Position - dragStart
        menuFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end

    menuFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch then
            isDragging = true
            dragStart = input.Position
            startPos = menuFrame.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    isDragging = false
                end
            end)
        end
    end)

    menuFrame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if input == dragInput and isDragging then
            update(input)
        end
    end)
end

createGUI()