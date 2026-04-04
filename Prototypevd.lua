-- [[ BoDcChii Project - v4.1: Minimalist BD 🎸 ]] --
-- Update: New Category [ SMOOTH MAPS ] + Core Locked

local CoreGui = game:GetService("CoreGui")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")

-- --- 0. NOTIFIKASI WELCOME (Seragam dengan Style UI) ---
local function ShowWelcome()
    local WelcomeGui = Instance.new("ScreenGui", CoreGui)
    WelcomeGui.Name = "BoDcChii_Welcome"
    WelcomeGui.DisplayOrder = 999
    
    local WelcomeFrame = Instance.new("Frame", WelcomeGui)
    WelcomeFrame.Size = UDim2.new(0, 220, 0, 40)
    WelcomeFrame.Position = UDim2.new(0, 20, 0, 20)
    WelcomeFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    WelcomeFrame.BorderSizePixel = 0
    
    Instance.new("UICorner", WelcomeFrame).CornerRadius = UDim.new(0, 8)
    local Stroke = Instance.new("UIStroke", WelcomeFrame)
    Stroke.Color = Color3.fromRGB(255, 105, 180)
    Stroke.Thickness = 2
    
    local WelcomeLabel = Instance.new("TextLabel", WelcomeFrame)
    WelcomeLabel.Size = UDim2.new(1, 0, 1, 0)
    WelcomeLabel.BackgroundTransparency = 1
    WelcomeLabel.Text = "Welcome To BoDcChii"
    WelcomeLabel.TextColor3 = Color3.new(1, 1, 1)
    WelcomeLabel.TextSize = 16
    WelcomeLabel.Font = Enum.Font.SourceSansBold
    
    task.delay(1.5, function()
        WelcomeGui:Destroy()
    end)
end

ShowWelcome()

-- Bersihkan versi sebelumnya
if CoreGui:FindFirstChild("BoDcChii_Minimalist") then
    CoreGui.BoDcChii_Minimalist:Destroy()
end

local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "BoDcChii_Minimalist"
ScreenGui.ResetOnSpawn = false

-- --- FUNGSI DRAG ---
local function EnableDrag(gui)
    local dragging, dragInput, dragStart, startPos
    gui.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true; dragStart = input.Position; startPos = gui.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)
    gui.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    UIS.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            gui.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

-- --- 1. ICON "BD" ---
local OpenButton = Instance.new("TextButton", ScreenGui)
OpenButton.Size = UDim2.new(0, 50, 0, 50)
OpenButton.Position = UDim2.new(0, 20, 0.5, -25)
OpenButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
OpenButton.Text = "BD" 
OpenButton.TextColor3 = Color3.fromRGB(255, 105, 180)
OpenButton.TextSize = 24
OpenButton.Font = Enum.Font.SourceSansBold
OpenButton.ZIndex = 500
Instance.new("UICorner", OpenButton).CornerRadius = UDim.new(0, 12)
Instance.new("UIStroke", OpenButton).Color = Color3.fromRGB(255, 105, 180)
EnableDrag(OpenButton)

-- --- 2. MAIN FRAME ---
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 240, 0, 340) -- Ukuran ditambah sedikit untuk kategori baru
MainFrame.Position = UDim2.new(0.5, -120, 0.4, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.Visible = false
MainFrame.Active = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)
local Stroke = Instance.new("UIStroke", MainFrame)
Stroke.Color = Color3.fromRGB(255, 105, 180)
EnableDrag(MainFrame)

local Header = Instance.new("TextLabel", MainFrame)
Header.Size = UDim2.new(1, 0, 0, 40)
Header.Text = "BoDcChii Project"
Header.TextColor3 = Color3.fromRGB(255, 105, 180)
Header.BackgroundTransparency = 1
Header.Font = Enum.Font.SourceSansBold
Header.TextSize = 18

