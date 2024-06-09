currentPed = nil
currentDialogId = 0
camSettings = {showCam = true}
dialogActive = false
currentZoneData = {}
Citizen.CreateThread(function()
	-- Settings
	local camSettingsData = GetResourceKvpString('camSettings_0r-npcdialog')
    if camSettingsData then loadSettings(json.decode(camSettingsData)) end
	-- Another
	for k, v in pairs(Config.Dialogs) do
		if v.Ped.Enable then
			local pedHash2 = type(v.Ped.hash) == "number" and v.Ped.hash or joaat(v.Ped.hash)
			RequestModel(pedHash2)
			while not HasModelLoaded(pedHash2) do
				Citizen.Wait(0)
			end
			v.Ped.ped = CreatePed(0, pedHash2, v.Ped.coords.x, v.Ped.coords.y, v.Ped.coords.z - 1, v.Ped.coords.w, false, true)
			FreezeEntityPosition(v.Ped.ped, true)
            SetEntityInvincible(v.Ped.ped, true)
            SetBlockingOfNonTemporaryEvents(v.Ped.ped, true)
			PlaceObjectOnGroundProperly(v.Ped.ped)
			SetEntityAsMissionEntity(v.Ped.ped, false, false)
        	SetPedCanPlayAmbientAnims(v.Ped.ped, false) 
            SetModelAsNoLongerNeeded(pedHash2)
			RequestAnimDict(v.Ped.animDict)
            while not HasAnimDictLoaded(v.Ped.animDict) do
                Citizen.Wait(0)
            end
			TaskPlayAnim(v.Ped.ped, v.Ped.animDict, v.Ped.animName, 5.0, 5.0, -1, 1, 0, false, false, false)
			if v.Interaction.Target.Enable then
				if GetResourceState('ox_target') == 'started' or GetResourceState('ac-target') == 'started' then
					exports['ox_target']:addLocalEntity(v.Ped.ped, {
						[1] = {
							label = v.Interaction.Target.Label,
							icon = v.Interaction.Target.Icon,
							distance = v.Interaction.Target.Distance,
							onSelect = function()
								openDialog(v.AutoMessage.Enable, v.AutoMessage.AutoMessages, v.Buttons, v.Menu, k)
							end
						},
					})
				elseif GetResourceState('qb-target') == 'started' then
					exports['qb-target']:AddTargetEntity(v.Ped.ped, {
						options = {
							{
								label = v.Interaction.Target.Label,
								icon = v.Interaction.Target.Icon,
								action = function()
									openDialog(v.AutoMessage.Enable, v.AutoMessage.AutoMessages, v.Buttons, v.Menu, k)
								end
							}
						},
						distance = v.Interaction.Target.Distance
					})
				end
			end
		end
		if v.Blip.Enable then
			local blip = AddBlipForCoord(v.Blip.coords.x, v.Blip.coords.y, v.Blip.coords.z)
			SetBlipSprite(blip, v.Blip.sprite)
			SetBlipScale(blip, v.Blip.scale)
			SetBlipDisplay(blip, 4)
			SetBlipColour(blip, v.Blip.color)
			SetBlipAsShortRange(blip, true)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentSubstringPlayerName(v.Blip.text)
			EndTextCommandSetBlipName(blip)
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		local sleep = 1000
		local playerCoords = GetEntityCoords(PlayerPedId())
		for k, v in pairs(Config.Dialogs) do
			if not dialogActive then
				local dist = #(playerCoords - vector3(v.Ped.coords.x, v.Ped.coords.y, v.Ped.coords.z))
				if v.Interaction.Text.Enable then
					if dist <= v.Interaction.Text.Distance then
						sleep = 0
						ShowFloatingHelpNotification(v.Interaction.Text.Label, v.Ped.coords)
						if IsControlJustReleased(0, 38) then
							openDialog(v.AutoMessage.Enable, v.AutoMessage.AutoMessages, v.Buttons, v.Menu, k)
						end
					end
				end
			end
		end
		Citizen.Wait(sleep)
	end
end)

closestPed = {}
local showTextUI = false
Citizen.CreateThread(function()
	while true do
		local sleep = 100
		if not dialogActive then
			playerPed = PlayerPedId()
			playerCoords = GetEntityCoords(playerPed)
			if not closestPed.id then
				for k, v in pairs(Config.Dialogs) do
					if v.Interaction.DrawText.Enable then
						local dist = #(playerCoords - vector3(v.Ped.coords.x, v.Ped.coords.y, v.Ped.coords.z))
						if dist <= v.Interaction.DrawText.Distance then
							function currentShow()
								v.Interaction.DrawText.Show()
								showTextUI = true
							end
							function currentHide()
								v.Interaction.DrawText.Hide()
							end
							closestPed = {id = k, distance = dist, maxDist = v.Interaction.DrawText.Distance, data = {coords = v.Ped.coords, enableAutoMessage = v.AutoMessage.Enable, autoMessages = v.AutoMessage.AutoMessages, buttons = v.Buttons, menu = v.Menu}}
						end
					end
				end
			end
			if closestPed.id then
				while LocalPlayer.state.isLoggedIn do
					playerCoords = GetEntityCoords(playerPed)
					closestPed.distance = #(vector3(closestPed.data.coords.x, closestPed.data.coords.y, closestPed.data.coords.z) - playerCoords)
					if closestPed.distance < closestPed.maxDist then
						if IsControlJustReleased(0, 38) then
							openDialog(closestPed.data.enableAutoMessage, closestPed.data.autoMessages, closestPed.data.buttons, closestPed.data.menu, closestPed.id)
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
				closestPed = {}
				sleep = 0
			end
		end
		Citizen.Wait(sleep)
	end
end)

