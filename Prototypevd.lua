-- [[ BoDcChii Project - v0.4.2: INSTANT PARRY & SURVIVAL SYNC ⚔️ ]] --

local CoreGui = game:GetService("CoreGui")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- --- 0. ANTI-REDUNDANT ---
if CoreGui:FindFirstChild("BoDcChii_Minimalist") then CoreGui.BoDcChii_Minimalist:Destroy() end

-- --- 1. SETTINGS & DRAG SYSTEM ---
local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "BoDcChii_Minimalist"; ScreenGui.ResetOnSpawn = false

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

-- --- 2. MAIN UI STRUCTURE ---
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 380, 0, 240); MainFrame.Position = UDim2.new(0.5, -190, 0.4, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15); MainFrame.Visible = false; MainFrame.Active = true
MainFrame.ClipsDescendants = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)
local MainStroke = Instance.new("UIStroke", MainFrame)
MainStroke.Color = Color3.fromRGB(255, 105, 180); MainStroke.Thickness = 2
EnableDrag(MainFrame)

-- Rainbow Stroke Effect
task.spawn(function()
    while task.wait() do
        MainStroke.Color = Color3.fromHSV(tick() % 5 / 5, 0.6, 1)
    end
end)

local Header = Instance.new("TextLabel", MainFrame)
Header.Size = UDim2.new(1, 0, 0, 35); Header.Text = "BoDcChii Project v0.4.2"; Header.TextColor3 = Color3.fromRGB(255, 105, 180)
Header.BackgroundTransparency = 1; Header.Font = Enum.Font.SourceSansBold; Header.TextSize = 18

-- --- 3. TABS SETUP ---
local SidebarScroll = Instance.new("ScrollingFrame", MainFrame)
SidebarScroll.Size = UDim2.new(0, 115, 1, -45); SidebarScroll.Position = UDim2.new(0, 5, 0, 42); SidebarScroll.BackgroundTransparency = 1; SidebarScroll.BorderSizePixel = 0
SidebarScroll.ScrollBarThickness = 2

local ContentScroll = Instance.new("ScrollingFrame", MainFrame)
ContentScroll.Size = UDim2.new(1, -135, 1, -50); ContentScroll.Position = UDim2.new(0, 130, 0, 45); ContentScroll.BackgroundTransparency = 1; ContentScroll.BorderSizePixel = 0
ContentScroll.ScrollBarThickness = 2

Instance.new("UIListLayout", SidebarScroll).Padding = UDim.new(0, 5)

local function CreateTabBtn(text)
    local btn = Instance.new("TextButton", SidebarScroll); btn.Size = UDim2.new(1, -10, 0, 35)
    btn.BackgroundColor3 = Color3.fromRGB(25, 25, 25); btn.Text = text; btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.SourceSansBold; btn.TextSize = 10; Instance.new("UICorner", btn)
    Instance.new("UIStroke", btn).Color = Color3.fromRGB(255, 105, 180)
    return btn
end

local T0 = CreateTabBtn("0. ABOUT"); local T1 = CreateTabBtn("1. PLAYER ESP")
local T2 = CreateTabBtn("2. SURVIVAL"); local T3 = CreateTabBtn("3. SMOOTH MAPS")

local function CreatePage()
    local f = Instance.new("Frame", ContentScroll); f.Size = UDim2.new(1, -10, 1, 0); f.BackgroundTransparency = 1; f.Visible = false
    Instance.new("UIListLayout", f).Padding = UDim.new(0, 5)
    return f
end

local P0, P1, P2, P3 = CreatePage(), CreatePage(), CreatePage(), CreatePage()

-- --- 4. ISI ABOUT (TETAP SAMA) ---
local AboutInfo = Instance.new("TextLabel", P0)
AboutInfo.Size = UDim2.new(1, 0, 0, 160); AboutInfo.BackgroundTransparency = 1
AboutInfo.Text = "Creator: BoDcChii\nScript Tester: Xiaoo\nVersi: v0.4.2 (Parry Edition)\n\nUpdate:\n- Added Instant Auto Parry\n- Improved ESP Logic\n- Fixed Menu Layout"
AboutInfo.TextColor3 = Color3.new(1, 1, 1); AboutInfo.TextSize = 12; AboutInfo.Font = Enum.Font.SourceSansBold; AboutInfo.TextXAlignment = Enum.TextXAlignment.Left

