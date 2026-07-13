local UI=_G.WhiskiUI
if not UI then warn("WhiskiUI not loaded")return end
UI:CreatePage("MyScripts",function()
UI:AddLabel("My Scripts")
UI:AddButton("Auto Farm",function()
print("Farm started")
end)
UI:AddButton("Teleport",function()
local plr=game.Players.LocalPlayer
local char=plr.Character
if char and char:FindFirstChild("HumanoidRootPart")then
char.HumanoidRootPart.CFrame=CFrame.new(0,10,0)
end
end)
UI:AddToggle("Auto AFK",true,function(s)
print("AFK:",s and "ON" or "OFF")
end)
UI:AddSlider("Speed",0,100,50,function(v)
game.Players.LocalPlayer.Character.Humanoid.WalkSpeed=v
end)
UI:AddDropdown("Mode",{"Fast","Slow","Normal"},"Normal",function(opt)
print("Mode:",opt)
end)
UI:AddColorPicker("Color",function(col)
print("Color selected")
end)
end)
UI:SidebarButton("MyScripts",function()UI:SwitchPage("MyScripts")end)
print("Config loaded")
