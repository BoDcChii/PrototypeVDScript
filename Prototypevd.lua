-- [[ BoDcChii Project - v5.0.6: LEFT SIDEBAR EDITION 🎸 ]] --

local CoreGui = game:GetService("CoreGui")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")

if CoreGui:FindFirstChild("BoDcChii_Minimalist") then CoreGui.BoDcChii_Minimalist:Destroy() end

local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "BoDcChii_Minimalist"

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

local OpenButton = Instance.new("TextButton", ScreenGui)
OpenButton.Size = UDim2.new(0, 50, 0, 50); OpenButton.Position = UDim2.new(0, 20, 0.5, -25)
OpenButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30); OpenButton.Text = "BD"; OpenButton.TextColor3 = Color3.fromRGB(255, 105, 180)
OpenButton.TextSize = 24; OpenButton.Font = Enum.Font.SourceSansBold
Instance.new("UICorner", OpenButton).CornerRadius = UDim.new(0, 12)
Instance.new("UIStroke", OpenButton).Color = Color3.fromRGB(255, 105, 180)
EnableDrag(OpenButton)

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 380, 0, 220); MainFrame.Position = UDim2.new(0.5, -190, 0.4, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15); MainFrame.Visible = false; MainFrame.Active = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)
Instance.new("UIStroke", MainFrame).Color = Color3.fromRGB(255, 105, 180)
EnableDrag(MainFrame)

local Header = Instance.new("TextLabel", MainFrame)
Header.Size = UDim2.new(1, 0, 0, 35); Header.Text = "BoDcChii Project"; Header.TextColor3 = Color3.fromRGB(255, 105, 180)
Header.BackgroundTransparency = 1; Header.Font = Enum.Font.SourceSansBold; Header.TextSize = 18

local LineH = Instance.new("Frame", MainFrame)
LineH.Size = UDim2.new(0.95, 0, 0, 2); LineH.Position = UDim2.new(0.025, 0, 0, 36); LineH.BackgroundColor3 = Color3.fromRGB(255, 105, 180); LineH.BorderSizePixel = 0

-- SIDEBAR LEFT (SEKARANG DI KIRI)
local Sidebar = Instance.new("Frame", MainFrame)
Sidebar.Size = UDim2.new(0, 110, 1, -45); Sidebar.Position = UDim2.new(0, 5, 0, 42); Sidebar.BackgroundTransparency = 1
Instance.new("UIListLayout", Sidebar).Padding = UDim.new(0, 5)

-- VERTICAL SEPARATOR
local LineV = Instance.new("Frame", MainFrame)
LineV.Size = UDim2.new(0, 2, 1, -50); LineV.Position = UDim2.new(0, 120, 0, 42)
LineV.BackgroundColor3 = Color3.fromRGB(255, 105, 180); LineV.BorderSizePixel = 0

-- CONTENT AREA (SEKARANG DI KANAN)
local ContentArea = Instance.new("Frame", MainFrame)
ContentArea.Size = UDim2.new(1, -135, 1, -50); ContentArea.Position = UDim2.new(0, 130, 0, 45); ContentArea.BackgroundTransparency = 1

local function CreateTabBtn(text)
    local btn = Instance.new("TextButton", Sidebar); btn.Size = UDim2.new(1, 0, 0, 35); btn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    btn.Text = text; btn.TextColor3 = Color3.new(1, 1, 1); btn.Font = Enum.Font.SourceSansBold; btn.TextSize = 10
    Instance.new("UICorner", btn); Instance.new("UIStroke", btn).Color = Color3.fromRGB(255, 105, 180)
    return btn
end

local T1, T2, T3 = CreateTabBtn("1. PLAYER"), CreateTabBtn("2. SURVIVAL"), CreateTabBtn("3. SMOOTH MAPS")

local function CreatePage()
    local f = Instance.new("Frame", ContentArea); f.Size = UDim2.new(1, 0, 1, 0); f.BackgroundTransparency = 1; f.Visible = false
    Instance.new("UIListLayout", f).Padding = UDim.new(0, 5)
    return f
end

local P1, P2, P3 = CreatePage(), CreatePage(), CreatePage()

local function Show(p, b)
    P1.Visible = false; P2.Visible = false; P3.Visible = false
    T1.BackgroundColor3 = Color3.fromRGB(25, 25, 25); T2.BackgroundColor3 = Color3.fromRGB(25, 25, 25); T3.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    p.Visible = true; b.BackgroundColor3 = Color3.fromRGB(255, 105, 180)
end

T1.MouseButton1Click:Connect(function() Show(P1, T1) end); T2.MouseButton1Click:Connect(function() Show(P2, T2) end); T3.MouseButton1Click:Connect(function() Show(P3, T3) end)
Show(P1, T1)

local function CreateBtn(parent, text)
    local btn = Instance.new("TextButton", parent); btn.Size = UDim2.new(1, 0, 0, 35); btn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    btn.Text = text .. ": OFF"; btn.TextColor3 = Color3.new(1, 1, 1); btn.Font = Enum.Font.SourceSansBold; btn.TextSize = 9
    Instance.new("UICorner", btn); local s = Instance.new("UIStroke", btn); s.Color = Color3.fromRGB(200, 50, 50)
    return btn
end

-- LOGIC & BUTTONS (LOCKED)
local _SurvOn, _KillOn, _GenOn, _NoSkillGen, _FullBright, _NoFog, _PotatoMode = false, false, false, false, false, false, false
local Btn1 = CreateBtn(P1, "ESP SURVIVAL"); local Btn2 = CreateBtn(P1, "ESP KILLER")
local Btn3 = CreateBtn(P2, "ESP GENERATOR"); local Btn4 = CreateBtn(P2, "NO SKILL CHECK")
local Btn5 = CreateBtn(P3, "FULL BRIGHT"); local Btn6 = CreateBtn(P3, "NO FOG"); local Btn7 = CreateBtn(P3, "POTATO MODE")

local function Toggle(