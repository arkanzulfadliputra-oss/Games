if game.PlaceId == 7253149844 then
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Success",
        Text = "Loading Script SCP Games...",
        Duration = 3
    })
    
    loadstring(game:HttpGet('https://raw.githubusercontent.com/arkanzulfadliputra-oss/ScriptGamingGamer/refs/heads/main/Tester/Main.lua.txt'))()
    
else
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Wrong Game",
        Text = "No SCP Games!",
        Duration = 3
    })
end
