--[[ Koci ]]
Client = {
    Callbacks = {},
    Functions = {},
    CreatedTargets = {},
    CreatedObjects = {},
    Player = {
        isBottleCreated = false,
    },
}

--[[ Core Functions ]]

function Client.Functions.TriggerServerCallback(key, callback, ...)
    callback = callback or function() end
    Client.Callbacks[key] = callback
    local event = _e("Server:HandleCallback")
    TriggerServerEvent(event, key, ...)
end

function Client.Functions.SendReactMessage(action, data)
    SendNUIMessage({ action = action, data = data })
end

function Client.Functions.SendNotify(title, type, duration, icon, text)
    Resmon.Lib.ShowNotify(title, type, duration, icon, text)
end

function Client.Functions.GetPlayerData()
    return Resmon.Lib.GetPlayerData()
end

function Client.Functions.IsPlayerLoaded()
    return Resmon.Lib.IsPlayerLoaded()
end

--[[ Script Functions ]]

function Client.Functions.AddTargetModel(key, model, options)
    local icon = options.icon
    local label = options.label
    if Config.TargetType == "ox_target" then
        for key, value in pairs(options) do
            value.distance = 2.0
        end
        exports.ox_target:addModel(model, options)
    elseif Config.TargetType == "qb_target" then
        for key, value in pairs(options) do
            value.action = value.onSelect
        end
        exports["qb-target"]:AddTargetModel(model, { options = options, distance = 2.0, })
    else
        Utils.Functions.CustomTarget.AddTargetModel(model, options)
    end
    table.insert(Client.CreatedTargets, {
        id = model,
        key = key,
    })
end

function Client.Functions.RemoveModel(id)
    if Config.TargetType == "ox_target" then
        exports.ox_target:removeModel(id)
    elseif Config.TargetType == "qb_target" then
        exports["qb-target"]:RemoveTargetModel(id)
    else
        Utils.Functions.CustomTarget.RemoveTargetModel(id)
    end
end

function Client.Functions.DeleteTargets()
    local entities = Client.CreatedTargets
    for _, value in pairs(entities) do
        Client.Functions.RemoveModel(value.id)
    end
    Client.CreatedTargets = {}
end

function Client.Functions.DeleteObjects()
    for _, value in pairs(Client.CreatedObjects) do
        if value.objectId and DoesEntityExist(value.objectId) then
            DeleteEntity(value.objectId)
        elseif NetworkDoesEntityExistWithNetworkId(value.netId) then
            local object = NetToEnt(netId)
            NetworkRequestControlOfEntity(object)
            SetEntityAsMissionEntity(object, true, true)
            while DoesEntityExist(object) do
                NetworkRequestControlOfEntity(object)
                DeleteEntity(object)
                Wait(1)
            end
        end
    end
    Client.CreatedObjects = {}
end

function Client.Functions.SetupUI()
    Client.Functions.SendReactMessage("ui:setTheme", Config.Theme)
    Client.Functions.SendReactMessage("ui:setLocale", locales.ui)
    Client.Functions.SendReactMessage("ui:setQuestionCategories", Config.QuestionCategories)
    Client.Functions.SendReactMessage("ui:setCategoryTasks", Config.CategoryTasks)
end

function Client.Functions.OnPlayerLogout()
    TriggerServerEvent(_e("Server:OnPlayerLogout"))
end

function Client.Functions.OpenMenu()
    Client.Functions.SendReactMessage("ui:clearSelects")
    Client.Functions.SendReactMessage("ui:setVisible", true)
    SetNuiFocus(true, true)
end

-- @ --

function Client.Functions.StartCore()
    Client.Functions.SetupUI()
end

function Client.Functions.StopCore()
    Client.Functions.DeleteTargets()
    Client.Functions.DeleteObjects()
    -- @ --
    Client.Player = {
        isBottleCreated = false
    }
end

local function GetClosestObjectsOfType(model, coords, dist)
    local ped = PlayerPedId()
    local objects = GetGamePool('CObject')
    local closestObjects = {}
    if coords then
        coords = type(coords) == 'table' and vec3(coords.x, coords.y, coords.z) or coords
    else
        coords = GetEntityCoords(ped)
    end
    for i = 1, #objects, 1 do
        local objectCoords = GetEntityCoords(objects[i])
        local distance = #(objectCoords - coords)
        if distance <= dist and GetEntityModel(objects[i]) == GetHashKey(model) then
            table.insert(closestObjects, objects[i])
        end
    end
    return closestObjects
