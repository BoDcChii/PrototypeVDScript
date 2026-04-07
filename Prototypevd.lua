-- [[ BoDcChii Project - v0.4.6: TRUE PARRY SYNC (STABLE MOBILE) 🎸 ]] --

local CoreGui = game:GetService("CoreGui")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VIM = game:GetService("VirtualInputManager")

-- --- 0. ANTI-REDUNDANT ---
if CoreGui:FindFirstChild("BoDcChii_Minimalist") then CoreGui.BoDcChii_Minimalist:Destroy() end

-- --- 1. SETUP UI (HP FRIENDLY) ---
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

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 320, 0, 190); MainFrame.Position = UDim2.new(0.5, -160, 0.3, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15); MainFrame.Visible = false; MainFrame.Active = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)
local MainStroke = Instance.new("UIStroke", MainFrame)
MainStroke.Color = Color3.fromRGB(255, 105, 180); MainStroke.Thickness = 2
EnableDrag(MainFrame)

task.spawn(function()
    while task.wait() do MainStroke.Color = Color3.fromHSV(tick() % 5 / 5, 0.6, 1) end
end)

local Header = Instance.new("TextLabel", MainFrame)
Header.Size = UDim2.new(1, 0, 0, 30); Header.Text = "BoDcChii Project v0.4.6"; Header.TextColor3 = Color3.fromRGB(255, 105, 180)
Header.BackgroundTransparency = 1; Header.Font = Enum.Font.SourceSansBold; Header.TextSize = 14

-- --- 2. TABS & PAGES ---
local SidebarScroll = Instance.new("ScrollingFrame", MainFrame)
SidebarScroll.Size = UDim2.new(0, 90, 1, -40); SidebarScroll.Position = UDim2.new(0, 5, 0, 35); SidebarScroll.BackgroundTransparency = 1; SidebarScroll.BorderSizePixel = 0; SidebarScroll.ScrollBarThickness = 0
Instance.new("UIListLayout", SidebarScroll).Padding = UDim.new(0, 5)

local ContentScroll = Instance.new("ScrollingFrame", MainFrame)
ContentScroll.Size = UDim2.new(1, -110, 1, -45); ContentScroll.Position = UDim2.new(0, 105, 0, 40); ContentScroll.BackgroundTransparency = 1; ContentScroll.BorderSizePixel = 0; ContentScroll.ScrollBarThickness = 2

local function CreateTabBtn(text)
    local btn = Instance.new("TextButton", SidebarScroll); btn.Size = UDim2.new(1, -5, 0, 30)
    btn.BackgroundColor3 = Color3.fromRGB(25, 25, 25); btn.Text = text; btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.SourceSansBold; btn.TextSize = 8; Instance.new("UICorner", btn)
    Instance.new("UIStroke", btn).Color = Color3.fromRGB(255, 105, 180)
    return btn
end

local T0, T1, T2, T3 = CreateTabBtn("ABOUT"), CreateTabBtn("ESP"), CreateTabBtn("SURVIVAL"), CreateTabBtn("WORLD")
local function CreatePage()
    local f = Instance.new("Frame", ContentScroll); f.Size = UDim2.new(1, -5, 1, 0); f.BackgroundTransparency = 1; f.Visible = false
    Instance.new("UIListLayout", f).Padding = UDim.new(0, 5)
    return f
end
local P0, P1, P2, P3 = CreatePage(), CreatePage(), CreatePage(), CreatePage()

local function Show(p, b)
    P0.Visible = false; P1.Visible = false; P2.Visible = false; P3.Visible = false
    T0.BackgroundColor3 = Color3.fromRGB(25, 25, 25); T1.BackgroundColor3 = Color3.fromRGB(25, 25, 25); T2.BackgroundColor3 = Color3.fromRGB(25, 25, 25); T3.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    p.Visible = true; b.BackgroundColor3 = Color3.fromRGB(255, 105, 180)
end
T0.MouseButton1Click:Connect(function() Show(P0, T0) end)
T1.MouseButton1Click:Connect(function() Show(P1, T1) end)
T2.MouseButton1Click:Connect(function() Show(P2, T2) end)
T3.MouseButton1Click:Connect(function() Show(P3, T3) end)
Show(P0, T0)

local AboutInfo = Instance.new("TextLabel", P0)
AboutInfo.Size = UDim2.new(1, 0, 0, 150); AboutInfo.BackgroundTransparency = 1; AboutInfo.TextColor3 = Color3.new(1, 1, 1); AboutInfo.TextSize = 10; AboutInfo.Font = Enum.Font.SourceSansBold; AboutInfo.TextXAlignment = Enum.TextXAlignment.Left
AboutInfo.Text = "Creator: BoDcChii\nScript Tester: Xiaoo\nVersi: v0.4 (Aesthetic)\n\nUpdate:\n- TRUE PARRY (Mobile Sync)\n- No More Emote Bug\n- Stabilized Logic"

-- --- 3. FEATURES & BUTTONS ---
local _SurvOn, _KillOn, _GenOn, _NoSkillGen, _FullBright, _NoFog, _PotatoMode, _AutoParry = false, false, false, false, false, false, false, false