-- --- FUNGSI CREATE BUTTON ---
local function CreateBtn(parent, pos, text)
    local btn = Instance.new("TextButton", parent)
    btn.Size = UDim2.new(1, 0, 0, 35)
    btn.Position = pos
    btn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    btn.Text = text .. ": OFF"
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.SourceSansBold
    Instance.new("UICorner", btn)
    local s = Instance.new("UIStroke", btn)
    s.Color = Color3.fromRGB(200, 50, 50)
    return btn
end

-- --- 3. TABEL 1: [ PLAYER & OBJECTIVE ] ---
local Category1Btn = Instance.new("TextButton", MainFrame)
Category1Btn.Size = UDim2.new(0.9, 0, 0, 35)
Category1Btn.Position = UDim2.new(0.05, 0, 0, 45)
Category1Btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Category1Btn.Text = "[ PLAYER & OBJECTIVE ]  +"
Category1Btn.TextColor3 = Color3.new(1, 1, 1)
Category1Btn.Font = Enum.Font.SourceSansBold
Category1Btn.TextSize = 14
Instance.new("UICorner", Category1Btn)

local Feature1Frame = Instance.new("Frame", MainFrame)
Feature1Frame.Size = UDim2.new(0.9, 0, 0, 130)
Feature1Frame.Position = UDim2.new(0.05, 0, 0, 85)
Feature1Frame.BackgroundTransparency = 1
Feature1Frame.Visible = false 

-- Isi Fitur ESP (Tetap Sama)
local _SurvOn, _KillOn, _GenOn = false, false, false
local SurvBtn = CreateBtn(Feature1Frame, UDim2.new(0, 0, 0, 5), "ESP SURVIVAL")
local KillBtn = CreateBtn(Feature1Frame, UDim2.new(0, 0, 0, 45), "ESP KILLER")
local GenBtn = CreateBtn(Feature1Frame, UDim2.new(0, 0, 0, 85), "ESP GENERATOR")

-- --- 4. TABEL 2: [ SMOOTH MAPS ] (KATEGORI BARU) ---
local Category2Btn = Instance.new("TextButton", MainFrame)
Category2Btn.Size = UDim2.new(0.9, 0, 0, 35)
Category2Btn.Position = UDim2.new(0.05, 0, 0, 85) -- Posisi default saat Cat 1 tertutup
Category2Btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Category2Btn.Text = "[ SMOOTH MAPS ]  +"
Category2Btn.TextColor3 = Color3.new(1, 1, 1)
Category2Btn.Font = Enum.Font.SourceSansBold
Category2Btn.TextSize = 14
Instance.new("UICorner", Category2Btn)

local Feature2Frame = Instance.new("Frame", MainFrame)
Feature2Frame.Size = UDim2.new(0.9, 0, 0, 90)
Feature2Frame.Position = UDim2.new(0.05, 0, 0, 125)
Feature2Frame.BackgroundTransparency = 1
Feature2Frame.Visible = false

-- Isi Fitur Smooth Maps
local _FullBright, _NoFog = false, false
local BrightBtn = CreateBtn(Feature2Frame, UDim2.new(0, 0, 0, 5), "FULL BRIGHT")
local FogBtn = CreateBtn(Feature2Frame, UDim2.new(0, 0, 0, 45), "NO FOG / MIST")

-- --- 5. LOGIKA DROPDOWN (AUTO ADJUST) ---
local is1Open, is2Open = false, false

local function UpdateMenu()
    if is1Open then
        Category1Btn.Text = "[ PLAYER & OBJECTIVE ]  -"
        Feature1Frame.Visible = true
        Category2Btn.Position = UDim2.new(0.05, 0, 0, 220) -- Geser ke bawah
        Feature2Frame.Position = UDim2.new(0.05, 0, 0, 260)
    else
        Category1Btn.Text = "[ PLAYER & OBJECTIVE ]  +"
        Feature1Frame.Visible = false
        Category2Btn.Position = UDim2.new(0.05, 0, 0, 85) -- Kembali ke atas
        Feature2Frame.Position = UDim2.new(0.05, 0, 0, 125)
    end
    
    if is2Open then
        Category2Btn.Text = "[ SMOOTH MAPS ]  -"
        Feature2Frame.Visible = true
    else
        Category2Btn.Text = "[ SMOOTH MAPS ]  +"
        Feature2Frame.Visible = false
    end
