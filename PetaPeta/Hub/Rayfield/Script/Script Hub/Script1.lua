if game.PlaceId == 14476003462 then
    game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "Warning",
    Text = "Game Support!",
    Duration = 3
})
    loadstring(game:HttpGet("https://raw.githubusercontent.com/arkanzulfadliputra-oss/Games/refs/heads/main/PetaPeta/Hub/Rayfield/Script/Script%20Hub/Script.lua"))()
else
    game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "Warning",
    Text = "Game Not Supported!",
    Duration = 3
})
end
