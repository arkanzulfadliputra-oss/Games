-- Services
local Players = game:GetService("Players")
local ReSt = game:GetService("ReplicatedStorage")

-- Variables
local Plr = Players.LocalPlayer

local SelfModules = {
    UI = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/UI.lua"))(),
    Functions = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Functions.lua"))(),
}

local CustomShop = { Selected = {} }

-- Items List
local List = Plr.PlayerGui.MainUI.ItemShop.Items

if List.ClassName ~= "ScrollingFrame" then
    List = SelfModules.UI.Create("ScrollingFrame", {
        Name = "Items",
        Active = true,
        AnchorPoint = Vector2.new(0.5, 0),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        CanvasSize = UDim2.new(0, 0, 0, 0),
        Position = UDim2.new(0.5, 0, 0.18, 0),
        Size = UDim2.new(1, 0, 0.6, 0),
        ZIndex = 5,
        HorizontalScrollBarInset = Enum.ScrollBarInset.Always,
        ScrollBarThickness = 0,

        SelfModules.UI.Create("UIGridLayout", {
            SortOrder = Enum.SortOrder.LayoutOrder,
            CellPadding = UDim2.new(0, 15, 0, 15),
        }),

        SelfModules.UI.Create("UIPadding", {
            PaddingBottom = UDim.new(0, 4),
            PaddingLeft = UDim.new(0, 4),
            PaddingRight = UDim.new(0, 4),
            PaddingTop = UDim.new(0, 4),
        }),
    })

    for _, v in next, Plr.PlayerGui.MainUI.ItemShop.Items:GetChildren() do
        if v.ClassName == "TextButton" then
            v.Parent = List
        end
    end
    
    Plr.PlayerGui.MainUI.ItemShop.Items:Destroy()
    List.Parent = Plr.PlayerGui.MainUI.ItemShop
    List.UIGridLayout.CellSize = UDim2.new(0.5, -8, 0, List.AbsoluteSize.Y / 1 * 0.31 - 4)
end

-- Functions
CustomShop.CreateItem = function(tool, config)
    task.spawn(function()
        local rawItemName = string.gsub(config.Title, " ", "")
        config.RawItemName = rawItemName

        if List:FindFirstChild("CustomItem_".. config.RawItemName) then
            List["CustomItem_".. config.RawItemName]:Destroy()
        end

        if ReSt.ItemShop:FindFirstChild(config.RawItemName) then
            ReSt.ItemShop[config.RawItemName]:Destroy()
        end
        
        local Item = { Tool = tool, Config = config }
        local button = List:FindFirstChildOfClass("TextButton"):Clone()
        local selected = false
        local connections = {}

        button.Visible = true
        button.Name = "CustomItem_".. config.RawItemName
        button.Title.Text = config.Title
        button.Desc.Text = config.Desc
        button.ImageLabel.Image = LoadCustomAsset(config.Image)
        button.Price.Text = config.Price

        if not config.Stack or config.Stack <= 1 then
            button.Stack.Visible = false
        else
            button.Stack.Visible = true
            button.Stack.Text = "x".. config.Stack
        end

        -- Animation
        if config.Animation then
            local Anim = Instance.new("Animation")
            Anim.AnimationId = config.Animation.AnimationID
            button.Animation = Anim
        end
        
        button.Parent = List
        Item.Button = button

        local folder = Instance.new("Folder")
        folder.Name = config.RawItemName
        folder.Parent = ReSt.ItemShop
        folder:SetAttribute("Price", config.Price)

        connections.select = button.MouseButton1Down:Connect(function()
            selected = not selected
            button.BackgroundTransparency = selected and 0.5 or 0.9
            Plr.PlayerGui.MainUI.Initiator.Main_Game.PreRun[selected and "Press" or "PressDown"]:Play()

            -- Play animation if exists
            if config.Animation and button.Animation then
                local char = Plr.Character
                if char and char:FindFirstChildOfClass("Humanoid") then
                    local animTrack = char.Humanoid:LoadAnimation(button.Animation)
                    animTrack:Play()
                end
            end

            local upvs = debug.getupvalues(getconnections(List:FindFirstChildOfClass("TextButton").MouseButton1Down)[1].Function)
            local selectedItems = upvs[1]

            if selected then
                selectedItems[#selectedItems + 1] = config.RawItemName
                CustomShop.Selected[#CustomShop.Selected + 1] = Item
            else
                table.remove(selectedItems, table.find(selectedItems, config.RawItemName))
                table.remove(CustomShop.Selected, table.find(CustomShop.Selected, Item))
            end

            upvs[4]()
        end)

        local buttonsCount = 0
        for _, v in next, List:GetChildren() do
            if v.ClassName == "TextButton" and v.Visible then
                buttonsCount += 1
            end
        end

        local rowCount = math.round(buttonsCount / 2)
        local rowHeight = 8 + rowCount * (List.AbsoluteSize.Y / 1 * 0.31 - 4) + (rowCount - 1) * 15
        List.CanvasSize = UDim2.new(0, 0, 0, rowHeight)
    end)
end

local confirmConnection; confirmConnection = Plr.PlayerGui.MainUI.ItemShop.Confirm.MouseButton1Down:Connect(function()
    confirmConnection:Disconnect()
    for _, v in next, CustomShop.Selected do
        if typeof(v.Tool) == "Instance" and v.Tool.ClassName == "Tool" then
            v.Tool.Parent = Plr.Backpack
        end
    end
end)

return CustomShop