local function CreateBtn(parent, text)
    local btn = Instance.new("TextButton", parent); btn.Size = UDim2.new(1, 0, 0, 32); btn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    btn.Text = text .. ": OFF"; btn.TextColor3 = Color3.new(1, 1, 1); btn.Font = Enum.Font.SourceSansBold; btn.TextSize = 9
    Instance.new("UICorner", btn); local s = Instance.new("UIStroke", btn); s.Color = Color3.fromRGB(200, 50, 50)
    return btn
end

local function Toggle(btn, state, txt)
    btn.Text = txt .. (state and ": ON" or ": OFF")
    btn.UIStroke.Color = state and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(200, 50, 50)
end

local Btn1 = CreateBtn(P1, "ESP SURVIVAL"); local Btn2 = CreateBtn(P1, "ESP KILLER")
local BtnAP = CreateBtn(P2, "AUTO PARRY (TRUE)"); local Btn3 = CreateBtn(P2, "ESP GENERATOR"); local Btn4 = CreateBtn(P2, "NO SKILL CHECK")
local Btn5 = CreateBtn(P3, "FULL BRIGHT"); local Btn6 = CreateBtn(P3, "NO FOG"); local Btn7 = CreateBtn(P3, "POTATO MODE")

Btn1.MouseButton1Click:Connect(function() _SurvOn = not _SurvOn Toggle(Btn1, _SurvOn, "ESP SURVIVAL") end)
Btn2.MouseButton1Click:Connect(function() _KillOn = not _KillOn Toggle(Btn2, _KillOn, "ESP KILLER") end)
BtnAP.MouseButton1Click:Connect(function() _AutoParry = not _AutoParry Toggle(BtnAP, _AutoParry, "AUTO PARRY (TRUE)") end)
Btn3.MouseButton1Click:Connect(function() _GenOn = not _GenOn Toggle(Btn3, _GenOn, "ESP GENERATOR") end)
Btn4.MouseButton1Click:Connect(function() _NoSkillGen = not _NoSkillGen Toggle(Btn4, _NoSkillGen, "NO SKILL CHECK") end)
Btn5.MouseButton1Click:Connect(function() _FullBright = not _FullBright Toggle(Btn5, _FullBright, "FULL BRIGHT") end)
Btn6.MouseButton1Click:Connect(function() _NoFog = not _NoFog Toggle(Btn6, _NoFog, "NO FOG") end)

-- --- 4. ULTIMATE AUTO PARRY LOGIC (FIXED) ---
task.spawn(function()
    while task.wait() do
        if _AutoParry then
            pcall(function()
                local player = Players.LocalPlayer
                local char = player.Character
                if char and char:FindFirstChild("HumanoidRootPart") then
                    for _, enemy in pairs(Players:GetPlayers()) do
                        if enemy ~= player and enemy.Character and enemy.Character:FindFirstChild("HumanoidRootPart") then
                            local enemyChar = enemy.Character
                            local dist = (char.HumanoidRootPart.Position - enemyChar.HumanoidRootPart.Position).Magnitude
                            
                            -- TRUE DETECTION: Jarak sangat dekat (12 unit) + Killer memegang senjata
                            if dist < 12 then
                                local killerTool = enemyChar:FindFirstChildOfClass("Tool")
                                if killerTool then
                                    -- Simulasi Tekan F (Parry)
                                    VIM:SendKeyEvent(true, Enum.KeyCode.F, false, game)
                                    task.wait(0.02)
                                    VIM:SendKeyEvent(false, Enum.KeyCode.F, false, game)
                                    
                                    -- Debounce agar tidak buka menu Emote (delay sedikit)
                                    task.wait(0.3) 
                                end
                            end
                        end
                    end
                end
            end)
        end
    end
end)

-- FITUR LAINNYA (TETAP SAMA)
Btn7.MouseButton1Click:Connect(function() 
    _PotatoMode = not _PotatoMode 
    Toggle(Btn7, _PotatoMode, "POTATO MODE")
    if _PotatoMode then
        for _, v in pairs(game.Workspace:GetDescendants()) do
            if v:IsA("BasePart") and not v:FindFirstAncestorOfClass("Model") then v.Material = Enum.Material.SmoothPlastic 
            elseif v:IsA("Decal") or v:IsA("Texture") then v.Transparency = 1 end
        end
    end
end)

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

-- --- 5. TOGGLE BUTTON ---
local OpenButton = Instance.new("TextButton", ScreenGui)
OpenButton.Size = UDim2.new(0, 40, 0, 40); OpenButton.Position = UDim2.new(0, 10, 0.5, -20)
OpenButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30); OpenButton.Text = "BD"; OpenButton.TextColor3 = Color3.fromRGB(255, 105, 180)
OpenButton.TextSize = 18; OpenButton.Font = Enum.Font.SourceSansBold; Instance.new("UICorner", OpenButton)
local BtnStroke = Instance.new("UIStroke", OpenButton); BtnStroke.Color = Color3.fromRGB(255, 105, 180); BtnStroke.Thickness = 2
EnableDrag(OpenButton)

OpenButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)