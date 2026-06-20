local StarterGui = game:GetService("StarterGui")

local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local Loading = Instance.new("TextLabel")
local SubLoading = Instance.new("TextLabel")

pcall(function()
    ScreenGui.Parent = game:GetService("CoreGui")
end)

Frame.Parent = ScreenGui
Frame.Size = UDim2.new(0,350,0,170)
Frame.Position = UDim2.new(0.5,-175,0.5,-85)
Frame.BackgroundColor3 = Color3.fromRGB(20,20,20)
Frame.BorderSizePixel = 0

Title.Parent = Frame
Title.Size = UDim2.new(1,0,0,40)
Title.BackgroundTransparency = 1
Title.Text = "Horror Pack"
Title.TextColor3 = Color3.fromRGB(255,255,255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 24

Loading.Parent = Frame
Loading.Position = UDim2.new(0,0,0,60)
Loading.Size = UDim2.new(1,0,0,40)
Loading.BackgroundTransparency = 1
Loading.Text = "Loading 0/100"
Loading.TextColor3 = Color3.fromRGB(255,255,255)
Loading.Font = Enum.Font.GothamBold
Loading.TextSize = 22

SubLoading.Parent = Frame
SubLoading.Position = UDim2.new(0,0,0,105)
SubLoading.Size = UDim2.new(1,0,0,30)
SubLoading.BackgroundTransparency = 1
SubLoading.Text = "Starting..."
SubLoading.TextColor3 = Color3.fromRGB(170,170,170)
SubLoading.Font = Enum.Font.Gotham
SubLoading.TextSize = 16

task.spawn(function()
    for i = 0,100 do
        Loading.Text = "Loading "..i.."/100"
        if i <= 20 then
            SubLoading.Text = "Credit By ScriptGaming"
        elseif i <= 40 then
            SubLoading.Text = "Loading Scripts..."
        elseif i <= 70 then
            SubLoading.Text = "Loading Rayfield..."
        elseif i <= 99 then
            SubLoading.Text = "Game Name : "..game.Name
        else
            SubLoading.Text = "Loaded!"
        end
        task.wait(0.03)
    end
end)

task.wait(3.5)

local Games = {
    [6205205961] = "https://pastebin.com/raw/aXakLQws",
    [1985320156] = "https://pastebin.com/raw/4ZpyA95n",
    [4480809144] = "https://pastebin.com/raw/J6KezjYT",
    [116387287343653] = "https://pastebin.com/raw/b9aw5sN9",
    [14476003462] = "https://pastebin.com/raw/VuBy59XD",
    [137811364710617] = "https://pastebin.com/raw/muNr8497",
    [9120716669] = "https://raw.githubusercontent.com/arkanzulfadliputra-oss/Games/main/Insane%20Elevator%20Testing/Script.lua",
    [16089229671] = "https://raw.githubusercontent.com/arkanzulfadliputra-oss/Games/main/Survival%20Granny/Script.lua",
    [5777099015] = "https://raw.githubusercontent.com/arkanzulfadliputra-oss/Games/main/Cheese%20Horror/Chapter%201/Script.lua",
    [9053673709] = "https://raw.githubusercontent.com/arkanzulfadliputra-oss/Games/main/Cheese%20Horror/Chapter%202/Script.lua",
    [6153766069] = "https://raw.githubusercontent.com/arkanzulfadliputra-oss/Games/main/Escape%20Carnival/Script.lua",
    [10384852727] = "https://pastebin.com/raw/VZp4HdVd",
    [4785497374] = "https://raw.githubusercontent.com/arkanzulfadliputra-oss/Games/main/Granny/Granny%202/Script.lua",
    [10384858885] = "https://raw.githubusercontent.com/arkanzulfadliputra-oss/Games/refs/heads/main/Granny/Granny%203/Script.lua"
}

local Link = Games[game.PlaceId]

if Link then
    local success, response = pcall(function()
        return game:HttpGet(Link)
    end)
    if success then
        StarterGui:SetCore("SendNotification", {
            Title = "Success",
            Text = "Game Supported",
            Duration = 3
        })
        loadstring(response)()
    else
        Loading.Text = "Failed"
        SubLoading.Text = "HTTP Error"
        StarterGui:SetCore("SendNotification", {
            Title = "Error",
            Text = tostring(response),
            Duration = 5
        })
        task.wait(3)
    end
else
    Loading.Text = "Failed"
    SubLoading.Text = "Wrong Game"
    StarterGui:SetCore("SendNotification", {
        Title = "Failed",
        Text = "Please play the game correctly",
        Duration = 5
    })
    task.wait(3)
end

ScreenGui:Destroy()
