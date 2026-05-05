local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "PetaPeta | Game",
   Icon = 0, -- Icon in Topbar. Can use Lucide Icons (string) or Roblox Image (number). 0 to use no icon (default).
   LoadingTitle = "Rayfield Interface Suite",
   LoadingSubtitle = "by ScriptGaming",
   ShowText = "Rayfield", -- for mobile users to unhide Rayfield, change if you'd like
   Theme = "Default", -- Check https://docs.sirius.menu/rayfield/configuration/themes

   ToggleUIKeybind = "K", -- The keybind to toggle the UI visibility (string like "K" or Enum.KeyCode)

   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false, -- Prevents Rayfield from emitting warnings when the script has a version mismatch with the interface.

   -- ScriptID = "sid_xxxxxxxxxxxx", -- Your Script ID from developer.sirius.menu — enables analytics, managed keys, and script hosting

   ConfigurationSaving = {
      Enabled = true,
      FolderName = nil, -- Create a custom folder for your hub/game
      FileName = "Big Hub"
   },

   Discord = {
      Enabled = false, -- Prompt the user to join your Discord server if their executor supports it
      Invite = "noinvitelink", -- The Discord invite code, do not include Discord.gg/. E.g. Discord.gg/ABCD would be ABCD
      RememberJoins = true -- Set this to false to make them join the Discord every time they load it up
   },

   KeySystem = false, -- Set this to true to use our key system
   KeySettings = {
      Title = "Untitled",
      Subtitle = "Key System",
      Note = "No method of obtaining the key is provided", -- Use this to tell the user how to get a key
      FileName = "Key", -- It is recommended to use something unique, as other scripts using Rayfield may overwrite your key file
      SaveKey = true, -- The user's key will be saved, but if you change the key, they will be unable to use your script
      GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
      Key = {"Hello"} -- List of keys that the system will accept, can be RAW file links (pastebin, github, etc.) or simple strings ("hello", "key22")
   }
})

local Tab = Window:CreateTab("Main", 4483362458) -- Title, Image

local Section = Tab:CreateSection("Main")

