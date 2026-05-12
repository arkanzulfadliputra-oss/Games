local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local Window = Rayfield:CreateWindow({
    Name = "Escape The Carnival | Obby | Hub",
    LoadingTitle = "Loading...",
    LoadingSubtitle = "by ScriptGaming",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "EscapeCarnivalHub",
        FileName = "Settings"
    }
})

local Tab = Window:CreateTab("Main", 0)

local Section = Tab:CreateSection("Main")

local Button = Tab:CreateButton({
    Name = "Get All Item (7 Items)",
    Callback = function()
        local ids = {8747403163, 191028585, 17139762380, 6847969414, 4683228878, 5016069393}
        
        for _, id in pairs(ids) do
            local item = game:GetObjects("rbxassetid://" .. id)[1]
            if item then
                item.Parent = game.Players.LocalPlayer.Backpack
            end
            task.wait(0.2)
        end
    end
})