local function Show(p, b)
    P0.Visible = false; P1.Visible = false; P2.Visible = false; P3.Visible = false
    T0.BackgroundColor3 = Color3.fromRGB(25, 25, 25); T1.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    T2.BackgroundColor3 = Color3.fromRGB(25, 25, 25); T3.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    p.Visible = true; b.BackgroundColor3 = Color3.fromRGB(255, 105, 180)
end

T0.MouseButton1Click:Connect(function() Show(P0, T0) end)
T1.MouseButton1Click:Connect(function() Show(P1, T1) end)
T2.MouseButton1Click:Connect(function() Show(P2, T2) end)
T3.MouseButton1Click:Connect(function() Show(P3, T3) end)
Show(P0, T0)

-- --- 5. LOGIKA FITUR ---
local _SurvOn, _KillOn, _GenOn, _NoSkillGen, _FullBright, _NoFog, _PotatoMode, _AutoParry = false, false, false, false, false, false, false, false

local function CreateBtn(parent, text)
    local btn = Instance.new("TextButton", parent); btn.Size = UDim2.new(1, 0, 0, 35); btn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    btn.Text = text .. ": OFF"; btn.TextColor3 = Color3.new(1, 1, 1); btn.Font = Enum.Font.SourceSansBold; btn.TextSize = 10
    Instance.new("UICorner", btn); local s = Instance.new("UIStroke", btn); s.Color = Color3.fromRGB(200, 50, 50); s.Thickness = 1.5
    return btn
end

local function Toggle(btn, state, txt)
    btn.Text = txt .. (state and ": ON" or ": OFF")
    btn.UIStroke.Color = state and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(200, 50, 50)
end

-- Tab 1: ESP
local Btn1 = CreateBtn(P1, "ESP SURVIVAL")
local Btn2 = CreateBtn(P1, "ESP KILLER")
-- Tab 2: SURVIVAL
local BtnAP = CreateBtn(P2, "AUTO PARRY (INSTANT)")
local Btn3 = CreateBtn(P2, "ESP GENERATOR")
local Btn4 = CreateBtn(P2, "NO SKILL CHECK")
-- Tab 3: PERFORMANCE
local Btn5 = CreateBtn(P3, "FULL BRIGHT")
local Btn6 = CreateBtn(P3, "NO FOG")
local Btn7 = CreateBtn(P3, "POTATO MODE")

-- Toggle Events
Btn1.MouseButton1Click:Connect(function() _SurvOn = not _SurvOn Toggle(Btn1, _SurvOn, "ESP SURVIVAL") end)
Btn2.MouseButton1Click:Connect(function() _KillOn = not _KillOn Toggle(Btn2, _KillOn, "ESP KILLER") end)
BtnAP.MouseButton1Click:Connect(function() _AutoParry = not _AutoParry Toggle(BtnAP, _AutoParry, "AUTO PARRY (INSTANT)") end)
Btn3.MouseButton1Click:Connect(function() _GenOn = not _GenOn Toggle(Btn3, _GenOn, "ESP GENERATOR") end)
Btn4.MouseButton1Click:Connect(function() _NoSkillGen = not _NoSkillGen Toggle(Btn4, _NoSkillGen, "NO SKILL CHECK") end)
Btn5.MouseButton1Click:Connect(function() _FullBright = not _FullBright Toggle(Btn5, _FullBright, "FULL BRIGHT") end)
Btn6.MouseButton1Click:Connect(function() _NoFog = not _NoFog Toggle(Btn6, _NoFog, "NO FOG") end)

