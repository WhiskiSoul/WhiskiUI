-- main.lua - Для Sirius / Delta Executor с Rayfield UI
-- GitHub raw: залей и выполняй через loadstring

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "Whiski Overlay",
    Icon = 0,
    LoadingTitle = "WhiskiSoul Mod",
    LoadingSubtitle = "by Whiski",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "WhiskiConfig",
        FileName = "WhiskiSettings"
    },
    KeySystem = false
})

local MainTab = Window:CreateTab("Display", 0)

local isActive = false
local textLabel = nil
local bgFrame = nil
local pulseCoroutine = nil
local colorCoroutine = nil

local function createOverlay()
    if textLabel then return end
    
    local sg = Instance.new("ScreenGui")
    sg.Name = "WhiskiOverlay"
    sg.ResetOnSpawn = false
    sg.Parent = game:GetService("CoreGui")
    
    bgFrame = Instance.new("Frame")
    bgFrame.Size = UDim2.new(1, 0, 1, 0)
    bgFrame.BackgroundColor3 = Color3.new(0, 0, 0)
    bgFrame.BackgroundTransparency = 0.8
    bgFrame.Visible = false
    bgFrame.Parent = sg
    
    textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, 0, 1, 0)
    textLabel.Position = UDim2.new(0, 0, 0, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = "WHISKITHEBEST"
    textLabel.TextColor3 = Color3.new(1, 0, 0)
    textLabel.TextScaled = true
    textLabel.Font = Enum.Font.BlackOpsOne
    textLabel.TextStrokeColor3 = Color3.new(0.3, 0, 0)
    textLabel.TextStrokeTransparency = 0.1
    textLabel.Visible = false
    textLabel.Parent = sg
    
    local glow = Instance.new("UIStroke")
    glow.Color = Color3.new(1, 0, 0)
    glow.Thickness = 6
    glow.Transparency = 0.6
    glow.Parent = textLabel
end

local function stopAnimations()
    if pulseCoroutine then task.cancel(pulseCoroutine) end
    if colorCoroutine then task.cancel(colorCoroutine) end
    pulseCoroutine = nil
    colorCoroutine = nil
end

local function startPulse()
    stopAnimations()
    pulseCoroutine = task.spawn(function()
        local dir = 1
        local scale = 0.9
        while isActive do
            scale = scale + (dir * 0.003)
            if scale >= 1.1 then dir = -1 end
            if scale <= 0.9 then dir = 1 end
            if textLabel then
                textLabel.Size = UDim2.new(scale, 0, scale, 0)
            end
            task.wait(0.016)
        end
        if textLabel then
            textLabel.Size = UDim2.new(1, 0, 1, 0)
        end
    end)
    
    colorCoroutine = task.spawn(function()
        local hue = 0
        while isActive do
            hue = (hue + 0.005) % 1
            local r = math.sin(hue * 2 * math.pi) * 0.3 + 0.7
            if textLabel then
                textLabel.TextColor3 = Color3.new(r, 0.05, 0.05)
            end
            task.wait(0.05)
        end
        if textLabel then
            textLabel.TextColor3 = Color3.new(1, 0, 0)
        end
    end)
end

local function toggleDisplay()
    if not textLabel then createOverlay() end
    isActive = not isActive
    textLabel.Visible = isActive
    bgFrame.Visible = isActive
    
    if isActive then
        startPulse()
    else
        stopAnimations()
    end
end

MainTab:CreateButton({
    Name = "▶ TOGGLE WHISKITHEBEST",
    Callback = function()
        toggleDisplay()
        Rayfield:Notify({
            Title = "Whiski",
            Content = isActive and "Overlay ON" or "Overlay OFF",
            Duration = 1.5
        })
    end
})

local SettingsTab = Window:CreateTab("Settings", 1)

SettingsTab:CreateSlider({
    Name = "Base Scale",
    Range = {50, 150},
    Increment = 5,
    Suffix = "%",
    CurrentValue = 100,
    Flag = "ScaleSlider",
    Callback = function(v)
        if textLabel then
            textLabel.TextScaled = false
            textLabel.TextSize = v
        end
    end
})

SettingsTab:CreateSlider({
    Name = "Background Opacity",
    Range = {0, 100},
    Increment = 5,
    Suffix = "%",
    CurrentValue = 80,
    Flag = "BgOpacity",
    Callback = function(v)
        if bgFrame then
            bgFrame.BackgroundTransparency = 1 - (v / 100)
        end
    end
})

SettingsTab:CreateToggle({
    Name = "Enable Pulse Effect",
    CurrentValue = true,
    Flag = "PulseToggle",
    Callback = function(state)
        if state and isActive then
            startPulse()
        elseif not state then
            stopAnimations()
            if textLabel then
                textLabel.Size = UDim2.new(1, 0, 1, 0)
            end
        end
    end
})

-- Горячая клавиша M
game:GetService("UserInputService").InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == Enum.KeyCode.M then
        toggleDisplay()
    end
end)

Rayfield:Notify({
    Title = "Whiski Mod",
    Content = "Loaded! Press M to toggle",
    Duration = 3
})

Rayfield:LoadConfiguration()
