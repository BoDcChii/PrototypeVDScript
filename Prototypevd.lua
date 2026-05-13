-- [[ BoDcChii Project - v0.4.6: FULL INTEGRATION 🎸 ]] --

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

-- --- 1. RADIUS VISUALIZER ---
local function CreateVisualRadius()
    local container = Instance.new("Part", workspace)
    container.Name = "BD_Radius"
    container.Shape = Enum.PartType.Cylinder
    container.Size = Vector3.new(0.2, 19, 19)
    container.Transparency = 1
    container.Color = Color3.new(1, 1, 1)
    container.CanCollide = false
    container.Anchored = true
    container.Material = Enum.Material.ForceField
    container.Orientation = Vector3.new(0, 0, 90)
    return container
end
local VisualRing = CreateVisualRadius()

-- --- 2. UI SETUP ---
local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "BoDcChii_Minimalist"; ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 400, 0, 250); MainFrame.Position = UDim2.new(0.5, -200, 0.4, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 12); MainFrame.Visible = false; MainFrame.Active = true
MainFrame.ClipsDescendants = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 12)

-- Rainbow Stroke Effect
local MainStroke = Instance.new("UIStroke", MainFrame)
MainStroke.Thickness = 2.5
local UIGradient = Instance.new("UIGradient", MainStroke)
UIGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 105, 180)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 255, 255))
})
task.spawn(function() while RunService.RenderStepped:Wait() do UIGradient.Rotation = (tick() * 90) % 360 end end)

-- Dragging System
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

-- --- 3. TABS & PAGES ---
local Sidebar = Instance.new("Frame", MainFrame)
Sidebar.Size = UDim2.new(0, 130, 1, -40); Sidebar.Position = UDim2.new(0, 5, 0, 40); Sidebar.BackgroundTransparency = 1
Instance.new("UIListLayout", Sidebar).Padding = UDim.new(0, 5)

local Container = Instance.new("ScrollingFrame", MainFrame)
Container.Size = UDim2.new(1, -145, 1, -50); Container.Position = UDim2.new(0, 140, 0, 40); Container.BackgroundTransparency = 1
Container.ScrollBarThickness = 2; Container.CanvasSize = UDim2.new(0, 0, 1.5, 0)

local Pages = {}
local function CreatePage(name)
    local f = Instance.new("Frame", Container)
    f.Size = UDim2.new(1, 0, 1, 0); f.BackgroundTransparency = 1; f.Visible = false
    Instance.new("UIListLayout", f).Padding = UDim.new(0, 8)
    Pages[name] = f
    return f
end

local P0, P1, P2, P3 = CreatePage("About"), CreatePage("ESP"), CreatePage("Surv"), CreatePage("Map")

local function CreateTabBtn(text, page)
    local btn = Instance.new("TextButton", Sidebar)
    btn.Size = UDim2.new(1, -5, 0, 35); btn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    btn.Text = text; btn.TextColor3 = Color3.new(0.8, 0.8, 0.8); btn.Font = Enum.Font.SourceSansBold; btn.TextSize = 12
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    btn.MouseButton1Click:Connect(function()
        for _, p in pairs(Pages) do p.Visible = false end
        page.Visible = true
    end)
    return btn
end

CreateTabBtn("👤 ABOUT", P0); CreateTabBtn("👁️ PLAYER ESP", P1)
CreateTabBtn("🛠️ SURVIVAL", P2); CreateTabBtn("🖼️ SMOOTH MAPS", P3)

-- --- 4. COMPONENTS ---
local function CreateToggle(parent, text, callback)
    local bg = Instance.new("Frame", parent)
    bg.Size = UDim2.new(1, -10, 0, 35); bg.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Instance.new("UICorner", bg)
    
    local lbl = Instance.new("TextLabel", bg)
    lbl.Size = UDim2.new(0.7, 0, 1, 0); lbl.Position = UDim2.new(0, 10, 0, 0)
    lbl.BackgroundTransparency = 1; lbl.Text = text; lbl.TextColor3 = Color3.new(1, 1, 1)
    lbl.Font = Enum.Font.SourceSansBold; lbl.TextSize = 11; lbl.TextXAlignment = "Left"
    
    local sw = Instance.new("TextButton", bg)
    sw.Size = UDim2.new(0, 35, 0, 18); sw.Position = UDim2.new(1, -45, 0.5, -9)
    sw.BackgroundColor3 = Color3.fromRGB(60, 60, 60); sw.Text = ""
    Instance.new("UICorner", sw).CornerRadius = UDim.new(1, 0)
    
    local dot = Instance.new("Frame", sw)
    dot.Size = UDim2.new(0, 14, 0, 14); dot.Position = UDim2.new(0, 2, 0.5, -7)
    dot.BackgroundColor3 = Color3.new(1, 1, 1); Instance.new("UICorner", dot).CornerRadius = UDim.new(1, 0)
    
    local state = false
    sw.MouseButton1Click:Connect(function()
        state = not state
        TweenService:Create(dot, TweenInfo.new(0.2), {Position = state and UDim2.new(1, -16, 0.5, -7) or UDim2.new(0, 2, 0.5, -7)}):Play()
        TweenService:Create(sw, TweenInfo.new(0.2), {BackgroundColor3 = state and Color3.fromRGB(255, 105, 180) or Color3.fromRGB(60, 60, 60)}):Play()
        callback(state)
    end)
end

-- --- 5. LOGIC & FEATURES ---
local _SurvOn, _KillOn, _GenOn, _NoSkillGen, _FullBright, _NoFog, _PotatoMode, _AutoParry, _NoclipOn = false, false, false, false, false, false, false, false, false
local isWaitingParry = false
local threatTimer = 0

