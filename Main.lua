local UIS=game:GetService("UserInputService")
local TS=game:GetService("TweenService")
local Players=game:GetService("Players")
local LP=Players.LocalPlayer
pcall(function()if gethui and gethui():FindFirstChild("WhiskiUI")then gethui().WhiskiUI:Destroy()end end)
pcall(function()if game:GetService("CoreGui"):FindFirstChild("WhiskiUI")then game:GetService("CoreGui").WhiskiUI:Destroy()end end)
local gui=Instance.new("ScreenGui")
gui.Name="WhiskiUI"
gui.ResetOnSpawn=false
pcall(function()if gethui then gui.Parent=gethui()end end)
if not gui.Parent then pcall(function()gui.Parent=game:GetService("CoreGui")end)end
if not gui.Parent then gui.Parent=LP:WaitForChild("PlayerGui")end
local Theme={BG=Color3.fromRGB(10,10,12),Surface=Color3.fromRGB(18,18,22),El=Color3.fromRGB(26,26,32),Text=Color3.fromRGB(200,200,210),Sub=Color3.fromRGB(120,120,135),Stroke=Color3.fromRGB(45,45,55),Accent=Color3.fromRGB(0,200,255),AccentDim=Color3.fromRGB(0,100,180)}
local function Corner(p,r)local c=Instance.new("UICorner")c.CornerRadius=UDim.new(0,r or 8)c.Parent=p return c end
local function Stroke(p,c,th,tr)local s=Instance.new("UIStroke")s.Color=c or Theme.Stroke s.Thickness=th or 1 s.Transparency=tr or 0 s.Parent=p return s end
local function Tween(p,props,time,style)local tw=TS:Create(p,TweenInfo.new(time or 0.35,style or Enum.EasingStyle.Quart,Enum.EasingDirection.Out),props)tw:Play()return tw end
local icon=Instance.new("TextButton")
icon.Size=UDim2.new(0,50,0,50)
icon.Position=UDim2.new(0,10,0,10)
icon.BackgroundColor3=Theme.Surface
icon.Text="W"
icon.TextColor3=Theme.Text
icon.TextSize=20
icon.Font=Enum.Font.GothamBold
icon.AutoButtonColor=false
icon.ZIndex=10
icon.Parent=gui
Corner(icon,25)
Stroke(icon,Theme.Stroke,1.5,0.4)
local W=420
local H=280
local main=Instance.new("Frame")
main.Size=UDim2.new(0,W,0,H)
main.Position=UDim2.new(0.5,-W/2,0.5,-H/2)
main.BackgroundColor3=Theme.BG
main.BorderSizePixel=0
main.ClipsDescendants=true
main.Parent=gui
main.Visible=false
Corner(main,12)
Stroke(main,Theme.Stroke,1,0.5)
local top=Instance.new("Frame")
top.Size=UDim2.new(1,0,0,38)
top.BackgroundColor3=Theme.Surface
top.BorderSizePixel=0
top.ZIndex=3
top.Parent=main
Corner(top,12)
local title=Instance.new("TextLabel")
title.Size=UDim2.new(1,-40,1,0)
title.Position=UDim2.new(0,20,0,0)
title.BackgroundTransparency=1
title.Text="WhiskiUI"
title.TextColor3=Theme.Text
title.TextSize=13
title.Font=Enum.Font.GothamBold
title.TextXAlignment=Enum.TextXAlignment.Left
title.ZIndex=4
title.Parent=top
local close=Instance.new("TextButton")
close.Size=UDim2.new(0,28,0,28)
close.Position=UDim2.new(1,-34,0.5,-14)
close.BackgroundColor3=Theme.BG
close.BackgroundTransparency=1
close.Text="×"
close.TextColor3=Color3.fromRGB(120,120,120)
close.TextSize=20
close.Font=Enum.Font.GothamBold
close.AutoButtonColor=false
close.ZIndex=4
close.Parent=top
Corner(close,6)
close.MouseButton1Click:Connect(function()Tween(main,{Size=UDim2.new(0,0,0,0),Position=UDim2.new(0.5,0,0.5,0)},0.3)task.wait(0.35)main.Visible=false main.Size=UDim2.new(0,W,0,H)main.Position=UDim2.new(0.5,-W/2,0.5,-H/2)end)
local drag=false
local dragStart,startPos
top.InputBegan:Connect(function(i)if i.UserInputType==Enum.UserInputType.MouseButton1 then drag=true dragStart=i.Position startPos=main.Position end end)
UIS.InputChanged:Connect(function(i)if drag and i.UserInputType==Enum.UserInputType.MouseMovement then local delta=i.Position-dragStart main.Position=UDim2.new(startPos.X.Scale,startPos.X.Offset+delta.X,startPos.Y.Scale,startPos.Y.Offset+delta.Y)end end)
UIS.InputEnded:Connect(function(i)if i.UserInputType==Enum.UserInputType.MouseButton1 then drag=false end end)
local sidebar=Instance.new("Frame")
sidebar.Size=UDim2.new(0,100,1,-38)
sidebar.Position=UDim2.new(0,0,0,38)
sidebar.BackgroundColor3=Theme.Surface
sidebar.BackgroundTransparency=0.3
sidebar.BorderSizePixel=0
sidebar.ZIndex=3
sidebar.Parent=main
local sidebarLayout=Instance.new("UIListLayout")
sidebarLayout.Padding=UDim.new(0,4)
sidebarLayout.Parent=sidebar
local sidebarPad=Instance.new("UIPadding")
sidebarPad.PaddingTop=UDim.new(0,10)
sidebarPad.PaddingLeft=UDim.new(0,8)
sidebarPad.PaddingRight=UDim.new(0,8)
sidebarPad.Parent=sidebar
local content=Instance.new("Frame")
content.Size=UDim2.new(1,-100,1,-38)
content.Position=UDim2.new(0,100,0,38)
content.BackgroundTransparency=1
content.ZIndex=3
content.Parent=main
local contentPad=Instance.new("UIPadding")
contentPad.PaddingTop=UDim.new(0,12)
contentPad.PaddingLeft=UDim.new(0,16)
contentPad.PaddingRight=UDim.new(0,16)
contentPad.PaddingBottom=UDim.new(0,12)
contentPad.Parent=content
local contentLayout=Instance.new("UIListLayout")
contentLayout.Padding=UDim.new(0,8)
contentLayout.SortOrder=Enum.SortOrder.LayoutOrder
contentLayout.Parent=content
local pages={}
local currentPage=nil
function SwitchPage(name)for k,v in pairs(pages)do v.Visible=(k==name)end currentPage=name end
function CreatePage(name,buildFunction)local page=Instance.new("Frame")page.Size=UDim2.new(1,0,1,0)page.BackgroundTransparency=1 page.Visible=false page.ZIndex=3 page.Parent=content local layout=Instance.new("UIListLayout")layout.Padding=UDim.new(0,8)layout.SortOrder=Enum.SortOrder.LayoutOrder layout.Parent=page local pad=Instance.new("UIPadding")pad.PaddingTop=UDim.new(0,4)pad.Parent=page local oldContent=content content=page if buildFunction then buildFunction()end content=oldContent pages[name]=page return page end
function SidebarButton(name,callback)local btn=Instance.new("TextButton")btn.Size=UDim2.new(1,0,0,32)btn.BackgroundColor3=Theme.El btn.BackgroundTransparency=0.5 btn.Text=name btn.TextColor3=Theme.Sub btn.TextSize=11 btn.Font=Enum.Font.GothamMedium btn.AutoButtonColor=false btn.ZIndex=4 btn.Parent=sidebar Corner(btn,6)local indicator=Instance.new("Frame")indicator.Size=UDim2.new(0,2,0,0)indicator.Position=UDim2.new(0,0,0.5,0)indicator.AnchorPoint=Vector2.new(0,0.5)indicator.BackgroundColor3=Theme.Text indicator.BorderSizePixel=0 indicator.ZIndex=5 indicator.Parent=btn Corner(indicator,1)btn.MouseButton1Click:Connect(function()for _,child in ipairs(sidebar:GetChildren())do if child:IsA("TextButton")then local ind=child:FindFirstChildOfClass("Frame")if ind then Tween(ind,{Size=UDim2.new(0,2,0,0)},0.2)end child.TextColor3=Theme.Sub end end Tween(indicator,{Size=UDim2.new(0,2,0,20)},0.25,Enum.EasingStyle.Back)btn.TextColor3=Theme.Text if callback then callback()end end)return btn end
local WhiskiUI={}
function WhiskiUI:AddLabel(text)local f=Instance.new("Frame")f.Size=UDim2.new(1,0,0,30)f.BackgroundColor3=Theme.Surface f.BackgroundTransparency=0.2 f.Parent=content Corner(f,6)local l=Instance.new("TextLabel")l.Size=UDim2.new(1,-10,1,0)l.Position=UDim2.new(0,10,0,0)l.BackgroundTransparency=1 l.Text=text l.TextColor3=Theme.Text l.TextSize=12 l.Font=Enum.Font.Gotham l.TextXAlignment=Enum.TextXAlignment.Center l.Parent=f return f end
function WhiskiUI:AddButton(text,callback)local f=Instance.new("TextButton")f.Size=UDim2.new(1,0,0,32)f.BackgroundColor3=Theme.El f.BackgroundTransparency=0.5 f.Text=text f.TextColor3=Theme.Text f.TextSize=12 f.Font=Enum.Font.GothamMedium f.AutoButtonColor=false f.Parent=content Corner(f,6)f.MouseButton1Click:Connect(function()if callback then pcall(callback)end end)return f end
function WhiskiUI:AddToggle(text,default,callback)local state=default or false local f=Instance.new("Frame")f.Size=UDim2.new(1,0,0,32)f.BackgroundColor3=Theme.Surface f.BackgroundTransparency=0.2 f.Parent=content Corner(f,6)local l=Instance.new("TextLabel")l.Size=UDim2.new(1,-50,1,0)l.Position=UDim2.new(0,10,0,0)l.BackgroundTransparency=1 l.Text=text l.TextColor3=Theme.Text l.TextSize=12 l.Font=Enum.Font.Gotham l.TextXAlignment=Enum.TextXAlignment.Left l.Parent=f local toggle=Instance.new("TextButton")toggle.Size=UDim2.new(0,40,0,20)toggle.Position=UDim2.new(1,-48,0.5,-10)toggle.BackgroundColor3=state and Theme.Accent or Theme.Stroke toggle.Text=state and "ON" or "OFF" toggle.TextColor3=Theme.Text toggle.TextSize=8 toggle.Font=Enum.Font.GothamBold toggle.AutoButtonColor=false toggle.Parent=f Corner(toggle,10)toggle.MouseButton1Click:Connect(function()state=not state toggle.BackgroundColor3=state and Theme.Accent or Theme.Stroke toggle.Text=state and "ON" or "OFF" if callback then callback(state)end end)return f end
function WhiskiUI:AddSlider(text,min,max,default,callback)local val=default or min local f=Instance.new("Frame")f.Size=UDim2.new(1,0,0,44)f.BackgroundColor3=Theme.Surface f.BackgroundTransparency=0.2 f.Parent=content Corner(f,6)local l=Instance.new("TextLabel")l.Size=UDim2.new(1,-60,0,20)l.Position=UDim2.new(0,10,0,0)l.BackgroundTransparency=1 l.Text=text l.TextColor3=Theme.Text l.TextSize=11 l.Font=Enum.Font.Gotham l.TextXAlignment=Enum.TextXAlignment.Left l.Parent=f local valLabel=Instance.new("TextLabel")valLabel.Size=UDim2.new(0,40,0,20)valLabel.Position=UDim2.new(1,-50,0,0)valLabel.BackgroundTransparency=1 valLabel.Text=tostring(val)valLabel.TextColor3=Theme.Accent valLabel.TextSize=11 valLabel.Font=Enum.Font.GothamBold valLabel.TextXAlignment=Enum.TextXAlignment.Right valLabel.Parent=f local track=Instance.new("Frame")track.Size=UDim2.new(1,-24,0,4)track.Position=UDim2.new(0,12,1,-10)track.BackgroundColor3=Theme.Stroke track.Parent=f Corner(track,2)local fill=Instance.new("Frame")fill.Size=UDim2.new((val-min)/(max-min),0,1,0)fill.BackgroundColor3=Theme.Accent fill.Parent=track Corner(fill,2)local sliding=false local function update(x)local r=math.clamp((x-track.AbsolutePosition.X)/math.max(track.AbsoluteSize.X,1),0,1)val=math.floor(min+(max-min)*r+0.5)valLabel.Text=tostring(val)fill.Size=UDim2.new(r,0,1,0)if callback then callback(val)end end track.InputBegan:Connect(function(i)if i.UserInputType==Enum.UserInputType.MouseButton1 then sliding=true update(i.Position.X)end end)UIS.InputChanged:Connect(function(i)if sliding and i.UserInputType==Enum.UserInputType.MouseMovement then update(i.Position.X)end end)UIS.InputEnded:Connect(function(i)if i.UserInputType==Enum.UserInputType.MouseButton1 then sliding=false end end)return f end
function WhiskiUI:AddDropdown(text,options,default,callback)local open=false local selected=default or options[1] or "" local f=Instance.new("Frame")f.Size=UDim2.new(1,0,0,34)f.BackgroundColor3=Theme.Surface f.BackgroundTransparency=0.2 f.ClipsDescendants=true f.Parent=content Corner(f,6)local l=Instance.new("TextLabel")l.Size=UDim2.new(1,-80,0,34)l.Position=UDim2.new(0,10,0,0)l.BackgroundTransparency=1 l.Text=text l.TextColor3=Theme.Text l.TextSize=11 l.Font=Enum.Font.Gotham l.TextXAlignment=Enum.TextXAlignment.Left l.Parent=f local sel=Instance.new("TextLabel")sel.Size=UDim2.new(0,70,0,34)sel.Position=UDim2.new(1,-80,0,0)sel.BackgroundTransparency=1 sel.Text=selected sel.TextColor3=Theme.Accent sel.TextSize=11 sel.Font=Enum.Font.GothamMedium sel.TextXAlignment=Enum.TextXAlignment.Right sel.Parent=f local btn=Instance.new("TextButton")btn.Size=UDim2.new(1,0,0,34)btn.BackgroundTransparency=1 btn.Text="" btn.ZIndex=5 btn.Parent=f local holder=Instance.new("Frame")holder.Size=UDim2.new(1,-16,0,#options*30)holder.Position=UDim2.new(0,8,0,36)holder.BackgroundTransparency=1 holder.ZIndex=4 holder.Parent=f local hl=Instance.new("UIListLayout")hl.Padding=UDim.new(0,4)hl.Parent=holder for _,opt in ipairs(options)do local ob=Instance.new("TextButton")ob.Size=UDim2.new(1,0,0,26)ob.BackgroundColor3=Theme.BG ob.Text=opt ob.TextColor3=Theme.Text ob.TextSize=11 ob.Font=Enum.Font.Gotham ob.AutoButtonColor=false ob.ZIndex=5 ob.Parent=holder Corner(ob,6)ob.MouseButton1Click:Connect(function()selected=opt sel.Text=opt open=false Tween(f,{Size=UDim2.new(1,0,0,34)},0.3)if callback then callback(opt)end end)end btn.MouseButton1Click:Connect(function()open=not open if open then Tween(f,{Size=UDim2.new(1,0,0,34+#options*30+10)},0.3)else Tween(f,{Size=UDim2.new(1,0,0,34)},0.3)end end)return f end
function WhiskiUI:AddColorPicker(text,callback)local hue=0.5 local bright=1 local open=false local f=Instance.new("Frame")f.Size=UDim2.new(1,0,0,36)f.BackgroundColor3=Theme.Surface f.BackgroundTransparency=0.2 f.ClipsDescendants=true f.Parent=content Corner(f,6)local l=Instance.new("TextLabel")l.Size=UDim2.new(1,-60,0,36)l.Position=UDim2.new(0,10,0,0)l.BackgroundTransparency=1 l.Text=text l.TextColor3=Theme.Text l.TextSize=11 l.Font=Enum.Font.Gotham l.TextXAlignment=Enum.TextXAlignment.Left l.Parent=f local preview=Instance.new("Frame")preview.Size=UDim2.new(0,30,0,20)preview.Position=UDim2.new(1,-42,0.5,-10)preview.BackgroundColor3=Color3.fromHSV(hue,0.85,bright)preview.Parent=f Corner(preview,6)Stroke(preview,Theme.Stroke,1,0.5)local btn=Instance.new("TextButton")btn.Size=UDim2.new(1,0,0,36)btn.BackgroundTransparency=1 btn.Text="" btn.ZIndex=5 btn.Parent=f local picker=Instance.new("Frame")picker.Size=UDim2.new(1,-24,0,50)picker.Position=UDim2.new(0,12,0,40)picker.BackgroundTransparency=1 picker.ZIndex=4 picker.Parent=f local function strip(y,colorSeq)local s=Instance.new("Frame")s.Size=UDim2.new(1,0,0,16)s.Position=UDim2.new(0,0,0,y)s.ZIndex=4 s.Parent=picker Corner(s,4)local g=Instance.new("UIGradient")g.Color=colorSeq g.Parent=s local cursor=Instance.new("Frame")cursor.Size=UDim2.new(0,4,1,0)cursor.AnchorPoint=Vector2.new(0.5,0)cursor.BackgroundColor3=Theme.Text cursor.ZIndex=5 cursor.Parent=s Corner(cursor,2)return s,cursor end local function applyColor()local col=Color3.fromHSV(hue,0.85,bright)preview.BackgroundColor3=col if callback then callback(col)end end local colors={}for i=0,6 do table.insert(colors,ColorSequenceKeypoint.new(i/6,Color3.fromHSV(i/6,0.85,1)))end local hueStrip,hueCursor=strip(0,ColorSequence.new(colors))local brightStrip,brightCursor=strip(20,ColorSequence.new(Color3.new(0,0,0),Color3.new(1,1,1)))brightCursor.Position=UDim2.new(1,-2,0,0)brightCursor.AnchorPoint=Vector2.new(1,0)local function bind(strip,cursor,setter)local sliding=false local function update(x)local r=math.clamp((x-strip.AbsolutePosition.X)/math.max(strip.AbsoluteSize.X,1),0,1)cursor.Position=UDim2.new(r,0,0,0)setter(r)applyColor()end strip.InputBegan:Connect(function(i)if i.UserInputType==Enum.UserInputType.MouseButton1 then sliding=true update(i.Position.X)end end)UIS.InputChanged:Connect(function(i)if sliding and i.UserInputType==Enum.UserInputType.MouseMovement then update(i.Position.X)end end)UIS.InputEnded:Connect(function(i)if i.UserInputType==Enum.UserInputType.MouseButton1 then sliding=false end end)end bind(hueStrip,hueCursor,function(r)hue=r end)bind(brightStrip,brightCursor,function(r)bright=r end)btn.MouseButton1Click:Connect(function()open=not open if open then Tween(f,{Size=UDim2.new(1,0,0,100)},0.3)else Tween(f,{Size=UDim2.new(1,0,0,36)},0.3)end end)return f end
CreatePage("Settings",function()WhiskiUI:AddLabel("By: WhiskiSoul")WhiskiUI:AddLabel("Gui By: WhihiSSoul(SS)")end)
SidebarButton("Settings",function()SwitchPage("Settings")end)
SwitchPage("Settings")
icon.MouseButton1Click:Connect(function()if main.Visible then Tween(main,{Size=UDim2.new(0,0,0,0),Position=UDim2.new(0.5,0,0.5,0)},0.3)task.wait(0.35)main.Visible=false main.Size=UDim2.new(0,W,0,H)main.Position=UDim2.new(0.5,-W/2,0.5,-H/2)else main.Visible=true main.Size=UDim2.new(0,0,0,0)main.Position=UDim2.new(0.5,0,0.5,0)Tween(main,{Size=UDim2.new(0,W,0,H),Position=UDim2.new(0.5,-W/2,0.5,-H/2)},0.35)end end)
_G.WhiskiUI={AddLabel=WhiskiUI.AddLabel,AddButton=WhiskiUI.AddButton,AddToggle=WhiskiUI.AddToggle,AddSlider=WhiskiUI.AddSlider,AddDropdown=WhiskiUI.AddDropdown,AddColorPicker=WhiskiUI.AddColorPicker,CreatePage=CreatePage,SidebarButton=SidebarButton,SwitchPage=SwitchPage,Theme=Theme}
print("WhiskiUI loaded")