-- POTATO MODE LOGIC
Btn7.MouseButton1Click:Connect(function() 
    _PotatoMode = not _PotatoMode 
    Toggle(Btn7, _PotatoMode, "POTATO MODE")
    if _PotatoMode then
        for _, v in pairs(game.Workspace:GetDescendants()) do
            if v:IsA("BasePart") and not v:FindFirstAncestorOfClass("Model") then 
                v.Material = Enum.Material.SmoothPlastic 
                if v:IsA("MeshPart") then v.TextureID = "" end
            elseif v:IsA("Decal") or v:IsA("Texture") then v.Transparency = 1 
            end
        end
    end
end)

-- --- 6. CORE LOGIC (AUTO PARRY INSTANT) ---
task.spawn(function()
    while task.wait() do
        if _AutoParry then
            pcall(function()
                local char = Players.LocalPlayer.Character
                if char and char:FindFirstChild("HumanoidRootPart") then
                    for _, p in pairs(Players:GetPlayers()) do
                        if p ~= Players.LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                            local dist = (char.HumanoidRootPart.Position - p.Character.HumanoidRootPart.Position).Magnitude
                            -- Cek jika musuh mulai menyerang (berdasarkan animasi atau tool)
                            local isAttacking = p.Character:FindFirstChildOfClass("Tool") and p.Character:FindFirstChildOfClass("Tool"):FindFirstChild("Handle")
                            
                            if dist < 12 and isAttacking then
                                -- Memicu Parry Instan (Mengirim Remote Event Parry game)
                                local remote = ReplicatedStorage:FindFirstChild("ParryEvent") or ReplicatedStorage:FindFirstChild("CombatEvent")
                                if remote then remote:FireServer() end
                                -- Cadangan: Kirim Input Key F jika remote tidak langsung
                                game:GetService("VirtualInputManager"):SendKeyEvent(true, Enum.KeyCode.F, false, game)
                                task.wait(0.05)
                                game:GetService("VirtualInputManager"):SendKeyEvent(false, Enum.KeyCode.F, false, game)
                            end
                        end
                    end
                end
            end)
        end
    end
end)

-- ESP & LIGHTING LOOP
RunService.RenderStepped:Connect(function()
    if _FullBright then Lighting.Ambient = Color3.new(1, 1, 1); Lighting.ClockTime = 12 end
    if _NoFog then Lighting.FogEnd = 100000 end
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= Players.LocalPlayer and p.Character then
            local hl = p.Character:FindFirstChild("BDEsp") or Instance.new("Highlight", p.Character)
            hl.Name = "BDEsp"
            local isK = (p.Team and p.Team.Name:lower():find("kill")) or (p.Character:FindFirstChild("Humanoid") and p.Character.Humanoid.MaxHealth > 100)
            hl.Enabled = (isK and _KillOn) or (not isK and _SurvOn)
            hl.FillColor = isK and Color3.new(1, 0, 0) or Color3.new(0, 1, 0)
        end
    end
end)

-- --- 7. OPEN/CLOSE TOGGLE ---
local OpenButton = Instance.new("TextButton", ScreenGui)
OpenButton.Size = UDim2.new(0, 50, 0, 50); OpenButton.Position = UDim2.new(0, 20, 0.5, -25)
OpenButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30); OpenButton.Text = "BD"; OpenButton.TextColor3 = Color3.fromRGB(255, 105, 180)
OpenButton.TextSize = 24; OpenButton.Font = Enum.Font.SourceSansBold; Instance.new("UICorner", OpenButton).CornerRadius = UDim.new(0, 12)
local BtnStroke = Instance.new("UIStroke", OpenButton); BtnStroke.Color = Color3.fromRGB(255, 105, 180); BtnStroke.Thickness = 2
EnableDrag(OpenButton)

OpenButton.MouseButton1Click:Connect(function()
    if MainFrame.Visible then
        MainFrame:TweenSize(UDim2.new(0, 0, 0, 0), "Out", "Quad", 0.3, true)
        task.delay(0.3, function() MainFrame.Visible = false end)
    else
        MainFrame.Visible = true; MainFrame.Size = UDim2.new(0, 0, 0, 0)
        MainFrame:TweenSize(UDim2.new(0, 380, 0, 240), "Out", "Back", 0.4, true)
    end
end)