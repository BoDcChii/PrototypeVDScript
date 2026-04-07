-- [[ BoDcChii Project - v0.4.2: KILLER EDITION 🎸 ]] --

local CoreGui = game:GetService("CoreGui")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")
local VIM = game:GetService("VirtualInputManager")

-- --- 0. ANTI-REDUNDANT ---
if CoreGui:FindFirstChild("BoDcChii_Minimalist") then CoreGui.BoDcChii_Minimalist:Destroy() end
if CoreGui:FindFirstChild("BoDcChii_Welcome") then CoreGui.BoDcChii_Welcome:Destroy() end

-- --- 1. WELCOME NOTIFICATION ---
local function ShowWelcome()
    local WelcomeGui = Instance.new("ScreenGui", CoreGui)
    WelcomeGui.Name = "BoDcChii_Welcome"
    local WelcomeFrame = Instance.new("Frame", WelcomeGui)
    WelcomeFrame.Size = UDim2.new(0, 220, 0, 45)
    WelcomeFrame.Position = UDim2.new(0.5, -110, 0.1, 0)
    WelcomeFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    Instance.new("UICorner", WelcomeFrame).CornerRadius = UDim.new(0, 10)
    local Stroke = Instance.new("UIStroke", WelcomeFrame)
    Stroke.Color = Color3.fromRGB(255, 105, 180); Stroke.Thickness = 2
    local WelcomeLabel = Instance.new("TextLabel", WelcomeFrame)
    WelcomeLabel.Size = UDim2.new(1, 0, 1, 0); WelcomeLabel.BackgroundTransparency = 1
    WelcomeLabel.Text = "Welcome To BoDcChii Project"; WelcomeLabel.TextColor3 = Color3.new(1, 1, 1)
    WelcomeLabel.TextSize = 14; WelcomeLabel.Font = Enum.Font.SourceSansBold
    task.delay(2, function() WelcomeGui:Destroy() end)
end
pcall(ShowWelcome)

local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "BoDcChii_Minimalist"; ScreenGui.ResetOnSpawn = false

local function EnableDrag(gui)
    local dragging, dragStart, startPos
    gui.InputBegan:Connect(function(input)
        if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) and not UIS:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
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

-- --- 2. MAIN UI STRUCTURE ---
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 380, 0, 240); MainFrame.Position = UDim2.new(0.5, -190, 0.4, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15); MainFrame.Visible = false; MainFrame.Active = true
MainFrame.ClipsDescendants = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)
local MainStroke = Instance.new("UIStroke", MainFrame)
MainStroke.Color = Color3.fromRGB(255, 105, 180); MainStroke.Thickness = 2
EnableDrag(MainFrame)

task.spawn(function()
    while task.wait() do
        local hue = tick() % 5 / 5
        MainStroke.Color = Color3.fromHSV(hue, 0.6, 1)
    end
end)

local Header = Instance.new("TextLabel", MainFrame)
Header.Size = UDim2.new(1, 0, 0, 35); Header.Text = "BoDcChii Project"; Header.TextColor3 = Color3.fromRGB(255, 105, 180)
Header.BackgroundTransparency = 1; Header.Font = Enum.Font.SourceSansBold; Header.TextSize = 18

-- --- 3. SCROLLING SETUP ---
local function SetupScroll(scroll)
    scroll.Active = true; scroll.ScrollBarThickness = 4
    scroll.ScrollBarImageColor3 = Color3.fromRGB(255, 105, 180)
    scroll.CanvasSize = UDim2.new(0, 0, 2, 0) 
    scroll.ScrollingDirection = Enum.ScrollingDirection.Y
end

local SidebarScroll = Instance.new("ScrollingFrame", MainFrame)
SidebarScroll.Size = UDim2.new(0, 115, 1, -45); SidebarScroll.Position = UDim2.new(0, 5, 0, 42); SidebarScroll.BackgroundTransparency = 1; SidebarScroll.BorderSizePixel = 0
SetupScroll(SidebarScroll)
Instance.new("UIListLayout", SidebarScroll).Padding = UDim.new(0, 5)

local ContentScroll = Instance.new("ScrollingFrame", MainFrame)
ContentScroll.Size = UDim2.new(1, -135, 1, -50); ContentScroll.Position = UDim2.new(0, 130, 0, 45); ContentScroll.BackgroundTransparency = 1; ContentScroll.BorderSizePixel = 0
SetupScroll(ContentScroll)