end

Category1Btn.MouseButton1Click:Connect(function() is1Open = not is1Open UpdateMenu() end)
Category2Btn.MouseButton1Click:Connect(function() is2Open = not is2Open UpdateMenu() end)

-- --- 6. LOGIKA FITUR (CORE) ---
-- ESP Logic (Locked)
local function IsKiller(p)
    local char = p.Character
    if not char then return false end
    if p.Team and (p.Team.Name:lower():find("killer") or p.Team.Name:lower():find("murder")) then return true end
    local hum = char:FindFirstChild("Humanoid")
    return hum and hum.MaxHealth > 100
end

RunService.RenderStepped:Connect(function()
    -- ESP Players
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= Players.LocalPlayer and p.Character then
            local hl = p.Character:FindFirstChild("BDEsp") or Instance.new("Highlight", p.Character)
            hl.Name = "BDEsp"
            if IsKiller(p) then
                hl.FillColor = Color3.fromRGB(255, 0, 0); hl.Enabled = _KillOn
            else
                hl.FillColor = Color3.fromRGB(0, 255, 0); hl.Enabled = _SurvOn
            end
        end
    end
    -- ESP Objective
    for _, obj in pairs(game.Workspace:GetDescendants()) do
        if obj.Name == "Generator" or obj.Name == "Gen" then
            local hl = obj:FindFirstChild("GenEsp") or Instance.new("Highlight", obj)
            hl.Name = "GenEsp"
            hl.FillColor = Color3.fromRGB(255, 255, 0); hl.Enabled = _GenOn
        end
    end
    -- Smooth Maps Logic
    if _FullBright then
        Lighting.Ambient = Color3.new(1, 1, 1)
        Lighting.OutdoorAmbient = Color3.new(1, 1, 1)
        Lighting.ClockTime = 12
    end
    if _NoFog then
        Lighting.FogEnd = 999999
        Lighting.FogStart = 999999
    end
end)

-- --- 7. INTERAKSI TOMBOL ---
local function Toggle(btn, state, txt)
    btn.Text = txt .. (state and ": ON" or ": OFF")
    btn.UIStroke.Color = state and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(200, 50, 50)
end

SurvBtn.MouseButton1Click:Connect(function() _SurvOn = not _SurvOn Toggle(SurvBtn, _SurvOn, "ESP SURVIVAL") end)
KillBtn.MouseButton1Click:Connect(function() _KillOn = not _KillOn Toggle(KillBtn, _KillOn, "ESP KILLER") end)
GenBtn.MouseButton1Click:Connect(function() _GenOn = not _GenOn Toggle(GenBtn, _GenOn, "ESP GENERATOR") end)

BrightBtn.MouseButton1Click:Connect(function() _FullBright = not _FullBright Toggle(BrightBtn, _FullBright, "FULL BRIGHT") end)
FogBtn.MouseButton1Click:Connect(function() _NoFog = not _NoFog Toggle(FogBtn, _NoFog, "NO FOG / MIST") end)

-- Tombol Utama
OpenButton.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)
local Exit = Instance.new("TextButton", MainFrame)
Exit.Size = UDim2.new(0, 25, 0, 25); Exit.Position = UDim2.new(1, -30, 0, 7); Exit.Text = "X"
Exit.BackgroundColor3 = Color3.fromRGB(200, 50, 50); Exit.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", Exit).CornerRadius = UDim.new(1, 0)
Exit.MouseButton1Click:Connect(function() MainFrame.Visible = false end)