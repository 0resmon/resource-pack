--[[ Koci ]]
Server = {
    Callbacks = {},
    Functions = {},
    Framework = Utils.Functions.GetFramework(),
}

--[[ Core Thread]]
CreateThread(function()
    while Resmon == nil do
        Wait(100)
    end
    while Server.Framework == nil do
        Server.Framework = Utils.Functions.GetFramework()
        Wait(100)
    end
end)

--[[ Others ]]

if Utils.Framework == "esx" then
    Server.Framework.RegisterUsableItem(Config.Item, function(playerId)
        TriggerClientEvent(_e("Client:OpenMenu"), playerId)
    end)
    Server.Framework.RegisterUsableItem(Config.BottleItem, function(playerId)
        TriggerClientEvent(_e("Client:UseBottleFlipping"), playerId)
    end)
elseif Utils.Framework == "qb" then
    Server.Framework.Functions.CreateUseableItem(Config.Item, function(source, item)
        TriggerClientEvent(_e("Client:OpenMenu"), source)
    end)
    Server.Framework.Functions.CreateUseableItem(Config.BottleItem, function(source, item)
        TriggerClientEvent(_e("Client:UseBottleFlipping"), source)
    end)
end
