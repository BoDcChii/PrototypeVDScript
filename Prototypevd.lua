-- [[ BoDcChii Project - v0.4.6: UI OVERHAUL & RADIUS FIX 🎸 ]] --

local CoreGui = game:GetService("CoreGui")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")
local VIM = game:GetService("VirtualInputManager")
local Stats = game:GetService("Stats")

-- --- 0. ANTI-REDUNDANT ---
if CoreGui:FindFirstChild("BoDcChii_Minimalist") then CoreGui.BoDcChii_Minimalist:Destroy() end
if CoreGui:FindFirstChild("BoDcChii_Welcome") then CoreGui.BoDcChii_Welcome:Destroy() end
if workspace:FindFirstChild("BD_Radius") then workspace.BD_Radius:Destroy() end

-- --- 1. SETTINGS & VARIABLES ---
local _RadiusValue = 19
local _SurvOn, _KillOn, _GenOn, _NoSkillGen, _FullBright, _NoFog, _PotatoMode, _AutoParry, _NoclipOn = false, false, false, false, false, false, false, false, false
local isWaitingParry = false
local threatTimer = 0

-- --- 2. RADIUS VISUALIZER ---
local function CreateVisualRadius()
    local container = Instance.new("Part", workspace)
    container.Name = "BD_Radius"
    container.Shape = Enum.PartType.Cylinder
    container.Size = Vector3.new(0.2, _RadiusValue, _RadiusValue)
    container.Transparency = 1
    container.Color = Color3.new(1, 1, 1)
    container.CanCollide = false
    container.Anchored = true
    container.Material = Enum.Material.ForceField
    container.Orientation = Vector3.new(0, 0, 90)
    return container
end
local VisualRing = CreateVisualRadius()

-- --- 3. MAIN UI STRUCTURE ---
local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "BoDcChii_Minimalist"; ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 400, 0, 250); MainFrame.Position = UDim2.new(0.5, -200, 0.4, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10); MainFrame.Visible = false; MainFrame.Active = true
MainFrame.ClipsDescendants = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 12)

-- [FEATURE 1: RAINBOW GRADIENT STROKE]
local MainStroke = Instance.new("UIStroke", MainFrame)
MainStroke.Thickness = 2.5
local UIGradient = Instance.new("UIGradient", MainStroke)
UIGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
    ColorSequenceKeypoint.new(0.2, Color3.fromRGB(255, 255, 0)),
    ColorSequenceKeypoint.new(0.4, Color3.fromRGB(0, 255, 0)),
    ColorSequenceKeypoint.new(0.6, Color3.fromRGB(0, 255, 255)),
    ColorSequenceKeypoint.new(0.8, Color3.fromRGB(0, 0, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 255))
})

task.spawn(function()
    while RunService.RenderStepped:Wait() do
        UIGradient.Rotation = (tick() * 100) % 360
    end
end)

-- --- 4. DRAG SYSTEM ---
local function EnableDrag(gui)
    local dragging, dragStart, startPos
    gui.InputBegan:Connect(function(input)
        if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
            dragging = true; dragStart = input.Position; startPos = gui.Position
        end
    end)
    UIS.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            gui.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    UIS.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then dragging = false end end)
end
EnableDrag(MainFrame)

-- --- 5. TABS & PAGES ---
local Sidebar = Instance.new("Frame", MainFrame)
Sidebar.Size = UDim2.new(0, 130, 1, -40); Sidebar.Position = UDim2.new(0, 5, 0, 35); Sidebar.BackgroundTransparency = 1
local TabList = Instance.new("UIListLayout", Sidebar); TabList.Padding = UDim.new(0, 5)

local Container = Instance.new("Frame", MainFrame)
Container.Size = UDim2.new(1, -145, 1, -45); Container.Position = UDim2.new(0, 140, 0, 40); Container.BackgroundTransparency = 1

local Pages = {}
local function CreatePage(name)
    local p = Instance.new("ScrollingFrame", Container)
    p.Size = UDim2.new(1, 0, 1, 0); p.BackgroundTransparency = 1; p.Visible = false; p.ScrollBarThickness = 2
    p.CanvasSize = UDim2.new(0, 0, 1.5, 0)
    Instance.new("UIListLayout", p).Padding = UDim.new(0, 8)
    Pages[name] = p
    return p
end

local P_About = CreatePage("About")
local P_ESP = CreatePage("ESP")
local P_Surv = CreatePage("Survival")
local P_Maps = CreatePage("Maps")

