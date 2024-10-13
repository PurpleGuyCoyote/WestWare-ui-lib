local UILibrary = {}

-- Функция для создания окна
function UILibrary:CreateWindow(title, size, position)
    local window = Instance.new("Frame")
    window.Size = size or UDim2.new(0, 400, 0, 300)
    window.Position = position or UDim2.new(0.5, -200, 0.5, -150)
    window.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    window.BorderSizePixel = 0
    window.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

    -- Заголовок окна
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, 0, 0, 50)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = title
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.Font = Enum.Font.SourceSansBold
    titleLabel.TextSize = 24
    titleLabel.Parent = window

    return window
end

-- Функция для создания вкладок
function UILibrary:CreateTab(parent, tabNames)
    local tabs = {}
    local tabContainer = Instance.new("Frame")
    tabContainer.Size = UDim2.new(1, 0, 1, -50)
    tabContainer.Position = UDim2.new(0, 0, 0, 50)
    tabContainer.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    tabContainer.Parent = parent

    for i, name in ipairs(tabNames) do
        local tabButton = Instance.new("TextButton")
        tabButton.Size = UDim2.new(1 / #tabNames, 0, 0, 50)
        tabButton.Position = UDim2.new((i - 1) / #tabNames, 0, 0, 0)
        tabButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
        tabButton.Text = name
        tabButton.Parent = parent

        tabButton.MouseButton1Click:Connect(function()
            for _, tab in pairs(tabs) do
                tab.Visible = false
            end
            tabContainer:FindFirstChild(name).Visible = true
        end)

        table.insert(tabs, tabContainer:FindFirstChild(name))
    end

    return tabs
end

-- Функция для создания кнопки
function UILibrary:CreateButton(parent, buttonText, size, position, callback)
    local button = Instance.new("TextButton")
    button.Size = size or UDim2.new(0, 200, 0, 50)
    button.Position = position or UDim2.new(0, 10, 0, 60)
    button.BackgroundColor3 = Color3.fromRGB(60, 60, 100)
    button.Text = buttonText
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Font = Enum.Font.SourceSans
    button.TextSize = 20
    button.Parent = parent

    button.MouseButton1Click:Connect(callback)

    return button
end

-- Функция для создания текстового поля
function UILibrary:CreateTextBox(parent, placeholder, size, position)
    local textBox = Instance.new("TextBox")
    textBox.Size = size or UDim2.new(0, 200, 0, 50)
    textBox.Position = position or UDim2.new(0, 10, 0, 60)
    textBox.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    textBox.Text = placeholder
    textBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    textBox.Font = Enum.Font.SourceSans
    textBox.TextSize = 20
    textBox.Parent = parent

    return textBox
end

-- Функция для создания переключателя (CheckBox)
function UILibrary:CreateCheckBox(parent, labelText, size, position, callback)
    local checkBox = Instance.new("Frame")
    checkBox.Size = size or UDim2.new(0, 200, 0, 30)
    checkBox.Position = position or UDim2.new(0, 10, 0, 130)
    checkBox.BackgroundTransparency = 1
    checkBox.Parent = parent

    local box = Instance.new("TextButton")
    box.Size = UDim2.new(0, 30, 0, 30)
    box.Position = UDim2.new(0, 0, 0, 0)
    box.BackgroundColor3 = Color3.fromRGB(60, 60, 100)
    box.Text = ""
    box.Parent = checkBox

    -- Элементы для галочки и крестика
    local checkmark = Instance.new("TextLabel")
    checkmark.Size = UDim2.new(1, 0, 1, 0)
    checkmark.BackgroundTransparency = 1
    checkmark.Text = "✔" -- Галочка
    checkmark.TextColor3 = Color3.fromRGB(0, 255, 0) -- Зелёный цвет
    checkmark.Font = Enum.Font.SourceSans
    checkmark.TextSize = 20
    checkmark.Position = UDim2.new(0.5, -10, 0.5, -10) -- Центрирование
    checkmark.Parent = box
    checkmark.Visible = false -- Скрываем галочку по умолчанию

    local cross = Instance.new("TextLabel")
    cross.Size = UDim2.new(1, 0, 1, 0)
    cross.BackgroundTransparency = 1
    cross.Text = "✖" -- Крестик
    cross.TextColor3 = Color3.fromRGB(255, 0, 0) -- Красный цвет
    cross.Font = Enum.Font.SourceSans
    cross.TextSize = 20
    cross.Position = UDim2.new(0.5, -10, 0.5, -10) -- Центрирование
    cross.Parent = box
    cross.Visible = true -- Показываем крестик по умолчанию

    local isChecked = false
    box.MouseButton1Click:Connect(function()
        isChecked = not isChecked
        if isChecked then
            checkmark.Visible = true
            cross.Visible = false
        else
            checkmark.Visible = false
            cross.Visible = true
        end
        if callback then
            callback(isChecked)
        end
    end)

    return checkBox
end

return UILibrary
