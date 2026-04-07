-- [[ BoDcChii Project - v0.4.3: KILLER OVERDRIVE FIX 🎸 ]] --

local CoreGui = game:GetService("CoreGui")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")

-- --- 0. ANTI-REDUNDANT ---
if CoreGui:FindFirstChild("BoDcChii_Minimalist") then CoreGui.BoDcChii_Minimalist:Destroy() end

-- --- 1. SETUP UI & DRAG ---
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
    UIS.InputEnded:Connect(function(input) dragging = false end)
end

-- --- 2. MAIN FRAME ---
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 380, 0, 240); MainFrame.Position = UDim2.new(0.5, -190, 0.4, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15); MainFrame.Visible = false; MainFrame.Active = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)
local MainStroke = Instance.new("UIStroke", MainFrame)
MainStroke.Color = Color3.fromRGB(255, 105, 180); MainStroke.Thickness = 2
EnableDrag(MainFrame)

-- --- 3. TABS SETUP ---
local Sidebar = Instance.new("ScrollingFrame", MainFrame)
Sidebar.Size = UDim2.new(0, 115, 1, -45); Sidebar.Position = UDim2.new(0, 5, 0, 42); Sidebar.BackgroundTransparency = 1; Sidebar.CanvasSize = UDim2.new(0,0,1.5,0)
local Content = Instance.new("ScrollingFrame", MainFrame)
Content.Size = UDim2.new(1, -135, 1, -50); Content.Position = UDim2.new(0, 130, 0, 45); Content.BackgroundTransparency = 1; Content.CanvasSize = UDim2.new(0,0,2,0)
Instance.new("UIListLayout", Sidebar).Padding = UDim.new(0, 5)
Instance.new("UIListLayout", Content).Padding = UDim.new(0, 5)

local function CreateTab(txt)
    local b = Instance.new("TextButton", Sidebar); b.Size = UDim2.new(1, -10, 0, 35); b.Text = txt
    b.BackgroundColor3 = Color3.fromRGB(25, 25, 25); b.TextColor3 = Color3.new(1,1,1); b.Font = Enum.Font.SourceSansBold; b.TextSize = 10
    Instance.new("UICorner", b); Instance.new("UIStroke", b).Color = Color3.fromRGB(255, 105, 180)
    local p = Instance.new("Frame", Content); p.Size = UDim2.new(1, 0, 1, 0); p.BackgroundTransparency = 1; p.Visible = false
    Instance.new("UIListLayout", p).Padding = UDim.new(0, 5)
    return b, p
end

local T0, P0 = CreateTab("0. ABOUT")
local T1, P1 = CreateTab("1. PLAYER ESP")
local T2, P2 = CreateTab("2. SURVIVAL")
local T3, P3 = CreateTab("3. KILLER UTILS")
local T4, P4 = CreateTab("4. SMOOTH MAPS")

local function Show(p)
    for _, v in pairs(Content:GetChildren()) do if v:IsA("Frame") then v.Visible = false end end
    p.Visible = true
end
T0.MouseButton1Click:Connect(function() Show(P0) end)
T1.MouseButton1Click:Connect(function() Show(P1) end)
T2.MouseButton1Click:Connect(function() Show(P2) end)
T3.MouseButton1Click:Connect(function() Show(P3) end)
T4.MouseButton1Click:Connect(function() Show(P4) end)
Show(P0)

local function CreateBtn(parent, text)
    local btn = Instance.new("TextButton", parent); btn.Size = UDim2.new(1, 0, 0, 35); btn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    btn.Text = text .. ": OFF"; btn.TextColor3 = Color3.new(1, 1, 1); btn.Font = Enum.Font.SourceSansBold; btn.TextSize = 9
    Instance.new("UICorner", btn); local s = Instance.new("UIStroke", btn); s.Color = Color3.fromRGB(200, 50, 50)
    return btn
end

-- --- 5. LOGIKA FITUR ---
local _SurvOn, _KillOn, _FullBright = false, false, false
local _NoCD, _Hitbox, _LongLunge = false, false, false
local isLunging = false 

local Btn1 = CreateBtn(P1, "ESP SURVIVAL"); local Btn2 = CreateBtn(P1, "ESP KILLER")
local BtnAP = CreateBtn(P2, "AUTO PARRY (BETA)")
local BtnLunge = CreateBtn(P3, "LONG LUNGE (PARU-PARU)"); local BtnNoCD = CreateBtn(P3, "NO ATTACK COOLDOWN"); local BtnHit = CreateBtn(P3, "HITBOX EXPANDER")
local BtnFB = CreateBtn(P4, "FULL BRIGHT")