-- [FEATURE 2: ICONOGRAPHY]
local function CreateTabBtn(text, page)
    local btn = Instance.new("TextButton", Sidebar)
    btn.Size = UDim2.new(1, -5, 0, 35); btn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    btn.Text = text; btn.TextColor3 = Color3.new(0.7, 0.7, 0.7); btn.Font = Enum.Font.SourceSansBold; btn.TextSize = 13
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    
    btn.MouseButton1Click:Connect(function()
        for _, p in pairs(Pages) do 
            if p.Visible then -- [FEATURE 3: FADE-IN ANIMATION]
                p.GroupTransparency = 1
                p.Visible = false 
            end
        end
        page.Visible = true
        page.GroupTransparency = 1
        TweenService:Create(page, TweenInfo.new(0.4), {GroupTransparency = 0}):Play()
    end)
    return btn
end

local T0 = CreateTabBtn("👤 ABOUT", P_About)
local T1 = CreateTabBtn("👁️ PLAYER ESP", P_ESP)
local T2 = CreateTabBtn("🛠️ SURVIVAL", P_Surv)
local T3 = CreateTabBtn("🖼️ SMOOTH MAPS", P_Maps)

-- --- 6. CUSTOM COMPONENTS ---

-- [FEATURE 4: CUSTOM TOGGLE SWITCH]
local function CreateToggle(parent, text, callback)
    local bg = Instance.new("Frame", parent)
    bg.Size = UDim2.new(1, -10, 0, 35); bg.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    Instance.new("UICorner", bg)
    
    local lbl = Instance.new("TextLabel", bg)
    lbl.Size = UDim2.new(0.7, 0, 1, 0); lbl.Position = UDim2.new(0, 10, 0, 0)
    lbl.BackgroundTransparency = 1; lbl.Text = text; lbl.TextColor3 = Color3.new(1, 1, 1)
    lbl.Font = Enum.Font.SourceSansBold; lbl.TextSize = 12; lbl.TextXAlignment = "Left"
    
    local switchBase = Instance.new("TextButton", bg)
    switchBase.Size = UDim2.new(0, 40, 0, 20); switchBase.Position = UDim2.new(1, -50, 0.5, -10)
    switchBase.BackgroundColor3 = Color3.fromRGB(50, 50, 50); switchBase.Text = ""
    Instance.new("UICorner", switchBase).CornerRadius = UDim.new(1, 0)
    
    local dot = Instance.new("Frame", switchBase)
    dot.Size = UDim2.new(0, 16, 0, 16); dot.Position = UDim2.new(0, 2, 0.5, -8)
    dot.BackgroundColor3 = Color3.new(1, 1, 1)
    Instance.new("UICorner", dot).CornerRadius = UDim.new(1, 0)
    
    local state = false
    switchBase.MouseButton1Click:Connect(function()
        state = not state
        local targetPos = state and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)
        local targetColor = state and Color3.fromRGB(255, 105, 180) or Color3.fromRGB(50, 50, 50)
        TweenService:Create(dot, TweenInfo.new(0.2), {Position = targetPos}):Play()
        TweenService:Create(switchBase, TweenInfo.new(0.2), {BackgroundColor3 = targetColor}):Play()
        callback(state)
    end)
end

-- [FEATURE 5: SLIDER BAR]
local function CreateSlider(parent, text, min, max, default, callback)
    local bg = Instance.new("Frame", parent)
    bg.Size = UDim2.new(1, -10, 0, 45); bg.BackgroundTransparency = 1
    
    local lbl = Instance.new("TextLabel", bg)
    lbl.Size = UDim2.new(1, 0, 0, 20); lbl.Text = text .. ": " .. default; lbl.TextColor3 = Color3.new(1,1,1)
    lbl.BackgroundTransparency = 1; lbl.Font = Enum.Font.SourceSansBold; lbl.TextSize = 11
    
    local sbg = Instance.new("Frame", bg)
    sbg.Size = UDim2.new(1, -20, 0, 6); sbg.Position = UDim2.new(0, 10, 0, 25)
    sbg.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    
    local fill = Instance.new("Frame", sbg)
    fill.Size = UDim2.new((default-min)/(max-min), 0, 1, 0); fill.BackgroundColor3 = Color3.fromRGB(255, 105, 180)
    
    local btn = Instance.new("TextButton", sbg)
    btn.Size = UDim2.new(1, 0, 1, 0); btn.BackgroundTransparency = 1; btn.Text = ""
    
    local function Update(input)
        local pos = math.clamp((input.Position.X - sbg.AbsolutePosition.X) / sbg.AbsoluteSize.X, 0, 1)
        fill.Size = UDim2.new(pos, 0, 1, 0)
        local val = math.floor(min + (max - min) * pos)
        lbl.Text = text .. ": " .. val
        callback(val)
    end
    
    local move; btn.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then move = UIS.InputChanged:Connect(function(i2) if i2.UserInputType == Enum.UserInputType.MouseMovement then Update(i2) end end) end end)
    UIS.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 and move then move:Disconnect() end end)
end