-- About Page Content
local info = Instance.new("TextLabel", P0)
info.Size = UDim2.new(1,0,0,120); info.BackgroundTransparency = 1; info.TextColor3 = Color3.new(1,1,1)
info.Text = "Creator: BoDcChii\nTester: Xiaoo\nVersion: v0.4.6 Hybrid\n\nStatus: [STABLE]"; info.TextSize = 11; info.Font = Enum.Font.SourceSansBold

-- ESP Page
CreateToggle(P1, "ESP SURVIVAL", function(s) _SurvOn = s end)
CreateToggle(P1, "ESP KILLER", function(s) _KillOn = s end)
CreateToggle(P1, "TEMBUS TEMBOK", function(s) _NoclipOn = s end)

-- Survival Page
CreateToggle(P2, "AUTO PARRY (BETA)", function(s) _AutoParry = s end)
CreateToggle(P2, "ESP GENERATOR", function(s) _GenOn = s end)
CreateToggle(P2, "NO SKILL CHECK", function(s) _NoSkillGen = s end)

-- Maps Page
CreateToggle(P3, "FULL BRIGHT", function(s) _FullBright = s end)
CreateToggle(P3, "NO FOG", function(s) _NoFog = s end)
CreateToggle(P3, "POTATO MODE", function(s) 
    _PotatoMode = s
    if s then
        for _, v in pairs(workspace:GetDescendants()) do
            if v:IsA("BasePart") and not v:FindFirstAncestorOfClass("Model") then
                v.Material = Enum.Material.SmoothPlastic
            end
        end
    end
end)

-- Core Loops (Integrated from v0.4.6)
RunService.Stepped:Connect(function()
    if _NoclipOn then
        local char = Players.LocalPlayer.Character
        if char then for _, p in pairs(char:GetDescendants()) do if p:IsA("BasePart") then p.CanCollide = false end end end
    end
end)

RunService.Heartbeat:Connect(function()
    if _FullBright then Lighting.Ambient = Color3.new(1, 1, 1); Lighting.ClockTime = 12 end
    if _NoFog then Lighting.FogEnd = 999999 end
    
    -- Player ESP
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= Players.LocalPlayer and p.Character then
            local hl = p.Character:FindFirstChild("BDEsp") or Instance.new("Highlight", p.Character)
            hl.Name = "BDEsp"
            local isK = (p.Team and p.Team.Name:lower():find("kill")) or (p.Character:FindFirstChild("Humanoid") and p.Character.Humanoid.MaxHealth > 100)
            hl.Enabled = (isK and _KillOn) or (not isK and _SurvOn)
            hl.FillColor = isK and Color3.new(1, 0, 0) or Color3.new(0, 1, 0)
        end
    end

    -- Radius & Auto Parry Logic
    local lp = Players.LocalPlayer
    if lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") and _AutoParry then
        VisualRing.Transparency = 0.7
        VisualRing.Position = lp.Character.HumanoidRootPart.Position - Vector3.new(0, 2.9, 0)
        
        -- Parry Trigger (9.5 Studs)
        if not isWaitingParry then
            for _, enemy in pairs(Players:GetPlayers()) do
                if enemy ~= lp and enemy.Character and enemy.Character:FindFirstChild("HumanoidRootPart") then
                    local isK = (enemy.Team and enemy.Team.Name:lower():find("kill")) or (enemy.Character:FindFirstChild("Humanoid") and enemy.Character.Humanoid.MaxHealth > 100)
                    if isK then
                        local d = (lp.Character.HumanoidRootPart.Position - enemy.Character.HumanoidRootPart.Position).Magnitude
                        if d < 9.5 then
                            isWaitingParry = true
                            local View = workspace.CurrentCamera.ViewportSize
                            VIM:SendMouseButtonEvent(View.X * 0.85, View.Y * 0.70, 0, true, game, 0)
                            task.wait(0.01)
                            VIM:SendMouseButtonEvent(View.X * 0.85, View.Y * 0.70, 0, false, game, 0)
                            task.delay(50, function() isWaitingParry = false end)
                        end
                    end
                end
            end
        end
    else
        VisualRing.Transparency = 1
    end
end)

-- No Skill Check Logic
local mt = getrawmetatable(game)
if mt then
    local old = mt.__namecall; setreadonly(mt, false)
    mt.__namecall = newcclosure(function(self, ...)
        local method = getnamecallmethod()
        if _NoSkillGen and (method == "FireServer" or method == "InvokeServer") then
            local n = tostring(self):lower()
            if n:find("fail") or n:find("skillcheck") or n:find("explode") then return nil end
        end
        return old(self, ...)
    end); setreadonly(mt, true)
end

-- --- 6. FLOATING TOGGLE BUTTON ---
local OpenButton = Instance.new("ScreenGui", CoreGui)
local MainBtn = Instance.new("TextButton", OpenButton)
MainBtn.Size = UDim2.new(0, 50, 0, 50); MainBtn.Position = UDim2.new(0, 20, 0.5, -25)
MainBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 20); MainBtn.Text = "BD"; MainBtn.TextColor3 = Color3.fromRGB(255, 105, 180)
MainBtn.TextSize = 20; MainBtn.Font = Enum.Font.SourceSansBold; Instance.new("UICorner", MainBtn).CornerRadius = UDim.new(1, 0)
local BStroke = Instance.new("UIStroke", MainBtn); BStroke.Thickness = 2; BStroke.Color = Color3.fromRGB(255, 105, 180)
EnableDrag(MainBtn)

MainBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

P0.Visible = true -- Start page