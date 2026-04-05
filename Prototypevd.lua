-- [[ BoDcChii Project - v5.0.7: REAL LEFT SIDEBAR FIX 🎸 ]] --

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

-- SIDEBAR (FIXED TO LEFT)
local Sidebar = Instance.new("Frame", MainFrame)
Sidebar.Size = UDim2.new(0, 110, 1, -45); Sidebar.Position = UDim2.new(0, 10, 0, 42); Sidebar.BackgroundTransparency = 1
Instance.new("UIListLayout", Sidebar).Padding = UDim.new(0, 5)

-- VERTICAL SEPARATOR (LEFT SIDE)
local LineV = Instance.new("Frame", MainFrame)
LineV.Size = UDim2.new(0, 2, 1, -50); LineV.Position = UDim2.new(0, 125, 0, 42)
LineV.BackgroundColor3 = Color3.fromRGB(255, 105, 180); LineV.BorderSizePixel = 0

-- CONTENT AREA (RIGHT SIDE)
local ContentArea = Instance.new("Frame", MainFrame)
ContentArea.Size = UDim2.new(1, -145, 1, -50); ContentArea.Position = UDim2.new(0, 135, 0, 45); ContentArea.BackgroundTransparency = 1

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
    P1.Visible = false; P2.Visible = false; P3.Visible =