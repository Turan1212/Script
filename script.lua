-- [SCRIPT START]
if not game:IsLoaded() then game.Loaded:Wait() end

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local Mouse = LocalPlayer:GetMouse()
local Workspace = game:GetService("Workspace")
local MarketplaceService = game:GetService("MarketplaceService")

-- Gamepass unlocker
function MarketplaceService:UserOwnsGamePassAsync(userId, passId)
    return true -- ALLE gamepasses als 'gekocht'
end

-- GUI
local gui = Instance.new("ScreenGui", game.CoreGui)
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 200, 0, 300)
frame.Position = UDim2.new(0, 10, 0.5, -150)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 30)
title.Text = "Ultimate Dev Script"
title.TextColor3 = Color3.new(1,1,1)
title.BackgroundTransparency = 1
title.Font = Enum.Font.SourceSansBold
title.TextSize = 20

local y = 35
local function addButton(text, func)
    local btn = Instance.new("TextButton", frame)
    btn.Size = UDim2.new(1, 0, 0, 30)
    btn.Position = UDim2.new(0, 0, 0, y)
    btn.Text = text
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Font = Enum.Font.SourceSans
    btn.TextSize = 18
    btn.MouseButton1Click:Connect(func)
    y += 35
end

-- ESP
local espOn = false
function toggleESP()
    espOn = not espOn
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("Head") then
            if espOn then
                local tag = Instance.new("BillboardGui", p.Character.Head)
                tag.Name = "ESP"
                tag.Size = UDim2.new(0, 100, 0, 40)
                tag.AlwaysOnTop = true
                local label = Instance.new("TextLabel", tag)
                label.Size = UDim2.new(1, 0, 1, 0)
                label.BackgroundTransparency = 1
                label.TextColor3 = Color3.new(1, 0, 0)
                label.Text = p.Name
                label.TextScaled = true
            else
                local head = p.Character:FindFirstChild("Head")
                if head and head:FindFirstChild("ESP") then head.ESP:Destroy() end
            end
        end
    end
end

-- Fly
local flying = false
function toggleFly()
    flying = not flying
    local hrp = LocalPlayer.Character:WaitForChild("HumanoidRootPart")
    if flying then
        local bv = Instance.new("BodyVelocity", hrp)
        bv.Name = "FlyForce"
        bv.MaxForce = Vector3.new(1e5, 1e5, 1e5)
        bv.Velocity = Vector3.zero

        RunService.RenderStepped:Connect(function()
            if flying and bv and hrp then
                bv.Velocity = Workspace.CurrentCamera.CFrame.LookVector * 100
            end
        end)
    else
        if hrp:FindFirstChild("FlyForce") then hrp.FlyForce:Destroy() end
    end
end

-- Aimbot
local aimbotOn = false
function toggleAimbot()
    aimbotOn = not aimbotOn
    RunService.RenderStepped:Connect(function()
        if aimbotOn then
            local closest, dist = nil, math.huge
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("Head") then
                    local head = p.Character.Head
                    local pos, visible = Workspace.CurrentCamera:WorldToViewportPoint(head.Position)
                    local mag = (Vector2.new(pos.X, pos.Y) - Vector2.new(Mouse.X, Mouse.Y)).Magnitude
                    if mag < dist then
                        closest = head
                        dist = mag
                    end
                end
            end
            if closest then
                Workspace.CurrentCamera.CFrame = CFrame.new(Workspace.CurrentCamera.CFrame.Position, closest.Position)
            end
        end
    end)
end

-- Autofarm
local autoFarm = false
function toggleAutofarm()
    autoFarm = not autoFarm
    while autoFarm do
        task.wait(1)
        -- Pas dit aan op jouw spel!
        local npc = Workspace:FindFirstChild("Dummy") or Workspace:FindFirstChildOfClass("Model")
        if npc and npc:FindFirstChild("HumanoidRootPart") then
            LocalPlayer.Character:MoveTo(npc.HumanoidRootPart.Position + Vector3.new(0,2,0))
        end
    end
end

-- GUI Buttons
addButton("Toggle ESP", toggleESP)
addButton("Toggle Fly", toggleFly)
addButton("Toggle Aimbot", toggleAimbot)
addButton("Toggle Autofarm", toggleAutofarm)

-- [SCRIPT END]
