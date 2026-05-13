local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local Window = Rayfield:CreateWindow({
    Name = "Cheese Horror | Chapter 3 | Hub",
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

local Players =
	game:GetService("Players")

local LocalPlayer =
	Players.LocalPlayer

local CheeseESP = {}
local CardESP = {}

local Button = Tab:CreateButton({
	Name = "Auto Win",

	Callback = function()

		local door =
			workspace:FindFirstChild("DoorExit")

		if door then
			door:Destroy()
		end

		local Character =
			LocalPlayer.Character

		local HRP =
			Character
			and Character:FindFirstChild(
				"HumanoidRootPart"
			)

		if HRP then

			HRP.CFrame = CFrame.new(
				48.4992828,
				2.99802518,
				-60.5251236,
				-0.741999805,
				-3.78364966e-08,
				0.670400083,
				-1.68112795e-08,
				1,
				3.78319314e-08,
				-0.670400083,
				1.68010033e-08,
				-0.741999805
			)
		end
	end,
})

local Toggle = Tab:CreateToggle({
	Name = "ESP Cheese",
	CurrentValue = false,
	Flag = "ESPCheese",

	Callback = function(Value)

		CheeseESP.Enabled = Value

		if Value then

			task.spawn(function()

				while CheeseESP.Enabled do
					task.wait(1)

					local folder =
						workspace:FindFirstChild(
							"FindCheese"
						)

					if folder then

						for _, obj in pairs(
							folder:GetChildren()
						) do

							if obj:IsA("Model")
							and not obj:FindFirstChild("Script_ESP") then

								local root =
									obj.PrimaryPart
									or obj:FindFirstChildWhichIsA(
										"BasePart",
										true
									)

								if root then

									local billboard =
										Instance.new("BillboardGui")

									billboard.Name =
										"Script_ESP"

									billboard.Adornee =
										root

									billboard.Size =
										UDim2.new(0, 140, 0, 35)

									billboard.AlwaysOnTop = true

									billboard.StudsOffset =
										Vector3.new(0, 2, 0)

									billboard.Parent =
										obj

									local text =
										Instance.new("TextLabel")

									text.Size =
										UDim2.new(1, 0, 1, 0)

									text.BackgroundTransparency = 1
									text.TextScaled = true
									text.Font = Enum.Font.GothamBold
									text.TextColor3 =
										Color3.fromRGB(255, 255, 0)

									text.Parent =
										billboard

									task.spawn(function()

										while obj.Parent do
											task.wait(0.2)

											local Character =
												LocalPlayer.Character

											local HRP =
												Character
												and Character:FindFirstChild(
													"HumanoidRootPart"
												)

											if HRP then

												local dist =
													(HRP.Position - root.Position).Magnitude

												text.Text =
													"Cheese [" ..
													math.floor(dist) ..
													"M]"
											end
										end
									end)
								end
							end
						end
					end
				end
			end)
		end
	end,
})

local Toggle = Tab:CreateToggle({
	Name = "ESP Card",
	CurrentValue = false,
	Flag = "ESPCard",

	Callback = function(Value)

		CardESP.Enabled = Value

		if Value then

			task.spawn(function()

				while CardESP.Enabled do
					task.wait(1)

					local folder =
						workspace:FindFirstChild(
							"TakingItems"
						)

					if folder then

						for _, obj in pairs(
							folder:GetChildren()
						) do

							if not obj:FindFirstChild("Script_ESP") then

								local root =
									obj:IsA("Model")
									and (
										obj.PrimaryPart
										or obj:FindFirstChildWhichIsA(
											"BasePart",
											true
										)
									)
									or obj

								if root then

									local billboard =
										Instance.new("BillboardGui")

									billboard.Name =
										"Script_ESP"

									billboard.Adornee =
										root

									billboard.Size =
										UDim2.new(0, 140, 0, 35)

									billboard.AlwaysOnTop = true

									billboard.StudsOffset =
										Vector3.new(0, 2, 0)

									billboard.Parent =
										obj

									local text =
										Instance.new("TextLabel")

									text.Size =
										UDim2.new(1, 0, 1, 0)

									text.BackgroundTransparency = 1
									text.TextScaled = true
									text.Font = Enum.Font.GothamBold
									text.TextColor3 =
										Color3.fromRGB(0, 255, 255)

									text.Parent =
										billboard

									task.spawn(function()

										while obj.Parent do
											task.wait(0.2)

											local Character =
												LocalPlayer.Character

											local HRP =
												Character
												and Character:FindFirstChild(
													"HumanoidRootPart"
												)

											if HRP then

												local dist =
													(HRP.Position - root.Position).Magnitude

												text.Text =
													obj.Name ..
													" [" ..
													math.floor(dist) ..
													"M]"
											end
										end
									end)
								end
							end
						end
					end
				end
			end)
		end
	end,
})

local Button = Tab:CreateButton({
	Name = "TP Card Blue",

	Callback = function()

		local Character =
			LocalPlayer.Character

		local HRP =
			Character
			and Character:FindFirstChild(
				"HumanoidRootPart"
			)

		if HRP then

			HRP.CFrame = CFrame.new(
				135.898041,
				3.09802532,
				-8.48085976,
				0.999267101,
				7.30725702e-10,
				0.0382787511,
				-2.26306041e-09,
				1,
				3.99876185e-08,
				-0.0382787511,
				-4.0044938e-08,
				0.999267101
			)
		end
	end,
})

local Button = Tab:CreateButton({
	Name = "TP Card Red",

	Callback = function()

		local safe =
			workspace:FindFirstChild("Safe")

		if safe then
			safe:Destroy()
		end

		local Character =
			LocalPlayer.Character

		local HRP =
			Character
			and Character:FindFirstChild(
				"HumanoidRootPart"
			)

		if HRP then

			HRP.CFrame = CFrame.new(
				30.6289539,
				2.99802518,
				-24.245306,
				0.565946579,
				-3.70415947e-08,
				-0.82444191,
				7.91345869e-08,
				1,
				9.39345401e-09,
				0.82444191,
				-7.05580661e-08,
				0.565946579
			)
		end
	end,
})

local Button = Tab:CreateButton({
	Name = "TP Card Orange",

	Callback = function()

		local Character =
			LocalPlayer.Character

		local HRP =
			Character
			and Character:FindFirstChild(
				"HumanoidRootPart"
			)

		if HRP then

			HRP.CFrame = CFrame.new(
				-131.572433,
				2.9980247,
				127.95282,
				-0.555550992,
				-6.76371812e-08,
				0.83148247,
				-7.48775761e-08,
				1,
				3.13162012e-08,
				-0.83148247,
				-4.48616433e-08,
				-0.555550992
			)
		end
	end,
})
