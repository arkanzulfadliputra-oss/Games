local CustomShop = loadstring(game:HttpGet("https://raw.githubusercontent.com/xxx/custom-shop.lua"))()

local tool = LoadCustomInstance("rbxassetid://11397433017")

CustomShop.CreateItem(tool, {
    Title = "Example",
    Desc = "Yo Man This is an example",
    Image = "https://cdn.discordapp.com/attachments/1034486774627573821/1035460240352747541/ExampleImage.png",
    Price = 500,
    Stack = 1,
})
