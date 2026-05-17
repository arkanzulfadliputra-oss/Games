local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local Window = Rayfield:CreateWindow({
    Name = "Granny 2 | Hub",
    Icon = 0,
    LoadingTitle = "Loading Granny Hub...",
    ConfigurationSaving = {Enabled = false}
})

local Tab = Window:CreateTab("Main", 0)

local Section = Tab:CreateSection("Main")

local RunService = game:GetService("RunService")
local player = game.Players.LocalPlayer
local espEnabled = false
local highlights = {}

local function addHighlight(instance, color)
    if highlights[instance] then return end
    
    local highlight = Instance.new("Highlight")
    highlight.Parent = instance
    highlight.FillColor = color
    highlight.FillTransparency = 0.5
    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
    highlight.OutlineTransparency = 0
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    
    highlights[instance] = highlight
end

local function removeHighlight(instance)
    local highlight = highlights[instance]
    if highlight then
        highlight:Destroy()
        highlights[instance] = nil
    end
end

local function removeAllHighlights()
    for instance, highlight in pairs(highlights) do
        highlight:Destroy()
    end
    highlights = {}
end

local function scanMonsters()
    for _, preset in pairs(workspace:GetChildren()) do
        if preset.Name:match("Preset") then
            local locks = preset:FindFirstChild("Locks")
            if locks then
                for _, name in pairs({"Granny", "Grandpa"}) do
                    local monster = locks:FindFirstChild(name)
                    if monster and not highlights[monster] then
                        local color = name == "Granny" and Color3.fromRGB(255, 0, 0) or Color3.fromRGB(255, 100, 0)
                        addHighlight(monster, color)
                    end
                end
            end
        end
    end
end

local function updateHighlights()
    for instance, highlight in pairs(highlights) do
        if not instance.Parent then
            removeHighlight(instance)
        end
    end
end

local conn1, conn2

local function startESP()
    espEnabled = true
    conn1 = workspace.DescendantAdded:Connect(function(desc)
        if desc.Name == "Granny" or desc.Name == "Grandpa" then
            task.wait(0.5)
            scanMonsters()
        end
    end)
    conn2 = RunService.RenderStepped:Connect(function()
        if espEnabled then
            scanMonsters()
            updateHighlights()
        end
    end)
    scanMonsters()
    Rayfield:Notify({
        Title = "ESP",
        Content = "Monster ESP Activated",
        Duration = 2
    })
end

local function stopESP()
    espEnabled = false
    if conn1 then conn1:Disconnect() end
    if conn2 then conn2:Disconnect() end
    removeAllHighlights()
    Rayfield:Notify({
        Title = "ESP",
        Content = "Monster ESP Deactivated",
        Duration = 2
    })
end

local Toggle = Tab:CreateToggle({
    Name = "Monster ESP",
    CurrentValue = false,
    Flag = "MonsterESP",
    Callback = function(Value)
        if Value then
            startESP()
        else
            stopESP()
        end
    end
})

local espItemEnabled = false
local highlights = {}

local function addHighlight(instance, color)
    if highlights[instance] then return end
    local highlight = Instance.new("Highlight")
    highlight.Parent = instance
    highlight.FillColor = color
    highlight.FillTransparency = 0.3
    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
    highlight.OutlineTransparency = 0
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlights[instance] = highlight
end

local function removeHighlight(instance)
    local highlight = highlights[instance]
    if highlight then
        highlight:Destroy()
        highlights[instance] = nil
    end
end

local function removeAllHighlights()
    for instance, highlight in pairs(highlights) do
        highlight:Destroy()
    end
    highlights = {}
end

local function scanItems()
    for _, preset in pairs(workspace:GetChildren()) do
        if preset.Name:match("Preset") then
            for _, obj in pairs(preset:GetDescendants()) do
                if obj:IsA("BasePart") then
                    local remote = obj:FindFirstChild("InteractRemote")
                    if remote then
                        if not highlights[obj] then
                            addHighlight(obj, Color3.fromRGB(0, 255, 0))
                        end
                    end
                end
            end
        end
    end
end

local function updateHighlights()
    for instance, highlight in pairs(highlights) do
        if not instance.Parent then
            removeHighlight(instance)
        end
    end
end

local conn1, conn2

