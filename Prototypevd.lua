-- [[ BoDcChii Project - v5.0.0: THE SIDE-TAB EVOLUTION 🎸 ]] --
-- Status: Rectangle UI + Right Sidebar (1, 2, 3) + Locked Features

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
    task.delay(2, function() WelcomeGui:Destroy() end)
end
pcall(ShowWelcome)

local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "BoDcChii_Minimalist"; ScreenGui.ResetOnSpawn = false

local function EnableDrag(gui)
    local dragging, dragStart, startPos
    gui.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
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

-- --- 2. ICON "BD" ---
local OpenButton = Instance.new("TextButton", ScreenGui)
OpenButton.Size = UDim2.new(0, 50, 0, 50); OpenButton.Position = UDim2.new(0, 20, 0.5, -25)
OpenButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30); OpenButton.Text = "BD" 
OpenButton.TextColor3 = Color3.fromRGB(255, 105, 180); OpenButton.TextSize = 24
OpenButton.Font = Enum.Font.SourceSansBold; OpenButton.ZIndex = 500
Instance.new("UICorner", OpenButton).CornerRadius = UDim.new(0, 12)
Instance.new("UIStroke", OpenButton).Color = Color3.fromRGB(255, 105, 180)
EnableDrag(OpenButton)

-- --- 3. MAIN FRAME (RECTANGLE) ---
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 380, 0, 240); MainFrame.Position = UDim2.new(0.5, -190, 0.4, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15); MainFrame.Visible = false; MainFrame.Active = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)
Instance.new("UIStroke", MainFrame).Color = Color3.fromRGB(255, 105, 180)
EnableDrag(MainFrame)

-- HEADER & LINE
local Header = Instance.new("TextLabel", MainFrame)
Header.Size = UDim2.new(1, 0, 0, 35); Header.Text = "BoDcChii Project"; Header.TextColor3 = Color3.fromRGB(255, 105, 180)
Header.BackgroundTransparency = 1; Header.Font = Enum.Font.SourceSansBold; Header.TextSize = 18

local LineH = Instance.new("Frame", MainFrame)
LineH.Size = UDim2.new(0.95, 0, 0, 2); LineH.Position = UDim2.new(0.025, 0, 0, 36)
LineH.BackgroundColor3 = Color3.fromRGB(255, 105, 180); LineH.BorderSizePixel = 0
Instance.new("UICorner", LineH)

-- SIDEBAR RIGHT (ANGKA 1, 2, 3)
local Sidebar = Instance.new("Frame", MainFrame)
Sidebar.Size = UDim2.new(0, 60, 1, -45); Sidebar.Position = UDim2.new(1, -65, 0, 42)
Sidebar.BackgroundTransparency = 1
local SidebarList = Instance.new("UIListLayout", Sidebar)
SidebarList.Padding = UDim.new(0, 8); SidebarList.HorizontalAlignment = Enum.HorizontalAlignment.Center

-- VERTICAL SEPARATOR LINE
local LineV = Instance.new("Frame", MainFrame)
LineV.Size = UDim2.new(0, 2, 1, -50); LineV.Position = UDim2.new(1, -70, 0, 42)
LineV.BackgroundColor3 = Color3.fromRGB(255, 105, 180); LineV.BorderSizePixel = 0

-- CONTENT AREA (LEFT)
local ContentArea = Instance.new("Frame", MainFrame)
ContentArea.Size = UDim2.new(1, -85, 1, -50); ContentArea.Position = UDim2.new(0, 10, 0, 45)
ContentArea.BackgroundTransparency = 1

local function CreateTabBtn(num)
    local btn = Instance.new("TextButton", Sidebar)
    btn.Size = UDim2.new(0, 45, 0, 45); btn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    btn.Text = tostring(num); btn.TextColor3 = Color3.new(1, 1, 1); btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 20; Instance.new("UICorner", btn)
    local s = Instance.new("UIStroke", btn); s.Color = Color3.fromRGB(255, 105, 180); s.Thickness = 1
    return btn
end

local Tab1Btn = CreateTabBtn(1)
local Tab2Btn = CreateTabBtn(2)
local Tab3Btn = CreateTabBtn(3)

-- PAGES
local function CreatePage()
    local sc = Instance.new("ScrollingFrame", ContentArea)
    sc.Size = UDim2.new(1, 0, 1, 0); sc.BackgroundTransparency = 1; sc.Visible = false
    sc.ScrollBarThickness = 2; sc.ScrollBarImageColor3 = Color3.fromRGB(255, 105, 180)
    local l = Instance.new("UIListLayout", sc); l.Padding = UDim.new(0, 5); l.HorizontalAlignment = Enum.HorizontalAlignment.Center
    return sc