local function Toggle(btn, state, txt)
    btn.Text = txt .. (state and ": ON" or ": OFF")
    btn.UIStroke.Color = state and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(200, 50, 50)
end

BtnLunge.MouseButton1Click:Connect(function() _LongLunge = not _LongLunge Toggle(BtnLunge, _LongLunge, "LONG LUNGE (PARU-PARU)") end)
BtnNoCD.MouseButton1Click:Connect(function() _NoCD = not _NoCD Toggle(BtnNoCD, _NoCD, "NO ATTACK COOLDOWN") end)
BtnHit.MouseButton1Click:Connect(function() _Hitbox = not _Hitbox Toggle(BtnHit, _Hitbox, "HITBOX EXPANDER") end)
Btn1.MouseButton1Click:Connect(function() _SurvOn = not _SurvOn Toggle(Btn1, _SurvOn, "ESP SURVIVAL") end)
Btn2.MouseButton1Click:Connect(function() _KillOn = not _KillOn Toggle(Btn2, _KillOn, "ESP KILLER") end)
BtnFB.MouseButton1Click:Connect(function() _FullBright = not _FullBright Toggle(BtnFB, _FullBright, "FULL BRIGHT") end)

-- FIXED NO ATTACK COOLDOWN (Ultimate Method)
task.spawn(function()
    while task.wait() do
        if _NoCD then
            pcall(function()
                local lp = Players.LocalPlayer
                local weapon = lp.Character and lp.Character:FindFirstChildOfClass("Tool")
                if weapon then
                    -- Hapus delay di level script lokal senjata
                    for _, v in pairs(weapon:GetDescendants()) do
                        if v:IsA("NumberValue") and (v.Name:lower():find("cooldown") or v.Name:lower():find("delay")) then
                            v.Value = 0
                        end
                    end
                    -- Paksa animasi berhenti agar bisa input ulang instan
                    local hum = lp.Character:FindFirstChildOfClass("Humanoid")
                    if hum then
                        for _, anim in pairs(hum:GetPlayingAnimationTracks()) do
                            if anim.Name:lower():find("attack") or anim.Name:lower():find("swing") then
                                anim:Stop()
                            end
                        end
                    end
                end
            end)
        end
    end
end)

-- FIXED LONG LUNGE (Anti-Glitch)
UIS.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    if _LongLunge and not isLunging and (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
        local char = Players.LocalPlayer.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        local hum = char and char:FindFirstChild("Humanoid")
        
        if hrp and hum then
            isLunging = true
            hrp.Velocity = hrp.CFrame.LookVector * 65 
            hum.WalkSpeed = 26
            task.wait(0.5) 
            hum.WalkSpeed = 16
            isLunging = false
        end
    end
end)

-- HITBOX EXPANDER
task.spawn(function()
    while task.wait(0.5) do
        if _Hitbox then
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= Players.LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                    p.Character.HumanoidRootPart.Size = Vector3.new(12, 12, 12)
                    p.Character.HumanoidRootPart.Transparency = 0.8
                    p.Character.HumanoidRootPart.CanCollide = false
                end
            end
        end
    end
end)

-- ESP & LIGHTING
RunService.Heartbeat:Connect(function()
    if _FullBright then Lighting.Ambient = Color3.new(1, 1, 1); Lighting.ClockTime = 12 end
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= Players.LocalPlayer and p.Character then
            local hl = p.Character:FindFirstChild("BDEsp") or Instance.new("Highlight", p.Character); hl.Name = "BDEsp"
            local isK = (p.Team and p.Team.Name:lower():find("kill")) or (p.Character:FindFirstChild("Humanoid") and p.Character.Humanoid.MaxHealth > 100)
            hl.Enabled = (isK and _KillOn) or (not isK and _SurvOn); hl.FillColor = isK and Color3.new(1, 0, 0) or Color3.new(0, 1, 0)
        end
    end
end)

-- --- 6. TOGGLE MENU ---
local OpenButton = Instance.new("ScreenGui", CoreGui)
local MainBtn = Instance.new("TextButton", OpenButton)
MainBtn.Size = UDim2.new(0, 50, 0, 50); MainBtn.Position = UDim2.new(0, 20, 0.5, -25)
MainBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30); MainBtn.Text = "BD"; MainBtn.TextColor3 = Color3.fromRGB(255, 105, 180); MainBtn.TextSize = 24; MainBtn.Font = Enum.Font.SourceSansBold
Instance.new("UICorner", MainBtn).CornerRadius = UDim.new(0, 12)
EnableDrag(MainBtn)
MainBtn.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)