local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
emP = Tunnel.getInterface("emp_taxista")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local emservico = false
local CoordenadaX = 896.48
local CoordenadaY = -177.45
local CoordenadaZ = 74.70

local payment = Config.ValorKM




RegisterNetEvent("global:loadJob")
AddEventHandler("global:loadJob",function()
	if emP.checkPermission() then
		emservico = true
		buscaPassageiro()
    end
end)
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- -- TRABALHAR
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- Citizen.CreateThread(function()
-- 	if emP.checkPermission() then
-- 		init()
--     end
-- end)

RegisterCommand("taxi", function(source, args, raw)
	if emP.checkPermission() then
		emservico = not emservico
		if emservico then
			buscaPassageiro()
		else
			cancelarPassageiros()
			TriggerEvent("Notify", "aviso", "Desativou a busca por passageiros americanos")
		end

	end
	
end)


-----------------------------------------------------------------------------------------------------------------------------------------
-- PASSAGEIRO
-----------------------------------------------------------------------------------------------------------------------------------------
local PassageiroAtual = nil
local PassageiroAtualBlip = nil 
local DestinationBlip = nil
local IsNearCustomer = false
local CustomerIsEnteringVehicle = false
local CustomerEnteredVehicle = false
local TargetCoords = nil
local distanciaTotal = 0.0

function cancelarPassageiros()

	RemoveBlip(PassageiroAtualBlip)
	if DoesEntityExist(PassageiroAtual) then
		TaskLeaveVehicle(PassageiroAtual,vehicle,262144)
		TaskWanderStandard(PassageiroAtual,10.0,10)
		Citizen.Wait(1100)
		SetVehicleDoorShut(vehicle,3,0)
		FreezeEntityPosition(vehicle,false)

		SetEntityAsNoLongerNeeded(PassageiroAtual)
		ClearPedTasks(PassageiroAtual)
	end
	PassageiroAtualBlip = nil
	PassageiroAtual = nil
end