local Toggle = Tab:CreateToggle({
    Name = "Item ESP",
    CurrentValue = false,
    Flag = "ItemESP",
    Callback = function(Value)
        if Value then
            espItemEnabled = true
            conn1 = workspace.DescendantAdded:Connect(function(desc)
                task.wait(0.3)
                scanItems()
            end)
            conn2 = game:GetService("RunService").RenderStepped:Connect(function()
                if espItemEnabled then
                    scanItems()
                    updateHighlights()
                end
            end)
            scanItems()
            Rayfield:Notify({
                Title = "Item ESP",
                Content = "Activated",
                Duration = 2
            })
        else
            espItemEnabled = false
            if conn1 then conn1:Disconnect() end
            if conn2 then conn2:Disconnect() end
            removeAllHighlights()
            Rayfield:Notify({
                Title = "Item ESP",
                Content = "Deactivated",
                Duration = 2
            })
        end
    end
})

local Button = Tab:CreateButton({
    Name = "Giver Items",
    Callback = function()
        local player = game.Players.LocalPlayer
        
        for _, preset in pairs(workspace:GetChildren()) do
            if preset.Name:match("Preset") then
                for _, obj in pairs(preset:GetDescendants()) do
                    if obj:IsA("BasePart") then
                        local remote = obj:FindFirstChild("InteractRemote")
                        if remote and remote:IsA("RemoteEvent") then
                            pcall(function()
                                remote:FireServer(player, obj)
                                task.wait()
                            end)
                        end
                        
                        local click = obj:FindFirstChild("ClickDetector")
                        if click then
                            pcall(function()
                                for _, conn in pairs(getconnections(click.MouseClick)) do
                                    conn:Fire(player)
                                end
                                task.wait()
                            end)
                        end
                        
                        local prompt = obj:FindFirstChild("ProximityPrompt")
                        if prompt then
                            pcall(function()
                                for _, conn in pairs(getconnections(prompt.Triggered)) do
                                    conn:Fire(player)
                                end
                                task.wait()
                            end)
                        end
                    end
                end
            end
        end
        
        Rayfield:Notify({
            Title = "Item Giver",
            Content = "Items given!",
            Duration = 2
        })
    end
})

local noclipEnabled = false
local noclipConn

local Toggle = Tab:CreateToggle({
    Name = "Noclip",
    CurrentValue = false,
    Flag = "Noclip",
    Callback = function(Value)
        noclipEnabled = Value
        
        if noclipEnabled then
            noclipConn = game:GetService("RunService").Stepped:Connect(function()
                if noclipEnabled and game.Players.LocalPlayer.Character then
                    for _, part in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.CanCollide = false
                        end
                    end
                end
            end)
            Rayfield:Notify({
                Title = "Noclip",
                Content = "Activated",
                Duration = 2
            })
        else
            if noclipConn then noclipConn:Disconnect() end
            if game.Players.LocalPlayer.Character then
                for _, part in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = true
                    end
                end
            end
            Rayfield:Notify({
                Title = "Noclip",
                Content = "Deactivated",
                Duration = 2
            })
        end
    end
})

local fullbrightEnabled = false
local defaultSettings = {
    Brightness = game.Lighting.Brightness,
    FogEnd = game.Lighting.FogEnd,
    Ambient = game.Lighting.Ambient,
    ClockTime = game.Lighting.ClockTime
}

local Toggle = Tab:CreateToggle({
    Name = "Fullbright",
    CurrentValue = false,
    Flag = "Fullbright",
    Callback = function(Value)
        fullbrightEnabled = Value
        
        if fullbrightEnabled then
            game.Lighting.Brightness = 2
            game.Lighting.FogEnd = 100000
            game.Lighting.Ambient = Color3.fromRGB(255, 255, 255)
            game.Lighting.ClockTime = 12
            
            Rayfield:Notify({
                Title = "Fullbright",
                Content = "Activated",
                Duration = 2
            })
        else
            game.Lighting.Brightness = defaultSettings.Brightness
            game.Lighting.FogEnd = defaultSettings.FogEnd
            game.Lighting.Ambient = defaultSettings.Ambient
            game.Lighting.ClockTime = defaultSettings.ClockTime
            
            Rayfield:Notify({
                Title = "Fullbright",
                Content = "Deactivated",
                Duration = 2
            })
        end
    end
})
