Hello guys!
I'm a partner in the discord chanel https://discord.gg/7gHQjAHzeW (pls join)
It's the best Westbound script I think, because it works with any roblox executors! (It works on Solara with 67% UNC)
===

I made this UI library for those who want to support us (later I will add a link to our Discord channel). 
Right now, I am improving it, and I hope in the future it will work better and have more features!
===

                                                            ======================
                                                                  HOW TO USE
                                                            ======================
Booting and setting up:
=
```
local UILibrary = loadstring(game:HttpGet(('https://raw.githubusercontent.com/PurpleGuyCoyote/WestWare-ui-lib/refs/heads/main/BootUILib.lua')))() -- Booting the library

-- Making a window
local window = UILibrary:CreateWindow("YOUR HUB NAME HERE", UDim2.new(0, 400, 0, 300), UDim2.new(0.5, -200, 0.5, -150))

-- Making tabs
local tabs = UILibrary:CreateTab(window, {"Tab 1", "Tab 2", "Tab 3"})

-- Adding a button to the first tab
UILibrary:CreateButton(tabs[1], "Click Me!", UDim2.new(0, 100, 0, 50), UDim2.new(0, 10, 0, 10), 
function()
    print("Button Clicked!")   
end)

-- Adding Input field to the second tab
local textBox = UILibrary:CreateTextBox(tabs[2], "Enter text here...", UDim2.new(0, 200, 0, 50), UDim2.new(0, 10, 0, 10))
textBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        print(textBox.Text) -- Function when user press Enter after typing text
    end
end)

-- Adding checkbox to the third tab
UILibrary:CreateCheckBox(tabs[3], "Enable feature", UDim2.new(0, 200, 0, 30), UDim2.new(0, 10, 0, 70),
function(isChecked)
    print("Checkbox status:", isChecked)
end)
```
