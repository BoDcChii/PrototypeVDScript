-- [[ BoDcChii Project - v0.4.1: LOW-END OPTIMIZED 🚀 ]] --

-- Global Caching untuk Performa (HP Low-End butuh ini)
local game = game
local Workspace = game:GetService("Workspace")
local CoreGui = game:GetService("CoreGui")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local VirtualInputManager = game:GetService("VirtualInputManager")
local LP = Players.LocalPlayer

-- --- 0. ANTI-REDUNDANT ---
if CoreGui:FindFirstChild("BoDcChii_Minimalist") then CoreGui.BoDcChii_Minimalist:Destroy() end

-- --- 1. MINIMALIST UI (BENTUK TETAP SAMA) ---
local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "BoDcChii_Minimalist"; ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 380, 0, 220); MainFrame.Position = UDim2.new(0.5, -190, 0.4, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15); MainFrame.Visible = false; MainFrame.Active = true
MainFrame.ClipsDescendants = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)
local MainStroke = Instance.new("UIStroke", MainFrame)
MainStroke.Color = Color3.fromRGB(255, 105, 180); MainStroke.Thickness = 2

-- Rainbow Effect Optimized (Hemat CPU)
task.spawn(function()
    local hue = 0
    while task.wait(0.05) do -- Tidak perlu setiap frame
        hue = (hue + 0.01) % 1
        MainStroke.Color = Color3.fromHSV(hue, 0.6, 1)
    end
end)

-- --- 2. DRAG LOGIC (COMPACT) ---
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
EnableDrag(MainFrame)

-- --- 3. HEADER & SCROLLING ---
local Header = Instance.new("TextLabel", MainFrame)
Header.Size = UDim2.new(1, 0, 0, 35); Header.Text = "BoDcChii Project"; Header.TextColor3 = Color3.fromRGB(255, 105, 180)
Header.BackgroundTransparency = 1; Header.Font = Enum.Font.SourceSansBold; Header.TextSize = 18

local function SetupScroll(scroll)
    scroll.Active = true; scroll.ScrollBarThickness = 2 -- Tipis biar enteng
    scroll.ScrollBarImageColor3 = Color3.fromRGB(255, 105, 180)
    scroll.CanvasSize = UDim2.new(0, 0, 1.5, 0); scroll.ScrollingDirection = Enum.ScrollingDirection.Y
end

local SidebarScroll = Instance.new("ScrollingFrame", MainFrame)
SidebarScroll.Size = UDim2.new(0, 115, 1, -45); SidebarScroll.Position = UDim2.new(0, 5, 0, 42); SidebarScroll.BackgroundTransparency = 1
SetupScroll(SidebarScroll)
Instance.new("UIListLayout", SidebarScroll).Padding = UDim.new(0, 5)

local ContentScroll = Instance.new("ScrollingFrame", MainFrame)
ContentScroll.Size = UDim2.new(1, -135, 1, -50); ContentScroll.Position = UDim2.new(0, 130, 0, 45); ContentScroll.BackgroundTransparency = 1
SetupScroll(ContentScroll)

-- Lines (Decoration)
local LineH = Instance.new("Frame", MainFrame)
LineH.Size = UDim2.new(0.95, 0, 0, 2); LineH.Position = UDim2.new(0.025, 0, 0, 36); LineH.BackgroundColor3 = Color3.fromRGB(255, 105, 180); LineH.BorderSizePixel = 0
local LineV = Instance.new("Frame", MainFrame)
LineV.Size = UDim2.new(0, 2, 1, -50); LineV.Position = UDim2.new(0, 122, 0, 42); LineV.BackgroundColor3 = Color3.fromRGB(255, 105, 180); LineV.BorderSizePixel = 0

