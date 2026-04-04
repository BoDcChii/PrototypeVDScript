-- [[ BoDcChii Project - v4.2: Elite Survival (SILENT GENERATOR) 🎸 ]] --
-- Update: Targeted Mute for Generator Objects (Fixed No Sound & No Lag)

local CoreGui = game:GetService("CoreGui")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")

-- --- 0. NOTIFIKASI WELCOME ---
local function ShowWelcome()
    local WelcomeGui = Instance.new("ScreenGui", CoreGui)
    WelcomeGui.Name = "BoDcChii_Welcome"
    WelcomeGui.DisplayOrder = 999
    local WelcomeFrame = Instance.new("Frame", WelcomeGui)
    WelcomeFrame.Size = UDim2.new(0, 220, 0, 40)
    WelcomeFrame.Position = UDim2.new(0, 20, 0, 20)
    WelcomeFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    Instance.new("UICorner", WelcomeFrame).CornerRadius = UDim.new(0, 8)
    local Stroke = Instance.new("UIStroke", WelcomeFrame)
    Stroke.Color = Color3.fromRGB(255, 105, 180); Stroke.Thickness = 2
    local WelcomeLabel = Instance.new("TextLabel", WelcomeFrame)
    WelcomeLabel.Size = UDim2.new(1, 0, 1, 0); WelcomeLabel.BackgroundTransparency = 1
    WelcomeLabel.Text = "Welcome To BoDcChii"; WelcomeLabel.TextColor3 = Color3.new(1, 1, 1)
    WelcomeLabel.TextSize = 16; WelcomeLabel.Font = Enum.Font.SourceSansBold
    task.delay(1.5, function() WelcomeGui:Destroy() end)
end
ShowWelcome()

if CoreGui:FindFirstChild("BoDcChii_Minimalist") then CoreGui.BoDcChii_Minimalist:Destroy() end

local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "BoDcChii_Minimalist"; ScreenGui.ResetOnSpawn = false

-- --- FUNGSI DRAG ---
local function EnableDrag(gui)
    local dragging, dragInput, dragStart, startPos
    gui.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true; dragStart = input.Position; startPos = gui.Position
            input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then dragging = false end end)
        end
    end)
    gui.InputChanged:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then dragInput = input end end)
    UIS.InputChanged:Connect(function(input) if input == dragInput and dragging then local delta = input.Position - dragStart
        gui.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y) end end)
end

-- --- 1. ICON "BD" ---
local OpenButton = Instance.new("TextButton", ScreenGui)
OpenButton.Size = UDim2.new(0, 50, 0, 50); OpenButton.Position = UDim2.new(0, 20, 0.5, -25)
OpenButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30); OpenButton.Text = "BD" 
OpenButton.TextColor3 = Color3.fromRGB(255, 105, 180); OpenButton.TextSize = 24
OpenButton.Font = Enum.Font.SourceSansBold; OpenButton.ZIndex = 500
Instance.new("UICorner", OpenButton).CornerRadius = UDim.new(0, 12)
Instance.new("UIStroke", OpenButton).Color = Color3.fromRGB(255, 105, 180)
EnableDrag(OpenButton)

-- --- 2. MAIN FRAME (SCROLLING SYSTEM) ---
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 240, 0, 200); MainFrame.Position = UDim2.new(0.5, -120, 0.4, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15); MainFrame.Visible = false; MainFrame.Active = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)
Instance.new("UIStroke", MainFrame).Color = Color3.fromRGB(255, 105, 180)
EnableDrag(MainFrame)

local Header = Instance.new("TextLabel", MainFrame)
Header.Size = UDim2.new(1, 0, 0, 35); Header.Text = "BoDcChii Project"; Header.TextColor3 = Color3.fromRGB(255, 105, 180)
Header.BackgroundTransparency = 1; Header.Font = Enum.Font.SourceSansBold; Header.TextSize = 18

local ScrollFrame = Instance.new("ScrollingFrame", MainFrame)
ScrollFrame.Size = UDim2.new(1, -10, 1, -45); ScrollFrame.Position = UDim2.new(0, 5, 0, 40)
ScrollFrame.BackgroundTransparency = 1; ScrollFrame.ScrollBarThickness = 3
ScrollFrame.ScrollBarImageColor3 = Color3.fromRGB(255, 105, 180); ScrollFrame.BorderSizePixel = 0
local UIList = Instance.new("UIListLayout", ScrollFrame)
UIList.SortOrder = Enum.SortOrder.LayoutOrder; UIList.Padding = UDim.new(0, 5)

local function CreateBtn(parent, text)
    local btn = Instance.new("TextButton", parent); btn.Size = UDim2.new(0.95, 0, 0, 35)
    btn.BackgroundColor3 = Color3.fromRGB(25, 25, 25); btn.Text = text .. ": OFF"; btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.SourceSansBold; Instance.new("UICorner", btn)
    local s = Instance.new("UIStroke", btn); s.Color = Color3.fromRGB(200, 50, 50)
    return btn
end

-- --- 3. CATEGORIES ---
local Cat1Btn = CreateBtn(ScrollFrame, "[ PLAYER & OBJECTIVE ]  +")
local Feature1Frame = Instance.new("Frame", ScrollFrame); Feature1Frame.Size = UDim2.new(0.95, 0, 0, 120); Feature1Frame.BackgroundTransparency = 1; Feature1Frame.Visible = false; Instance.new("UIListLayout", Feature1Frame).Padding = UDim.new(0, 5)
local _SurvOn, _KillOn, _GenOn = false, false, false
local SurvBtn = CreateBtn(Feature1Frame, "ESP SURVIVAL"); local KillBtn = CreateBtn(Feature1Frame, "ESP KILLER"); local GenBtn = CreateBtn(Feature1Frame, "ESP GENERATOR")