function ShowFloatingHelpNotification(msg, coords)
    AddTextEntry('0rFloatingHelpNotification', msg)
    SetFloatingHelpTextWorldPosition(1, coords)
    SetFloatingHelpTextStyle(1, 1, 2, -1, 3, 0)
    BeginTextCommandDisplayHelp('0rFloatingHelpNotification')
    EndTextCommandDisplayHelp(2, false, false, -1)
end

function loadSettings(settings)
	Citizen.Wait(500)
	camSettings.showCam = settings.showCam
	print("Settings Loaded. Cam state is " .. tostring(camSettings.showCam) .. ".")
end

function openDialog(AutoMessageEnabled, AutoMessages, Buttons, Menu, Id)
	currentPed = Config.Dialogs[Id].Ped.ped
	currentDialogId = Id
	local buttonsTable = {}
	for k, v in pairs(Buttons) do
		table.insert(buttonsTable, {
			id = k,
			label = v.label,
			systemAnswer = {type = v.systemAnswer.type, text = v.systemAnswer.text, enable = v.systemAnswer.enable},
			playerAnswer = {text = v.playerAnswer.text, enable = v.playerAnswer.enable},
			maxClick = v.maxClick
		})
	end
	table.sort(buttonsTable, function(a, b) return a.id < b.id end)
	if AutoMessageEnabled then
		SendNUIMessage({
			action = "openDialog",
			resourceName = GetCurrentResourceName(),
			menuData = Menu,
			buttons = buttonsTable,
			autoMessages = AutoMessages,
			menuAlign = Config.MenuAlign,
			showCam = not camSettings.showCam
		})
	else
		SendNUIMessage({
			action = "openDialog",
			resourceName = GetCurrentResourceName(),
			menuData = Menu,
			buttons = buttonsTable,
			menuAlign = Config.MenuAlign,
			showCam = not camSettings.showCam
		})
	end
	SetNuiFocus(true, true)
	dialogActive = true
	-- Camera Functions
	if camSettings.showCam then
		if DoesEntityExist(currentPed) then
			local px, py, pz = table.unpack(GetEntityCoords(currentPed, true))
			local x, y, z = px + GetEntityForwardX(currentPed) * 0.9, py + GetEntityForwardY(currentPed) * 0.9, pz + 0.52
			local rx = GetEntityRotation(currentPed, 2)
			camRotation = rx + vector3(0.0, 0.0, 181.0)
			cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", x, y, z, camRotation, GetGameplayCamFov())
			SetCamActive(cam, true)
			RenderScriptCams(true, true, 1000, 1, 1)
			Citizen.SetTimeout(500, function()
				while dialogActive and IsCamActive(cam) do
					Citizen.Wait(0)
					SetEntityLocallyInvisible(PlayerPedId())
				end
			end)
		end
	end
end

RegisterNUICallback('callback', function(data)
	if data.action == "nuiFocus" then
		SetNuiFocus(false, false)
		ClearFocus()
		RenderScriptCams(false, true, 1000, true, false)
		DestroyCam(cam, false)
		dialogActive = false
		SetEntityLocallyVisible(PlayerPedId())
	elseif data.action == "camera" then
		if data.state then
			local px, py, pz = table.unpack(GetEntityCoords(currentPed, true))
			local x, y, z = px + GetEntityForwardX(currentPed) * 0.9, py + GetEntityForwardY(currentPed) * 0.9, pz + 0.52
			local rx = GetEntityRotation(currentPed, 2)
			camRotation = rx + vector3(0.0, 0.0, 181.0)
			cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", x, y, z, camRotation, GetGameplayCamFov())
			SetCamActive(cam, true)
			RenderScriptCams(true, true, 1000, 1, 1)
			camSettings.showCam = true
			SetResourceKvp('camSettings_0r-npcdialog', json.encode(camSettings))
			Citizen.SetTimeout(500, function()
				while dialogActive and IsCamActive(cam) do
					Citizen.Wait(0)
					SetEntityLocallyInvisible(PlayerPedId())
				end
			end)
		else
			ClearFocus()
			RenderScriptCams(false, true, 1000, true, false)
			DestroyCam(cam, false)
			camSettings.showCam = false
			SetResourceKvp('camSettings_0r-npcdialog', json.encode(camSettings))
		end
	elseif data.action == "onClick" then
		Config.Dialogs[currentDialogId].Buttons[data.id].onClick()
	end
end)

AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end
    for k, v in pairs(Config.Dialogs) do
		if v.Ped.Enable then
			DeletePed(v.Ped.ped)
		end
	end
end)

function closeMenu()
	SetNuiFocus(false, false)
	ClearFocus()
	RenderScriptCams(false, true, 1000, true, false)
	DestroyCam(cam, false)
	dialogActive = false
	SetEntityLocallyVisible(PlayerPedId())
	SendNUIMessage({action = "closeMenu"})
end

exports('closeMenu', closeMenu)