end

local Page1 = CreatePage() -- ESP
local Page2 = CreatePage() -- SKILLS
local Page3 = CreatePage() -- MAPS

local function ShowPage(page, btn)
    Page1.Visible = false; Page2.Visible = false; Page3.Visible = false
    Tab1Btn.UIStroke.Thickness = 1; Tab2Btn.UIStroke.Thickness = 1; Tab3Btn.UIStroke.Thickness = 1
    page.Visible = true; btn.UIStroke.Thickness = 3
end

Tab1Btn.MouseButton1Click:Connect(function() ShowPage(Page1, Tab1Btn) end)
Tab2Btn.MouseButton1Click:Connect(function() ShowPage(Page2, Tab2Btn) end)
Tab3Btn.MouseButton1Click:Connect(function() ShowPage(Page3, Tab3Btn) end)
ShowPage(Page1, Tab1Btn) -- Default view

-- --- 4. BUTTON GENERATOR (LOGIC REUSE) ---
local function CreateBtn(parent, text)
    local btn = Instance.new("TextButton", parent); btn.Size = UDim2.new(0.95, 0, 0, 40)
    btn.BackgroundColor3 = Color3.fromRGB(25, 25, 25); btn.Text = text .. ": OFF"; btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.SourceSansBold; btn.TextSize = 10; Instance.new("UICorner", btn)
    local s = Instance.new("UIStroke", btn); s.Color = Color3.fromRGB(200, 50, 50)
    return btn
end

-- Tab 1: PLAYER ESP
local _SurvOn, _KillOn = false, false
local SurvBtn = CreateBtn(Page1, "ESP SURVIVAL")
local KillBtn = CreateBtn(Page1, "ESP KILLER")

-- Tab 2: SURVIVAL SKILLS
local _GenOn, _NoSkillGen = false, false
local GenBtn = CreateBtn(Page2, "ESP GENERATOR")
local SkillBtn = CreateBtn(Page2, "NO SKILL CHECK GENERATOR")

-- Tab 3: SMOOTH MAPS
local _FullBright, _NoFog, _PotatoMode = false, false, false
local BrightBtn = CreateBtn(Page3, "FULL BRIGHT")
local FogBtn = CreateBtn(Page3, "NO FOG / MIST")
local PotatoBtn = CreateBtn(Page3, "POTATO MODE (ANTI LAG)")

local PotatoDesc = Instance.new("TextLabel", Page3)
PotatoDesc.Size = UDim2.new(0.9, 0, 0, 30); PotatoDesc.BackgroundTransparency = 1
PotatoDesc.Text = "*Reload fitur ini setiap pindah map"; PotatoDesc.TextColor3 = Color3.fromRGB(200, 200, 200)
PotatoDesc.TextSize = 8; PotatoDesc.Font = Enum.Font.SourceSansItalic; PotatoDesc.TextWrapped = true

-- --- 5. LOGIKA FITUR (LOCKED & STABLE) ---
local function Toggle(btn, state, txt)
    btn.Text = txt .. (state and ": ON" or ": OFF")
    btn.UIStroke.Color = state and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(200, 50, 50)
end

SurvBtn.MouseButton1Click:Connect(function() _SurvOn = not _SurvOn Toggle(SurvBtn, _SurvOn, "ESP SURVIVAL") end)
KillBtn.MouseButton1Click:Connect(function() _KillOn = not _KillOn Toggle(KillBtn, _KillOn, "ESP KILLER") end)
GenBtn.MouseButton1Click:Connect(function() _GenOn = not _GenOn Toggle(GenBtn, _GenOn, "ESP GENERATOR") end)
SkillBtn.MouseButton1Click:Connect(function() _NoSkillGen = not _NoSkillGen Toggle(SkillBtn, _NoSkillGen, "NO SKILL CHECK GENERATOR") end)
BrightBtn.MouseButton1Click:Connect(function() _FullBright = not _FullBright Toggle(BrightBtn, _FullBright, "FULL BRIGHT") end)
FogBtn.MouseButton1Click:Connect(function() _NoFog = not _NoFog Toggle(FogBtn, _NoFog, "NO FOG / MIST") end)

PotatoBtn.MouseButton1Click:Connect(function() 
    _PotatoMode = not _PotatoMode 
    Toggle(PotatoBtn, _PotatoMode, "POTATO MODE (ANTI LAG)")
    if _PotatoMode then
        for _, v in pairs(game.Workspace:GetDescendants()) do
            local isP = v:FindFirstAncestorOfClass("Model") and Players:GetPlayerFromCharacter(v:FindFirstAncestorOfClass("Model"))
            local isI = v.Name:find("Gen") or v.Name:find("Generator") or v.Name:find