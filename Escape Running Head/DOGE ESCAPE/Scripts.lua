local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local Window = Rayfield:CreateWindow({
    Name = "Doge Escape | Game Simple | Hub",
    LoadingTitle = "Loading...",
    LoadingSubtitle = "by ScriptGaming",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "DogeEscapeHub",
        FileName = "Settings"
    }
})

local Tab = Window:CreateTab("Main", 0)

local Section = Tab:CreateSection("Main")

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local ChildCatESP = Tab:CreateToggle({
    Name = "ESP Child Cat",
    CurrentValue = false,
    Flag = "ChildCatESP",

    Callback = function(Value)

        if Value then

            for _, obj in pairs(workspace.Maps.StartMap.DummyCollection:GetChildren()) do

                if obj:IsA("Model") then

                    local part =
                        obj:FindFirstChildWhichIsA("BasePart")

                    if part and not part:FindFirstChild("ESP") then

                        local Billboard =
                            Instance.new("BillboardGui")

                        Billboard.Name = "ESP"
                        Billboard.Size = UDim2.new(0,140,0,40)
                        Billboard.AlwaysOnTop = true
                        Billboard.StudsOffset = Vector3.new(0,2,0)
                        Billboard.Parent = part

                        local Text =
                            Instance.new("TextLabel")

                        Text.Size = UDim2.new(1,0,1,0)
                        Text.BackgroundTransparency = 1
                        Text.TextColor3 = Color3.fromRGB(255,255,255)
                        Text.TextStrokeTransparency = 0
                        Text.Font = Enum.Font.GothamBold
                        Text.TextSize = 15
                        Text.Parent = Billboard

                        task.spawn(function()

                            while Billboard.Parent do

                                local char =
                                    LocalPlayer.Character

                                local hrp =
                                    char and char:FindFirstChild("HumanoidRootPart")

                                if hrp then

                                    local dist =
                                        math.floor((hrp.Position - part.Position).Magnitude)

                                    Text.Text =
                                        "Child Cat ["..dist.."M]"
                                end

                                task.wait(0.1)
                            end
                        end)
                    end
                end
            end

        else

            for _, obj in pairs(workspace.Maps.StartMap.DummyCollection:GetChildren()) do

                local part =
                    obj:FindFirstChildWhichIsA("BasePart")

                if part and part:FindFirstChild("ESP") then
                    part.ESP:Destroy()
                end
            end
        end
    end
})

local KeyESP = Tab:CreateToggle({
    Name = "ESP Key",
    CurrentValue = false,
    Flag = "KeyESP",

    Callback = function(Value)

        local Keys = {
            "Key Sample Blue",
            "Key Sample Green",
            "Key Sample Orange",
            "Key Sample Red",
            "Key Sample Purple",
            "Key Sample Yellow"
        }

        if Value then

            for _, name in pairs(Keys) do

                local obj =
                    workspace.Maps.StartMap:FindFirstChild(name)

                if obj then

                    local part =
                        obj:FindFirstChildWhichIsA("BasePart")
                        or obj

                    if part and not part:FindFirstChild("ESP") then

                        local Billboard =
                            Instance.new("BillboardGui")

                        Billboard.Name = "ESP"
                        Billboard.Size = UDim2.new(0,160,0,40)
                        Billboard.AlwaysOnTop = true
                        Billboard.StudsOffset = Vector3.new(0,2,0)
                        Billboard.Parent = part

                        local Text =
                            Instance.new("TextLabel")

                        Text.Size = UDim2.new(1,0,1,0)
                        Text.BackgroundTransparency = 1
                        Text.TextColor3 = Color3.fromRGB(255,255,0)
                        Text.TextStrokeTransparency = 0
                        Text.Font = Enum.Font.GothamBold
                        Text.TextSize = 15
                        Text.Parent = Billboard

                        task.spawn(function()

                            while Billboard.Parent do

                                local char =
                                    LocalPlayer.Character

                                local hrp =
                                    char and char:FindFirstChild("HumanoidRootPart")

                                if hrp then

                                    local dist =
                                        math.floor((hrp.Position - part.Position).Magnitude)

                                    Text.Text =
                                        name.." ["..dist.."M]"
                                end

                                task.wait(0.1)
                            end
                        end)
                    end
                end
            end

        else

            for _, obj in pairs(workspace.Maps.StartMap:GetDescendants()) do

                if obj.Name == "ESP" then
                    obj:Destroy()
                end
            end
        end
    end
})

local DogeESP = Tab:CreateToggle({
    Name = "ESP Doge",
    CurrentValue = false,
    Flag = "DogeESP",

    Callback = function(Value)

        local Doge =
            workspace.Maps.StartMap:GetChildren()[12]

        if Doge and Doge:IsA("Model") then

            local part =
                Doge:FindFirstChild("HumanoidRootPart")
                or Doge:FindFirstChild("Torso")
                or Doge:FindFirstChildWhichIsA("BasePart")

            if Value then

                if part and not part:FindFirstChild("ESP") then

                    local Billboard =
                        Instance.new("BillboardGui")

                    Billboard.Name = "ESP"
                    Billboard.Size = UDim2.new(0,150,0,40)
                    Billboard.AlwaysOnTop = true
                    Billboard.StudsOffset = Vector3.new(0,3,0)
                    Billboard.Parent = part

                    local Text =
                        Instance.new("TextLabel")

                    Text.Size = UDim2.new(1,0,1,0)
                    Text.BackgroundTransparency = 1
                    Text.TextColor3 = Color3.fromRGB(255,0,0)
                    Text.TextStrokeTransparency = 0
                    Text.Font = Enum.Font.GothamBold
                    Text.TextSize = 16
                    Text.Parent = Billboard

                    task.spawn(function()

                        while Billboard.Parent do

                            local char =
                                LocalPlayer.Character

                            local hrp =
                                char and char:FindFirstChild("HumanoidRootPart")

                            if hrp then

                                local dist =
                                    math.floor((hrp.Position - part.Position).Magnitude)

                                Text.Text =
                                    "Doge ["..dist.."M]"
                            end

                            task.wait(0.1)
                        end
                    end)
                end

            else

                if part and part:FindFirstChild("ESP") then
                    part.ESP:Destroy()
                end
            end
        end
    end
})
