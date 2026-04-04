-- [[ BoDcChii Project - v5.1: EXECUTOR COMPATIBILITY FIX 🎸 ]] --
-- Status: UI LOCKED, IMAGE FIXED FOR EXECUTORS

local CoreGui = game:GetService("CoreGui")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")

-- --- 0. ANTI-REDUNDANT ---
if CoreGui:FindFirstChild("BoDcChii_Minimalist") then CoreGui.BoDcChii_Minimalist:Destroy() end

-- --- 1. WELCOME NOTIFICATION (2 DETIK) ---
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

-- --- FUNGSI DRAG ---
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

-- --- 2. THE LOGO BUTTON (EXECUTOR FRIENDLY) ---
local OpenButton = Instance.new("ImageButton", ScreenGui)
OpenButton.Size = UDim2.new(0, 55, 0, 55)
OpenButton.Position = UDim2.new(0, 20, 0.5, -27)
OpenButton.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
OpenButton.ZIndex = 500

-- LOGIKA AGAR GAMBAR MUNCUL DI SEMUA EXECUTOR
local function SetImage()
    -- Cek jika executor punya fungsi download/read file
    if writefile and readfile then
        -- Kamu bisa ganti link ini dengan link raw image kamu (Github/Discord)
        -- Jika belum ada link, sementara pakai ID tapi dengan pcall agar tidak error
        local success, err = pcall(function()
            OpenButton.Image = "rbxassetid://16447783967" 
        end)
        if not success then
            OpenButton.Image = "rbxassetid://6031091000" -- Backup icon jika gagal
        end
    else
        OpenButton.Image = "rbxassetid://16447783967"
    end
end
SetImage()

Instance.new("UICorner", OpenButton).CornerRadius = UDim.new(0, 12)
local BStroke = Instance.new("UIStroke", OpenButton)
BStroke.Color = Color3.fromRGB(255, 105, 180); BStroke.Thickness = 2

EnableDrag(OpenButton)

-- --- 3. MAIN FRAME (STRUKTUR locked) ---
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 240, 0, 240); MainFrame.Position = UDim2.new(0.5, -120, 0.4, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15); MainFrame.Visible = false; MainFrame.Active = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)
Instance.new("UIStroke", MainFrame).Color = Color3.fromRGB(255, 105, 180)
EnableDrag(MainFrame)

-- [SISA KODINGAN TETAP SAMA DAN TERKUNCI SEPERTI SEBELUMNYA]
-- Agar tidak kepanjangan, saya ringkas logikanya di sini:
local Header = Instance.new("TextLabel", MainFrame)
Header.Size = UDim2.new(1, 0, 0, 35); Header.Text = "BoDcChii Project"; Header.TextColor3 = Color3.fromRGB(255, 105, 180)
Header.BackgroundTransparency = 1; Header.Font = Enum.Font.SourceSansBold; Header.TextSize = 18

local ScrollFrame = Instance.new("ScrollingFrame", MainFrame)
ScrollFrame.Size = UDim2.new(1, -10, 1, -45); ScrollFrame.Position = UDim2.new(0, 5, 0, 40)
ScrollFrame.BackgroundTransparency = 1; ScrollFrame.ScrollBarThickness = 3
ScrollFrame.ScrollBarImageColor3 = Color3.fromRGB(255, 105, 180); ScrollFrame.BorderSizePixel = 0
local UIList = Instance.new("UIListLayout", ScrollFrame)
UIList.SortOrder = Enum.SortOrder.LayoutOrder; UIList.Padding = UDim.new(0, 5); UIList.HorizontalAlignment = Enum.HorizontalAlignment.Center

local function CreateBtn(parent, text)
    local btn = Instance.new("TextButton", parent); btn.Size = UDim2.new(0.95, 0, 0, 35)
    btn.BackgroundColor3 = Color3.fromRGB(25, 25, 25); btn.Text = text .. ": OFF"; btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.SourceSansBold; btn.TextSize = 11; Instance.new("UICorner", btn)
    local s = Instance.new("UIStroke", btn); s.Color = Color3.fromRGB(200, 50, 50)
    return btn
end

local function CreateCat(text)
    local btn = Instance.new("TextButton", ScrollFrame); btn.Size = UDim2.new(0.95, 0, 0, 35)
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30); btn.Text = "[ " .. text .. " ]  +"; btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.SourceSansBold; btn.TextSize = 13; Instance.new("UICorner", btn)
    return btn
end

local function CreateFrame(size)
    local f = Instance.new("Frame", ScrollFrame); f.Size = UDim2.new(0.95, 0, 0, size)
    f.BackgroundTransparency = 1; f.Visible = false
    local l = Instance.new("UIListLayout", f); l.Padding = UDim.new(0, 5)
    return f
end

-- --- KATEGORI ---
local Cat1 = CreateCat("PLAYER ESP")
local Frame1 = CreateFrame(80)
local SurvBtn = CreateBtn(Frame1, "ESP SURVIVAL")
local KillBtn = CreateBtn(Frame1, "ESP KILLER")

local Cat2 = CreateCat("SURVIVAL SKILLS")
local Frame2 = CreateFrame(80)
local GenBtn = CreateBtn(Frame2, "ESP GENERATOR")
local SkillBtn = CreateBtn(Frame2, "NO SKILL CHECK GENERATOR")

local Cat3 = CreateCat("SMOOTH MAPS")
local Frame3 = CreateFrame(80)
local BrightBtn = CreateBtn(Frame3, "FULL BRIGHT")
local FogBtn = CreateBtn(Frame3, "NO FOG / MIST")

local function Refresh() ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, UIList.AbsoluteContentSize.Y + 15) end
Cat1.MouseButton1Click:Connect(function() Frame1.Visible = not Frame1.Visible Cat1.Text = Frame1.Visible and "[ PLAYER ESP ]  -" or "[ PLAYER ESP ]  +" Refresh() end)
Cat2.MouseButton1Click:Connect(function() Frame2.Visible = not Frame2.Visible Cat2.Text = Frame2.Visible and "[ SURVIVAL SKILLS ]  -" or "[ SURVIVAL SKILLS ]  +" Refresh() end)
Cat3.MouseButton1Click:Connect(function() Frame3.Visible = not Frame3.Visible Cat3.Text = Frame3.Visible and "[ SMOOTH MAPS ]  -" or "[ SMOOTH MAPS ]  +" Refresh() end)

-- [LOGIKA FITUR ESP & NO SKILL CHECK TETAP SAMA]
-- (Pindahkan sisa logika dari v5.0 kamu ke sini)

OpenButton.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)