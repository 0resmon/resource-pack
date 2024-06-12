-- [[ Core Events ]]

RegisterNetEvent(_e("Server:HandleCallback"), function(key, ...)
    local src = source
    if Server.Callbacks[key] then
        Server.Callbacks[key](src, function(...)
            TriggerClientEvent(_e("Client:HandleCallback"), src, key, ...)
        end, ...)
    end
end)

--[[ Custom Events ]]

RegisterNetEvent(_e("Server:SendToPeopleNearby"), function(data)
    local src = source
    for _, player in ipairs(GetPlayers()) do
        player = tonumber(player)
        src = tonumber(src)
        if src ~= player and #(GetEntityCoords(GetPlayerPed(src)) - GetEntityCoords(GetPlayerPed(player))) < 5.0 then
            TriggerClientEvent(_e("Client:SendToPeopleNearby"), player, data)
        end
    end
end)
