
-- GREEDY GARDEN | LIGHTNING ALERT
-- Client-side detection for Velocity Executor

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- SETTINGS
local Keywords = {
    "lightning",
    "thunder",
    "strike",
    "electric",
    "bolt"
}

local Debounce = false
local AlertDuration = 3

-- GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "GreedyGardenLightningAlert"
ScreenGui.ResetOnSpawn = false

pcall(function()
    ScreenGui.Parent = PlayerGui
end)

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 330, 0, 75)
Frame.Position = UDim2.new(0.5, -165, 0.12, 0)
Frame.BackgroundColor3 = Color3.fromRGB(35, 25, 20)
Frame.Visible = false
Frame.Parent = ScreenGui

local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 12)
Corner.Parent = Frame

local Label = Instance.new("TextLabel")
Label.Size = UDim2.new(1, 0, 1, 0)
Label.BackgroundTransparency = 1
Label.Text = "⚡ LIGHTNING DETECTED!"
Label.TextColor3 = Color3.fromRGB(255, 220, 50)
Label.TextSize = 21
Label.Font = Enum.Font.GothamBold
Label.Parent = Frame

-- ALERT
local function ShowAlert()
    if Debounce then return end
    Debounce = true

    Frame.Visible = true

    task.wait(AlertDuration)

    Frame.Visible = false
    Debounce = false
end

-- DETECTION
local function CheckObject(obj)
    local current = obj

    for i = 1, 5 do
        if not current then break end

        local name = string.lower(current.Name)

        for _, keyword in ipairs(Keywords) do
            if string.find(name, keyword, 1, true) then
                ShowAlert()
                return
            end
        end

        current = current.Parent
    end
end

-- MONITOR NEW OBJECTS
Workspace.DescendantAdded:Connect(function(obj)
    CheckObject(obj)
end)

print("[Greedy Garden] Lightning Alert loaded!")
