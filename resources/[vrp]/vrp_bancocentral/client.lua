local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
func = Tunnel.getInterface("vrp_bancocentral")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local andamento = false
local segundos = Config.tempoRoubo*60
local listPaineis = Config.listPaineis
---------------------------------------------------------
-- HACKEAR
--------------------------------------------------------
local menorDistancia = 0
local portaDestrancada = 0

local item = {}

Citizen.CreateThread(function()

	-- RESETA AS PORTAS
	TriggerEvent("vrp_bancocentral:resetBanco")

	local loop = 1
	while true do
		Citizen.Wait(loop)
		-- CONTROLE DE TREAD
		if menorDistancia < 30 then
			loop = 1
		else
			loop = 10000
		end
		menorDistancia = 100
		-- FIM
		
		for i, porta in pairs(listPaineis) do
			local PlayerPos = GetEntityCoords(PlayerPedId(), true)
			local distancia = Vdist(PlayerPos.x, PlayerPos.y, PlayerPos.z, porta.x, porta.y, porta.z)
			
			if distancia < menorDistancia then menorDistancia = distancia end
			if distancia <= 0.5 then
				drawTxt("PRESSIONE  ~b~E~w~  PARA HACKEAR", 4, 0.5, 0.93, 0.50, 255, 255, 255, 180)
				if IsControlJustPressed(0, 38) and func.isStatus() then
					if func.possuiItem(porta.item) >= porta.qtd then 
						portaDestrancada = i
                        vRP._playAnim(false, {
                            {"amb@prop_human_atm@male@idle_a", "idle_a"}
                        }, true)

						item = porta

                        TriggerEvent("mhacking:show")
                        TriggerEvent("mhacking:start", 6, 25, mycallback)
                    else
                        TriggerEvent("Notify","negado","Você precisa de "..porta.qtd.."x "..porta.name)
                    end
                end
			end
		end
	end
end)

function mycallback(success, time)
	-- TriggerEvent("vrp_sound:source",'alarm',0.7)
	
    if success then
        TriggerEvent("mhacking:hide")
        vRP._stopAnim(false)
		func.removeItem(item.item, item.qtd)
		TriggerServerEvent("vrp_bancocentral:openDoor", portaDestrancada)
		func.ChamaPolicia(261.81, 223.16, 106.28)
    else
        TriggerEvent("mhacking:hide")
		vRP._stopAnim(false)
	end
	portaDestrancada = 0
end

RegisterNetEvent("vrp_bancocentral:openDoorClient")
AddEventHandler("vrp_bancocentral:openDoorClient", function(index)
	local VaultDoor = GetClosestObjectOfType(listPaineis[index].x, listPaineis[index].y, listPaineis[index].z, listPaineis[index].r, listPaineis[index].p, false, false, false)

	NetworkRequestControlOfEntity(VaultDoor)
	FreezeEntityPosition(VaultDoor, false)

	if listPaineis[index].p == 961976194 then
		local CurrentHeading = GetEntityHeading(VaultDoor)
		while round(CurrentHeading, 1) >= 10.0 do -- Open
			Citizen.Wait(1)
			SetEntityHeading(VaultDoor, round(CurrentHeading, 1) - 0.1)
			CurrentHeading = GetEntityHeading(VaultDoor)
		end
	end
end)

function round(num, numDecimalPlaces)
	local mult = 10^(numDecimalPlaces or 0)
	return math.floor(num * mult + 0.5) / mult
end



-----------------------------------------------------------------------------------------------------------------------------------------
-- INICIO/CANCELAR
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		local ped = PlayerPedId()
		local x,y,z = table.unpack(GetEntityCoords(ped))
		local distance = GetDistanceBetweenCoords(GetEntityCoords(ped), 265.83,213.77,101.68,true)
		if andamento then
			drawTxt("APERTE ~r~M~w~ PARA CANCELAR O ROUBO EM ANDAMENTO",4,0.5,0.91,0.35,255,255,255,80)
			drawTxt("RESTAM ~g~"..segundos.." SEGUNDOS ~w~PARA TERMINAR",4,0.5,0.93,0.50,255,255,255,180)
	
			if IsControlJustPressed(0,244) or GetEntityHealth(ped) <= 100 then
				andamento = false
				ClearPedTasks(ped)
				func.cancelRobbery()
				TriggerEvent('cancelando',false)
			end
		else
			if distance <= 1.2 then
				drawTxt("PRESSIONE  ~b~E~w~  PARA INICIAR O ROUBO",4,0.5,0.93,0.50,255,255,255,180)
				if IsControlJustPressed(0,38) and not IsPedInAnyVehicle(ped) then
					if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") or GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
						func.checkRobbery(1,265.83,213.77,101.68,251.05)
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INICIADO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("iniciandoroubobancocentral")
AddEventHandler("iniciandoroubobancocentral",function(x,y,z,secs,head)
	segundos = secs
	andamento = true
	SetEntityHeading(PlayerPedId(),head)
	SetEntityCoords(PlayerPedId(),x,y,z-1,false,false,false,false)
	TriggerEvent("global:getMochilaRoubo")
	SetCurrentPedWeapon(PlayerPedId(),GetHashKey("WEAPON_UNARMED"),true)
	TriggerEvent('cancelando',true)
end)

RegisterNetEvent("vrp_bancocentral:resetBanco")
AddEventHandler("vrp_bancocentral:resetBanco", function()
	for i, porta in pairs(listPaineis) do
		local VaultDoor = GetClosestObjectOfType(porta.x, porta.y, porta.z, porta.r, porta.p, false, false, false)

		NetworkRequestControlOfEntity(VaultDoor)
		if porta.p == 961976194 then
			FreezeEntityPosition(VaultDoor, false)
			SetEntityHeading(VaultDoor, 160.0)
		end
		FreezeEntityPosition(VaultDoor, true)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONTAGEM
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if andamento then
			segundos = segundos - 1
			if segundos <= 0 then
				andamento = false
				ClearPedTasks(PlayerPedId())
				TriggerEvent('cancelando',false)
			end
		end
	end
end)