-- --- 4. TABS & PAGES ---
local Pages = {}
local function CreateTabBtn(text, id)
    local btn = Instance.new("TextButton", SidebarScroll); btn.Size = UDim2.new(1, -10, 0, 35)
    btn.BackgroundColor3 = Color3.fromRGB(25, 25, 25); btn.Text = text; btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.SourceSansBold; btn.TextSize = 10; Instance.new("UICorner", btn)
    local s = Instance.new("UIStroke", btn); s.Color = Color3.fromRGB(255, 105, 180)
    
    local pg = Instance.new("Frame", ContentScroll); pg.Size = UDim2.new(1, -10, 1, 0); pg.BackgroundTransparency = 1; pg.Visible = false
    Instance.new("UIListLayout", pg).Padding = UDim.new(0, 5)
    Pages[id] = {btn = btn, page = pg}
    
    btn.MouseButton1Click:Connect(function()
        for _, v in pairs(Pages) do v.page.Visible = false; v.btn.BackgroundColor3 = Color3.fromRGB(25, 25, 25) end
        pg.Visible = true; btn.BackgroundColor3 = Color3.fromRGB(255, 105, 180)
    end)
    return pg
end

local P0 = CreateTabBtn("0. ABOUT", 0); local P1 = CreateTabBtn("1. PLAYER ESP", 1)
local P2 = CreateTabBtn("2. SURVIVAL", 2); local P3 = CreateTabBtn("3. SMOOTH MAPS", 3)

-- About Info
local AboutInfo = Instance.new("TextLabel", P0)
AboutInfo.Size = UDim2.new(1, 0, 0, 150); AboutInfo.BackgroundTransparency = 1; AboutInfo.TextColor3 = Color3.new(1, 1, 1)
AboutInfo.Text = "Creator: BoDcChii\nv0.4.1 (HP OPTIMIZED)\n\nPerubahan:\n- Caching System\n- Low-Hertz Heartbeat\n- Resource Guard Active"
AboutInfo.TextSize = 12; AboutInfo.Font = Enum.Font.SourceSansBold; AboutInfo.TextXAlignment = Enum.TextXAlignment.Left

-- Default Show
Pages[0].page.Visible = true; Pages[0].btn.BackgroundColor3 = Color3.fromRGB(255, 105, 180)

-- --- 5. FEATURE LOGIC (ULTRA OPTIMIZED) ---
local _SurvOn, _KillOn, _GenOn, _NoSkillGen, _FullBright, _NoFog, _PotatoMode, _AutoParry = false, false, false, false, false, false, false, false

local function CreateBtn(parent, text, varName)
    local btn = Instance.new("TextButton", parent); btn.Size = UDim2.new(1, 0, 0, 35); btn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    btn.Text = text .. ": OFF"; btn.TextColor3 = Color3.new(1, 1, 1); btn.Font = Enum.Font.SourceSansBold; btn.TextSize = 9; Instance.new("UICorner", btn)
    local s = Instance.new("UIStroke", btn); s.Color = Color3.fromRGB(200, 50, 50)
    
    btn.MouseButton1Click:Connect(function()
        _G[varName] = not _G[varName]
        local state = _G[varName]
        btn.Text = text .. (state and ": ON" or ": OFF")
        s.Color = state and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(200, 50, 50)
    end)
    return btn
end

-- Link Variable ke Global untuk kemudahan akses
_G.Surv = false; _G.Kill = false; _G.Gen = false; _G.Skill = false; _G.Parry = false; _G.Bright = false; _G.Fog = false; _G.Potato = false

CreateBtn(P1, "ESP SURVIVAL", "Surv"); CreateBtn(P1, "ESP KILLER", "Kill")
CreateBtn(P2, "ESP GENERATOR", "Gen"); CreateBtn(P2, "NO SKILL CHECK", "Skill"); CreateBtn(P2, "AUTO PARRY (BETA)", "Parry")
CreateBtn(P3, "FULL BRIGHT", "Bright"); CreateBtn(P3, "NO FOG", "Fog")
local PBtn = CreateBtn(P3, "POTATO MODE", "Potato")

