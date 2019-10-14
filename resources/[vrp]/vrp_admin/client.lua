local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- DELETAR VEICULO
-----------------------------------------------------------------------------------------------------------------------------------------
-- RegisterNetEvent('deletarveiculo')
-- AddEventHandler('deletarveiculo',function(vehicle)
-- 	TriggerServerEvent("vrp_adv_garages_id",VehToNet(vehicle),GetVehicleEngineHealth(vehicle),GetVehicleBodyHealth(vehicle),GetVehicleFuelLevel(vehicle))
-- 	TriggerServerEvent("trydeleteveh",VehToNet(vehicle))
-- end)
RegisterNetEvent("deletarveiculo")
AddEventHandler('deletarveiculo',function(distance)
	local vehicle = vRP.getNearestVehicle(distance)
	if IsEntityAVehicle(vehicle) then
		TriggerServerEvent("vrp_adv_garages_id",VehToNet(vehicle),GetVehicleEngineHealth(vehicle),GetVehicleBodyHealth(vehicle),GetVehicleFuelLevel(vehicle))
		TriggerServerEvent("trydeleteentity",VehToNet(vehicle))
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SYNCDELETEVEH
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("syncdeleteveh")
AddEventHandler("syncdeleteveh",function(index)
	Citizen.CreateThread(function()
		if NetworkDoesNetworkIdExist(index) then
			SetVehicleAsNoLongerNeeded(index)
			SetEntityAsMissionEntity(index,true,true)
			local v = NetToVeh(index)
			if DoesEntityExist(v) then
				SetVehicleHasBeenOwnedByPlayer(v,false)
				PlaceObjectOnGroundProperly(v)
				SetEntityAsNoLongerNeeded(v)
				SetEntityAsMissionEntity(v,true,true)
				DeleteVehicle(v)
			end
		end
	end)
end)


RegisterNetEvent("changeSkin")
AddEventHandler("changeSkin", function(Model)
	Model = GetHashKey(Model)
	if IsModelValid(Model) then
		if not HasModelLoaded(Model) then
			RequestModel(Model)
			while not HasModelLoaded(Model) do
				Citizen.Wait(0)
			end
		end
		
		SetPlayerModel(PlayerId(), Model)
		SetPedDefaultComponentVariation(PlayerPedId())
		
		SetModelAsNoLongerNeeded(Model)
	else
		SetNotificationTextEntry('STRING')
		AddTextComponentString('~r~Invalid Model!')
		DrawNotification(false, false)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SYNCDELETEPED
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("syncdeleteped")
AddEventHandler("syncdeleteped",function(index)
	Citizen.CreateThread(function()
		if NetworkDoesNetworkIdExist(index) then
			SetPedAsNoLongerNeeded(index)
			SetEntityAsMissionEntity(index,true,true)
			local v = NetToPed(index)
			if DoesEntityExist(v) then
				PlaceObjectOnGroundProperly(v)
				SetEntityAsNoLongerNeeded(v)
				SetEntityAsMissionEntity(v,true,true)
				DeletePed(v)
			end
		end
	end)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SYNCDELETEOBJ
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("syncdeleteobj")
AddEventHandler("syncdeleteobj",function(index)
	Citizen.CreateThread(function()

		if NetworkDoesNetworkIdExist(index) then
			SetEntityAsMissionEntity(index,true,true)
			SetObjectAsNoLongerNeeded(index)
			local v = NetToObj(index)
			if DoesEntityExist(v) then
				DetachEntity(v,false,false)
				PlaceObjectOnGroundProperly(v)
				SetEntityAsNoLongerNeeded(v)
				SetEntityAsMissionEntity(v,true,true)
				DeleteObject(v)
			end
		end
	end)
end)

RegisterNetEvent('syncdeleteentity')
AddEventHandler('syncdeleteentity',function(netid)
	if NetworkDoesNetworkIdExist(netid) then
		local v = NetToEnt(netid)
		if DoesEntityExist(v) then
			Citizen.InvokeNative(0xAD738C3085FE7E11,v,false,true)
			SetEntityAsNoLongerNeeded(Citizen.PointerValueIntInitialized(v))
			DeleteEntity(v)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------
-- cobject
-----------------------------------------------------------------------------------------------------------------------------------------
local cobject = nil
RegisterNetEvent('cobject')
AddEventHandler('cobject',function(objectname,nome)
	local coord = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1),0.0,1.0,-0.94)
	local prop = objectname
	local h = GetEntityHeading(GetPlayerPed(-1))
	if nome ~= "d" then
		cone = CreateObject(GetHashKey(prop),coord.x,coord.y,coord.z,true,true,true)
		PlaceObjectOnGroundProperly(cone)
		SetEntityHeading(cone,h)
		-- FreezeEntityPosition(cone,true)
	else
		if DoesObjectOfTypeExistAtCoords(coord.x,coord.y,coord.z,0.9,GetHashKey(prop),true) then
			cone = GetClosestObjectOfType(coord.x,coord.y,coord.z,0.9,GetHashKey(prop),false,false,false)
			SetEntityAsMissionEntity(cone,true,true)
			DeleteObject(cone)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LIMPAREA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("syncarea")
AddEventHandler("syncarea",function(x,y,z,r)
	Citizen.CreateThread(function()
		ClearAreaOfVehicles(x,y,z,r,false,false,false,false,false)
		ClearAreaOfEverything(x,y,z,r,false,false,false,false)
	end)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HASH VEICULO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("vehash")
AddEventHandler("vehash",function()
	local vehicle = vRP.getNearestVehicle(7)
	if IsEntityAVehicle(vehicle) then
		-- TriggerEvent('chatMessage',"ALERTA",{255,70,50},GetEntityModel(vehicle))
		vRP.prompt("Cordenadas:",GetEntityModel(vehicle))
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SPAWNAR VEICULO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('spawnarveiculo')
AddEventHandler('spawnarveiculo',function(name)
	local mhash = GetHashKey(name)
	while not HasModelLoaded(mhash) do
		RequestModel(mhash)
		Citizen.Wait(10)
	end

	if HasModelLoaded(mhash) then
		local ped = PlayerPedId()
		local nveh = CreateVehicle(mhash,GetEntityCoords(ped),GetEntityHeading(ped),true,false)

		SetVehicleOnGroundProperly(nveh)
		SetVehicleNumberPlateText(nveh,vRP.getRegistrationNumber())
		SetEntityAsMissionEntity(nveh,true,false) -- Torna a entidade especificada (ped, veículo ou objeto) persistente. Entidades persistentes não serão removidas automaticamente pelo mecanismo.
		TaskWarpPedIntoVehicle(ped,nveh,-1)

		SetModelAsNoLongerNeeded(mhash)

		--TriggerEvent("vehtuning", nveh)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TELEPORTAR PARA O LOCAL MARCADO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('tptoway')
AddEventHandler('tptoway',function()
	local ped = PlayerPedId()
	local veh = GetVehiclePedIsUsing(ped)
	if IsPedInAnyVehicle(ped) then
		ped = veh
    end

	local waypointBlip = GetFirstBlipInfoId(8)
	local x,y,z = table.unpack(Citizen.InvokeNative(0xFA7C7F0AADF25D09,waypointBlip,Citizen.ResultAsVector()))

	local ground
	local groundFound = false
	local groundCheckHeights = { 0.0,50.0,100.0,150.0,200.0,250.0,300.0,350.0,400.0,450.0,500.0,550.0,600.0,650.0,700.0,750.0,800.0,850.0,900.0,950.0,1000.0,1050.0,1100.0 }

	for i,height in ipairs(groundCheckHeights) do
		SetEntityCoordsNoOffset(ped,x,y,height,0,0,1)

		RequestCollisionAtCoord(x,y,z)
		while not HasCollisionLoadedAroundEntity(ped) do
			RequestCollisionAtCoord(x,y,z)
			Citizen.Wait(1)
		end
		Citizen.Wait(20)

		ground,z = GetGroundZFor_3dCoord(x,y,height)
		if ground then
			z = z + 1.0
			groundFound = true
			break;
		end
	end

	if not groundFound then
		z = 1200
		GiveDelayedWeaponToPed(PlayerPedId(),0xFBAB5776,1,0)
	end

	RequestCollisionAtCoord(x,y,z)
	while not HasCollisionLoadedAroundEntity(ped) do
		RequestCollisionAtCoord(x,y,z)
		Citizen.Wait(1)
	end

	SetEntityCoordsNoOffset(ped,x,y,z,0,0,1)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DELETAR NPCS MORTOS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('delnpcs')
AddEventHandler('delnpcs',function()
	local handle,ped = FindFirstPed()
	local finished = false
	repeat
		local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),GetEntityCoords(ped),true)
		if IsPedDeadOrDying(ped) and not IsPedAPlayer(ped) and distance < 8 then
			TriggerServerEvent("trydeleteped",PedToNet(ped))
			finished = true
		end
		finished,ped = FindNextPed(handle)
	until not finished
	EndFindPed(handle)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HEADING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("loadIPL")
AddEventHandler("loadIPL",function(IPL)
	RequestIpl(IPL)
	TriggerEvent("Notify", "sucesso","ADD")		
end)

RegisterNetEvent("unloadIPL")
AddEventHandler("unloadIPL",function(IPL)
	RemoveIpl(IPL)
	TriggerEvent("Notify", "sucesso","REMOVIDO")		
end)

RegisterCommand('anim',function(source,args,rawCommand)
	local player = PlayerPedId()
	request(args[1])
	TaskPlayAnim(player, args[1], args[2], 3.0, -1, -1, 50, 0, false, false, false)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HASH VEICULO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("vehtuning")
AddEventHandler("vehtuning",function(vehicle)
	local ped = PlayerPedId()
	if IsEntityAVehicle(vehicle) then
		SetVehicleModKit(vehicle,0)
		SetVehicleWheelType(vehicle,7)
		SetVehicleMod(vehicle,0,GetNumVehicleMods(vehicle,0)-1,false)
		SetVehicleMod(vehicle,1,GetNumVehicleMods(vehicle,1)-1,false)
		SetVehicleMod(vehicle,2,GetNumVehicleMods(vehicle,2)-1,false)
		SetVehicleMod(vehicle,3,GetNumVehicleMods(vehicle,3)-1,false)
		SetVehicleMod(vehicle,4,GetNumVehicleMods(vehicle,4)-1,false)
		SetVehicleMod(vehicle,5,GetNumVehicleMods(vehicle,5)-1,false)
		SetVehicleMod(vehicle,6,GetNumVehicleMods(vehicle,6)-1,false)
		SetVehicleMod(vehicle,7,GetNumVehicleMods(vehicle,7)-1,false)
		SetVehicleMod(vehicle,8,GetNumVehicleMods(vehicle,8)-1,false)
		SetVehicleMod(vehicle,9,GetNumVehicleMods(vehicle,9)-1,false)
		SetVehicleMod(vehicle,10,GetNumVehicleMods(vehicle,10)-1,false)
		SetVehicleMod(vehicle,11,GetNumVehicleMods(vehicle,11)-1,false)
		SetVehicleMod(vehicle,12,GetNumVehicleMods(vehicle,12)-1,false)
		SetVehicleMod(vehicle,13,GetNumVehicleMods(vehicle,13)-1,false)
		SetVehicleMod(vehicle,14,16,false)
		SetVehicleMod(vehicle,15,GetNumVehicleMods(vehicle,15)-2,false)
		SetVehicleMod(vehicle,16,GetNumVehicleMods(vehicle,16)-1,false)
		ToggleVehicleMod(vehicle,17,true)
		ToggleVehicleMod(vehicle,18,true)
		ToggleVehicleMod(vehicle,19,true)
		ToggleVehicleMod(vehicle,20,true)
		ToggleVehicleMod(vehicle,21,true)
		ToggleVehicleMod(vehicle,22,true)
		SetVehicleMod(vehicle,23,1,false)
		SetVehicleMod(vehicle,24,1,false)
		SetVehicleMod(vehicle,25,GetNumVehicleMods(vehicle,25)-1,false)
		SetVehicleMod(vehicle,27,GetNumVehicleMods(vehicle,27)-1,false)
		SetVehicleMod(vehicle,28,GetNumVehicleMods(vehicle,28)-1,false)
		SetVehicleMod(vehicle,30,GetNumVehicleMods(vehicle,30)-1,false)
		SetVehicleMod(vehicle,33,GetNumVehicleMods(vehicle,33)-1,false)
		SetVehicleMod(vehicle,34,GetNumVehicleMods(vehicle,34)-1,false)
		SetVehicleMod(vehicle,35,GetNumVehicleMods(vehicle,35)-1,false)
		SetVehicleMod(vehicle,38,GetNumVehicleMods(vehicle,38)-1,true)
		SetVehicleTyreSmokeColor(vehicle,0,0,127)
		SetVehicleWindowTint(vehicle,1)
		SetVehicleTyresCanBurst(vehicle,false)
		-- SetVehicleNumberPlateText(vehicle,"PREFEITURA")
		-- SetVehicleNumberPlateTextIndex(vehicle,5)
		-- SetVehicleModColor_1(vehicle,4,12,0)
		-- SetVehicleModColor_2(vehicle,4,12)
		-- SetVehicleColours(vehicle,12,12)
		-- SetVehicleExtraColours(vehicle,70,141)
		SetVehicleDirtLevel(vehicle, 0)
	end
end)

-- local radio = 0
-- local frequencia = 0
-- RegisterCommand("radio",function(source,args)
-- 	-- SetUserRadioControlEnabled(true)

	
-- 	if parseInt(args[1]) == 0 then
-- 		Citizen.InvokeNative(0xE036A705F989E049)
-- 		NetworkClearVoiceChannel()
-- 		NetworkSetTalkerProximity(2.5)
-- 		radio = 0
-- 	else
-- 		radio = parseInt(args[1])
-- 		frequencia = args[1]
-- 	end
	

	
-- 	while radio > 0 do
-- 		Citizen.Wait(1)
-- 		if radio > 0 then
-- 			NetworkSetVoiceChannel(4)
-- 			NetworkSetVoiceActive(true) 
-- 			NetworkSetTalkerProximity(0.0)
-- 		end
-- 		drawTxt("RADIO: ~b~"..args[1].."~w~",4,0.5,0.93,0.50,255,255,255,180)
-- 	end
-- end)

function drawTxt(text,font,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextScale(scale,scale)
	SetTextColour(r,g,b,a)
	SetTextOutline()
	SetTextCentre(1)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x,y)
end