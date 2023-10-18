-- Создание кнопки-меню на экране
local menuButton = Instance.new("TextButton")
menuButton.Position = UDim2.new(0, 10, 0, 10)
menuButton.Size = UDim2.new(0, 100, 0, 40)
menuButton.Text = "Меню"
menuButton.Parent = script.Parent -- Положение кнопки на экране

-- При нажатии на кнопку-меню открывается окно с функциями
menuButton.MouseButton1Click:Connect(function()
    local menuFrame = Instance.new("Frame")
    menuFrame.Position = UDim2.new(0, 10, 0, 60)
    menuFrame.Size = UDim2.new(0, 200, 1, -70) -- Отступ по вертикали для кнопки-меню и нижней границы
    menuFrame.BackgroundColor3 = Color3.new(1, 1, 1)
    menuFrame.Parent = script.Parent -- Положение окна на экране

    -- Функция main - отображение кнопок в окне
    function main()
        local function1Button = Instance.new("TextButton")
        function1Button.Position = UDim2.new(0, 10, 0, 10)
        function1Button.Size = UDim2.new(0, 180, 0, 30)
        function1Button.Text = "Функция 1"
        function1Button.Parent = menuFrame

        local function2Button = Instance.new("TextButton")
        function2Button.Position = UDim2.new(0, 10, 0, 50)
        function2Button.Size = UDim2.new(0, 180, 0, 30)
        function2Button.Text = "Функция 2"
        function2Button.Parent = menuFrame

        local function3Button = Instance.new("TextButton")
        function3Button.Position = UDim2.new(0, 10, 0, 90)
        function3Button.Size = UDim2.new(0, 180, 0, 30)
        function3Button.Text = "Функция 3"
        function3Button.Parent = menuFrame

        -- Логика при нажатии на кнопки функций
        function1Button.MouseButton1Click:Connect(function()
            print("Вы выбрали функцию 1")
            -- Здесь можно написать логику для выполнения функции 1
        end)

        function2Button.MouseButton1Click:Connect(function()
            print("Вы выбрали функцию 2")
            -- Здесь можно написать логику для выполнения функции 2
        end)

        function3Button.MouseButton1Click:Connect(function()
            print("Вы выбрали функцию 3")
            -- Здесь можно написать логику для выполнения функции 3
        end)
    end

    -- Запуск программы
    print("Меню при запуске:")
    main()
end)
