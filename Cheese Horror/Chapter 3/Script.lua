local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local Window = Rayfield:CreateWindow({
    Name = "Cheese Horror | Chapter 3 | Coming Soon For 14 may",
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
