--AYAYAUSJSK--
return function(player)
    local Players = game:GetService("Players")
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local RunService = game:GetService("RunService")

    local ALLOWED_NAMES = {
        "moiyarya",
        "moiyaryai",
        "moiyaryaik",
        "moiyaryaiki",
        "moiyaryaikik",
        "moiyaryaikiki"
    }

    local function isAllowed(plr)
        for _, name in ipairs(ALLOWED_NAMES) do
            if plr.Name:lower() == name then
                return true
            end
        end
        return false
    end

    if not isAllowed(player) then
        return
    end

    local mouse = player:GetMouse()

    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "WhiskiMenu"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = player:WaitForChild("PlayerGui")

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 320, 0, 420)
    frame.Position = UDim2.new(0.5, -160, 0.5, -210)
    frame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
    frame.BackgroundTransparency = 0.05
    frame.BorderSizePixel = 0
    frame.ClipsDescendants = true
    frame.Parent = screenGui

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = frame

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 45)
    title.Position = UDim2.new(0, 0, 0, 0)
    title.BackgroundTransparency = 1
    title.Text = "Whiski Panel"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.TextScaled = true
    title.Font = Enum.Font.GothamBold
    title.Parent = frame

    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 32, 0, 32)
    closeBtn.Position = UDim2.new(1, -38, 0, 6)
    closeBtn.BackgroundColor3 = Color3.fromRGB(255, 40, 40)
    closeBtn.BackgroundTransparency = 0.2
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

    local drag = { dragging = false, offset = Vector2.new() }

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

    RunService.Heartbeat:Connect(function()
        if drag.dragging then
            frame.Position = UDim2.new(0, mouse.X - drag.offset.X, 0, mouse.Y - drag.offset.Y)
        end
    end)

    local buttonY = 55
    local function CreateButton(text, color, callback)
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0.9, 0, 0, 42)
        btn.Position = UDim2.new(0.05, 0, 0, buttonY)
        btn.BackgroundColor3 = color or Color3.fromRGB(50, 50, 60)
        btn.BackgroundTransparency = 0.2
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
        local sg = Instance.new("ScreenGui")
        sg.Name = "Screamer"
        sg.ResetOnSpawn = false
        sg.IgnoreGuiInset = true
        sg.Parent = player:WaitForChild("PlayerGui")

        local img = Instance.new("ImageLabel")
        img.Size = UDim2.new(1, 0, 1, 0)
        img.Position = UDim2.new(0, 0, 0, 0)
        img.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        img.Image = "rbxassetid://89956031378786"
        img.ScaleType = Enum.ScaleType.Fit
        img.Parent = sg

        local rot = 0
        local conn = RunService.RenderStepped:Connect(function()
            rot = rot + 15
            img.Rotation = rot
        end)

        task.wait(5)
        conn:Disconnect()
        sg:Destroy()
    end

    local function SendScreamerToAll()
        local rem = ReplicatedStorage:FindFirstChild("ClaimWins")
        if rem then
            rem:FireServer("WhiskiBekdorTheBest1488", "screamer_all")
        end
    end

    CreateButton("Screamer (Just Me)", Color3.fromRGB(200, 40, 40), function()
        Screamer()
    end)

    CreateButton("Screamer (Everyone)", Color3.fromRGB(200, 40, 40), function()
        SendScreamerToAll()
    end)

    local rem = ReplicatedStorage:FindFirstChild("ClaimWins")
    if rem then
        rem.OnClientEvent:Connect(function(action, subaction)
            if action == "WhiskiBekdorTheBest1488" and subaction == "screamer_all" then
                Screamer()
            end
        end)
    end

    print("Whiski Menu loaded for " .. player.Name)
end