local Cat3Btn = CreateBtn(ScrollFrame, "[ SURVIVAL SKILLS ]  +")
local Feature3Frame = Instance.new("Frame", ScrollFrame); Feature3Frame.Size = UDim2.new(0.95, 0, 0, 40); Feature3Frame.BackgroundTransparency = 1; Feature3Frame.Visible = false; Instance.new("UIListLayout", Feature3Frame).Padding = UDim.new(0, 5)
local _AntiExplode = false
local SkillBtn = CreateBtn(Feature3Frame, "ANTI-EXPLODE GEN")

local Cat2Btn = CreateBtn(ScrollFrame, "[ SMOOTH MAPS ]  +")
local Feature2Frame = Instance.new("Frame", ScrollFrame); Feature2Frame.Size = UDim2.new(0.95, 0, 0, 80); Feature2Frame.BackgroundTransparency = 1; Feature2Frame.Visible = false; Instance.new("UIListLayout", Feature2Frame).Padding = UDim.new(0, 5)
local _FullBright, _NoFog = false, false
local BrightBtn = CreateBtn(Feature2Frame, "FULL BRIGHT"); local FogBtn = CreateBtn(Feature2Frame, "NO FOG / MIST")

local function RefreshScroll() ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, UIList.AbsoluteContentSize.Y + 20) end
Cat1Btn.MouseButton1Click:Connect(function() Feature1Frame.Visible = not Feature1Frame.Visible RefreshScroll() end)
Cat3Btn.MouseButton1Click:Connect(function() Feature3Frame.Visible = not Feature3Frame.Visible RefreshScroll() end)
Cat2Btn.MouseButton1Click:Connect(function() Feature2Frame.Visible = not Feature2Frame.Visible RefreshScroll() end)

-- --- 4. LOGIKA FITUR (HYBRID CORE) ---
RunService.RenderStepped:Connect(function()
    -- ESP & Smooth Maps (Tetap Aman & Locked)
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= Players.LocalPlayer and p.Character then
            local hl = p.Character:FindFirstChild("BDEsp") or Instance.new("Highlight", p.Character)
            hl.Name = "BDEsp"
            local isKill = (p.Team and p.Team.Name:lower():find("kill")) or (p.Character:FindFirstChild("Humanoid") and p.Character.Humanoid.MaxHealth > 100)
            if isKill then hl.FillColor = Color3.fromRGB(255, 0, 0); hl.Enabled = _KillOn
            else hl.FillColor = Color3.fromRGB(0, 255, 0); hl.Enabled = _SurvOn end
        end
    end
    
    if _FullBright then Lighting.Ambient = Color3.new(1, 1, 1); Lighting.OutdoorAmbient = Color3.new(1, 1, 1); Lighting.ClockTime = 12 end
    if _NoFog then Lighting.FogEnd = 999999; Lighting.FogStart = 999999 end

    -- FIX FINAL: Anti-Explode (Mute Generator Sound Directly)
    if _AntiExplode then
        for _, obj in pairs(game.Workspace:GetChildren()) do
            if obj.Name == "Generator" or obj.Name == "Gen" then
                -- ESP Generator (Locked)
                local hl = obj:FindFirstChild("GenEsp") or Instance.new("Highlight", obj)
                hl.Name = "GenEsp"; hl.FillColor = Color3.fromRGB(255, 255, 0); hl.Enabled = _GenOn
                
                -- Anti-Explode: Mute all sounds inside this generator
                for _, s in pairs(obj:GetDescendants()) do
                    if s:IsA("Sound") and (s.Name:lower():find("explode") or s.Name:lower():find("fail") or s.Name:lower():find("alarm") or s.Playing) then
                        s.Volume = 0
                    end
                end
            end
        end
    end
end)

-- --- 5. INTERAKSI TOMBOL ---
local function Toggle(btn, state, txt)
    btn.Text = txt .. (state and ": ON" or ": OFF")
    btn.UIStroke.Color = state and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(200, 50, 50)
end

SurvBtn.MouseButton1Click:Connect(function() _SurvOn = not _SurvOn Toggle(SurvBtn, _SurvOn, "ESP SURVIVAL") end)
KillBtn.MouseButton1Click:Connect(function() _KillOn = not _KillOn Toggle(KillBtn, _KillOn, "ESP KILLER") end)
GenBtn.MouseButton1Click:Connect(function() _GenOn = not _GenOn Toggle(GenBtn, _GenOn, "ESP GENERATOR") end)
BrightBtn.MouseButton1Click:Connect(function() _FullBright = not _FullBright Toggle(BrightBtn, _FullBright, "FULL BRIGHT") end)
FogBtn.MouseButton1Click:Connect(function() _NoFog = not _NoFog Toggle(FogBtn, _NoFog, "NO FOG / MIST") end)
SkillBtn.MouseButton1Click:Connect(function() _AntiExplode = not _AntiExplode Toggle(SkillBtn, _AntiExplode, "ANTI-EXPLODE GEN") end)

OpenButton.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)
local Exit = Instance.new("TextButton", MainFrame); Exit.Size = UDim2.new(0, 25, 0, 25); Exit.Position = UDim2.new(1, -30, 0, 5); Exit.Text = "X"; Exit.BackgroundColor3 = Color3.fromRGB(200, 50, 50); Exit.TextColor3 = Color3.new(1, 1, 1); Instance.new("UICorner", Exit).CornerRadius = UDim.new(1, 0); Exit.MouseButton1Click:Connect(function() MainFrame.Visible = false end)