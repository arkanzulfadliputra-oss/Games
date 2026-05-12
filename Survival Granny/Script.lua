local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local Window = Rayfield:CreateWindow({
    Name = "Survival Granny | Normal | Hub",
    LoadingTitle = "Loading...",
    LoadingSubtitle = "by ScriptGaming",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "SurvivalGrannyHub",
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
	Name = "ESP Monster",
	CurrentValue = false,
	Flag = "ESPMonster",

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
				Color3.fromRGB(255, 0, 0)

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

					local Killers =
						workspace:FindFirstChild(
							"Killers"
						)

					if Killers then

						for _, Object in pairs(
							Killers:GetChildren()
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

local LocalPlayer =
	game.Players.LocalPlayer

local Script_Running = false
local Script_Thread

local NormalSpeed = 16
local RunSpeed = 50
local DetectDistance = 30
local SafeDistance = 100

local Toggle = Tab:CreateToggle({
	Name = "Auto Run",
	CurrentValue = false,
	Flag = "AutoRun",

	Callback = function(Value)

		Script_Running = Value

		if Value then

			Script_Thread =
				task.spawn(function()

				while Script_Running do
					task.wait(0.2)

					local Character =
						LocalPlayer.Character

					local HumanoidRootPart =
						Character
						and Character:FindFirstChild(
							"HumanoidRootPart"
						)

					local Humanoid =
						Character
						and Character:FindFirstChildWhichIsA(
							"Humanoid"
						)

					local Killers =
						workspace:FindFirstChild(
							"Killers"
						)

					if HumanoidRootPart
					and Humanoid
					and Killers then

						local NearMonster =
							false

						for _, Object in pairs(
							Killers:GetChildren()
						) do

							local MonsterPart =
								Object.PrimaryPart
								or Object:FindFirstChildWhichIsA(
									"BasePart",
									true
								)

							if MonsterPart then

								local Distance =
									(HumanoidRootPart.Position - MonsterPart.Position).Magnitude

								if Distance <= DetectDistance then

									NearMonster = true
									break
								end
							end
						end

						if NearMonster then

							Humanoid.WalkSpeed =
								RunSpeed

						else

							local Safe =
								true

							for _, Object in pairs(
								Killers:GetChildren()
							) do

								local MonsterPart =
									Object.PrimaryPart
									or Object:FindFirstChildWhichIsA(
										"BasePart",
										true
									)

								if MonsterPart then

									local Distance =
										(HumanoidRootPart.Position - MonsterPart.Position).Magnitude

									if Distance <= SafeDistance then

										Safe = false
										break
									end
								end
							end

							if Safe then

								Humanoid.WalkSpeed =
									NormalSpeed
							end
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

			local Character =
				LocalPlayer.Character

			local Humanoid =
				Character
				and Character:FindFirstChildWhichIsA(
					"Humanoid"
				)

			if Humanoid then
				Humanoid.WalkSpeed =
					NormalSpeed
			end
		end
	end,
})

local Script_Running = false
local Script_Thread

local RespawnTime = 20

local Toggle = Tab:CreateToggle({
	Name = "Kill Monster (Client)",
	CurrentValue = false,
	Flag = "KillMonsterClient",

	Callback = function(Value)

		Script_Running = Value

		if Value then

			Script_Thread =
				task.spawn(function()

				while Script_Running do
					task.wait(1)

					local Killers =
						workspace:FindFirstChild(
							"Killers"
						)

					if Killers then

						for _, Object in pairs(
							Killers:GetChildren()
						) do

							if not Object:FindFirstChild(
								"Script_Hidden"
							) then

								local HiddenTag =
									Instance.new("BoolValue")

								HiddenTag.Name =
									"Script_Hidden"

								HiddenTag.Parent =
									Object

								for _, Descendant in pairs(
									Object:GetDescendants()
								) do

									if Descendant:IsA(
										"BasePart"
									) then

										Descendant.LocalTransparencyModifier =
											1

										Descendant.CanCollide =
											false
									end

									if Descendant:IsA(
										"Decal"
									) then

										Descendant.Transparency =
											1
									end
								end

								task.spawn(function()

									task.wait(
										RespawnTime
									)

									if Object
									and Object.Parent then

										for _, Descendant in pairs(
											Object:GetDescendants()
										) do

											if Descendant:IsA(
												"BasePart"
											) then

												Descendant.LocalTransparencyModifier =
													0
											end

											if Descendant:IsA(
												"Decal"
											) then

												Descendant.Transparency =
													0
											end
										end

										local Tag =
											Object:FindFirstChild(
												"Script_Hidden"
											)

										if Tag then
											Tag:Destroy()
										end
									end
								end)
							end
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

			local Killers =
				workspace:FindFirstChild(
					"Killers"
				)

			if Killers then

				for _, Object in pairs(
					Killers:GetChildren()
				) do

					for _, Descendant in pairs(
						Object:GetDescendants()
					) do

						if Descendant:IsA(
							"BasePart"
						) then

							Descendant.LocalTransparencyModifier =
								0
						end

						if Descendant:IsA(
							"Decal"
						) then

							Descendant.Transparency =
								0
						end
					end

					local Tag =
						Object:FindFirstChild(
							"Script_Hidden"
						)

					if Tag then
						Tag:Destroy()
					end
				end
			end
		end
	end,
})
