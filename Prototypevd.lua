-- [[ BoDcChii Project - v4.4: Stabilized Edition 🎸 ]] --
-- Fix: GUI Not Showing + Optimized for Low-End PC/Mobile

local CoreGui = game:GetService("CoreGui")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")

-- --- 0. ANTI-REDUNDANT ---
if CoreGui:FindFirstChild("BoDcChii_Minimalist") then CoreGui.BoDcChii_Minimalist:Destroy() end
if CoreGui:FindFirstChild("BoDcChii_Welcome") then CoreGui.BoDcChii_Welcome:Destroy() end

-- --- 1. NOTIFIKASI WELCOME (Dibuat lebih simpel agar pasti muncul) ---
local function ShowWelcome()
    local WelcomeGui = Instance.new("ScreenGui", CoreGui)
    WelcomeGui.Name = "BoDcChii_Welcome"
    local WelcomeFrame = Instance.new("Frame", WelcomeGui)
    WelcomeFrame.Size = UDim2.new(0, 220, 0, 40)
    WelcomeFrame.Position = UDim2.new(0, 20, 0, 20)
    WelcomeFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    Instance.new("UICorner", WelcomeFrame)
    local WelcomeLabel = Instance.new("TextLabel", WelcomeFrame)
    WelcomeLabel.Size = UDim2.new(1, 0, 1, 0); WelcomeLabel.BackgroundTransparency = 1
    WelcomeLabel.Text = "BoDcChii v4.4 Loaded!"; WelcomeLabel.TextColor3 = Color3.new(1, 1, 1)
    WelcomeLabel.TextSize = 14; WelcomeLabel.Font = Enum.Font.GothamBold
    task.delay(2, function() WelcomeGui:Destroy() end)
end
pcall(ShowWelcome)

-- --- 2. MAIN GUI SETUP ---
local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "BoDcChii_Minimalist"
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Tombol Open/Close (BD)
local OpenButton = Instance.new("TextButton", ScreenGui)
OpenButton.Size = UDim2.new(0, 50, 0, 50); OpenButton.Position = UDim2.new(0, 20, 0.5, -25)
OpenButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30); OpenButton.Text = "BD" 
OpenButton.TextColor3 = Color3.fromRGB(255, 105, 180); OpenButton.TextSize = 22
OpenButton.Font = Enum.Font.GothamBold
Instance.new("UICorner", OpenButton).CornerRadius = UDim.new(0, 12)
local Stroke = Instance.new("UIStroke", OpenButton); Stroke.Color = Color3.fromRGB(255, 105, 180); Stroke.Thickness = 2

-- Frame Utama
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 240, 0, 220); MainFrame.Position = UDim2.new(0.5, -120, 0.4, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15); MainFrame.Visible = false
Instance.new("UICorner", MainFrame)
local MStroke = Instance.new("UIStroke", MainFrame); MStroke.Color = Color3.fromRGB(255, 105, 180)

-- Judul
local Header = Instance.new("TextLabel", MainFrame)
Header.Size = UDim2.new(1, 0, 0, 35); Header.Text = "BoDcChii Project"; Header.TextColor3 = Color3.fromRGB(255, 105, 180)
Header.BackgroundTransparency = 1; Header.Font = Enum.Font.GothamBold; Header.TextSize = 16

-- Scrolling Content
local Scroll = Instance.new("ScrollingFrame", MainFrame)
Scroll.Size = UDim2.new(1, -10, 1, -45); Scroll.Position = UDim2.new(0, 5, 0, 40)
Scroll.BackgroundTransparency = 1; Scroll.CanvasSize = UDim2.new(0, 0, 1.5, 0); Scroll.ScrollBarThickness = 2
local UIList = Instance.new("UIListLayout", Scroll); UIList.Padding = UDim.new(0, 5); UIList.HorizontalAlignment = "Center"

-- --- 3. FUNGSI DRAG ---
local function EnableDrag(gui)
    local dragging, dragInput, dragStart, startPos
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
    UIS.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then dragging = false end
    end)
