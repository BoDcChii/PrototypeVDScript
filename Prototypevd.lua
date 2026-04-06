-- [[ BoDcChii Project - v0.3: VIOLENCE DISTRICT FINAL FIX 🎸 ]] --

local CoreGui = game:GetService("CoreGui")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")

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
    task.delay(3, function() if WelcomeGui then WelcomeGui:Destroy() end end)
end
spawn(ShowWelcome)

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
MainFrame.Size = UDim2.new(0, 380, 0, 220); MainFrame.Position = UDim2.new(0.5, -190, 0.4, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15); MainFrame.Visible = false; MainFrame.Active = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)
Instance.new("UIStroke", MainFrame).Color = Color3.fromRGB(255, 105, 180)
EnableDrag(MainFrame)

local Header = Instance.new("TextLabel", MainFrame)
Header.Size = UDim2.new(1, 0, 0, 35); Header.Text = "BoDcChii Project"; Header.TextColor3 = Color3.fromRGB(255, 105, 180)
Header.BackgroundTransparency = 1; Header.Font = Enum.Font.SourceSansBold; Header.TextSize = 18

local SidebarScroll = Instance.new("ScrollingFrame", MainFrame)
SidebarScroll.Size = UDim2.new(0, 115, 1, -45); SidebarScroll.Position = UDim2.new(0, 5, 0, 42)
SidebarScroll.BackgroundTransparency = 1; SidebarScroll.BorderSizePixel = 0; SidebarScroll.CanvasSize = UDim2.new(0,0,1.2,0)

local SideLayout = Instance.new("UIListLayout", SidebarScroll); SideLayout.Padding = UDim.new(0, 5)

local ContentScroll = Instance.new("ScrollingFrame", MainFrame)
ContentScroll.Size = UDim2.new(1, -135, 1, -50); ContentScroll.Position = UDim2.new(0, 130, 0, 45)
ContentScroll.BackgroundTransparency = 1; ContentScroll.BorderSizePixel = 0; ContentScroll.CanvasSize = UDim2.new(0,0,1.5,0)

local function CreateTabBtn(text)
    local btn = Instance.new("TextButton", SidebarScroll); btn.Size = UDim2.new(1, -10, 0, 35)
    btn.BackgroundColor3 = Color3.fromRGB(25, 25, 25); btn.Text = text; btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.SourceSansBold; btn.TextSize = 10; Instance.new("UICorner", btn)
    Instance.new("UIStroke", btn).Color = Color3.fromRGB(255, 105, 180)
    return btn
end

local T0, T1, T2, T3 = CreateTabBtn("0. ABOUT"), CreateTabBtn("1. PLAYER ESP"), CreateTabBtn("2. SURVIVAL"), CreateTabBtn("3. SMOOTH MAPS")

local function CreatePage()
    local f = Instance.new("Frame", ContentScroll); f.Size = UDim2.new(1, -10, 1, 0); f.BackgroundTransparency = 1; f.Visible = false
    Instance.new("UIListLayout", f).Padding = UDim.new(0, 5)
    return f
end

local P0, P1, P2, P3 = CreatePage(), CreatePage(), CreatePage(), CreatePage()

local AboutInfo = Instance.new("TextLabel", P0)
AboutInfo.Size = UDim2.new(1, 0, 0, 150); AboutInfo.BackgroundTransparency = 1
AboutInfo.Text = "Creator: BoDcChii\nTester: Xiaoo\nVersi: v0.3\n\n- Fix Execute\n- Smart Gen ESP\n- Potato Mode"
AboutInfo.TextColor3 = Color3.new(1, 1, 1); AboutInfo.TextSize = 12; AboutInfo.Font = Enum.Font.SourceSansBold

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

local function CreateBtn(parent, text)
    local btn = Instance.new("TextButton", parent); btn.Size = UDim2.new(1, 0, 0, 35); btn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    btn.Text = text .. ": OFF"; btn.TextColor3 = Color3.new(1, 1, 1); btn.Font = Enum.Font.SourceSansBold; btn.TextSize = 9
    Instance.new("UICorner", btn); local s = Instance.new("UIStroke", btn); s.Color = Color3.fromRGB(200, 50, 50); s.Name = "St"
    return btn
end

-- --- 5. FITUR ---
local _SurvOn, _KillOn, _GenOn, _NoSkillGen, _FullBright, _NoFog, _PotatoMode = false, false, false, false, false, false, false
local Btn1, Btn2 = CreateBtn(P1, "ESP SURVIVAL"), CreateBtn(P1, "ESP KILLER")
local Btn3, Btn4 = CreateBtn(P2, "ESP GENERATOR"), CreateBtn(P2, "NO SKILL CHECK")
local Btn5, Btn6, Btn7 = CreateBtn(P3, "FULL BRIGHT"), CreateBtn(P3, "NO FOG"), CreateBtn(P3, "POTATO MODE")

