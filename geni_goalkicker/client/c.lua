function CreateNamedRenderTargetForModel(name, model)
    local handle = 0
    if not IsNamedRendertargetRegistered(name) then
        RegisterNamedRendertarget(name, 0)
    end
    if not IsNamedRendertargetLinked(model) then
        LinkNamedRendertarget(model)
    end
    if IsNamedRendertargetRegistered(name) then
        handle = GetNamedRendertargetRenderId(name)
    end
    return handle
end

local scale = 1.2  
local screenWidth = math.floor(1280 / scale)  
local screenHeight = math.floor(720 / scale)  
local screenModel = GetHashKey('hei_prop_hei_monitor_overlay')  
local handle = CreateNamedRenderTargetForModel('hei_mon', screenModel)
local Initialized = false
RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    if not Initialized then loadProps() end
end)

RegisterNetEvent('esx:playerLoaded', function()
    if not Initialized then loadProps() end
end)

AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end
    if not Initialized then loadProps() end
end)

function loadProps()
    Initialized = true
    for k, v in pairs(Config.GoalKickers) do
        -- Table Operations
        v.objectData.spawned = false
        v.objectData.busy = false
        v.objectData.show = false
        v.objectData.currentScore = 000
        v.objectData.bestScore = 0
        -- DUI Operations
        v.duiData = {}
        v.duiData.txd = CreateRuntimeTxd('goalkicker-txd-dict-' .. tostring(k))
        v.duiData.duiObj = CreateDui('nui://'.. GetCurrentResourceName() ..'/html/index.html', screenWidth, screenHeight)
        v.duiData.dui = GetDuiHandle(v.duiData.duiObj)
        v.duiData.tx = CreateRuntimeTextureFromDuiHandle(v.duiData.txd, 'goalkicker-txd-' .. tostring(k), v.duiData.dui)
        -- Goal Kicker
        LoadModel(GetHashKey("quadria_soccergate"))
        v.objectData.object1 = CreateObject(GetHashKey("quadria_soccergate"), v.objectData.coords.x, v.objectData.coords.y, v.objectData.coords.z - 1, false, true, false)
        FreezeEntityPosition(v.objectData.object1, true)
        SetEntityHeading(v.objectData.object1, v.objectData.coords.w)
        SetModelAsNoLongerNeeded(GetHashKey("quadria_soccergate"))
        SetEntityLodDist(v.objectData.object1, v.objectData.lodDistance)
        print("quadria_soccergate model loaded. " .. k)
        if Config.Interaction.Target.Enable then
            if GetResourceState('ox_target') == 'started' or GetResourceState('pa-target') == 'started' then
                exports['ox_target']:addLocalEntity(v.objectData.object1, {
                    [1] = {
                        onSelect = function(entity) goalKick(k) end,
                        canInteract = function(entity, distance, data)
                            return not Config.GoalKickers[k].objectData.busy
                        end,
                        icon = "fas fa-baseball-ball",
                        label = Lang:t("target.kickBall"),
                        distance = Config.Interaction.Target.Distance
                    }, 
                    [2] = {
                        onSelect = function(entity) seeScoreboard(k) end,
                        icon = "fas fa-chess-queen",
                        label = Lang:t("target.showScoreboard"),
                        distance = Config.Interaction.Target.Distance
                    }
                })
            elseif GetResourceState('qb-target') == 'started' then
                exports['qb-target']:AddTargetEntity(v.objectData.object1, {
                    options = {
                        {
                            action = function(entity) goalKick(k) end,
                            canInteract = function(entity, distance, data)
                                return not Config.GoalKickers[k].objectData.busy
                            end,
                            icon = "fas fa-baseball-ball",
                            label = Lang:t("target.kickBall")
                        }, {
                            action = function(entity) seeScoreboard(k) end,
                            icon = "fas fa-chess-queen",
                            label = Lang:t("target.showScoreboard")
                        }
                    },
                    distance = Config.Interaction.Target.Distance
                })
            end
        end
        -- Ball Stick
        RequestModel(GetHashKey("quadria_soccergate_ball_stick"))
		while not HasModelLoaded(GetHashKey("quadria_soccergate_ball_stick")) do
			Citizen.Wait(0)
		end
        v.objectData.object2 = CreateObject(GetHashKey("quadria_soccergate_ball_stick"), v.objectData.coords.x , v.objectData.coords.y, v.objectData.coords.z, false, true, false)
        FreezeEntityPosition(v.objectData.object2, true)
        SetEntityHeading(v.objectData.object2, v.objectData.coords.w)
        AttachEntityToEntity(v.objectData.object2, v.objectData.object1, 0, 0.0, -0.5, -0.3, 0, 0, 0, -1, false, true, false, true, true)
        SetEntityLodDist(v.objectData.object2, v.objectData.lodDistance)
        -- Ball
        RequestModel(GetHashKey("quadria_soccergate_ball"))
		while not HasModelLoaded(GetHashKey("quadria_soccergate_ball")) do
			Citizen.Wait(0)
		end
        v.objectData.object3 = CreateObject(GetHashKey("quadria_soccergate_ball"), v.objectData.coords.x, v.objectData.coords.y, v.objectData.coords.z, false, true, false)
        FreezeEntityPosition(v.objectData.object3, true)
        AttachEntityToEntity(v.objectData.object3, v.objectData.object2, 0, 0.0, -0.3, 0, 0, 0, 0, -1, false, true, false, true, true)
        SetEntityLodDist(v.objectData.object3, v.objectData.lodDistance)
        -- Counter 1
        RequestModel(GetHashKey("hei_prop_hei_monitor_overlay"))
		while not HasModelLoaded(GetHashKey("hei_prop_hei_monitor_overlay")) do
			Citizen.Wait(0)
		end
        v.objectData.object4 = CreateObject(GetHashKey("hei_prop_hei_monitor_overlay"), v.objectData.coords.x, v.objectData.coords.y, v.objectData.coords.z, false, true, false)
        AttachEntityToEntity(v.objectData.object4, v.objectData.object1, 0, 0.0, -0.330, 1.45, 5.0, 0, 0, -1, false, true, false, true, true)
        -- Server Operations
        TriggerServerEvent('geni_goalkicker:getPropData', k)
    end
