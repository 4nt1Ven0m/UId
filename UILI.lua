local library = { 
    flags = { }, 
    items = { } 
}

-- Services
local players = game:GetService("Players")
local uis = game:GetService("UserInputService")
local runservice = game:GetService("RunService")
local tweenservice = game:GetService("TweenService")
local marketplaceservice = game:GetService("MarketplaceService")
local textservice = game:GetService("TextService")
local coregui = game:GetService("CoreGui")
local httpservice = game:GetService("HttpService")

local player = players.LocalPlayer
local mouse = player:GetMouse()
local camera = game.Workspace.CurrentCamera

library.theme = {
    fontsize = 15,
    titlesize = 18,
    font = Enum.Font.Code,
    background = "rbxassetid://5553946656",
    tilesize = 90,
    cursor = true,
    cursorimg = "https://t0.rbxcdn.com/42f66da98c40252ee151326a82aab51f",
    backgroundcolor = Color3.fromRGB(20, 20, 20),
    tabstextcolor = Color3.fromRGB(240, 240, 240),
    bordercolor = Color3.fromRGB(60, 60, 60),
    accentcolor = Color3.fromRGB(28, 56, 139),
    accentcolor2 = Color3.fromRGB(16, 31, 78),
    outlinecolor = Color3.fromRGB(60, 60, 60),
    outlinecolor2 = Color3.fromRGB(0, 0, 0),
    sectorcolor = Color3.fromRGB(30, 30, 30),
    toptextcolor = Color3.fromRGB(255, 255, 255),
    topheight = 48,
    topcolor = Color3.fromRGB(30, 30, 30),
    topcolor2 = Color3.fromRGB(30, 30, 30),
    buttoncolor = Color3.fromRGB(49, 49, 49),
    buttoncolor2 = Color3.fromRGB(39, 39, 39),
    itemscolor = Color3.fromRGB(200, 200, 200),
    itemscolor2 = Color3.fromRGB(210, 210, 210)
}

if library.theme.cursor and Drawing then
    local success = pcall(function() 
        library.cursor = Drawing.new("Image")
        library.cursor.Data = game:HttpGet(library.theme.cursorimg)
        library.cursor.Size = Vector2.new(64, 64)
        library.cursor.Visible = uis.MouseEnabled
        library.cursor.Rounding = 0
        library.cursor.Position = Vector2.new(mouse.X - 32, mouse.Y + 6)
    end)
    if success and library.cursor then
        uis.InputChanged:Connect(function(input)
            if uis.MouseEnabled then
                if input.UserInputType == Enum.UserInputType.MouseMovement then
                    library.cursor.Position = Vector2.new(input.Position.X - 32, input.Position.Y + 7)
                end
            end
        end)
        
        game:GetService("RunService").RenderStepped:Connect(function()
            uis.OverrideMouseIconBehavior = Enum.OverrideMouseIconBehavior.ForceHide
            library.cursor.Visible = uis.MouseEnabled and (uis.MouseIconEnabled or game:GetService("GuiService").MenuIsOpen)
        end)
    elseif not success and library.cursor then
        library.cursor:Remove()
    end
end

