-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONEXÃO
-----------------------------------------------------------------------------------------------------------------------------------------
src = {}
Tunnel.bindInterface("vrp_stockade",src)
vSERVER = Tunnel.getInterface("vrp_stockade")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local pos = 0
local nveh = nil
local pveh01 = nil
local pveh02 = nil
local bomba = nil
local CoordenadaX = 1275.45
local CoordenadaY = -1710.53
local CoordenadaZ = 54.77
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCS  
-----------------------------------------------------------------------------------------------------------------------------------------
local locs = {
	[1] = { ['x'] = -1220.72, ['y'] = -316.61, ['z'] = 37.62, ['x2'] = 883.82, ['y2'] = -2382.88, ['z2'] = 28.05, ['h'] = 297.05, ['lugar'] = "2/8" },
	[2] = { ['x'] = -345.50, ['y'] = -27.71, ['z'] = 47.49, ['x2'] = 883.82, ['y2'] = -2382.88, ['z2'] = 28.05, ['h'] = 248.95, ['lugar'] = "6/8" },
	[3] = { ['x'] = 225.70, ['y'] = 211.13, ['z'] = 105.54, ['x2'] = 883.82, ['y2'] = -2382.88, ['z2'] = 28.05, ['h'] = 121.03, ['lugar'] = "7/8" },
	[4] = { ['x'] = 294.00, ['y'] = -276.88, ['z'] = 53.98, ['x2'] = 883.82, ['y2'] = -2382.88, ['z2'] = 28.05, ['h'] = 336.96, ['lugar'] = "5/8" },
	[5] = { ['x'] = 130.16, ['y'] = -1034.55, ['z'] = 29.43, ['x2'] = 883.82, ['y2'] = -2382.88, ['z2'] = 28.05, ['h'] = 336.13, ['lugar'] = "1/8" }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- HACKEAR
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		local ped = PlayerPedId()
		local x,y,z = table.unpack(GetEntityCoords(ped))
		local bowz,cdz = GetGroundZFor_3dCoord(CoordenadaX,CoordenadaY,CoordenadaZ)
		local distance = GetDistanceBetweenCoords(CoordenadaX,CoordenadaY,cdz,x,y,z,true)

		if distance <= 30.0 then
			DrawMarker(23,CoordenadaX,CoordenadaY,CoordenadaZ-0.97,0,0,0,0,0,0,1.0,1.0,0.5,240,200,80,20,0,0,0,0)
			if distance <= 1.2 then
				drawTxt("PRESSIONE  ~b~E~w~  PARA HACKEAR",4,0.5,0.93,0.50,255,255,255,180)
				if IsControlJustPressed(0,38) and vSERVER.checkTimers() then
					TriggerEvent("mhacking:show")
					TriggerEvent("mhacking:start",6,25,mycallback)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HACKEAR
-----------------------------------------------------------------------------------------------------------------------------------------
function mycallback(success,time)
	if success then
		TriggerEvent("mhacking:hide")
		vSERVER.checkStockade()
	else
		TriggerEvent("mhacking:hide")
		vSERVER.resetTimer()
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STARTSTOCKADE
-----------------------------------------------------------------------------------------------------------------------------------------
function src.startStockade()
	pos = math.random(#locs)
	src.spawnStockade(locs[pos].x,locs[pos].y,locs[pos].z,locs[pos].x2,locs[pos].y2,locs[pos].z2,locs[pos].h)
	TriggerEvent("Notify","aviso","Hackeado com sucesso, o carro forte está saindo do Banco <b>"..locs[pos].lugar.."</b>.",8000)
		vSERVER.removeItem("pendrive32")
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SPAWNVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
function src.spawnStockade(x,y,z,x2,y2,z2,h)

	local vhash = GetHashKey("stockade")
	while not HasModelLoaded(vhash) do
		RequestModel(vhash)
		Citizen.Wait(10)
	end

	local phash = GetHashKey("s_m_m_security_01")
	while not HasModelLoaded(phash) do
		RequestModel(phash)
		Citizen.Wait(10)
	end

	local armas = {
		"WEAPON_SMG",
		"WEAPON_CARBINERIFLE",
		"WEAPON_CARBINERIFLE_MK2",
		"WEAPON_COMBATPDW",
		"weapon_assaultrifle",
		"weapon_pumpshotgun",
	}

	if HasModelLoaded(vhash) then
		nveh = CreateVehicle(vhash,x,y,z,h,true,false)
		pveh01 = CreatePedInsideVehicle(nveh,4,GetHashKey("s_m_m_security_01"),-1,true,false)
		pveh02 = CreatePedInsideVehicle(nveh,4,GetHashKey("s_m_m_security_01"),0,true,false)
		setPedPropertys(pveh01,armas[math.random(1,#armas)])
		setPedPropertys(pveh02,armas[math.random(1,#armas)])

		SetEntityAsMissionEntity(nveh,  true, false)
		SetEntityAsMissionEntity(pveh01,  true, false)
		SetEntityAsMissionEntity(pveh02,  true, false)

		SetVehicleOnGroundProperly(nveh)
		TaskVehicleDriveToCoordLongrange(pveh01,nveh,x2,y2,z2,10.0,447,1.0)
		SetModelAsNoLongerNeeded(vhash)
	end
end

function setPedPropertys(npc,weapon)
	SetPedShootRate(npc,700)
	SetPedAlertness(npc,100)
	SetPedAccuracy(npc,100)
	SetPedCanSwitchWeapon(npc,true)
	SetEntityHealth(npc,400)
	SetPedFleeAttributes(npc,0,0)
	SetPedCombatAttributes(npc,46,true)
	SetPedCombatAbility(npc,2)
	SetPedCombatRange(npc,50)
	SetPedPathAvoidFire(npc,1)
	SetPedPathCanUseLadders(npc,1)
	SetPedPathCanDropFromHeight(npc,1)
	SetPedPathPreferToAvoidWater(npc,1)
	SetPedGeneratesDeadBodyEvents(npc,1)
	GiveWeaponToPed(npc,GetHashKey(weapon),5000,true,true)
	SetPedRelationshipGroupHash(npc,GetHashKey("security_guard"))
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- START
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	
	while true do
		Citizen.Wait(1000)
		if DoesEntityExist(nveh) and DoesEntityExist(pveh01) and DoesEntityExist(pveh02) then
			local x,y,z = table.unpack(GetEntityCoords(nveh))
			local x2,y2,z2 = table.unpack(GetOffsetFromEntityInWorldCoords(nveh,0.0,-4.0,0.5))
			local bowz,cdz = GetGroundZFor_3dCoord(locs[pos].x2,locs[pos].y2,locs[pos].z2)
			local distance = GetDistanceBetweenCoords(locs[pos].x2,locs[pos].y2,cdz,x,y,z,true)

			if IsPedDeadOrDying(pveh01) and IsPedDeadOrDying(pveh02) and not DoesEntityExist(bomba) then
				vSERVER.markOcorrency(x,y,z)
				bomba = CreateObject(GetHashKey("prop_c4_final_green"),x,y,z,true,false,false)
				AttachEntityToEntity(bomba,nveh,GetEntityBoneIndexByName(nveh,"door_dside_r"),0.78,0.0,0.0,180.0,-90.0,180.0,false,false,false,true,2,true)
				SetTimeout(20000,function()
					TriggerServerEvent("trydeleteped",PedToNet(pveh01))
					TriggerServerEvent("trydeleteped",PedToNet(pveh02))
					TriggerServerEvent("trydeleteobj",ObjToNet(bomba))
					SetVehicleDoorOpen(nveh,2,0,0)
					SetVehicleDoorOpen(nveh,3,0,0)
					NetworkExplodeVehicle(nveh,1,1,1)
					vSERVER.dropSystem(x2,y2,z2)

					SetEntityAsNoLongerNeeded(pveh01)
					SetEntityAsNoLongerNeeded(pveh02)
					-- SetEntityAsNoLongerNeeded(nveh)

					nveh = nil
					pveh01 = nil
					pveh02 = nil
					bomba = nil
				end)
			end

			if distance <= 10.0 then
				TriggerServerEvent("trydeleteveh",VehToNet(nveh))
				TriggerServerEvent("trydeleteped",PedToNet(pveh01))
				TriggerServerEvent("trydeleteped",PedToNet(pveh02))
				nveh = nil
					pveh01 = nil
					pveh02 = nil
					bomba = nil
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
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