end

if Config.Interaction.Text.Enable == true then
    Citizen.CreateThread(function()
        while true do
            local sleep = 1000
            for k, v in pairs(Config.GoalKickers) do
                local playerCoords = GetEntityCoords(PlayerPedId())
                local dist = #(playerCoords - vector3(v.objectData.coords.x, v.objectData.coords.y, v.objectData.coords.z))
                if dist <= Config.Interaction.Text.Distance then
                    sleep = 0
                    local currentId = k
                    if not Config.GoalKickers[k].objectData.busy then
                        Config.DrawText3D(v.objectData.coords.x, v.objectData.coords.y, v.objectData.coords.z, Lang:t("text3d.text"))
                        if IsControlJustPressed(0, Config.Interaction.Text.KickBallKey) then
                            goalKick(currentId)
                        end
                        if IsControlJustPressed(0, Config.Interaction.Text.ShowScoreboardkey) then
                            seeScoreboard(currentId)
                        end
                    end
                end
            end
            Citizen.Wait(sleep)
        end
    end)
elseif Config.Interaction.DrawText.Enable == true then
    closestProp = {}
    local showTextUI = false
    Citizen.CreateThread(function()
        while true do
            local sleep = 100
            --if not kickingBall then
                playerPed = PlayerPedId()
                playerCoords = GetEntityCoords(playerPed)
                if not closestProp.id then
                    for k, v in pairs(Config.GoalKickers) do
                        if Config.Interaction.DrawText.Enable then
                            local dist = #(playerCoords - vector3(v.objectData.coords.x, v.objectData.coords.y, v.objectData.coords.z))
                            if dist <= Config.Interaction.DrawText.Distance then
                                function currentShow()
                                    Config.Interaction.DrawText.Show()
                                    showTextUI = true
                                end
                                function currentHide()
                                    Config.Interaction.DrawText.Hide()
                                end
                                closestProp = {id = k, distance = dist, maxDist = Config.Interaction.DrawText.Distance, coords = vector3(v.objectData.coords.x, v.objectData.coords.y, v.objectData.coords.z)}
                            end
                        end
                    end
                end
                if closestProp.id then
                    while true do
                        playerCoords = GetEntityCoords(playerPed)
                        closestProp.distance = #(vector3(closestProp.coords.x, closestProp.coords.y, closestProp.coords.z) - playerCoords)
                        if closestProp.distance < closestProp.maxDist then
                            if IsControlJustPressed(0, Config.Interaction.DrawText.KickBallKey) then
                                goalKick(closestProp.id)
                            end
                            if IsControlJustPressed(0, Config.Interaction.DrawText.ShowScoreboardkey) then
                                seeScoreboard(closestProp.id)
                            end
                            if not showTextUI then
                                currentShow()
                            end
                        else
                            currentHide()
                            break
                        end
                        Citizen.Wait(0)
                    end
                    showTextUI = false
                    closestProp = {}
                    sleep = 0
                end
            --end
            Citizen.Wait(sleep)
        end
    end)
