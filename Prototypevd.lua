-- [[ BoDcChii Project - v0.4.9: COORDINATE PARRY (SCREEN SCAN METHOD) 🎸 ]] --

local CoreGui = game:GetService("CoreGui")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VIM = game:GetService("VirtualInputManager")
local CAS = game:GetService("ContextActionService")

-- --- 0. CLEANUP ---
if CoreGui:FindFirstChild("BoDcChii_Minimalist") then CoreGui.BoDcChii_Minimalist:Destroy() end

-- --- 1. UI SETUP (STABLE) ---
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
MainFrame.Size = UDim2.new(0, 300, 0, 180); MainFrame.Position = UDim2.new(0.5, -150, 0.3, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15); MainFrame.Visible = false; MainFrame.Active = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)
local MainStroke = Instance.new("UIStroke", MainFrame)
MainStroke.Color = Color3.fromRGB(255, 105, 180); MainStroke.Thickness = 2
EnableDrag(MainFrame)

task.spawn(function()
    while task.wait() do MainStroke.Color = Color3.fromHSV(tick() % 5 / 5, 0.6, 1) end
end)

-- --- 2. BUTTONS SETUP ---
local ContentScroll = Instance.new("ScrollingFrame", MainFrame)
ContentScroll.Size = UDim2.new(1, -20, 1, -40); ContentScroll.Position = UDim2.new(0, 10, 0, 35); ContentScroll.BackgroundTransparency = 1; ContentScroll.BorderSizePixel = 0; ContentScroll.ScrollBarThickness = 0
local List = Instance.new("UIListLayout", ContentScroll); List.Padding = UDim.new(0, 5)

local function CreateBtn(text)
    local btn = Instance.new("TextButton", ContentScroll); btn.Size = UDim2.new(1, 0, 0, 35); btn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    btn.Text = text .. ": OFF"; btn.TextColor3 = Color3.new(1, 1, 1); btn.Font = Enum.Font.SourceSansBold; btn.TextSize = 10
    Instance.new("UICorner", btn); local s = Instance.new("UIStroke", btn); s.Color = Color3.fromRGB(200, 50, 50)
    return btn
end

local function Toggle(btn, state, txt)
    btn.Text = txt .. (state and ": ON" or ": OFF")
    btn.UIStroke.Color = state and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(200, 50, 50)
end

local _SurvOn, _KillOn, _GenOn, _NoSkillGen, _FullBright, _NoFog, _PotatoMode, _AutoParry = false, false, false, false, false, false, false, false

local BtnAP = CreateBtn("AUTO PARRY (FIXED)"); local Btn1 = CreateBtn("ESP SURVIVAL"); local Btn2 = CreateBtn("ESP KILLER")
local Btn3 = CreateBtn("ESP GENERATOR"); local Btn4 = CreateBtn("NO SKILL CHECK"); local Btn5 = CreateBtn("FULL BRIGHT")
local Btn6 = CreateBtn("NO FOG"); local Btn7 = CreateBtn("POTATO MODE")

BtnAP.MouseButton1Click:Connect(function() _AutoParry = not _AutoParry Toggle(BtnAP, _AutoParry, "AUTO PARRY (FIXED)") end)
Btn1.MouseButton1Click:Connect(function() _SurvOn = not _SurvOn Toggle(Btn1, _SurvOn, "ESP SURVIVAL") end)
Btn2.MouseButton1Click:Connect(function() _KillOn = not _KillOn Toggle(Btn2, _KillOn, "ESP KILLER") end)
Btn3.MouseButton1Click:Connect(function() _GenOn = not _GenOn Toggle(Btn3, _GenOn, "ESP GENERATOR") end)
Btn4.MouseButton1Click:Connect(function() _NoSkillGen = not _NoSkillGen Toggle(Btn4, _NoSkillGen, "NO SKILL CHECK") end)
Btn5.MouseButton1Click:Connect(function() _FullBright = not _FullBright Toggle(Btn5, _FullBright, "FULL BRIGHT") end)
Btn6.MouseButton1Click:Connect(function() _NoFog = not _NoFog Toggle(Btn6, _NoFog, "NO FOG") end)
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

-- --- 4. CORE PARRY (COORDINATE & ACTION BYPASS) ---
local function PressParryButton()
    -- 1. Berdasarkan Foto: Tombol pedang ada di area kanan bawah.
    -- Kita ambil ukuran layar pemain secara real-time
    local ViewportSize = workspace.CurrentCamera.ViewportSize
    local TargetX = ViewportSize.X * 0.85 -- 85% ke kanan
    local TargetY = ViewportSize.Y * 0.70 -- 70% ke bawah
    
    -- Simulasi sentuhan tepat di atas tombol pedang
    VIM:SendMouseButtonEvent(TargetX, TargetY, 0, true, game, 0)
    task.wait(0.01)
    VIM:SendMouseButtonEvent(TargetX, TargetY, 0, false, game, 0)
    
    -- 2. Bypass via ContextAction (Back up plan)
    pcall(function()
        CAS:CallAction("Attack")
        CAS:CallAction("Parry")
        CAS:CallAction("Block")
    end)
end

task.spawn(function()
    while task.wait(0.01) do
        if _AutoParry then
            pcall(function()
                local char = Players.LocalPlayer.Character
                local root = char and char:FindFirstChild("HumanoidRootPart")
                if root then
                    for _, enemy in pairs(Players:GetPlayers()) do
                        if enemy ~= Players.LocalPlayer and enemy.Character and enemy.Character:FindFirstChild("HumanoidRootPart") then
                            local eRoot = enemy.Character.HumanoidRootPart
                            local dist = (root.Position - eRoot.Position).Magnitude
                            
                            -- Deteksi Jarak & Kecepatan (Dash Detection)
                            if dist < 14 or (dist < 20 and eRoot.Velocity.Magnitude > 35) then
                                PressParryButton()
                                task.wait(0.3) -- Cooldown aman
                            end
                        end
                    end
                end
            end)
        end
    end
end)

-- --- 5. WORLD & ESP (UNCHANGED) ---
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

-- --- 6. OPEN BUTTON ---
local OpenButton = Instance.new("TextButton", ScreenGui)
OpenButton.Size = UDim2.new(0, 45, 0, 45); OpenButton.Position = UDim2.new(0, 10, 0.5, -22)
OpenButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30); OpenButton.Text = "BD"; OpenButton.TextColor3 = Color3.fromRGB(255, 105, 180); OpenButton.TextSize = 20; OpenButton.Font = Enum.Font.SourceSansBold
Instance.new("UICorner", OpenButton); local s = Instance.new("UIStroke", OpenButton); s.Color = Color3.fromRGB(255, 105, 180)
EnableDrag(OpenButton)
OpenButton.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)