end
local function RandomRotationSpeed(min, max)
    return math.random() * (max - min) + min
end

function Client.Functions.FlipTheBottle()
    if Client.Player.isBottleCreated then
        local netId = Client.Player.isBottleCreated
        if netId and NetworkDoesEntityExistWithNetworkId(netId) then
            local object = NetToEnt(netId)
            local startTime = GetGameTimer()
            local duration = 5000
            local rotationSpeed = 8.0
            while GetGameTimer() - startTime < duration and DoesEntityExist(object) do
                local rotation = GetEntityRotation(object)
                SetEntityRotation(object, rotation.x, rotation.y, rotation.z + rotationSpeed, 0, true)
                Wait(1)
                local diss = RandomRotationSpeed(0.0005, 0.001)
                rotationSpeed = math.max(1.0, rotationSpeed - diss)
            end
        end
    end
end

function Client.Functions.RemoveTheBottle()
    Client.Functions.DeletePlayerBottle()
end

function Client.Functions.CreateBottleTarget()
    Client.Functions.DeleteTargets()
    Client.Functions.AddTargetModel("bottle", "prop_amb_beer_bottle", {
        {
            icon = "fa-solid fa-rotate",
            label = _t("game.flip_bottle"),
            onSelect = function()
                Client.Functions.FlipTheBottle()
            end
        },
        {
            icon = "fa-solid fa-xmark",
            label = _t("game.remove_bottle"),
            onSelect = function()
                Client.Functions.RemoveTheBottle()
            end
        },
    })
end

function Client.Functions.DeletePlayerBottle()
    if Client.Player.isBottleCreated then
        local netId = Client.Player.isBottleCreated
        if netId and NetworkDoesEntityExistWithNetworkId(netId) then
            local object = NetToEnt(netId)
            NetworkRequestControlOfEntity(object)
            SetEntityAsMissionEntity(object, true, true)
            while DoesEntityExist(object) do
                NetworkRequestControlOfEntity(object)
                DeleteEntity(object)
                Wait(1)
            end
        end
        Client.Player.isBottleCreated = false
    end
end

function Client.Functions.CreateBottle()
    Client.Functions.DeletePlayerBottle()
    local model = "prop_amb_beer_bottle"
    if not Utils.Functions.RequestModel(model) then return end
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    local forwardVector = GetEntityForwardVector(playerPed)
    local distanceToLook = 0.5
    local coords = playerCoords + (forwardVector * distanceToLook)
    local object = CreateObject(model, coords.x, coords.y, coords.z, true, true)
    if object ~= 0 then
        SetEntityCoords(object, coords.x, coords.y, coords.z)
        SetEntityAsMissionEntity(object, true, true)
        SetEntityCollision(object, false, true)
        SetEntityCompletelyDisableCollision(object, true)
        FreezeEntityPosition(object, true)
        SetEntityInvincible(createdObject, true)
        PlaceObjectOnGroundProperly(object)
        local coords = GetEntityCoords(object)
        SetEntityRotation(object, 0.0, 90.0, 90.0, 2)
        SetEntityCoords(object, coords.x, coords.y, coords.z - 0.1)
        while not NetworkGetEntityIsNetworked(object) do
            NetworkRegisterEntityAsNetworked(object)
            Wait(1)
        end
        local netId = ObjToNet(object)
        SetNetworkIdCanMigrate(netId, true)
        NetworkUseHighPrecisionBlending(netId, true)
        SetModelAsNoLongerNeeded(model)
        table.insert(Client.CreatedObjects, {
            objectId = object,
            netId = netId,
        })
        Client.Player.isBottleCreated = netId
        Client.Functions.CreateBottleTarget()
    end
end

-- NUI

RegisterNUICallback("nui:hideFrame", function(data, cb)
    SetNuiFocus(false, false)
    if not data then
        Client.Functions.SendReactMessage("ui:setVisible", false)
        Client.Functions.SendReactMessage("ui:clearSelects")
    end
    cb(true)
end)

RegisterNUICallback("nui:SendToPeopleNearby", function(data, cb)
    TriggerServerEvent(_e("Server:SendToPeopleNearby"), data)
    cb(true)
end)
