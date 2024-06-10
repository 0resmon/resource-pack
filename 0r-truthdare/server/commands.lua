RegisterCommand(Config.Commands.openMenu, function(source)
    local src = source
    TriggerClientEvent(_e("Client:OpenMenu"), src)
end)
