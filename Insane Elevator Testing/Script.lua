local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local Window = Rayfield:CreateWindow({
    Name = "Insane Elevator Testing | Hub",
    LoadingTitle = "Loading...",
    LoadingSubtitle = "by ScriptGaming",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "InsaneElevatorHub",
        FileName = "Settings"
    }
})

local Tab = Window:CreateTab("Main", 0)

local Section = Tab:CreateSection("Main")

local Button = Tab:CreateButton({
	Name = "Delete Door",

	Callback = function()

		local VIPDoor =
			workspace.Lobby:FindFirstChild(
				"VIPDoor"
			)

		local PremiumDoor =
			workspace.Lobby:FindFirstChild(
				"PremiumDoor"
			)

		local Timer1 =
			workspace.Lobby:FindFirstChild(
				"Timer1"
			)

		if VIPDoor then
			VIPDoor:Destroy()
		end

		if PremiumDoor then
			PremiumDoor:Destroy()
		end

		if Timer1 then
			Timer1:Destroy()
		end
	end,
})

local LocalPlayer =
	game.Players.LocalPlayer

local Script_ESP = {}
local Script_Running = false
local Script_Thread

local Toggle = Tab:CreateToggle({
	Name = "ESP Door",
	CurrentValue = false,
	Flag = "ESPDoor",

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
				Color3.fromRGB(0, 255, 0)

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

					local Elevator =
						workspace:FindFirstChild(
							"Elevator"
						)

					if Elevator then

						CreateESP(
							Elevator,
							"Door"
						)
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

local LocalPlayer =
	game.Players.LocalPlayer

local SpeedValue = 16
local SpeedConnection

local Slider = Tab:CreateSlider({
	Name = "Speed",
	Range = {16, 100},
	Increment = 1,
	Suffix = "WalkSpeed",
	CurrentValue = 16,
	Flag = "SpeedSlider",

	Callback = function(Value)

		SpeedValue = Value

		if SpeedConnection then
			SpeedConnection:Disconnect()
		end

		SpeedConnection =
			game:GetService("RunService").RenderStepped:Connect(function()

			local Character =
				LocalPlayer.Character

			local Humanoid =
				Character
				and Character:FindFirstChildWhichIsA(
					"Humanoid"
				)

			if Humanoid then
				Humanoid.WalkSpeed =
					SpeedValue
			end
		end)
	end,
})

local LocalPlayer =
	game.Players.LocalPlayer

local Script_Running = false
local Script_Thread

local Toggle = Tab:CreateToggle({
	Name = "Anti Ragdoll",
	CurrentValue = false,
	Flag = "AntiRagdoll",

	Callback = function(Value)

		Script_Running = Value

		if Value then

			Script_Thread =
				task.spawn(function()

				while Script_Running do
					task.wait(0.1)

					local Character =
						LocalPlayer.Character

					local Humanoid =
						Character
						and Character:FindFirstChildWhichIsA(
							"Humanoid"
						)

					if Humanoid then

						Humanoid.Sit = false
						Humanoid.PlatformStand = false
					end
				end
			end)

		else

			Script_Running = false

			if Script_Thread then
				task.cancel(Script_Thread)
				Script_Thread = nil
			end
		end
	end,
})
