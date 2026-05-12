local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local Window = Rayfield:CreateWindow({
    Name = "Cheese Horror | Chapter 2 | Hub",
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

local DoorDestroyed = false

local Button = Tab:CreateButton({
	Name = "Auto Win",

	Callback = function()

		local LocalPlayer =
			game.Players.LocalPlayer

		local Character =
			LocalPlayer.Character

		local HRP =
			Character
			and Character:FindFirstChild("HumanoidRootPart")

		local door =
			workspace:FindFirstChild("DoorExit")

		if door and not DoorDestroyed then
			door:Destroy()
			DoorDestroyed = true
		end

		if HRP then
			HRP.CFrame = CFrame.new(
				-160.780609,
				3.9980979,
				-145.529419,
				-0.997099996,
				-3.22870903e-08,
				-0.0761028007,
				-3.10849373e-08,
				1,
				-1.69810157e-08,
				0.0761028007,
				-1.45661199e-08,
				-0.997099996
			)
		end
	end,
})

local LocalPlayer =
	game.Players.LocalPlayer

local Script_ESP = {}
local Script_Running = false

local function GetRoot(model)

	return model.PrimaryPart
		or model:FindFirstChildWhichIsA(
			"BasePart",
			true
		)
end

local function GetHRP()

	local char =
		LocalPlayer.Character

	return char
		and char:FindFirstChild(
			"HumanoidRootPart"
		)
end

local Toggle = Tab:CreateToggle({
	Name = "ESP Cheese + Distance",
	CurrentValue = false,
	Flag = "ESPCheeseDist",

	Callback = function(Value)

		local function CreateESP(model)

			if Script_ESP[model] then
				return
			end

			local root =
				GetRoot(model)

			if not root then
				return
			end

			local highlight =
				Instance.new("Highlight")

			highlight.Adornee = model
			highlight.FillColor =
				Color3.fromRGB(255, 255, 0)
			highlight.FillTransparency = 0.5
			highlight.OutlineTransparency = 0
			highlight.DepthMode =
				Enum.HighlightDepthMode.AlwaysOnTop
			highlight.Parent = model

			local billboard =
				Instance.new("BillboardGui")

			billboard.Adornee = root
			billboard.Size =
				UDim2.new(0, 150, 0, 40)
			billboard.AlwaysOnTop = true
			billboard.StudsOffset =
				Vector3.new(0, 2, 0)
			billboard.Parent = root

			local text =
				Instance.new("TextLabel")

			text.Size =
				UDim2.new(1, 0, 1, 0)
			text.BackgroundTransparency = 1
			text.TextScaled = true
			text.Font = Enum.Font.GothamBold
			text.TextColor3 =
				Color3.fromRGB(255, 255, 0)
			text.Parent = billboard

			task.spawn(function()

				while model.Parent
				and root.Parent do

					task.wait(0.2)

					local hrp =
						GetHRP()

					if hrp then

						local dist =
							(hrp.Position - root.Position).Magnitude

						text.Text =
							model.Name ..
							" [" ..
							math.floor(dist) ..
							"m]"
					end
				end
			end)

			Script_ESP[model] = true
		end

		Script_Running = Value

		if Value then

			task.spawn(function()

				while Script_Running do
					task.wait(1)

					local folder =
						workspace:FindFirstChild(
							"FindCheese"
						)

					if folder then

						for _, obj in pairs(
							folder:GetChildren()
						) do

							if obj:IsA("Model") then
								CreateESP(obj)
							end
						end
					end
				end
			end)

		else
			Script_Running = false
			table.clear(Script_ESP)
		end
	end,
})

local Slider = Tab:CreateSlider({
	Name = "Speed",
	Range = {16, 100},
	Increment = 1,
	CurrentValue = 16,
	Flag = "SpeedSlider",

	Callback = function(Value)

		local player =
			game.Players.LocalPlayer

		local character =
			player.Character

		local humanoid =
			character
			and character:FindFirstChildOfClass("Humanoid")

		if humanoid then
			humanoid.WalkSpeed = Value
		end

		player.CharacterAdded:Connect(function(char)

			local h =
				char:WaitForChild("Humanoid")

			h.WalkSpeed = Value
		end)
	end,
})

local Players =
	game:GetService("Players")

local RunService =
	game:GetService("RunService")

local LocalPlayer =
	Players.LocalPlayer

local NoclipEnabled = false
local NoclipConnection = nil

local Toggle = Tab:CreateToggle({
	Name = "Noclip",
	CurrentValue = false,
	Flag = "NoclipToggle",

	Callback = function(Value)

		NoclipEnabled = Value

		if Value then

			NoclipConnection =
				RunService.Stepped:Connect(function()

					local Character =
						LocalPlayer.Character

					if Character then

						for _, v in pairs(
							Character:GetDescendants()
						) do

							if v:IsA("BasePart") then
								v.CanCollide = false
							end
						end
					end
				end)

		else

			if NoclipConnection then
				NoclipConnection:Disconnect()
				NoclipConnection = nil
			end

			local Character =
				LocalPlayer.Character

			if Character then

				for _, v in pairs(
					Character:GetDescendants()
				) do

					if v:IsA("BasePart") then
						v.CanCollide = true
					end
				end
			end
		end
	end,
})