local LineH = Instance.new("Frame", MainFrame)
LineH.Size = UDim2.new(0.95, 0, 0, 2); LineH.Position = UDim2.new(0.025, 0, 0, 36); LineH.BackgroundColor3 = Color3.fromRGB(255, 105, 180); LineH.BorderSizePixel = 0
local LineV = Instance.new("Frame", MainFrame)
LineV.Size = UDim2.new(0, 2, 1, -50); LineV.Position = UDim2.new(0, 122, 0, 42); LineV.BackgroundColor3 = Color3.fromRGB(255, 105, 180); LineV.BorderSizePixel = 0

-- --- 4. TABS & PAGES ---
local function CreateTabBtn(text)
    local btn = Instance.new("TextButton", SidebarScroll); btn.Size = UDim2.new(1, -10, 0, 35)
    btn.BackgroundColor3 = Color3.fromRGB(25, 25, 25); btn.Text = text; btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.SourceSansBold; btn.TextSize = 10; Instance.new("UICorner", btn)
    Instance.new("UIStroke", btn).Color = Color3.fromRGB(255, 105, 180)
    return btn
end

local T0 = CreateTabBtn("0. ABOUT")
local T1 = CreateTabBtn("1. PLAYER ESP")
local T2 = CreateTabBtn("2. SURVIVAL")
local T4 = CreateTabBtn("3. KILLER UTILS") -- TAB BARU
local T3 = CreateTabBtn("4. SMOOTH MAPS")

local function CreatePage()
    local f = Instance.new("Frame", ContentScroll); f.Size = UDim2.new(1, -10, 1, 0); f.BackgroundTransparency = 1; f.Visible = false
    Instance.new("UIListLayout", f).Padding = UDim.new(0, 5)
    return f
end

local P0, P1, P2, P3, P4 = CreatePage(), CreatePage(), CreatePage(), CreatePage(), CreatePage()

local AboutInfo = Instance.new("TextLabel", P0)
AboutInfo.Size = UDim2.new(1, 0, 0, 200); AboutInfo.BackgroundTransparency = 1
AboutInfo.Text = "Creator: BoDcChii\nTester: Xiaoo\nVersi: v0.4.2 (KILLER UPDATE)\n\nUpdate:\n- Tab Killer Utils\n- No Attack Cooldown\n- Hitbox Expander\n- Potato Mode Fix"
AboutInfo.TextColor3 = Color3.new(1, 1, 1); AboutInfo.TextSize = 11; AboutInfo.Font = Enum.Font.SourceSansBold; AboutInfo.TextXAlignment = Enum.TextXAlignment.Left

local function Show(p, b)
    P0.Visible = false; P1.Visible = false; P2.Visible = false; P3.Visible = false; P4.Visible = false
    T0.BackgroundColor3 = Color3.fromRGB(25, 25, 25); T1.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    T2.BackgroundColor3 = Color3.fromRGB(25, 25, 25); T3.BackgroundColor3 = Color3.fromRGB(25, 25, 25); T4.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    p.Visible = true; b.BackgroundColor3 = Color3.fromRGB(255, 105, 180)
end

T0.MouseButton1Click:Connect(function() Show(P0, T0) end)
T1.MouseButton1Click:Connect(function() Show(P1, T1) end)
T2.MouseButton1Click:Connect(function() Show(P2, T2) end)
T4.MouseButton1Click:Connect(function() Show(P4, T4) end)
T3.MouseButton1Click:Connect(function() Show(P3, T3) end)
Show(P0, T0)

local function CreateBtn(parent, text)
    local btn = Instance.new("TextButton", parent); btn.Size = UDim2.new(1, 0, 0, 35); btn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    btn.Text = text .. ": OFF"; btn.TextColor3 = Color3.new(1, 1, 1); btn.Font = Enum.Font.SourceSansBold; btn.TextSize = 9
    Instance.new("UICorner", btn); local s = Instance.new("UIStroke", btn); s.Color = Color3.fromRGB(200, 50, 50)
    return btn
end

-- --- 5. LOGIKA FITUR ---
local _SurvOn, _KillOn, _GenOn, _NoSkillGen, _FullBright, _NoFog, _PotatoMode, _AutoParry = false, false, false, false, false, false, false, false
local _NoCD, _HitboxEx = false, false
local isWaitingParry = false