end

AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        for k, v in pairs(Config.GoalKickers) do
            DeleteEntity(v.objectData.object1)
            DeleteEntity(v.objectData.object2)
            DeleteEntity(v.objectData.object3)
            DeleteEntity(v.objectData.object4)
        end
    end
end)

function seeScoreboard(id)
    TriggerServerEvent('geni_goalkicker:getScoreboard', id)
end

RegisterNetEvent('geni_goalkicker:openScoreboard', function(data, myData)
    SetNuiFocus(true, true)
    local translations = {}
    for k in pairs(Lang.fallback and Lang.fallback.phrases or Lang.phrases) do
        if k:sub(0, ('ui.'):len()) then
            translations[k:sub(('ui.'):len() + 1)] = Lang:t(k)
        end
    end
    if data == "unknown" then 
        SendNUIMessage({action = "openScoreboardUnknown", resourceName = GetCurrentResourceName(), translations = translations, me = myData})
    else
        SendNUIMessage({action = "openScoreboard", resourceName = GetCurrentResourceName(), first = data[2], second = data[1], third = data[3], me = myData, translations = translations})
    end
end)

RegisterNetEvent('geni_goalkicker:busyData:client', function(id, state)
    Config.GoalKickers[id].objectData.busy = state
end)

RegisterNUICallback('callback', function(data)
    if data.action == "nuiFocus" then
        SetNuiFocus(false, false)
    elseif data.action == "kickedBall" then
        local id = data.id
        ClearPedTasks(PlayerPedId())
        RequestAnimDict("misstrevor3_beatup")
        while not HasAnimDictLoaded("misstrevor3_beatup") do
            Citizen.Wait(0)
        end
        TaskPlayAnim(PlayerPedId(), "misstrevor3_beatup", "guard_beatup_kickidle_guard1", 8.0, -8.0, -1, 0, false, false, false)
        AttachEntityToEntity(Config.GoalKickers[id].objectData.object2, Config.GoalKickers[id].objectData.object1, 0, 0.0, 0.1, -0.3, 0, 0, 0, -1, false, true, false, true, true)
        Citizen.Wait(1000)
        ClearPedTasks(PlayerPedId())
        AttachEntityToEntity(Config.GoalKickers[id].objectData.object2, Config.GoalKickers[id].objectData.object1, 0, 0.0, -0.5, -0.3, 0, 0, 0, -1, false, true, false, true, true)
        local number = data.score * 10
        TriggerServerEvent('geni_goalkicker:kick', number, id)
        TriggerServerEvent('geni_goalkicker:busyData:server', id, false)
        SetNuiFocus(false, false)
    elseif data.action == "cancelKick" then
        local id = data.id
        TriggerServerEvent('geni_goalkicker:busyData:server', id, false)
        SetNuiFocus(false, false)
        ClearPedTasks(PlayerPedId())
        AttachEntityToEntity(Config.GoalKickers[id].objectData.object2, Config.GoalKickers[id].objectData.object1, 0, 0.0, -0.5, -0.3, 0, 0, 0, -1, false, true, false, true, true)
    end
end)

function loadAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		RequestAnimDict(dict)
		Citizen.Wait(0)
	end
end

-- DUI
Citizen.CreateThread(function()  
    while true do
        local sleep = 1000
        for k, v in pairs(Config.GoalKickers) do
            if v.duiData then
                local playerCoords = GetEntityCoords(PlayerPedId())
                local dist = #(playerCoords - vector3(v.objectData.coords.x, v.objectData.coords.y, v.objectData.coords.z))
                if dist <= v.objectData.duiDistance then
                    sleep = 0
                    SetTextRenderId(handle)  
                    SetScriptGfxDrawOrder(4) 
                    SetScriptGfxDrawBehindPausemenu(1)  
                    DrawSprite("goalkicker-txd-dict-" .. tostring(k), "goalkicker-txd-" .. tostring(k), 0.5, 0.5, 1.0, 1.0, 0.0, 255, 255, 255, 255)
                    SetTextRenderId(GetDefaultScriptRendertargetRenderId()) -- reset
                    ClearDrawOrigin()
                    if v.objectData.show == false then
                        v.objectData.show = true
                        SendDuiMessage(v.duiData.duiObj, json.encode({action = "opendui", best = v.objectData.bestScore, current = v.objectData.currentScore, bestText = Lang:t("dui.bestScore"), currentText = Lang:t("dui.yourScore")}))
                    else
                        SendDuiMessage(v.duiData.duiObj, json.encode({action = "opendui", best = v.objectData.bestScore, bestText = Lang:t("dui.bestScore")}))
                    end
                else
                    v.objectData.show = false
                end
            end
        end
        Citizen.Wait(sleep)
    end
end)

function goalKick(id)
    local mySkillMultiplier = 0
    local myTotalKick = 250
    table.sort(Config.MultiplierTable, function(a, b)
        return a.min < b.min
    end)
    for k, v in pairs(Config.MultiplierTable) do
        if myTotalKick < v.min then
            mySkillMultiplier = Config.MultiplierTable[k].multiplier
            break
        end
    end
    TriggerServerEvent('geni_goalkicker:busyData:server', id, true)
    SendNUIMessage({action = "openMinigame", resourceName = GetCurrentResourceName(), time = Config.MinigameTime, id = id, mySkillMultiplier = mySkillMultiplier, presskey = Lang:t("ui.minigamePressKey"), description = Lang:t("ui.minigameDescription", {time = Config.MinigameTime})})
    SetNuiFocus(true, true)
    RequestAnimDict("mini@triathlon")
    while not HasAnimDictLoaded("mini@triathlon") do
        Citizen.Wait(0)
    end
    TaskPlayAnim(PlayerPedId(), "mini@triathlon", "idle_d", 5.0, 5.0, -1, 1, 0, false, false, false)
end

RegisterNetEvent('geni_goalkicker:updateBestScore', function(id, score)
    Config.GoalKickers[id].objectData.bestScore = score
end)

RegisterNetEvent('geni_goalkicker:updateCurrentScore', function(id, score)
    Config.GoalKickers[id].objectData.currentScore = score
    SendDuiMessage(Config.GoalKickers[id].duiData.duiObj, json.encode({action = "yourScore", number = score, text = Lang:t("dui.yourScore")}))
end)

function LoadModel(model)
    if HasModelLoaded(model) then return end
    RequestModel(model)
    while not HasModelLoaded(model) do
        Citizen.Wait(0)
    end
    print("quadria_soccergate model has loaded.")
end