local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local Window = Rayfield:CreateWindow({
    Name = "Cheese Horror | Chapter 1 | Hub",
    LoadingTitle = "Loading...",
    LoadingSubtitle = "by ScriptGaming",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "CheeseHorrorHub",
        FileName = "Settings"
    }
})

local Tab = Window:CreateTab("Main", 0)

local Section = Tab:CreateSection("Main")				

local LocalPlayer =
	game.Players.LocalPlayer

local Script_ESP = {}
local Script_Running = false
local Script_Thread

local Toggle = Tab:CreateToggle({
	Name = "ESP Cheese",
	CurrentValue = false,
	Flag = "ESPCheese",

	Callback = function(Value)

		local function CreateESP(Object, ESPName)

			if not Object then
				return
			end

			if Script_ESP[Object] then
				return
			end

			local Part

			if Object:IsA("Model") then
				Part =
					Object.PrimaryPart
					or Object:FindFirstChildWhichIsA(
						"BasePart",
						true
					)
			else
				Part = Object
			end

			if not Part then
				return
			end

			local ESPColor =
				Color3.fromRGB(255, 255, 0)

			local Highlight =
				Instance.new("Highlight")

			Highlight.Name =
				"Script_ESP_Highlight"

			Highlight.Adornee = Object
			Highlight.FillColor = ESPColor
			Highlight.FillTransparency = 0.5
			Highlight.OutlineTransparency = 0

			Highlight.DepthMode =
				Enum.HighlightDepthMode.AlwaysOnTop

			Highlight.Parent = Object

			local BillboardGui =
				Instance.new("BillboardGui")

			BillboardGui.Name =
				"Script_ESP_BillboardGui"

			BillboardGui.Size =
				UDim2.new(0, 180, 0, 45)

			BillboardGui.AlwaysOnTop = true

			BillboardGui.StudsOffset =
				Vector3.new(0, 3, 0)

			BillboardGui.Adornee = Part
			BillboardGui.Parent = Part

			local TextLabel =
				Instance.new("TextLabel")

			TextLabel.Name =
				"Script_ESP_TextLabel"

			TextLabel.Size =
				UDim2.new(1, 0, 1, 0)

			TextLabel.BackgroundTransparency = 1
			TextLabel.TextScaled = true
			TextLabel.Font = Enum.Font.GothamBold
			TextLabel.TextColor3 = ESPColor
			TextLabel.TextStrokeTransparency = 0.3
			TextLabel.Parent = BillboardGui

			Script_ESP[Object] = {
				Highlight = Highlight,
				BillboardGui = BillboardGui,
				TextLabel = TextLabel
			}

			task.spawn(function()

				while Object.Parent
				and BillboardGui.Parent do

					task.wait(0.5)

					local Character =
						LocalPlayer.Character

					local HumanoidRootPart =
						Character
						and Character:FindFirstChild(
							"HumanoidRootPart"
						)

					if HumanoidRootPart
					and Part then

						local Distance =
							(HumanoidRootPart.Position - Part.Position).Magnitude

						TextLabel.Text =
							ESPName ..
							" [" ..
							math.floor(Distance) ..
							"M]"
					end
				end
			end)
		end

		local function ClearESP()

			for _, ESPData in pairs(
				Script_ESP
			) do

				if ESPData.Highlight then
					ESPData.Highlight:Destroy()
				end

				if ESPData.BillboardGui then
					ESPData.BillboardGui:Destroy()
				end
			end

			table.clear(Script_ESP)
		end

		Script_Running = Value

		if Value then

			Script_Thread =
				task.spawn(function()

				while Script_Running do
					task.wait(1)

					local FindCheese =
						workspace:FindFirstChild(
							"FindCheese"
						)

					if FindCheese then

						for _, Object in pairs(
							FindCheese:GetChildren()
						) do

							CreateESP(
								Object,
								Object.Name
							)
						end
					end
				end
			end)

		else

			Script_Running = false

			if Script_Thread then
				task.cancel(Script_Thread)
				Script_Thread = nil
			end

			ClearESP()
		end
	end,
})

local Button = Tab:CreateButton({
    Name = "TP Key Green",
    Callback = function()
        local LocalPlayer = game.Players.LocalPlayer
        if LocalPlayer and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-279.601654, 1.29329336, -38.6287994, 0.707060337, -0.707153201, 1.33812428e-05, 1.33812428e-05, 3.23057175e-05, 1, -0.707153201, -0.707060337, 3.23057175e-05)
        end
    end
})