local function UpdateVisual(btn, state, txt)
    btn.Text = txt .. (state and ": ON" or ": OFF")
    btn.St.Color = state and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(200, 50, 50)
end

Btn1.MouseButton1Click:Connect(function() _SurvOn = not _SurvOn UpdateVisual(Btn1, _SurvOn, "ESP SURVIVAL") end)
Btn2.MouseButton1Click:Connect(function() _KillOn = not _KillOn UpdateVisual(Btn2, _KillOn, "ESP KILLER") end)
Btn3.MouseButton1Click:Connect(function() _GenOn = not _GenOn UpdateVisual(Btn3, _GenOn, "ESP GENERATOR") end)
Btn4.MouseButton1Click:Connect(function() _NoSkillGen = not _NoSkillGen UpdateVisual(Btn4, _NoSkillGen, "NO SKILL CHECK") end)
Btn5.MouseButton1Click:Connect(function() _FullBright = not _FullBright UpdateVisual(Btn5, _FullBright, "FULL BRIGHT") end)
Btn6.MouseButton1Click:Connect(function() _NoFog = not _NoFog UpdateVisual(Btn6, _NoFog, "NO FOG") end)
Btn7.MouseButton1Click:Connect(function() 
    _PotatoMode = not _PotatoMode 
    UpdateVisual(Btn7, _PotatoMode, "POTATO MODE")
    if _PotatoMode then
        for _, v in pairs(game.Workspace:GetDescendants()) do
            if v:IsA("BasePart") and not v:FindFirstAncestorOfClass("Model") then
                v.Material = Enum.Material.SmoothPlastic
            end
        end
    end
end)

-- --- LOOP ESP ---
task.spawn(function()
    while task.wait(2) do
        if _GenOn then
            for _, v in pairs(game.Workspace:GetDescendants()) do
                if (v.Name:lower():find("gen") or v.Name:lower():find("generator")) and (v:IsA("Model") or v:IsA("BasePart")) then
                    -- Filter: Jika generator sudah selesai (biasanya transparan atau ada penanda lain di Violence District)
                    local isFinished = v:FindFirstChild("Done") or v:FindFirstChild("Completed")
                    if not isFinished then
                        if not v:FindFirstChild("GenEsp") then
                            local h = Instance.new("Highlight", v); h.Name = "GenEsp"; h.FillColor = Color3.fromRGB(255, 255, 0)
                        end
                    else
                        if v:FindFirstChild("GenEsp") then v.GenEsp:Destroy() end
                    end
                end
            end
        else
            for _, v in pairs(game.Workspace:GetDescendants()) do if v:FindFirstChild("GenEsp") then v.GenEsp:Destroy() end end
        end
    end
end)

RunService.RenderStepped:Connect(function()
    if _FullBright then Lighting.Ambient = Color3.new(1, 1, 1); Lighting.ClockTime = 12 end
    if _NoFog then Lighting.FogEnd = 100000 end
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= Players.LocalPlayer and p.Character then
            local hl = p.Character:FindFirstChild("BDEsp") or Instance.new("Highlight", p.Character); hl.Name = "BDEsp"
            local isK = (p.Team and p.Team.Name:lower():find("kill")) or (p.Character:FindFirstChild("Humanoid") and p.Character.Humanoid.MaxHealth > 100)
            hl.Enabled = (isK and _KillOn) or (not isK and _SurvOn)
            hl.FillColor = isK and Color3.new(1, 0, 0) or Color3.new(0, 1, 0)
        end
    end
end)

-- --- 6. TOGGLE BUTTON ---
local OpenButton = Instance.new("TextButton", ScreenGui)
OpenButton.Size = UDim2.new(0, 50, 0, 50); OpenButton.Position = UDim2.new(0, 20, 0.5, -25)
OpenButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30); OpenButton.Text = "BD"; OpenButton.TextColor3 = Color3.fromRGB(255, 105, 180)
OpenButton.TextSize = 24; OpenButton.Font = Enum.Font.SourceSansBold; OpenButton.ZIndex = 500
Instance.new("UICorner", OpenButton).CornerRadius = UDim.new(0, 12)
Instance.new("UIStroke", OpenButton).Color = Color3.fromRGB(255, 105, 180)
EnableDrag(OpenButton)

OpenButton.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)