function library:CreateWatermark(name, position)
    local gamename = marketplaceservice:GetProductInfo(game.PlaceId).Name
    local watermark = { }
    watermark.Visible = true
    watermark.text = " " .. name:gsub("{game}", gamename):gsub("{fps}", "0 FPS") .. " "

    watermark.main = Instance.new("ScreenGui", coregui)
    watermark.main.Name = "Watermark"
    if syn then
        syn.protect_gui(watermark.main)
    end

    if getgenv().watermark then
        getgenv().watermark:Remove()
    end
    getgenv().watermark = watermark.main
    
    watermark.mainbar = Instance.new("Frame", watermark.main)
    watermark.mainbar.Name = "Main"
    watermark.mainbar.BorderColor3 = Color3.fromRGB(80, 80, 80)
    watermark.mainbar.Visible = watermark.Visible
    watermark.mainbar.BorderSizePixel = 0
    watermark.mainbar.ZIndex = 5
    watermark.mainbar.Position = UDim2.new(0, position and position.X or 10, 0, position and position.Y or 10)
    watermark.mainbar.Size = UDim2.new(0, 0, 0, 25)

    watermark.Gradient = Instance.new("UIGradient", watermark.mainbar)
    watermark.Gradient.Rotation = 90
    watermark.Gradient.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0.00, Color3.fromRGB(40, 40, 40)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(10, 10, 10)) })

    watermark.Outline = Instance.new("Frame", watermark.mainbar)
    watermark.Outline.Name = "outline"
    watermark.Outline.ZIndex = 4
    watermark.Outline.BorderSizePixel = 0
    watermark.Outline.Visible = watermark.Visible
    watermark.Outline.BackgroundColor3 = library.theme.outlinecolor
    watermark.Outline.Position = UDim2.fromOffset(-1, -1)

    watermark.BlackOutline = Instance.new("Frame", watermark.mainbar)
    watermark.BlackOutline.Name = "blackline"
    watermark.BlackOutline.ZIndex = 3
    watermark.BlackOutline.BorderSizePixel = 0
    watermark.BlackOutline.BackgroundColor3 = library.theme.outlinecolor2
    watermark.BlackOutline.Visible = watermark.Visible
    watermark.BlackOutline.Position = UDim2.fromOffset(-2, -2)

    watermark.label = Instance.new("TextLabel", watermark.mainbar)
    watermark.label.Name = "FPSLabel"
    watermark.label.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    watermark.label.BackgroundTransparency = 1.000
    watermark.label.Position = UDim2.new(0, 0, 0, 0)
    watermark.label.Size = UDim2.new(0, 238, 0, 25)
    watermark.label.Font = library.theme.font
    watermark.label.ZIndex = 6
    watermark.label.Visible = watermark.Visible
    watermark.label.Text = watermark.text
    watermark.label.TextColor3 = Color3.fromRGB(255, 255, 255)
    watermark.label.TextSize = 15
    watermark.label.TextStrokeTransparency = 0.000
    watermark.label.TextXAlignment = Enum.TextXAlignment.Left
    watermark.label.Size = UDim2.new(0, watermark.label.TextBounds.X+10, 0, 25)
    
    watermark.topbar = Instance.new("Frame", watermark.mainbar)
    watermark.topbar.Name = "TopBar"
    watermark.topbar.ZIndex = 6
    watermark.topbar.BackgroundColor3 = library.theme.accentcolor
    watermark.topbar.BorderSizePixel = 0
    watermark.topbar.Visible = watermark.Visible
    watermark.topbar.Size = UDim2.new(0, 0, 0, 1)

    watermark.mainbar.Size = UDim2.new(0, watermark.label.TextBounds.X, 0, 25)
    watermark.topbar.Size = UDim2.new(0, watermark.label.TextBounds.X+6, 0, 1)
    watermark.Outline.Size = watermark.mainbar.Size + UDim2.fromOffset(2, 2)
    watermark.BlackOutline.Size = watermark.mainbar.Size + UDim2.fromOffset(4, 4)

    watermark.mainbar.Size = UDim2.new(0, watermark.label.TextBounds.X+4, 0, 25)    
    watermark.label.Size = UDim2.new(0, watermark.label.TextBounds.X+4, 0, 25)
    watermark.topbar.Size = UDim2.new(0, watermark.label.TextBounds.X+6, 0, 1)
    watermark.Outline.Size = watermark.mainbar.Size + UDim2.fromOffset(2, 2)
    watermark.BlackOutline.Size = watermark.mainbar.Size + UDim2.fromOffset(4, 4)

    local startTime, counter, oldfps = os.clock(), 0, nil
    runservice.Heartbeat:Connect(function()
        watermark.label.Visible = watermark.Visible
        watermark.mainbar.Visible = watermark.Visible
        watermark.topbar.Visible = watermark.Visible
        watermark.Outline.Visible = watermark.Visible
        watermark.BlackOutline.Visible = watermark.Visible

        if not name:find("{fps}") then
            watermark.label.Text = " " .. name:gsub("{game}", gamename):gsub("{fps}", "0 FPS") .. " "
        end

        if name:find("{fps}") then
            local currentTime = os.clock()
            counter = counter + 1
            if currentTime - startTime >= 1 then 
                local fps = math.floor(counter / (currentTime - startTime))
                counter = 0
                startTime = currentTime

                if fps ~= oldfps then
                    watermark.label.Text = " " .. name:gsub("{game}", gamename):gsub("{fps}", fps .. " FPS") .. " "
        
                    watermark.label.Size = UDim2.new(0, watermark.label.TextBounds.X+10, 0, 25)
                    watermark.mainbar.Size = UDim2.new(0, watermark.label.TextBounds.X, 0, 25)
                    watermark.topbar.Size = UDim2.new(0, watermark.label.TextBounds.X, 0, 1)

                    watermark.Outline.Size = watermark.mainbar.Size + UDim2.fromOffset(2, 2)
                    watermark.BlackOutline.Size = watermark.mainbar.Size + UDim2.fromOffset(4, 4)
                end
                oldfps = fps
            end
        end
    end)

    watermark.mainbar.MouseEnter:Connect(function()
        tweenservice:Create(watermark.mainbar, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), { BackgroundTransparency = 1, Active = false }):Play()
        tweenservice:Create(watermark.topbar, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), { BackgroundTransparency = 1, Active = false }):Play()
        tweenservice:Create(watermark.label, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), { TextTransparency = 1, Active = false }):Play()
        tweenservice:Create(watermark.Outline, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), { BackgroundTransparency = 1, Active = false }):Play()
        tweenservice:Create(watermark.BlackOutline, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), { BackgroundTransparency = 1, Active = false }):Play()
    end)
    
    watermark.mainbar.MouseLeave:Connect(function()
        tweenservice:Create(watermark.mainbar, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), { BackgroundTransparency = 0, Active = true }):Play()
        tweenservice:Create(watermark.topbar, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), { BackgroundTransparency = 0, Active = true }):Play()
        tweenservice:Create(watermark.label, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), { TextTransparency = 0, Active = true }):Play()
        tweenservice:Create(watermark.Outline, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), { BackgroundTransparency = 0, Active = true }):Play()
        tweenservice:Create(watermark.BlackOutline, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), { BackgroundTransparency = 0, Active = true }):Play()
    end)

    function watermark:UpdateTheme(theme)
        theme = theme or library.theme
        watermark.Outline.BackgroundColor3 = theme.outlinecolor
        watermark.BlackOutline.BackgroundColor3 = theme.outlinecolor2
        watermark.label.Font = theme.font
        watermark.topbar.BackgroundColor3 = theme.accentcolor
    end

    return watermark
end