local Button = Tab:CreateButton({
    Name = "TP Key Magenta",
    Callback = function()
        local LocalPlayer = game.Players.LocalPlayer
        if LocalPlayer and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-295.501617, 122.143295, 497.471191, -0.707060337, -0.707153201, -1.33812428e-05, 1.33812428e-05, -3.23057175e-05, 1, -0.707153201, 0.707060337, 3.23057175e-05)
        end
    end
})

local Button = Tab:CreateButton({
    Name = "TP Red Key",
    Callback = function()
        local LocalPlayer = game.Players.LocalPlayer
        if LocalPlayer and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(70.8000183, 1.20000398, -448.399994, -0.707060337, 0.707153201, 1.33812428e-05, -1.33812428e-05, -3.23057175e-05, 1, 0.707153201, 0.707060337, 3.23057175e-05)
        end
    end
})

local Button = Tab:CreateButton({
    Name = "TP Yellow Key",
    Callback = function()
        local LocalPlayer = game.Players.LocalPlayer
        if LocalPlayer and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(64.2216949, 26.8932934, -481.771179, 0.707060337, 0.707153201, -1.33812428e-05, -1.33812428e-05, 3.23057175e-05, 1, 0.707153201, -0.707060337, 3.23057175e-05)
        end
    end
})

local Button = Tab:CreateButton({
    Name = "TP Blue Key",
    Callback = function()
        local LocalPlayer = game.Players.LocalPlayer
        if LocalPlayer and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-110.590004, 44.5, -91.7500076, 1, 0, 0, 0, 1, 0, 0, 0, 1)
        end
    end
})

local Button = Tab:CreateButton({
    Name = "TP White Key",
    Callback = function()
        local LocalPlayer = game.Players.LocalPlayer
        if LocalPlayer and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-20.8197327, 5.15002108, -80.3065872, 0.642762303, -0.766065598, 3.78489494e-06, 3.78489494e-06, 8.10623169e-06, 1, -0.766065598, -0.642762303, 8.10623169e-06)
        end
    end
})

local Button = Tab:CreateButton({
    Name = "TP Red Cheese",
    Callback = function()
        local LocalPlayer = game.Players.LocalPlayer
        if LocalPlayer and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-12.8112183, 5.32002211, -120.237991, -1, 0, 0, 0, 1, 0, 0, 0, -1)
        end
    end
})

local Button = Tab:CreateButton({
    Name = "TP Bloxy Cola",
    Callback = function()
        local LocalPlayer = game.Players.LocalPlayer
        if LocalPlayer and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(76.3000107, 4.6000061, -455.199982, 0, 0, -1, 0, 1, 0, 1, 0, 0)
        end
    end
})

local Button = Tab:CreateButton({
    Name = "TP Wood",
    Callback = function()
        local LocalPlayer = game.Players.LocalPlayer
        if LocalPlayer and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-200.901642, 1.2932936, -166.903625, 0.913549721, 0, 0.406727046, 0, 1, 0, -0.406727046, 0, 0.913549721)
        end
    end
})

local Button = Tab:CreateButton({
    Name = "TP Red Cheese 2",
    Callback = function()
        local LocalPlayer = game.Players.LocalPlayer
        if not LocalPlayer.Character then return end
        
        local Noclip = nil
        local Clip = false
        
        local function noclip()
            Clip = false
            local function Nocl()
                if Clip == false and LocalPlayer.Character then
                    for _, v in pairs(LocalPlayer.Character:GetDescendants()) do
                        if v:IsA('BasePart') and v.CanCollide then
                            v.CanCollide = false
                        end
                    end
                end
            end
            Noclip = game:GetService('RunService').Stepped:Connect(Nocl)
        end
        
        local function clip()
            if Noclip then Noclip:Disconnect() end
            Clip = true
        end
        
        noclip()
        task.wait(1.0)
        
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-311.051636, 11.9432936, -125.103638, 1, 0, 0, 0, 1, 0, 0, 0, 1)
        end
    end
})

local Button = Tab:CreateButton({
	Name = "Auto Win",

	Callback = function()

		local Character =
			game.Players.LocalPlayer.Character

		local HRP =
			Character
			and Character:FindFirstChild("HumanoidRootPart")

		local DoorExit =
			workspace:FindFirstChild("DoorExit")


		if HRP then
			HRP.CFrame = CFrame.new(
				-282.051025,
				4.19131899,
				-124.325485,
				-0.0155229736,
				3.43177469e-08,
				0.999879539,
				-1.13156126e-07,
				1,
				-3.60786103e-08,
				-0.999879539,
				-1.13702541e-07,
				-0.0155229736
			)
		end

		if DoorExit then
			DoorExit:Destroy()
		end
	end,
})