function buscaPassageiro()

	Citizen.CreateThread(function()
		while emservico do
			Citizen.Wait(1000)
			if emP.checkPermission() then
				local playerPed = PlayerPedId()
				local vehicleModel = GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsIn(PlayerPedId())))
				
				if IsPedInAnyVehicle(playerPed,  false) and vehicleModel == "TAXI" then
					
					if PassageiroAtual == nil then
						
						if IsPedInAnyVehicle(playerPed,  false) then
							TriggerEvent("Notify","importante","Dirigindo em busca de <b>passageiros</b>")
				
							local waitUntil = GetGameTimer() + GetRandomIntInRange(30000,  45000)
					
							while emservico and waitUntil > GetGameTimer() do
								Citizen.Wait(0)
							end
				
							PassageiroAtual = GetRandomWalkingNPC()
								
							if PassageiroAtual ~= nil then
								PassageiroAtualBlip = AddBlipForEntity(PassageiroAtual)
					
								SetBlipAsFriendly(PassageiroAtualBlip, 1)
								SetBlipColour(PassageiroAtualBlip, 2)
								SetBlipCategory(PassageiroAtualBlip, 3)
								SetBlipRoute(PassageiroAtualBlip,  true)
					
								SetEntityAsMissionEntity(PassageiroAtual,  true, false)
								ClearPedTasksImmediately(PassageiroAtual)
								SetBlockingOfNonTemporaryEvents(PassageiroAtual, 1)
								
								local standTime = GetRandomIntInRange(60000,  180000)
								TaskStandStill(PassageiroAtual, standTime)
								TriggerEvent("Notify","sucesso","Você encontrou um passageiro, dirija até o destino")
				
							end
						end
					else
	
						if IsPedInAnyVehicle(playerPed,  false) then
							local vehicle          = GetVehiclePedIsIn(playerPed,  false)
							local playerCoords     = GetEntityCoords(playerPed)
							local customerCoords   = GetEntityCoords(PassageiroAtual)
							local customerDistance = GetDistanceBetweenCoords(playerCoords.x,  playerCoords.y,  playerCoords.z,  customerCoords.x,  customerCoords.y,  customerCoords.z)
					
							if IsPedSittingInVehicle(PassageiroAtual,  vehicle) then
								if CustomerEnteredVehicle then
									local targetDistance = GetDistanceBetweenCoords(playerCoords.x,  playerCoords.y,  playerCoords.z,  TargetCoords.x,  TargetCoords.y,  TargetCoords.z)
					
									if targetDistance <= 10.0 then
										payment = parseInt( payment * distanciaTotal )
										-- TaskLeaveVehicle(PassageiroAtual,  vehicle,  0)
						
										TriggerEvent("Notify","sucesso","Você chegou ao destino! Pagamento: $"..payment)
						
										-- TaskGoStraightToCoord(PassageiroAtual,  TargetCoords.x,  TargetCoords.y,  TargetCoords.z,  1.0,  -1,  0.0,  0.0)
										-- SetEntityAsMissionEntity(PassageiroAtual,  false, true)
						
										emP.checkPayment(payment)
										Citizen.Wait(3000)
										TaskLeaveVehicle(PassageiroAtual,vehicle,262144)
										TaskWanderStandard(PassageiroAtual,10.0,10)
										SetEntityAsNoLongerNeeded(PassageiroAtual)
										Citizen.Wait(1100)
										SetVehicleDoorShut(vehicle,3,0)
	
										RemoveBlip(DestinationBlip)
						
										PassageiroAtual           = nil
										PassageiroAtualBlip       = nil
										DestinationBlip           = nil
										IsNearCustomer            = false
										CustomerIsEnteringVehicle = false
										CustomerEnteredVehicle    = false
										TargetCoords              = nil
										distanciaTotal = 0.0			  
									end
					
								else
					
									time = 0
									payment = Config.ValorKM
	
									RemoveBlip(PassageiroAtualBlip)
									PassageiroAtualBlip = nil
									TargetCoords = Config.JobLocations[GetRandomIntInRange(1,  #Config.JobLocations)]
					
									if distanciaTotal == 0 then
										distanciaTotal = GetDistanceBetweenCoords(playerCoords.x,  playerCoords.y,  playerCoords.z,  TargetCoords.x,  TargetCoords.y,  TargetCoords.z, true) / 1000 
										if distanciaTotal > 5 then 
											distanciaTotal = 5
										end
									end
					
									local street = table.pack(GetStreetNameAtCoord(TargetCoords.x, TargetCoords.y, TargetCoords.z))
									local msg    = nil
					
									if street[2] ~= 0 and street[2] ~= nil then
									msg = string.format("~w~Leve me para ~y~ ".. GetStreetNameFromHashKey(street[1]).."~w~, perto de~y~ ".. GetStreetNameFromHashKey(street[2]))
									else
									msg = string.format("~w~Leve me para ~y~ ".. GetStreetNameFromHashKey(street[1]))
									end
					
									Msg(msg)
					
									DestinationBlip = AddBlipForCoord(TargetCoords.x, TargetCoords.y, TargetCoords.z)
					
									BeginTextCommandSetBlipName("STRING")
									AddTextComponentString(GetStreetNameFromHashKey(street[1]))
									EndTextCommandSetBlipName(blip)
					
									SetBlipRoute(DestinationBlip,  true)
					
									CustomerEnteredVehicle = true
					
								end
							else
								if IsPedFatallyInjured(PassageiroAtual) then
									TriggerEvent("Notify","negado","Seu passageiro está insconsciente. Procure por outro.")
						
									if DoesBlipExist(PassageiroAtualBlip) then
									RemoveBlip(PassageiroAtualBlip)
									end
						
									if DoesBlipExist(DestinationBlip) then
									RemoveBlip(DestinationBlip)
									end
						
									SetEntityAsMissionEntity(PassageiroAtual,  false, true)
						
									PassageiroAtual           = nil
									PassageiroAtualBlip       = nil
									DestinationBlip           = nil
									IsNearCustomer            = false
									CustomerIsEnteringVehicle = false
									CustomerEnteredVehicle    = false
									TargetCoords              = nil
						
								end
								-- AO PEGAR O PASSAGEIRO
								if not CustomerEnteredVehicle then
									local seat = 2
									if customerDistance <= 30.0 then
						
										if not IsNearCustomer then
											if not CustomerIsEnteringVehicle then
												TriggerEvent("Notify","importante","Você está perto do passageiro, aproximisse dele")
												CustomerIsEnteringVehicle = true
											end
											if GetEntitySpeed(playerPed) == 0 then
												ClearPedTasksImmediately(PassageiroAtual)
												seat = GetVehicleMaxNumberOfPassengers(vehicle)-1
												for i=4, 0, 1 do
													if IsVehicleSeatFree(vehicle,  seat) then
													seat = i
													break
													end
												end
												TaskEnterVehicle(PassageiroAtual,  vehicle,  -1,  seat,  1.0,  1)
												IsNearCustomer = true
											end
										end
									elseif customerDistance > 500 then
										cancelarPassageiros()
									end

						
								end
							end
						end
						
					end
				end
			end
		end
	end)

end


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


function GetPeds(ignoreList)
	local ignoreList = ignoreList or {}
	local peds       = {}

	for ped in EnumeratePeds() do
		local found = false

		for j=1, #ignoreList, 1 do
			if ignoreList[j] == ped then
				found = true
			end
		end

		if not found then
			table.insert(peds, ped)
		end
	end

	return peds
end

function GetRandomWalkingNPC()

	local search = {}
	local peds   = GetPeds()
  
	for i=1, #peds, 1 do
	  if IsPedHuman(peds[i]) and IsPedWalking(peds[i]) and not IsPedAPlayer(peds[i]) then
		table.insert(search, peds[i])
	  end
	end
  
	if #search > 0 then
	  return search[GetRandomIntInRange(1, #search)]
	end
  
	print('Using fallback code to find walking ped')
  
	for i=1, 250, 1 do
  
	  local ped = GetRandomPedAtCoord(0.0,  0.0,  0.0,  math.huge + 0.0,  math.huge + 0.0,  math.huge + 0.0,  26)
  
	  if DoesEntityExist(ped) and IsPedHuman(ped) and IsPedWalking(ped) and not IsPedAPlayer(ped) then
		table.insert(search, ped)
	  end
  
	end
  
	if #search > 0 then
	  return search[GetRandomIntInRange(1, #search)]
	end
  
end

function DrawSub(msg, time)
	ClearPrints()
	SetTextEntry_2("STRING")
	AddTextComponentString(msg)
	DrawSubtitleTimed(time, 1)
end

function Msg(msg) 
	SetNotificationTextEntry('STRING')
	AddTextComponentSubstringPlayerName(msg)
	DrawNotification(false, true)
end