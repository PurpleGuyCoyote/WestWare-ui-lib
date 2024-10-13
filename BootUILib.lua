-- Создаем библиотеку
local UILibrary = {}

-- Функция для создания окна (Frame) с возможностью перетаскивания
function UILibrary:CreateWindow(title, size, position)
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "CustomUI"
    screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    
    local frame = Instance.new("Frame")
    frame.Size = size or UDim2.new(0, 400, 0, 300)
    frame.Position = position or UDim2.new(0.5, -200, 0.5, -150)
    frame.AnchorPoint = Vector2.new(0.5, 0.5)
    frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    frame.BorderSizePixel = 0
    frame.Parent = screenGui

    -- Добавляем закругленные углы
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 10)  -- Угол закругления в 10 пикселей
    corner.Parent = frame
    
    local titleBar = Instance.new("Frame")
    titleBar.Size = UDim2.new(1, 0, 0, 30)
    titleBar.Position = UDim2.new(0, 0, 0, 0)
    titleBar.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    titleBar.Parent = frame

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, 0, 1, 0)
    titleLabel.Position = UDim2.new(0, 0, 0, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = title
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.Font = Enum.Font.SourceSansBold
    titleLabel.TextSize = 20
    titleLabel.Parent = titleBar

    -- Перетаскивание окна
    local dragging = false
    local dragStart = nil
    local startPos = nil

    titleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    titleBar.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement and dragging then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)

    return frame
end

-- Функция для создания вкладок
function UILibrary:CreateTab(frame, tabNames)
    local tabHolder = Instance.new("Frame")
    tabHolder.Size = UDim2.new(1, 0, 0, 30)
    tabHolder.Position = UDim2.new(0, 0, 0, 30)
    tabHolder.BackgroundTransparency = 1
    tabHolder.Parent = frame
    
    local tabs = {}
    local contentFrames = {}
    
    for i, tabName in ipairs(tabNames) do
        local tabButton = Instance.new("TextButton")
        tabButton.Size = UDim2.new(0, 100, 0, 30)
        tabButton.Position = UDim2.new(0, (i - 1) * 100, 0, 0)
        tabButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
        tabButton.Text = tabName
        tabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        tabButton.Font = Enum.Font.SourceSansBold
        tabButton.TextSize = 18
        tabButton.Parent = tabHolder
        
        local contentFrame = Instance.new("Frame")
        contentFrame.Size = UDim2.new(1, 0, 1, -60)
        contentFrame.Position = UDim2.new(0, 0, 0, 60)
        contentFrame.BackgroundTransparency = 1
        contentFrame.Visible = i == 1
        contentFrame.Parent = frame
        
        table.insert(tabs, tabButton)
        table.insert(contentFrames, contentFrame)
        
        -- Логика переключения вкладок
        tabButton.MouseButton1Click:Connect(function()
            for j, otherContent in ipairs(contentFrames) do
                otherContent.Visible = false
            end
            contentFrame.Visible = true
        end)
    end
    
    return contentFrames
end

-- Функция для создания кнопки
function UILibrary:CreateButton(parent, text, size, position, callback)
    local button = Instance.new("TextButton")
    button.Size = size or UDim2.new(0, 200, 0, 50)
    button.Position = position or UDim2.new(0, 10, 0, 10)
    button.BackgroundColor3 = Color3.fromRGB(90, 90, 90)
    button.Text = text
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Font = Enum.Font.SourceSans
    button.TextSize = 18
    button.Parent = parent

    -- Закругленные углы
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 5)
    corner.Parent = button

    button.MouseButton1Click:Connect(function()
        if callback then
            callback()
        end
    end)

    return button
end

-- Функция для создания поля ввода (TextBox)
function UILibrary:CreateTextBox(parent, placeholderText, size, position)
    local textBox = Instance.new("TextBox")
    textBox.Size = size or UDim2.new(0, 200, 0, 50)
    textBox.Position = position or UDim2.new(0, 10, 0, 70)
    textBox.BackgroundColor3 = Color3.fromRGB(90, 90, 90)
    textBox.Text = ""
    textBox.PlaceholderText = placeholderText
    textBox.PlaceholderColor3 = Color3.fromRGB(180, 180, 180)
    textBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    textBox.Font = Enum.Font.SourceSans
    textBox.TextSize = 18
    textBox.Parent = parent

    -- Закругленные углы
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 5)
    corner.Parent = textBox

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
    box.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    box.Text = ""
    box.Parent = checkBox

    -- Закругленные углы для переключателя
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 5)
    corner.Parent = box

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -40, 1, 0)
    label.Position = UDim2.new(0, 40, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = labelText
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.Font = Enum.Font.SourceSans
    label.TextSize = 18
    label.Parent = checkBox

    local isChecked = false
    box.MouseButton1Click:Connect(function()
        isChecked = not isChecked
        if isChecked then
            box.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
            box.Text = "✔"  -- Галочка
        else
            box.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            box.Text = "✖"  -- Крестик
        end
        if callback then
            callback(isChecked)
        end
    end)

    return checkBox
end

return UILibrary
