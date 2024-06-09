local isNuiOpen = false
local myData = {}
local myCoords = {}
local myDistance = 0
local dist = 0

function closeNui()
    isNuiOpen = false
    SetNuiFocus(false, false)
    SendNUIMessage({
        action = "close"
    })
end

function openTextUi(data,coords,distance,color)
    isNuiOpen = true
    myData = data
    myCoords = coords
    myDistance = distance
    if not isNuiOpen then
        closeNui()
        return
    end
    
    local playerCoords = GetEntityCoords(PlayerPedId())
    local itemCoords = coords
    
    if IsControlJustReleased(0, 177) then
        closeNui()
        return
    elseif IsControlJustReleased(0, 300) then
        SendNUIMessage({
            action = "key",
            key = "up"
        })
    elseif IsControlJustReleased(0, 299) then
        SendNUIMessage({
            action = "key",
            key = "down"
        })
    elseif IsControlJustReleased(0, 191) then
        SendNUIMessage({
            action = "key",
            key = "enter"
        })
    elseif IsControlJustReleased(0, 194) then
        SetNuiFocus(false, false)
        SendNUIMessage({
            action = "key",
            key = "backspace"
        })
    end

    if dist < 1.5 then
    if  IsControlJustReleased(0, 38) then
            SetNuiFocus(true, true)
            SendNUIMessage({
                action = "key",
                key = "e"
            })
        end
    end

    
    local onScreen, _x, _y = World3dToScreen2d(itemCoords.x, itemCoords.y, itemCoords.z)
    local px, py, pz = table.unpack(GetGameplayCamCoord())
    
    objCoords = {
        x = _x*100,
        y = _y*110
    }

    SendNUIMessage({
        action = "open",
        data = data,
        coords = objCoords,
        dist = dist,
        color = color,
        colorData = FRKN.colorData[color]
    })
end
exports("openTextUi", openTextUi)

function closeTextUi()
    if not isNuiOpen then
        return
    end
    closeNui()
    isNuiOpen = false
    return
end
exports("closeTextUi", closeTextUi)


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if isNuiOpen then
            local playerCoords = GetEntityCoords(PlayerPedId())
            local itemCoords = myCoords

            dist = Vdist(playerCoords.x, playerCoords.y, playerCoords.z, itemCoords.x, itemCoords.y, itemCoords.z)
            if dist > myDistance then
                closeTextUi()
            end
        end
    end
end)


RegisterNUICallback("enter",function(data,cb)
    TriggerEvent(myData["item"][data.currentIndex+1].event,myData["item"][data.currentIndex+1].eventData)
end)

RegisterNUICallback('exit', function(data, cb)
    SetNuiFocus(false, false)
end)


local function EnumerateEntitiesWithinDistance(entities, isPlayerEntities, coords, maxDistance)
    local nearbyEntities = {}

    if coords then
        coords = vector3(coords.x, coords.y, coords.z)
    else
        local playerPed = ESX.PlayerData.ped
        coords = GetEntityCoords(playerPed)
    end

    for k, entity in pairs(entities) do
        local distance = #(coords - GetEntityCoords(entity))

        if distance <= maxDistance then
            nearbyEntities[#nearbyEntities + 1] = isPlayerEntities and k or entity
        end
    end

    return nearbyEntities
end

function GetVehicles()
    return GetGamePool('CVehicle')
end

function GetVehiclesInArea(coords, maxDistance)
    return EnumerateEntitiesWithinDistance(GetVehicles(), false, coords, maxDistance)
end


Citizen.CreateThread(function()
    while FRKN.vehicleControl do
        Citizen.Wait(0)

        local coords = GetEntityCoords(PlayerPedId())

        local vehicles = GetVehiclesInArea(coords, FRKN.carDistance)
    
        if not IsPedInAnyVehicle(PlayerPedId(), false) then
            if #vehicles > 0 then
            for i = 1, #vehicles do
                item = {["item"] = {
                    [1] = {name = "Use Vehicle"  ,  event = "useVehicle"      , icon = "fa fa-car"       , eventData = vehicles[i]},
                    [2] = {name = "Lock Vehicle" ,  event = "lockVehicle"     , icon = "fa fa-lock"      , eventData = vehicles[i]},
                    [3] = {name = "Unlock Vehicle" ,  event = "unlockVehicle"   , icon = "fa fa-unlock"    , eventData = vehicles[i]},
                    [4] = {name = "Open All",  event = "openvehicledoor"      , icon = "fa fa-chevron-up"    , eventData = {vehicles[i],{0,1,2,3,4,5,6}}},
                    [5] = {name = "Close All"  ,  event = "closevehicledoor"  , icon = "fa fa-chevron-down" , eventData = {vehicles[i],{0,1,2,3,4,5,6}}},
                },}
                openTextUi(item,GetEntityCoords(vehicles[i]),3,"blue")
                    end
                end 
            else
                closeTextUi()
            end
    end
end)

RegisterNetEvent('useVehicle')
AddEventHandler('useVehicle', function(vehicle)
    local ped = PlayerPedId()
    TaskWarpPedIntoVehicle(ped, vehicle, -1)
end)

RegisterNetEvent('lockVehicle')
AddEventHandler('lockVehicle', function(vehicle)
    SetVehicleDoorsLocked(vehicle, 2)
end)

RegisterNetEvent('unlockVehicle')
AddEventHandler('unlockVehicle', function(vehicle)
    SetVehicleDoorsLocked(vehicle, 1)
end)

RegisterNetEvent('openvehicledoor')
AddEventHandler('openvehicledoor', function(data)
    veh = data[1]
    for i = 1, #data[2] do
        SetVehicleDoorOpen(veh, data[2][i], false, false)
    end
end)

RegisterNetEvent('closevehicledoor')
AddEventHandler('closevehicledoor', function(data)
    veh = data[1]
    for i = 1, #data[2] do
        SetVehicleDoorShut(veh, data[2][i], false)
    end
end)