end
EnableDrag(OpenButton)
EnableDrag(MainFrame)

-- --- 4. INTERFACE HELPERS ---
local function CreateToggle(name)
    local btn = Instance.new("TextButton", Scroll)
    btn.Size = UDim2.new(0.9, 0, 0, 35); btn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    btn.Text = name .. ": OFF"; btn.TextColor3 = Color3.new(1, 1, 1); btn.Font = Enum.Font.GothamBold; btn.TextSize = 12
    Instance.new("UICorner", btn)
    local s = Instance.new("UIStroke", btn); s.Color = Color3.fromRGB(200, 50, 50); s.Thickness = 1
    return btn
end

local _SurvOn, _KillOn, _GenOn, _NoSkill, _FullB = false, false, false, false, false

local btnSurv = CreateToggle("ESP SURVIVAL")
local btnKill = CreateToggle("ESP KILLER")
local btnGen = CreateToggle("ESP GENERATOR")
local btnSkill = CreateToggle("NO SKILL CHECK GENERATOR")
local btnBright = CreateToggle("FULL BRIGHT")

-- --- 5. CORE LOGIC ---
local function UpdateToggle(btn, state, text)
    btn.Text = text .. (state and ": ON" or ": OFF")
    btn.UIStroke.Color = state and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(200, 50, 50)
end

btnSurv.MouseButton1Click:Connect(function() _SurvOn = not _SurvOn UpdateToggle(btnSurv, _SurvOn, "ESP SURVIVAL") end)
btnKill.MouseButton1Click:Connect(function() _KillOn = not _KillOn UpdateToggle(btnKill, _KillOn, "ESP KILLER") end)
btnGen.MouseButton1Click:Connect(function() _GenOn = not _GenOn UpdateToggle(btnGen, _GenOn, "ESP GENERATOR") end)
btnSkill.MouseButton1Click:Connect(function() _NoSkill = not _NoSkill UpdateToggle(btnSkill, _NoSkill, "NO SKILL CHECK GENERATOR") end)
btnBright.MouseButton1Click:Connect(function() _FullB = not _FullB UpdateToggle(btnBright, _FullB, "FULL BRIGHT") end)

OpenButton.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)

-- Loop Fitur (Optimized)
RunService.Heartbeat:Connect(function()
    if _FullB then Lighting.Ambient = Color3.new(1, 1, 1); Lighting.ClockTime = 12 end
    
    -- ESP Logic
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= Players.LocalPlayer and p.Character then
            local hl = p.Character:FindFirstChild("BDEsp") or Instance.new("Highlight", p.Character)
            hl.Name = "BDEsp"
            local isK = (p.Team and p.Team.Name:lower():find("kill")) or (p.Character:FindFirstChild("Humanoid") and p.Character.Humanoid.MaxHealth > 100)
            hl.Enabled = (isK and _KillOn) or (not isK and _SurvOn)
            hl.FillColor = isK and Color3.new(1, 0, 0) or Color3.new(0, 1, 0)
        end
    end
    
    if _GenOn then
        for _, v in pairs(game.Workspace:GetChildren()) do
            if v.Name:find("Gen") or v.Name:find("Generator") then
                local h = v:FindFirstChild("GenEsp") or Instance.new("Highlight", v)
                h.Name = "GenEsp"; h.FillColor = Color3.new(1, 1, 0); h.Enabled = true
            end
        end
    end
end)

-- Metatable Hook (Safeguarded)
local mt = getrawmetatable(game)
if mt then
    local old = mt.__namecall
    setreadonly(mt, false)
    mt.__namecall = newcclosure(function(self, ...)
        local method = getnamecallmethod()
        if _NoSkill and (method == "FireServer" or method == "InvokeServer") then
            local name = tostring(self):lower()
            if name:find("fail") or name:find("skillcheck") then return end
        end
        return old(self, ...)
    end)
    setreadonly(mt, true)
end