--[[ Core Events ]]

AddEventHandler("onResourceStart", function(resource)
    if resource == GetCurrentResourceName() then
        Wait(1000)
        Client.Functions.StartCore()
    end
end)
AddEventHandler("onResourceStop", function(resource)
    if resource == GetCurrentResourceName() then
        Client.Functions.StopCore()
    end
end)
RegisterNetEvent(_e("Client:HandleCallback"), function(key, ...)
    if Client.Callbacks[key] then
        Client.Callbacks[key](...)
        Client.Callbacks[key] = nil
    end
end)

--[[ Framework Events ]]

RegisterNetEvent("esx:playerLoaded", function(xPlayer)
    Wait(1000)
    Client.Functions.StartCore()
end)
RegisterNetEvent("esx:onPlayerLogout", function(xPlayer)
    Client.Functions.OnPlayerLogout()
    Client.Functions.StopCore()
end)

RegisterNetEvent("QBCore:Client:OnPlayerLoaded", function()
    Wait(1000)
    Client.Functions.StartCore()
end)
RegisterNetEvent("QBCore:Client:OnPlayerUnload", function()
    Client.Functions.OnPlayerLogout()
    Client.Functions.StopCore()
end)

--[[ Custom Events ]]

RegisterNetEvent(_e("Client:OpenMenu"), function()
    Client.Functions.OpenMenu()
end)

RegisterNetEvent(_e("Client:UseBottleFlipping"), function()
    Client.Functions.CreateBottle()
end)

RegisterNetEvent(_e("Client:SendToPeopleNearby"), function(data)
    Client.Functions.SendReactMessage("ui:PlayerChoosesTask", data)
end)