local Toggle = Tab:CreateToggle({
    Name = "ESP PetaPeta",
    CurrentValue = false,
    Flag = "ESPToggle",
    Callback = function(Value)
        if Value then
            local function createESP(instance)
                if espObjects[instance] then return end
                
                local box = Instance.new("BoxHandleAdornment")
                box.Adornee = instance
                box.Size = instance.Size or Vector3.new(4, 4, 4)
                box.Color3 = Color3.fromRGB(255, 0, 0)
                box.Transparency = 0.5
                box.AlwaysOnTop = true
                box.Parent = instance
                
                local billboard = Instance.new("BillboardGui")
                billboard.Adornee = instance
                billboard.Size = UDim2.new(0, 200, 0, 50)
                billboard.StudsOffset = Vector3.new(0, 2.5, 0)
                billboard.AlwaysOnTop = true
                billboard.Parent = instance
                
                local nameLabel = Instance.new("TextLabel")
                nameLabel.Size = UDim2.new(1, 0, 0.5, 0)
                nameLabel.BackgroundTransparency = 1
                nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                nameLabel.TextStrokeTransparency = 0
                nameLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
                nameLabel.Font = Enum.Font.GothamBold
                nameLabel.TextSize = 12
                nameLabel.Text = "PetaPeta"
                nameLabel.Parent = billboard
                
                local distanceLabel = Instance.new("TextLabel")
                distanceLabel.Size = UDim2.new(1, 0, 0.5, 0)
                distanceLabel.Position = UDim2.new(0, 0, 0.5, 0)
                distanceLabel.BackgroundTransparency = 1
                distanceLabel.TextColor3 = Color3.fromRGB(255, 255, 0)
                distanceLabel.TextStrokeTransparency = 0
                distanceLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
                distanceLabel.Font = Enum.Font.GothamBold
                distanceLabel.TextSize = 10
                distanceLabel.Text = "0 studs"
                distanceLabel.Parent = billboard
                
                local line = Instance.new("LineHandleAdornment")
                line.Adornee = instance
                line.Color3 = Color3.fromRGB(255, 0, 0)
                line.Thickness = 2
                line.Transparency = 0.5
                line.AlwaysOnTop = true
                line.Length = 10
                line.Parent = instance
                
                espObjects[instance] = {box = box, billboard = billboard, nameLabel = nameLabel, distanceLabel = distanceLabel, line = line}
            end
            
            local function removeESP(instance)
                local esp = espObjects[instance]
                if esp then
                    if esp.box then esp.box:Destroy() end
                    if esp.billboard then esp.billboard:Destroy() end
                    if esp.line then esp.line:Destroy() end
                    espObjects[instance] = nil
                end
            end
            
            local function showNotification(text)
                game:GetService("StarterGui"):SetCore("SendNotification", {
                    Title = "⚠ PetaPeta",
                    Text = text,
                    Duration = 2
                })
            end
            
            local function updateESP()
                local LocalPlayer = game.Players.LocalPlayer
                if not LocalPlayer.Character or not LocalPlayer.Character.HumanoidRootPart then return end
                
                for instance, esp in pairs(espObjects) do
                    if instance and instance.Parent then
                        local distance = (instance.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
                        esp.distanceLabel.Text = math.floor(distance) .. " studs"
                        
                        if distance < 30 then
                            esp.nameLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
                            esp.distanceLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
                            if esp.box then esp.box.Color3 = Color3.fromRGB(255, 0, 0) end
                            if esp.line then esp.line.Color3 = Color3.fromRGB(255, 0, 0) end
                            
                            if distance < 20 and tick() - lastWarningTime > 3 then
                                lastWarningTime = tick()
                                showNotification("PetaPeta NEARBY! " .. math.floor(distance) .. " studs")
                            end
                        elseif distance < 50 then
                            esp.nameLabel.TextColor3 = Color3.fromRGB(255, 255, 0)
                            esp.distanceLabel.TextColor3 = Color3.fromRGB(255, 255, 0)
                            if esp.box then esp.box.Color3 = Color3.fromRGB(255, 255, 0) end
                            if esp.line then esp.line.Color3 = Color3.fromRGB(255, 255, 0) end
                        else
                            esp.nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                            esp.distanceLabel.TextColor3 = Color3.fromRGB(255, 255, 0)
                            if esp.box then esp.box.Color3 = Color3.fromRGB(255, 0, 0) end
                            if esp.line then esp.line.Color3 = Color3.fromRGB(255, 0, 0) end
                        end
                    else
                        removeESP(instance)
                    end
                end
            end
            
            local function scanForEnemy()
                for _, v in pairs(workspace:GetDescendants()) do
                    if v.Name == "EnemyPETAPETA_01" then
                        if espEnabled and not espObjects[v] then
                            createESP(v)
                        end
                    end
                end
            end
            
            espEnabled = true
            
            local conn1 = workspace.DescendantAdded:Connect(function(descendant)
                if descendant.Name == "EnemyPETAPETA_01" and espEnabled then
                    createESP(descendant)
                end
            end)
            
            local conn2 = workspace.DescendantRemoving:Connect(function(descendant)
                if descendant.Name == "EnemyPETAPETA_01" then
                    removeESP(descendant)
                end
            end)
            
            local conn3 = game:GetService("RunService").RenderStepped:Connect(function()
                if espEnabled then
                    scanForEnemy()
                    updateESP()
                end
            end)
            
            connections = {conn1, conn2, conn3}
            scanForEnemy()
        else
            espEnabled = false
            for _, conn in pairs(connections) do
                conn:Disconnect()
            end
            connections = {}
            for instance, esp in pairs(espObjects) do
                if esp.box then esp.box:Destroy() end
                if esp.billboard then esp.billboard:Destroy() end
                if esp.line then esp.line:Destroy() end
            end
            espObjects = {}
        end
    end,
})

local Slider = Tab:CreateSlider({
    Name = "Walkspeed",
    Range = {16, 30},
    Increment = 1,
    Suffix = "Speed",
    CurrentValue = 16,
    Flag = "SpeedSlider",
    Callback = function(Value)
        local player = game.Players.LocalPlayer
        local character = player.Character
        if character then
            local humanoid = character:FindFirstChild("Humanoid")
            if humanoid then
                humanoid.WalkSpeed = Value
            end
        end
        player.CharacterAdded:Connect(function(newChar)
            local humanoid = newChar:WaitForChild("Humanoid")
            humanoid.WalkSpeed = Value
        end)
    end,
})