function library:CreateWindow(name, size, hidebutton)
    local window = { }

    window.name = name or ""
    window.size = UDim2.fromOffset(size.X, size.Y) or UDim2.fromOffset(492, 598)
    window.hidebutton = hidebutton or Enum.KeyCode.RightShift
    window.theme = library.theme

    local updateevent = Instance.new("BindableEvent")
    function window:UpdateTheme(theme)
        updateevent:Fire(theme or library.theme)
        window.theme = (theme or library.theme)
    end

    window.Main = Instance.new("ScreenGui", coregui)
    window.Main.Name = name
    window.Main.DisplayOrder = 15
    if syn then
        syn.protect_gui(window.Main)
    end

    if getgenv().uilib then
        getgenv().uilib:Remove()
    end
    getgenv().uilib = window.Main

    local dragging, dragInput, dragStart, startPos
    uis.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            window.Frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)

    local dragstart = function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = window.Frame.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end

    local dragend = function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end

    window.Frame = Instance.new("TextButton", window.Main)
    window.Frame.Name = "main"
    window.Frame.Position = UDim2.fromScale(0.5, 0.5)
    window.Frame.BorderSizePixel = 0
    window.Frame.Size = window.size
    window.Frame.AutoButtonColor = false
    window.Frame.Text = ""
    window.Frame.BackgroundColor3 = window.theme.backgroundcolor
    window.Frame.AnchorPoint = Vector2.new(0.5, 0.5)
    updateevent.Event:Connect(function(theme)
        window.Frame.BackgroundColor3 = theme.backgroundcolor
    end)

    uis.InputBegan:Connect(function(key)
        if key.KeyCode == window.hidebutton then
            window.Frame.Visible = not window.Frame.Visible
        end
    end)

    local function checkIfGuiInFront(Pos)
        local objects = coregui:GetGuiObjectsAtPosition(Pos.X, Pos.Y)
        for i,v in pairs(objects) do 
            if not string.find(v:GetFullName(), window.name) then 
                table.remove(objects, i)
            end 
        end
        return (#objects ~= 0 and objects[1].AbsolutePosition ~= Pos)
    end

    --[[ MEMCORRUPTV2 - BEGIN -- MEMCORRUPTV2 - BEGIN -- MEMCORRUPTV2 - BEGIN -- MEMCORRUPTV2 - BEGIN -- MEMCORRUPTV2 - BEGIN
    local corruptImage = Instance.new("ImageLabel", window.Frame)
    corruptImage.Name = "memcorrupt"
    corruptImage.ZIndex = 100
    corruptImage.BackgroundTransparency = 1
    corruptImage.BorderSizePixel = 0
    corruptImage.Position = UDim2.new(0, 0, 0, 0)
    corruptImage.Size = window.Frame.Size
    corruptImage.Image = "rbxassetid://10782245771" -- Replace with your meme image ID
    corruptImage.Visible = false  -- Initially hidden

    local function showCorrupt()
        corruptImage.Visible = true
        -- Adjust the duration and fade speed as needed
        tweenservice:Create(corruptImage, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), { ImageTransparency = 0 }):Play()
        wait(0.5)
        tweenservice:Create(corruptImage, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), { ImageTransparency = 1 }):Play()
        wait(0.1)
        corruptImage.Visible = false
    end

    -- Example trigger (replace with your actual trigger logic)
    local trollFaceImage = Instance.new("ImageLabel", window.Frame)
    trollFaceImage.Name = "trollface"
    trollFaceImage.ZIndex = 100
    trollFaceImage.BackgroundTransparency = 1
    trollFaceImage.BorderSizePixel = 0
    trollFaceImage.Position = UDim2.new(0.5, -50, 0.5, -50)  -- Centered relative to Frame
    trollFaceImage.Size = UDim2.new(0, 100, 0, 100) -- Trollface size
    trollFaceImage.Image = "rbxassetid://139077913" -- Trollface ID
    trollFaceImage.Visible = false  -- Initially hidden

    --  Example trigger (replace with your actual trigger logic)
    local function showTrollFace()
        trollFaceImage.Visible = true
        -- Adjust the duration and fade speed as needed
        tweenservice:Create(trollFaceImage, TweenInfo.new(0.2, Enum.EasingStyle.Linear, Enum.EasingDirection.In), { ImageTransparency = 0 }):Play()
        wait(0.8)
        tweenservice:Create(trollFaceImage, TweenInfo.new(0.2, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), { ImageTransparency = 1 }):Play()
        wait(0.2)
        trollFaceImage.Visible = false
    end

    -- Trigger based on a flag (example)
    local showTrollFaceFlag = false -- Define a flag elsewhere.
    runservice.Heartbeat:Connect(function()
        if showTrollFaceFlag then
            showTrollFace()
            showCorrupt()
            showTrollFaceFlag = false -- Reset the flag
        end
    end)
    -- MEMCORRUPTV2 - END -- MEMCORRUPTV2 - END -- MEMCORRUPTV2 - END -- MEMCORRUPTV2 - END -- MEMCORRUPTV2 - END]]

    window.BlackOutline = Instance.new("Frame", window.Frame)
    window.BlackOutline.Name = "outline"
    window.BlackOutline.ZIndex = 1
    window.BlackOutline.Size = window.size + UDim2.fromOffset(2, 2)
    window.BlackOutline.BorderSizePixel = 0
    window.BlackOutline.BackgroundColor3 = window.theme.outlinecolor2
    window.BlackOutline.Position = UDim2.fromOffset(-1, -1)
    updateevent.Event:Connect(function(theme)
        window.BlackOutline.BackgroundColor3 = theme.outlinecolor2
    end)

    window.Outline = Instance.new("Frame", window.Frame)
    window.Outline.Name = "outline"
    window.Outline.ZIndex = 0
    window.Outline.Size = window.size + UDim2.fromOffset(4, 4)
    window.Outline.BorderSizePixel = 0
    window.Outline.BackgroundColor3 = window.theme.outlinecolor
    window.Outline.Position = UDim2.fromOffset(-2, -2)
    updateevent.Event:Connect(function(theme)
        window.Outline.BackgroundColor3 = theme.outlinecolor
    end)

    window.BlackOutline2 = Instance.new("Frame", window.Frame)
    window.BlackOutline2.Name = "outline"
    window.BlackOutline2.ZIndex = -1
    window.BlackOutline2.Size = window.size + UDim2.fromOffset(6, 6)
    window.BlackOutline2.BorderSizePixel = 0
    window.BlackOutline2.BackgroundColor3 = window.theme.outlinecolor2
    window.BlackOutline2.Position = UDim2.fromOffset(-3, -3)
    updateevent.Event:Connect(function(theme)
        window.BlackOutline2.BackgroundColor3 = theme.outlinecolor2
    end)

    window.TopBar = Instance.new("Frame", window.Frame)
    window.TopBar.Name = "top"
    window.TopBar.Size = UDim2.fromOffset(window.size.X.Offset, window.theme.topheight)
    window.TopBar.BorderSizePixel = 0
    window.TopBar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    window.TopBar.InputBegan:Connect(dragstart)
    window.TopBar.InputChanged:Connect(dragend)
    updateevent.Event:Connect(function(theme)
        window.TopBar.Size = UDim2.fromOffset(window.size.X.Offset, theme.topheight)
    end)

    window.TopGradient = Instance.new("UIGradient", window.TopBar)
    window.TopGradient.Rotation = 90
    window.TopGradient.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0.00, window.theme.topcolor), ColorSequenceKeypoint.new(1.00, window.theme.topcolor2) })
    updateevent.Event:Connect(function(theme)
        window.TopGradient.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0.00, theme.topcolor), ColorSequenceKeypoint.new(1.00, theme.topcolor2) })
    end)

    window.NameLabel = Instance.new("TextLabel", window.TopBar)
    window.NameLabel.TextColor3 = window.theme.toptextcolor
    window.NameLabel.Text = window.name
    window.NameLabel.TextXAlignment = Enum.TextXAlignment.Left
    window.NameLabel.Font = window.theme.font
    window.NameLabel.Name = "title"
    window.NameLabel.Position = UDim2.fromOffset(4, -2)
    window.NameLabel.BackgroundTransparency = 1
    window.NameLabel.Size = UDim2.fromOffset(190, window.TopBar.AbsoluteSize.Y / 2 - 2)
    window.NameLabel.TextSize = window.theme.titlesize
    updateevent.Event:Connect(function(theme)
        window.NameLabel.TextColor3 = theme.toptextcolor
        window.NameLabel.Font = theme.font
        window.NameLabel.TextSize = theme.titlesize
    end)

    window.Line2 = Instance.new("Frame", window.TopBar)
    window.Line2.Name = "line"
    window.Line2.Position = UDim2.fromOffset(0, window.TopBar.AbsoluteSize.Y / 2.1)
    window.Line2.Size = UDim2.fromOffset(window.size.X.Offset, 1)
    window.Line2.BorderSizePixel = 0
    window.Line2.BackgroundColor3 = window.theme.accentcolor
    updateevent.Event:Connect(function(theme)
        window.Line2.BackgroundColor3 = theme.accentcolor
    end)

    window.TabList = Instance.new("Frame", window.TopBar)
    window.TabList.Name = "tablist"
    window.TabList.BackgroundTransparency = 1
    window.TabList.Position = UDim2.fromOffset(0, window.TopBar.AbsoluteSize.Y / 2 + 1)
    window.TabList.Size = UDim2.fromOffset(window.size.X.Offset, window.TopBar.AbsoluteSize.Y / 2)
    window.TabList.BorderSizePixel = 0
    window.TabList.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

    window.TabList.InputBegan:Connect(dragstart)
    window.TabList.InputChanged:Connect(dragend)

    window.BlackLine = Instance.new("Frame", window.Frame)
    window.BlackLine.Name = "blackline"
    window.BlackLine.Size = UDim2.fromOffset(window.size.X.Offset, 1)
    window.BlackLine.BorderSizePixel = 0
    window.BlackLine.ZIndex = 9
    window.BlackLine.BackgroundColor3 = window.theme.outlinecolor2
    window.BlackLine.Position = UDim2.fromOffset(0, window.TopBar.AbsoluteSize.Y)
    updateevent.Event:Connect(function(theme)
        window.BlackLine.BackgroundColor3 = theme.outlinecolor2
    end)

    window.BackgroundImage = Instance.new("ImageLabel", window.Frame)
    window.BackgroundImage.Name = "background"
    window.BackgroundImage.BorderSizePixel = 0
    window.BackgroundImage.ScaleType = Enum.ScaleType.Tile
    window.BackgroundImage.Position = window.BlackLine.Position + UDim2.fromOffset(0, 1)
    window.BackgroundImage.Size = UDim2.fromOffset(window.size.X.Offset, window.size.Y.Offset - window.TopBar.AbsoluteSize.Y - 1)
    window.BackgroundImage.Image = window.theme.background or ""
    window.BackgroundImage.ImageTransparency = window.BackgroundImage.Image ~= "" and 0 or 1
    window.BackgroundImage.ImageColor3 = Color3.new() 
    window.BackgroundImage.BackgroundColor3 = window.theme.backgroundcolor
    window.BackgroundImage.TileSize = UDim2.new(0, window.theme.tilesize, 0, window.theme.tilesize)
    updateevent.Event:Connect(function(theme)
        window.BackgroundImage.Image = theme.background or ""
        window.BackgroundImage.ImageTransparency = window.BackgroundImage.Image ~= "" and 0 or 1
        window.BackgroundImage.BackgroundColor3 = theme.backgroundcolor
        window.BackgroundImage.TileSize = UDim2.new(0, theme.tilesize, 0, theme.tilesize)
    end)

    window.Line = Instance.new("Frame", window.Frame)
    window.Line.Name = "line"
    window.Line.Position = UDim2.fromOffset(0, 0)
    window.Line.Size = UDim2.fromOffset(60, 1)
    window.Line.BorderSizePixel = 0
    window.Line.BackgroundColor3 = window.theme.accentcolor
    updateevent.Event:Connect(function(theme)
        window.Line.BackgroundColor3 = theme.accentcolor
    end)

    window.ListLayout = Instance.new("UIListLayout", window.TabList)
    window.ListLayout.FillDirection = Enum.FillDirection.Horizontal
    window.ListLayout.SortOrder = Enum.SortOrder.LayoutOrder

    window.OpenedColorPickers = { }
    window.Tabs = { }

    function window:CreateTab(name)
        local tab = { }
        tab.name = name or ""

        local textservice = game:GetService("TextService")
        local size = textservice:GetTextSize(tab.name, window.theme.fontsize, window.theme.font, Vector2.new(200,300))

        tab.TabButton = Instance.new("TextButton", window.TabList)
        tab.TabButton.TextColor3 = window.theme.tabstextcolor
        tab.TabButton.Text = tab.name
        tab.TabButton.AutoButtonColor = false
        tab.TabButton.Font = window.theme.font
        tab.TabButton.TextYAlignment = Enum.TextYAlignment.Center
        tab.TabButton.BackgroundTransparency = 1
        tab.TabButton.BorderSizePixel = 0
        tab.TabButton.Size = UDim2.fromOffset(size.X + 15, window.TabList.AbsoluteSize.Y - 1)
        tab.TabButton.Name = tab.name
        tab.TabButton.TextSize = window.theme.fontsize
        updateevent.Event:Connect(function(theme)
            local size = textservice:GetTextSize(tab.name, theme.fontsize, theme.font, Vector2.new(200,300))
            tab.TabButton.TextColor3 = tab.TabButton.Name == "SelectedTab" and theme.accentcolor or theme.tabstextcolor
            tab.TabButton.Font = theme.font
            tab.TabButton.Size = UDim2.fromOffset(size.X + 15, window.TabList.AbsoluteSize.Y - 1)
            tab.TabButton.TextSize = theme.fontsize
        end)

        tab.Left = Instance.new("ScrollingFrame", window.Frame) 
        tab.Left.Name = "leftside"
        tab.Left.BorderSizePixel = 0
        tab.Left.Size = UDim2.fromOffset(window.size.X.Offset / 2, window.size.Y.Offset - (window.TopBar.AbsoluteSize.Y + 1))
        tab.Left.BackgroundTransparency = 1
        tab.Left.Visible = false
        tab.Left.ScrollBarThickness = 0
        tab.Left.ScrollingDirection = "Y"
        tab.Left.Position = window.BlackLine.Position + UDim2.fromOffset(0, 1)

        tab.LeftListLayout = Instance.new("UIListLayout", tab.Left)
        tab.LeftListLayout.FillDirection = Enum.FillDirection.Vertical
        tab.LeftListLayout.SortOrder = Enum.SortOrder.LayoutOrder
        tab.LeftListLayout.Padding = UDim.new(0, 12)

        tab.LeftListPadding = Instance.new("UIPadding", tab.Left)
        tab.LeftListPadding.PaddingTop = UDim.new(0, 12)
        tab.LeftListPadding.PaddingLeft = UDim.new(0, 12)
        tab.LeftListPadding.PaddingRight = UDim.new(0, 12)

        tab.Right = Instance.new("ScrollingFrame", window.Frame) 
        tab.Right.Name = "rightside"
        tab.Right.ScrollBarThickness = 0
        tab.Right.ScrollingDirection = "Y"
        tab.Right.Visible = false
        tab.Right.BorderSizePixel = 0
        tab.Right.Size = UDim2.fromOffset(window.size.X.Offset / 2, window.size.Y.Offset - (window.TopBar.AbsoluteSize.Y + 1))
        tab.Right.BackgroundTransparency = 1
        tab.Right.Position = tab.Left.Position + UDim2.fromOffset(tab.Left.AbsoluteSize.X, 0)

        tab.RightListLayout = Instance.new("UIListLayout", tab.Right)
        tab.RightListLayout.FillDirection = Enum.FillDirection.Vertical
        tab.RightListLayout.SortOrder = Enum.SortOrder.LayoutOrder
        tab.RightListLayout.Padding = UDim.new(0, 12)

        tab.RightListPadding = Instance.new("UIPadding", tab.Right)
        tab.RightListPadding.PaddingTop = UDim.new(0, 12)
        tab.RightListPadding.PaddingLeft = UDim.new(0, 6)
        tab.RightListPadding.PaddingRight = UDim.new(0, 12)

        local block = false
        function tab:SelectTab()
            repeat 
                wait()
            until block == false

            block = true
            for i,v in pairs(window.Tabs) do
                if v ~= tab then
                    v.TabButton.TextColor3 = Color3.fromRGB(230, 230, 230)
                    v.TabButton.Name = "Tab"
                    v.Left.Visible = false
                    v.Right.Visible = false
                end
            end

            tab.TabButton.TextColor3 = window.theme.accentcolor
            tab.TabButton.Name = "SelectedTab"
            tab.Left.Visible = true
            tab.Right.Visible = true
            block = false
        end

        tab.TabButton.MouseButton1Click:Connect(function()
            tab:SelectTab()
        end)

        tab.TabButton.MouseEnter:Connect(function()
            if tab.TabButton.Name == "Tab" then
                tab.TabButton.TextColor3 = window.theme.accentcolor2
            end
        end)

        tab.TabButton.MouseLeave:Connect(function()
            if tab.TabButton.Name == "Tab" then
                tab.TabButton.TextColor3 = window.theme.tabstextcolor
            end
        end)

        window.ListLayout:Apply()

        table.insert(window.Tabs, tab)

        return tab
    end

    function window:CreateButton(name, tab, callback)
        local button = { }
        button.name = name or ""

        button.Button = Instance.new("TextButton", tab.Left)
        button.Button.AutoButtonColor = false
        button.Button.BackgroundColor3 = window.theme.buttoncolor
        button.Button.Size = UDim2.fromOffset(tab.Left.AbsoluteSize.X - 24, 30)
        button.Button.Font = window.theme.font
        button.Button.Text = button.name
        button.Button.TextColor3 = window.theme.itemscolor
        button.Button.TextSize = window.theme.fontsize
        button.Button.TextYAlignment = Enum.TextYAlignment.Center
        button.Button.BorderSizePixel = 0
        button.Button.Name = name
        updateevent.Event:Connect(function(theme)
            button.Button.BackgroundColor3 = theme.buttoncolor
            button.Button.TextColor3 = theme.itemscolor
            button.Button.Font = theme.font
            button.Button.TextSize = theme.fontsize
        end)

        button.Button.MouseButton1Click:Connect(function()
            callback()
        end)

        button.Button.MouseEnter:Connect(function()
            button.Button.BackgroundColor3 = window.theme.buttoncolor2
        end)

        button.Button.MouseLeave:Connect(function()
            button.Button.BackgroundColor3 = window.theme.buttoncolor
        end)

        return button
    end

    function window:CreateToggle(name, tab, callback)
        local toggle = { }
        toggle.name = name or ""
        toggle.value = false
        toggle.callback = callback
    
        toggle.Frame = Instance.new("Frame", tab.Left)
        toggle.Frame.Size = UDim2.new(1, 0, 0, 30)
        toggle.Frame.BackgroundTransparency = 1
        toggle.Frame.Name = name

        toggle.Layout = Instance.new("UIListLayout", toggle.Frame)
        toggle.Layout.FillDirection = Enum.FillDirection.Horizontal
        toggle.Layout.Padding = UDim.new(0, 6)
        toggle.Layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
        toggle.Layout.SortOrder = Enum.SortOrder.LayoutOrder

        toggle.Label = Instance.new("TextLabel", toggle.Frame)
        toggle.Label.Size = UDim2.new(0, 0, 1, 0)
        toggle.Label.Text = name
        toggle.Label.Font = window.theme.font
        toggle.Label.TextSize = window.theme.fontsize
        toggle.Label.TextColor3 = window.theme.itemscolor
        toggle.Label.BackgroundTransparency = 1
        toggle.Label.TextXAlignment = Enum.TextXAlignment.Left
        toggle.Label.TextYAlignment = Enum.TextYAlignment.Center
        toggle.Label.Name = name
        updateevent.Event:Connect(function(theme)
            toggle.Label.Font = theme.font
            toggle.Label.TextSize = theme.fontsize
            toggle.Label.TextColor3 = theme.itemscolor
        end)

        toggle.Toggler = Instance.new("TextButton", toggle.Frame)
        toggle.Toggler.Size = UDim2.new(0, 24, 0, 24)
        toggle.Toggler.BackgroundTransparency = 1
        toggle.Toggler.Font = window.theme.font
        toggle.Toggler.Text = ""
        toggle.Toggler.TextColor3 = window.theme.itemscolor
        toggle.Toggler.TextSize = window.theme.fontsize
        toggle.Toggler.TextYAlignment = Enum.TextYAlignment.Center
        toggle.Toggler.BorderSizePixel = 0
        toggle.Toggler.Name = name
        updateevent.Event:Connect(function(theme)
            toggle.Toggler.Font = theme.font
            toggle.Toggler.TextSize = theme.fontsize
        end)

        local function updateToggle()
            if toggle.value then
                toggle.Toggler.BackgroundColor3 = window.theme.accentcolor
            else
                toggle.Toggler.BackgroundColor3 = window.theme.buttoncolor
            end
        end

        updateevent.Event:Connect(function(theme)
            updateToggle()
        end)

        toggle.Toggler.MouseButton1Click:Connect(function()
            toggle.value = not toggle.value
            updateToggle()
            if toggle.callback then
                toggle.callback(toggle.value)
            end
        end)

        updateToggle()
        return toggle
    end

    function window:CreateSlider(name, tab, min, max, defaultValue, callback, step)
        local slider = { }
        slider.name = name or ""
        slider.min = min or 0
        slider.max = max or 100
        slider.value = defaultValue or 50
        slider.step = step or 1
        slider.callback = callback
        
        slider.Frame = Instance.new("Frame", tab.Left)
        slider.Frame.Size = UDim2.new(1, 0, 0, 30)
        slider.Frame.BackgroundTransparency = 1
        slider.Frame.Name = name

        slider.Layout = Instance.new("UIListLayout", slider.Frame)
        slider.Layout.FillDirection = Enum.FillDirection.Horizontal
        slider.Layout.Padding = UDim.new(0, 6)
        slider.Layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
        slider.Layout.SortOrder = Enum.SortOrder.LayoutOrder

        slider.Label = Instance.new("TextLabel", slider.Frame)
        slider.Label.Size = UDim2.new(0, 0, 1, 0)
        slider.Label.Text = name
        slider.Label.Font = window.theme.font
        slider.Label.TextSize = window.theme.fontsize
        slider.Label.TextColor3 = window.theme.itemscolor
        slider.Label.BackgroundTransparency = 1
        slider.Label.TextXAlignment = Enum.TextXAlignment.Left
        slider.Label.TextYAlignment = Enum.TextYAlignment.Center
        slider.Label.Name = name

        updateevent.Event:Connect(function(theme)
            slider.Label.Font = theme.font
            slider.Label.TextSize = theme.fontsize
            slider.Label.TextColor3 = theme.itemscolor
        end)
        
        slider.ValueLabel = Instance.new("TextLabel", slider.Frame)
        slider.ValueLabel.Size = UDim2.new(0, 60, 1, 0)
        slider.ValueLabel.Text = slider.value
        slider.ValueLabel.Font = window.theme.font
        slider.ValueLabel.TextSize = window.theme.fontsize
        slider.ValueLabel.TextColor3 = window.theme.itemscolor
        slider.ValueLabel.BackgroundTransparency = 1
        slider.ValueLabel.TextXAlignment = Enum.TextXAlignment.Right
        slider.ValueLabel.TextYAlignment = Enum.TextYAlignment.Center
        slider.ValueLabel.Name = name.."Value"

        updateevent.Event:Connect(function(theme)
            slider.ValueLabel.Font = theme.font
            slider.ValueLabel.TextSize = theme.fontsize
            slider.ValueLabel.TextColor3 = theme.itemscolor
        end)

        slider.Bar = Instance.new("Frame", slider.Frame)
        slider.Bar.Size = UDim2.new(0.5, 0, 0, 6)
        slider.Bar.BackgroundColor3 = window.theme.buttoncolor
        slider.Bar.Name = name.."Bar"
        slider.Bar.AnchorPoint = Vector2.new(0, 0.5)
        slider.Bar.Position = UDim2.new(0,0, 0.5, 0)
        slider.Bar.BorderSizePixel = 0

        slider.Fill = Instance.new("Frame", slider.Bar)
        slider.Fill.Size = UDim2.new(0, 0, 1, 0)
        slider.Fill.BackgroundColor3 = window.theme.accentcolor
        slider.Fill.Name = name.."Fill"
        slider.Fill.BorderSizePixel = 0
        
        local dragging = false
        local dragStart
        local function updateSlider()
            local percentage = (slider.value - slider.min) / (slider.max - slider.min)
            slider.Fill.Size = UDim2.new(percentage, 0, 1, 0)
            slider.ValueLabel.Text = math.floor(slider.value)
        end

        local function clampValue(value)
            return math.floor(math.clamp(value, slider.min, slider.max) / slider.step) * slider.step
        end
        
        local function onInputBegan(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                local inputPos = input.Position
                local barAbsolutePosition = slider.Bar.AbsolutePosition
                local barAbsoluteSize = slider.Bar.AbsoluteSize
                
                if inputPos.X >= barAbsolutePosition.X and inputPos.X <= barAbsolutePosition.X + barAbsoluteSize.X and inputPos.Y >= barAbsolutePosition.Y and inputPos.Y <= barAbsolutePosition.Y + barAbsoluteSize.Y then
                    dragging = true
                    dragStart = inputPos
                end
            end
        end
        
        local function onInputChanged(input)
            if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                local delta = input.Position - dragStart
                local barAbsolutePosition = slider.Bar.AbsolutePosition
                local barAbsoluteSize = slider.Bar.AbsoluteSize
                local newX = math.clamp(input.Position.X - barAbsolutePosition.X, 0, barAbsoluteSize.X)
                local percentage = newX / barAbsoluteSize.X
                slider.value = clampValue(slider.min + (slider.max - slider.min) * percentage)
                updateSlider()
                if slider.callback then
                    slider.callback(slider.value)
                end
            end
        end
        
        local function onInputEnded(input)
            if dragging and (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
                dragging = false
            end
        end
        
        uis.InputBegan:Connect(onInputBegan)
        uis.InputChanged:Connect(onInputChanged)
        uis.InputEnded:Connect(onInputEnded)
        
        updateevent.Event:Connect(function(theme)
            slider.Bar.BackgroundColor3 = theme.buttoncolor
            slider.Fill.BackgroundColor3 = theme.accentcolor
        end)

        updateSlider()
        return slider
    end

    function window:CreateDropdown(name, tab, options, callback)
        local dropdown = { }
        dropdown.name = name or ""
        dropdown.options = options or { }
        dropdown.selected = 1
        dropdown.callback = callback

        dropdown.Frame = Instance.new("Frame", tab.Left)
        dropdown.Frame.Size = UDim2.new(1, 0, 0, 30)
        dropdown.Frame.BackgroundTransparency = 1
        dropdown.Frame.Name = name
        
        dropdown.Layout = Instance.new("UIListLayout", dropdown.Frame)
        dropdown.Layout.FillDirection = Enum.FillDirection.Horizontal
        dropdown.Layout.Padding = UDim.new(0, 6)
        dropdown.Layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
        dropdown.Layout.SortOrder = Enum.SortOrder.LayoutOrder

        dropdown.Label = Instance.new("TextLabel", dropdown.Frame)
        dropdown.Label.Size = UDim2.new(0, 0, 1, 0)
        dropdown.Label.Text = name
        dropdown.Label.Font = window.theme.font
        dropdown.Label.TextSize = window.theme.fontsize
        dropdown.Label.TextColor3 = window.theme.itemscolor
        dropdown.Label.BackgroundTransparency = 1
        dropdown.Label.TextXAlignment = Enum.TextXAlignment.Left
        dropdown.Label.TextYAlignment = Enum.TextYAlignment.Center
        dropdown.Label.Name = name
        updateevent.Event:Connect(function(theme)
            dropdown.Label.Font = theme.font
            dropdown.Label.TextSize = theme.fontsize
            dropdown.Label.TextColor3 = theme.itemscolor
        end)

        dropdown.Button = Instance.new("TextButton", dropdown.Frame)
        dropdown.Button.Size = UDim2.new(0, 100, 1, 0)
        dropdown.Button.BackgroundTransparency = 0
        dropdown.Button.BackgroundColor3 = window.theme.buttoncolor
        dropdown.Button.Font = window.theme.font
        dropdown.Button.Text = dropdown.options[dropdown.selected] or "None"
        dropdown.Button.TextColor3 = window.theme.itemscolor
        dropdown.Button.TextSize = window.theme.fontsize
        dropdown.Button.TextXAlignment = Enum.TextXAlignment.Center
        dropdown.Button.TextYAlignment = Enum.TextYAlignment.Center
        dropdown.Button.BorderSizePixel = 0
        dropdown.Button.Name = name
        updateevent.Event:Connect(function(theme)
            dropdown.Button.BackgroundColor3 = theme.buttoncolor
            dropdown.Button.TextColor3 = theme.itemscolor
            dropdown.Button.Font = theme.font
            dropdown.Button.TextSize = theme.fontsize
        end)

        local function updateDropdown()
            dropdown.Button.Text = dropdown.options[dropdown.selected] or "None"
        end

        updateevent.Event:Connect(function(theme)
            updateDropdown()
        end)

        dropdown.Menu = Instance.new("Frame", window.Main)
        dropdown.Menu.Size = UDim2.new(0, dropdown.Button.AbsoluteSize.X, 0, #dropdown.options * 30)
        dropdown.Menu.Position = UDim2.new(0, dropdown.Button.AbsolutePosition.X, 0, dropdown.Button.AbsolutePosition.Y + dropdown.Button.AbsoluteSize.Y)
        dropdown.Menu.BackgroundTransparency = 0.9
        dropdown.Menu.BackgroundColor3 = window.theme.backgroundcolor
        dropdown.Menu.BorderSizePixel = 0
        dropdown.Menu.Visible = false
        dropdown.Menu.Name = name.."Menu"
        updateevent.Event:Connect(function(theme)
            dropdown.Menu.BackgroundColor3 = theme.backgroundcolor
        end)

        local dropdownOptionsListLayout = Instance.new("UIListLayout", dropdown.Menu)
        dropdownOptionsListLayout.FillDirection = Enum.FillDirection.Vertical
        dropdownOptionsListLayout.SortOrder = Enum.SortOrder.LayoutOrder

        for i, option in ipairs(dropdown.options) do
            local optionButton = Instance.new("TextButton", dropdown.Menu)
            optionButton.Size = UDim2.new(1, 0, 0, 30)
            optionButton.Text = option
            optionButton.TextColor3 = window.theme.itemscolor
            optionButton.Font = window.theme.font
            optionButton.TextSize = window.theme.fontsize
            optionButton.TextXAlignment = Enum.TextXAlignment.Center
            optionButton.TextYAlignment = Enum.TextYAlignment.Center
            optionButton.AutoButtonColor = false
            optionButton.BackgroundColor3 = window.theme.buttoncolor
            optionButton.BorderSizePixel = 0
            updateevent.Event:Connect(function(theme)
                optionButton.TextColor3 = theme.itemscolor
                optionButton.Font = theme.font
                optionButton.TextSize = theme.fontsize
                optionButton.BackgroundColor3 = theme.buttoncolor
            end)

            optionButton.MouseButton1Click:Connect(function()
                dropdown.selected = i
                updateDropdown()
                dropdown.Menu.Visible = false
                if dropdown.callback then
                    dropdown.callback(option)
                end
            end)
        end

        dropdown.Button.MouseButton1Click:Connect(function()
            dropdown.Menu.Visible = not dropdown.Menu.Visible
        end)

        uis.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                local mousePos = input.Position
                if dropdown.Menu.Visible then
                    local menuAbsolutePosition = dropdown.Menu.AbsolutePosition
                    local menuAbsoluteSize = dropdown.Menu.AbsoluteSize

                    if mousePos.X < menuAbsolutePosition.X or mousePos.X > menuAbsolutePosition.X + menuAbsoluteSize.X or
                       mousePos.Y < menuAbsolutePosition.Y or mousePos.Y > menuAbsolutePosition.Y + menuAbsoluteSize.Y then
                        dropdown.Menu.Visible = false
                    end
                end
            end
        end)

        return dropdown
    end

    function window:CreateTextbox(name, tab, callback, placeholder)
        local textbox = { }
        textbox.name = name or ""
        textbox.text = ""
        textbox.callback = callback
        textbox.placeholder = placeholder or ""

        textbox.Frame = Instance.new("Frame", tab.Left)
        textbox.Frame.Size = UDim2.new(1, 0, 0, 30)
        textbox.Frame.BackgroundTransparency = 1
        textbox.Frame.Name = name

        textbox.Layout = Instance.new("UIListLayout", textbox.Frame)
        textbox.Layout.FillDirection = Enum.FillDirection.Horizontal
        textbox.Layout.Padding = UDim.new(0, 6)
        textbox.Layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
        textbox.Layout.SortOrder = Enum.SortOrder.LayoutOrder

        textbox.Label = Instance.new("TextLabel", textbox.Frame)
        textbox.Label.Size = UDim2.new(0, 0, 1, 0)
        textbox.Label.Text = name
        textbox.Label.Font = window.theme.font
        textbox.Label.TextSize = window.theme.fontsize
        textbox.Label.TextColor3 = window.theme.itemscolor
        textbox.Label.BackgroundTransparency = 1
        textbox.Label.TextXAlignment = Enum.TextXAlignment.Left
        textbox.Label.TextYAlignment = Enum.TextYAlignment.Center
        textbox.Label.Name = name

        updateevent.Event:Connect(function(theme)
            textbox.Label.Font = theme.font
            textbox.Label.TextSize = theme.fontsize
            textbox.Label.TextColor3 = theme.itemscolor
        end)

        textbox.TextBox = Instance.new("TextBox", textbox.Frame)
        textbox.TextBox.Size = UDim2.new(1, 0, 1, 0)
        textbox.TextBox.Text = textbox.text
        textbox.TextBox.PlaceholderText = textbox.placeholder
        textbox.TextBox.Font = window.theme.font
        textbox.TextBox.TextSize = window.theme.fontsize
        textbox.TextBox.TextColor3 = window.theme.itemscolor
        textbox.TextBox.BackgroundColor3 = window.theme.buttoncolor
        textbox.TextBox.BorderSizePixel = 0
        textbox.TextBox.TextXAlignment = Enum.TextXAlignment.Left
        textbox.TextBox.TextYAlignment = Enum.TextYAlignment.Center
        textbox.TextBox.Name = name
        textbox.TextBox.ClearTextOnFocus = false

        updateevent.Event:Connect(function(theme)
            textbox.TextBox.Font = theme.font
            textbox.TextBox.TextSize = theme.fontsize
            textbox.TextBox.TextColor3 = theme.itemscolor
            textbox.TextBox.BackgroundColor3 = theme.buttoncolor
        end)

        textbox.TextBox.FocusLost:Connect(function(enterPressed)
            textbox.text = textbox.TextBox.Text
            if textbox.callback then
                textbox.callback(textbox.text, enterPressed)
            end
        end)
        return textbox
    end

    function window:CreateColorPicker(name, tab, initialColor, callback)
        local colorPicker = { }
        colorPicker.name = name or ""
        colorPicker.color = initialColor or Color3.new(1, 1, 1)
        colorPicker.callback = callback

        colorPicker.Frame = Instance.new("Frame", tab.Left)
        colorPicker.Frame.Size = UDim2.new(1, 0, 0, 30)
        colorPicker.Frame.BackgroundTransparency = 1
        colorPicker.Frame.Name = name

        colorPicker.Layout = Instance.new("UIListLayout", colorPicker.Frame)
        colorPicker.Layout.FillDirection = Enum.FillDirection.Horizontal
        colorPicker.Layout.Padding = UDim.new(0, 6)
        colorPicker.Layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
        colorPicker.Layout.SortOrder = Enum.SortOrder.LayoutOrder

        colorPicker.Label = Instance.new("TextLabel", colorPicker.Frame)
        colorPicker.Label.Size = UDim2.new(0, 0, 1, 0)
        colorPicker.Label.Text = name
        colorPicker.Label.Font = window.theme.font
        colorPicker.Label.TextSize = window.theme.fontsize
        colorPicker.Label.TextColor3 = window.theme.itemscolor
        colorPicker.Label.BackgroundTransparency = 1
        colorPicker.Label.TextXAlignment = Enum.TextXAlignment.Left
        colorPicker.Label.TextYAlignment = Enum.TextYAlignment.Center
        colorPicker.Label.Name = name
        updateevent.Event:Connect(function(theme)
            colorPicker.Label.Font = theme.font
            colorPicker.Label.TextSize = theme.fontsize
            colorPicker.Label.TextColor3 = theme.itemscolor
        end)

        colorPicker.ColorFrame = Instance.new("Frame", colorPicker.Frame)
        colorPicker.ColorFrame.Size = UDim2.new(0, 24, 1, 0)
        colorPicker.ColorFrame.BackgroundColor3 = colorPicker.color
        colorPicker.ColorFrame.BorderSizePixel = 0
        colorPicker.ColorFrame.Name = name.."Color"
        updateevent.Event:Connect(function(theme)
            -- colorPicker.ColorFrame.BackgroundColor3 = theme.accentcolor
        end)

        colorPicker.Button = Instance.new("TextButton", colorPicker.Frame)
        colorPicker.Button.Size = UDim2.new(1, 0, 1, 0)
        colorPicker.Button.BackgroundTransparency = 1
        colorPicker.Button.Text = ""
        colorPicker.Button.BorderSizePixel = 0
        colorPicker.Button.Name = name.."Button"
        
        local function showColorPickerMenu()
            local colorPickerMenu = Instance.new("Frame", window.Main)
            colorPickerMenu.Name = "ColorPickerMenu"
            colorPickerMenu.Size = UDim2.new(0, 300, 0, 200)
            colorPickerMenu.Position = UDim2.new(0, colorPicker.Button.AbsolutePosition.X, 0, colorPicker.Button.AbsolutePosition.Y + colorPicker.Button.AbsoluteSize.Y)
            colorPickerMenu.BackgroundTransparency = 0.9
            colorPickerMenu.BackgroundColor3 = window.theme.backgroundcolor
            colorPickerMenu.BorderSizePixel = 0
            colorPickerMenu.Visible = true
            
            local pickerTitle = Instance.new("TextLabel", colorPickerMenu)
            pickerTitle.Size = UDim2.new(1, 0, 0, 20)
            pickerTitle.Position = UDim2.new(0, 0, 0, 0)
            pickerTitle.Text = "Pick a Color"
            pickerTitle.TextColor3 = window.theme.toptextcolor
            pickerTitle.Font = window.theme.font
            pickerTitle.TextSize = window.theme.titlesize
            pickerTitle.BackgroundTransparency = 1
            pickerTitle.TextXAlignment = Enum.TextXAlignment.Center
            
            local colorPickerUI = Instance.new("ColorPicker", colorPickerMenu)
            colorPickerUI.Position = UDim2.new(0.1, 0, 0.2, 0)
            colorPickerUI.Size = UDim2.new(0.8, 0, 0.6, 0)
            colorPickerUI.Color = colorPicker.color

            colorPickerUI.ColorChanged:Connect(function(newColor)
                colorPicker.color = newColor
                colorPicker.ColorFrame.BackgroundColor3 = newColor
            end)

            local confirmButton = Instance.new("TextButton", colorPickerMenu)
            confirmButton.Text = "Confirm"
            confirmButton.Size = UDim2.new(0, 100, 0, 30)
            confirmButton.Position = UDim2.new(0.5, -50, 0.8, 0)
            confirmButton.BackgroundColor3 = window.theme.accentcolor
            confirmButton.Font = window.theme.font
            confirmButton.TextColor3 = window.theme.itemscolor
            confirmButton.TextSize = window.theme.fontsize
            confirmButton.BorderSizePixel = 0
            confirmButton.MouseButton1Click:Connect(function()
                colorPickerMenu:Destroy()
                if colorPicker.callback then
                    colorPicker.callback(colorPicker.color)
                end
            end)
            
            uis.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    local mousePos = input.Position
                    local menuAbsolutePosition = colorPickerMenu.AbsolutePosition
                    local menuAbsoluteSize = colorPickerMenu.AbsoluteSize

                    if mousePos.X < menuAbsolutePosition.X or mousePos.X > menuAbsolutePosition.X + menuAbsoluteSize.X or
                       mousePos.Y < menuAbsolutePosition.Y or mousePos.Y > menuAbsolutePosition.Y + menuAbsoluteSize.Y then
                        colorPickerMenu:Destroy()
                    end
                end
            end)
            
            table.insert(window.OpenedColorPickers, colorPickerMenu)
        end
        
        colorPicker.Button.MouseButton1Click:Connect(showColorPickerMenu)
        return colorPicker
    end
    
    tab.TabButton.Parent = window.TabList
    tab.Left.Parent = window.Frame
    tab.Right.Parent = window.Frame

    -- Select the first tab by default
    if #window.Tabs == 1 then
        tab:SelectTab()
    end

    return window
end

return library