-- [[ OPTIMIZED AUTO PARRY ]]
local lastParry = 0
local function TriggerParry()
    if tick() - lastParry < 0.6 then return end
    lastParry = tick()
    local char = LP.Character
    local tool = char and char:FindFirstChildOfClass("Tool")
    if tool then
        VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 0)
        local rem = tool:FindFirstChildOfClass("RemoteEvent") or tool:FindFirstChild("Remote")
        if rem then rem:FireServer("Parry", true) end
        task.wait(0.1)
        VirtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 0)
    end
end

-- Heartbeat Throttling (ESP & Parry dijalankan lebih efisien)
local counter = 0
RunService.Heartbeat:Connect(function()
    counter = counter + 1
    if counter % 2 ~= 0 then return end -- Hanya jalan di frame genap (Hemat 50% CPU)

    if _G.Parry then
        local myChar = LP.Character
        local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
        if myRoot then
            for _, k in pairs(Players:GetPlayers()) do
                if k ~= LP and k.Character then
                    local kRoot = k.Character:FindFirstChild("HumanoidRootPart")
                    if kRoot and (myRoot.Position - kRoot.Position).Magnitude < 11.5 then
                        local hum = k.Character:FindFirstChild("Humanoid")
                        if hum then
                            for _, t in pairs(hum:GetPlayingAnimationTracks()) do
                                if t.IsPlaying and t.Length < 1.2 and t.TimePosition < 0.3 then
                                    TriggerParry() break
                                end
                            end
                        end
                    end
                end
            end
        end
    end

    -- ESP Player (Optimized)
    if _G.Surv or _G.Kill then
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LP and p.Character then
                local hl = p.Character:FindFirstChild("BDEsp")
                if not hl then 
                    hl = Instance.new("Highlight", p.Character); hl.Name = "BDEsp"; hl.OutlineTransparency = 0.5
                end
                local isK = (p.Team and p.Team.Name:lower():find("kill")) or (p.Character:FindFirstChild("Humanoid") and p.Character.Humanoid.MaxHealth > 100)
                hl.Enabled = (isK and _G.Kill) or (not isK and _G.Surv)
                hl.FillColor = isK and Color3.new(1, 0, 0) or Color3.new(0, 1, 0)
            end
        end
    end

    if _G.Bright then Lighting.Ambient = Color3.new(1, 1, 1); Lighting.ClockTime = 12 end
    if _G.Fog then Lighting.FogEnd = 1e5 end
end)

-- Potato Mode (Satu kali jalan agar tidak lag)
PBtn.MouseButton1Click:Connect(function()
    if _G.Potato then
        for _, v in pairs(Workspace:GetDescendants()) do
            if v:IsA("BasePart") and not v:FindFirstAncestorOfClass("Model") then
                v.Material = Enum.Material.SmoothPlastic
                if v:IsA("MeshPart") then v.TextureID = "" end
            elseif v:IsA("Decal") or v:IsA("Texture") then v:Destroy() end
        end
    end
end)

-- --- 6. BUTTON TOGGLE (NO TWEEN FOR PERFORMANCE) ---
local OpenButton = Instance.new("TextButton", ScreenGui)
OpenButton.Size = UDim2.new(0, 45, 0, 45); OpenButton.Position = UDim2.new(0, 10, 0.5, -22)
OpenButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30); OpenButton.Text = "BD"
OpenButton.TextColor3 = Color3.fromRGB(255, 105, 180); OpenButton.TextSize = 20
Instance.new("UICorner", OpenButton).CornerRadius = UDim.new(0, 10)
local BtnStroke = Instance.new("UIStroke", OpenButton); BtnStroke.Color = Color3.fromRGB(255, 105, 180)
EnableDrag(OpenButton)

OpenButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

-- Metatable Skillcheck (Tetap Sama)
local mt = getrawmetatable(game)
local old = mt.__namecall
setreadonly(mt, false)
mt.__namecall = newcclosure(function(self, ...)
    if _G.Skill and getnamecallmethod() == "FireServer" then
        local n = tostring(self):lower()
        if n:find("fail") or n:find("skillcheck") then return nil end
    end
    return old(self, ...)
end)
setreadonly(mt, true)