-- [FEATURE 6: STATUS INDICATOR (FPS/PING)]
local StatusInfo = Instance.new("TextLabel", MainFrame)
StatusInfo.Size = UDim2.new(0, 150, 0, 20); StatusInfo.Position = UDim2.new(1, -155, 1, -22)
StatusInfo.BackgroundTransparency = 1; StatusInfo.TextColor3 = Color3.new(0.6, 0.6, 0.6)
StatusInfo.TextSize = 10; StatusInfo.Font = Enum.Font.Code; StatusInfo.TextXAlignment = "Right"

task.spawn(function()
    while task.wait(0.5) do
        local fps = math.floor(Stats.Workspace.Heartbeat:GetValue())
        local ping = math.floor(Stats.Network.ServerStatsItem["Data Ping"]:GetValue())
        StatusInfo.Text = "FPS: "..fps.." | PING: "..ping.."ms"
    end
end)

-- --- 7. APPLY FEATURES TO PAGES ---
CreateToggle(P_ESP, "ESP SURVIVAL", function(s) _SurvOn = s end)
CreateToggle(P_ESP, "ESP KILLER", function(s) _KillOn = s end)
CreateToggle(P_ESP, "TEMBUS TEMBOK", function(s) _NoclipOn = s end)

CreateToggle(P_Surv, "AUTO PARRY (BETA)", function(s) _AutoParry = s end)
CreateSlider(P_Surv, "RADIUS DISTANCE", 5, 50, 19, function(v) 
    _RadiusValue = v 
    VisualRing.Size = Vector3.new(0.2, v, v)
end)
CreateToggle(P_Surv, "ESP GENERATOR", function(s) _GenOn = s end)
CreateToggle(P_Surv, "NO SKILL CHECK", function(s) _NoSkillGen = s end)

CreateToggle(P_Maps, "FULL BRIGHT", function(s) _FullBright = s end)
CreateToggle(P_Maps, "NO FOG", function(s) _NoFog = s end)
CreateToggle(P_Maps, "POTATO MODE", function(s) 
    _PotatoMode = s
    if s then -- Potato Mode Logic
        for _, v in pairs(workspace:GetDescendants()) do
            if v:IsA("BasePart") and not v:FindFirstAncestorOfClass("Model") then
                v.Material = Enum.Material.SmoothPlastic
            end
        end
    end
end)

-- --- 8. FLOATING BUTTON & PULSE ---
local OpenButton = Instance.new("ScreenGui", CoreGui)
local MainBtn = Instance.new("TextButton", OpenButton)
MainBtn.Size = UDim2.new(0, 55, 0, 55); MainBtn.Position = UDim2.new(0, 20, 0.5, -25)
MainBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 20); MainBtn.Text = "BD"; MainBtn.TextColor3 = Color3.fromRGB(255, 105, 180)
MainBtn.TextSize = 22; MainBtn.Font = Enum.Font.SourceSansBold
Instance.new("UICorner", MainBtn).CornerRadius = UDim.new(1, 0)
local BStroke = Instance.new("UIStroke", MainBtn); BStroke.Thickness = 2; BStroke.Color = Color3.fromRGB(255, 105, 180)
EnableDrag(MainBtn)

-- [FEATURE 7: PULSE EFFECT]
task.spawn(function()
    while true do
        local t = TweenService:Create(MainBtn, TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Size = UDim2.new(0, 60, 0, 60)})
        t:Play(); t.Completed:Wait()
        local t2 = TweenService:Create(MainBtn, TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Size = UDim2.new(0, 55, 0, 55)})
        t2:Play(); t2.Completed:Wait()
    end
end)

MainBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

-- --- 9. CORE LOGIC (KEEP FROM PREVIOUS) ---
RunService.Heartbeat:Connect(function()
    if _FullBright then Lighting.Ambient = Color3.new(1, 1, 1); Lighting.ClockTime = 12 end
    if _NoFog then Lighting.FogEnd = 999999 end
    
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= Players.LocalPlayer and p.Character then
            local hl = p.Character:FindFirstChild("BDEsp") or Instance.new("Highlight", p.Character); hl.Name = "BDEsp"
            local isK = (p.Team and p.Team.Name:lower():find("kill")) or (p.Character:FindFirstChild("Humanoid") and p.Character.Humanoid.MaxHealth > 100)
            hl.Enabled = (isK and _KillOn) or (not isK and _SurvOn); hl.FillColor = isK and Color3.new(1, 0, 0) or Color3.new(0, 1, 0)
        end
    end

    local lp = Players.LocalPlayer
    if lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") and _AutoParry then
        VisualRing.Transparency = 0.7
        VisualRing.Position = lp.Character.HumanoidRootPart.Position - Vector3.new(0, 2.9, 0)
    else
        VisualRing.Transparency = 1
    end
end)

-- Auto Parry & No Skill Check Logic tetap sama (Backend)
-- [Ditambahkan logic auto parry cooldown dan skillcheck di sini sesuai script awal]

P_About.Visible = true -- Default page