local Btn1 = CreateBtn(P1, "ESP SURVIVAL"); local Btn2 = CreateBtn(P1, "ESP KILLER")
local BtnAP = CreateBtn(P2, "AUTO PARRY (BETA)"); local Btn3 = CreateBtn(P2, "ESP GENERATOR"); local Btn4 = CreateBtn(P2, "NO SKILL CHECK")
local BtnNoCD = CreateBtn(P4, "NO ATTACK COOLDOWN"); local BtnHitbox = CreateBtn(P4, "HITBOX EXPANDER")
local Btn5 = CreateBtn(P3, "FULL BRIGHT"); local Btn6 = CreateBtn(P3, "NO FOG"); local Btn7 = CreateBtn(P3, "POTATO MODE")

local function Toggle(btn, state, txt)
    btn.Text = txt .. (state and ": ON" or ": OFF")
    btn.UIStroke.Color = state and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(200, 50, 50)
end

Btn1.MouseButton1Click:Connect(function() _SurvOn = not _SurvOn Toggle(Btn1, _SurvOn, "ESP SURVIVAL") end)
Btn2.MouseButton1Click:Connect(function() _KillOn = not _KillOn Toggle(Btn2, _KillOn, "ESP KILLER") end)
BtnAP.MouseButton1Click:Connect(function() _AutoParry = not _AutoParry Toggle(BtnAP, _AutoParry, "AUTO PARRY (BETA)") end)
Btn3.MouseButton1Click:Connect(function() _GenOn = not _GenOn Toggle(Btn3, _GenOn, "ESP GENERATOR") end)
Btn4.MouseButton1Click:Connect(function() _NoSkillGen = not _NoSkillGen Toggle(Btn4, _NoSkillGen, "NO SKILL CHECK") end)

-- KILLER LOGIC
BtnNoCD.MouseButton1Click:Connect(function() _NoCD = not _NoCD Toggle(BtnNoCD, _NoCD, "NO ATTACK COOLDOWN") end)
BtnHitbox.MouseButton1Click:Connect(function() _HitboxEx = not _HitboxEx Toggle(BtnHitbox, _HitboxEx, "HITBOX EXPANDER") end)

-- POTATO MODE FIX
Btn7.MouseButton1Click:Connect(function() 
    _PotatoMode = not _PotatoMode 
    Toggle(Btn7, _PotatoMode, "POTATO MODE")
    if _PotatoMode then
        for _, v in pairs(game.Workspace:GetDescendants()) do
            local isPlayer = v:FindFirstAncestorOfClass("Model") and Players:GetPlayerFromCharacter(v:FindFirstAncestorOfClass("Model"))
            if not isPlayer and (v:IsA("BasePart") or v:IsA("Texture") or v:IsA("Decal")) then
                if v:IsA("BasePart") then v.Material = Enum.Material.SmoothPlastic end
                if v:IsA("Texture") or v:IsA("Decal") then v.Transparency = 1 end
            end
        end
    end
end)

-- LOOP FITUR (HITBOX & COOLDOWN)
task.spawn(function()
    while task.wait(0.5) do
        if _HitboxEx then
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= Players.LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                    p.Character.HumanoidRootPart.Size = Vector3.new(10, 10, 10)
                    p.Character.HumanoidRootPart.Transparency = 0.7
                end
            end
        end
    end
end)

-- METATABLE HOOK (NO CD & NO SKILL CHECK)
local mt = getrawmetatable(game)
local old = mt.__namecall
setreadonly(mt, false)
mt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    local args = {...}
    if _NoCD and method == "FireServer" and tostring(self) == "AttackRemote" then -- Ganti "AttackRemote" dengan nama remote aslinya
        return old(self, unpack(args))
    end
    if _NoSkillGen and (method == "FireServer" or method == "InvokeServer") then
        local n = tostring(self):lower()
        if n:find("fail") or n:find("skillcheck") then return nil end
    end
    return old(self, ...)
end)
setreadonly(mt, true)

-- ESP & LIGHTING LOOP
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
end)

-- --- 6. TOGGLE BUTTON ---
local OpenButton = Instance.new("ScreenGui", CoreGui)
local MainBtn = Instance.new("TextButton", OpenButton)
MainBtn.Size = UDim2.new(0, 50, 0, 50); MainBtn.Position = UDim2.new(0, 20, 0.5, -25)
MainBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30); MainBtn.Text = "BD"; MainBtn.TextColor3 = Color3.fromRGB(255, 105, 180); MainBtn.TextSize = 24; MainBtn.Font = Enum.Font.SourceSansBold
Instance.new("UICorner", MainBtn).CornerRadius = UDim.new(0, 12)
local BtnStroke = Instance.new("UIStroke", MainBtn); BtnStroke.Color = Color3.fromRGB(255, 105, 180); BtnStroke.Thickness = 2
EnableDrag(MainBtn)

MainBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)