local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")

func = {}
Tunnel.bindInterface("vrp_race",func)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local Races = {}
local InRace = false
local RaceId = 0
local ShowCountDown = false
local RaceCount = 10
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		if Races ~= nil then
			local ped = PlayerPedId()
			local pos = GetEntityCoords(ped)
			if RaceId == 0 then
				for k,v in pairs(Races) do
					if Races[k] ~= nil then
						if GetDistanceBetweenCoords(pos.x,pos.y,pos.z,Races[k].startx,Races[k].starty,Races[k].startz,true) <= 15.0 and IsPedInAnyVehicle(PlayerPedId()) and not Races[k].started then
							DrawText3D(Races[k].startx,Races[k].starty,Races[k].startz,"~g~E ~w~  PARTICIPAR POR $~g~"..Races[k].amount)
							if IsControlJustReleased(0,38) then
								TriggerServerEvent("vrp_race:JoinRace",k)
							end
						end
					end
				end
			end

			if RaceId ~= 0 and not InRace then
				if GetDistanceBetweenCoords(pos.x,pos.y,pos.z,Races[RaceId].startx,Races[RaceId].starty,Races[RaceId].startz,true) <= 15.0 and not Races[RaceId].started then
					DrawText3D(Races[RaceId].startx,Races[RaceId].starty,Races[RaceId].startz,"~w~AGUARDE...")
				end
			end

			if RaceId ~= 0 and InRace then
				if GetDistanceBetweenCoords(pos.x,pos.y,pos.z,Races[RaceId].endx,Races[RaceId].endy,pos.z,true) <= 500.0 and Races[RaceId].started then
					DrawText3D(Races[RaceId].endx,Races[RaceId].endy,pos.z+1.05,"~w~CHEGADA")
					if GetDistanceBetweenCoords(pos.x,pos.y,pos.z,Races[RaceId].endx,Races[RaceId].endy,pos.z,true) <= 15.0 and IsPedInAnyVehicle(PlayerPedId()) then
						TriggerServerEvent("vrp_race:RaceWon",RaceId)
						InRace = false
					end
				end
			end

			if ShowCountDown then
				if GetDistanceBetweenCoords(pos.x,pos.y,pos.z,Races[RaceId].startx,Races[RaceId].starty,Races[RaceId].startz,true) <= 15.0 and Races[RaceId].started then
					DrawText3D(Races[RaceId].startx,Races[RaceId].starty,Races[RaceId].startz,"INICIANDO EM ~g~"..RaceCount.." ~w~SEGUNDOS")
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STARTRACE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('vrp_race:StartRace')
AddEventHandler('vrp_race:StartRace',function(race)
	if RaceId ~= 0 and RaceId == race then
		SetNewWaypoint(Races[RaceId].endx,Races[RaceId].endy)
		InRace = true
		RaceCountDown()
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RACEDONE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('vrp_race:RaceDone')
AddEventHandler('vrp_race:RaceDone',function(race,nome,sobrenome)
	if RaceId ~= 0 and RaceId == race then
		RaceId = 0
		InRace = false
		PlaySoundFrontend(-1,"RACE_PLACED","HUD_AWARDS",false)
		TriggerEvent("Notify","importante","O vencedor da corrida foi <b>"..nome.." "..sobrenome.."</b>.",10000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STOPRACE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('vrp_race:StopRace')
AddEventHandler('vrp_race:StopRace',function()
	RaceId = 0
	InRace = false
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CREATERACE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('vrp_race:CreateRace')
AddEventHandler('vrp_race:CreateRace',function(amount,waypoint)
	local pos = GetEntityCoords(PlayerPedId())
	local x2,y2,z2 = table.unpack(Citizen.InvokeNative(0xFA7C7F0AADF25D09,waypoint,Citizen.ReturnResultAnyway(),Citizen.ResultAsVector()))
	unusedBool,groundZ = GetGroundZFor_3dCoord(x2,y2,99999.0,1)
	if GetDistanceBetweenCoords(pos.x,pos.y,pos.z,x2,y2,groundZ,true) >= 50.1 then
		local race = { creator = nil, started = false, startx = pos.x, starty = pos.y, startz = pos.z, endx = x2, endy = y2, endz = groundZ, amount = amount, pot = amount, joined = {} }
		TriggerServerEvent("vrp_race:NewRace",race)
	else
		TriggerEvent("Notify","aviso","Escolha um destino mais distante da largada.",10000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETRACE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('vrp_race:SetRace')
AddEventHandler('vrp_race:SetRace',function(RaceTable)
	Races = RaceTable
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETRACEID
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('vrp_race:SetRaceId')
AddEventHandler('vrp_race:SetRaceId',function(race)
	RaceId = race
	SetNewWaypoint(Races[RaceId].endx,Races[RaceId].endy)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RACECOUNTDOWN
-----------------------------------------------------------------------------------------------------------------------------------------
function RaceCountDown()
	ShowCountDown = true
	while RaceCount ~= 0 do
		local pos = GetEntityCoords(PlayerPedId())
		FreezeEntityPosition(GetVehiclePedIsIn(PlayerPedId()),true)
		PlaySound(-1,"slow","SHORT_PLAYER_SWITCH_SOUND_SET",0,0,1)
		Citizen.Wait(1000)
		RaceCount = RaceCount - 1
	end
	ShowCountDown = false
	RaceCount = 10
	FreezeEntityPosition(GetVehiclePedIsIn(PlayerPedId()),false)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRAWTEXT3D
-----------------------------------------------------------------------------------------------------------------------------------------
function DrawText3D(x,y,z,text)
	local onScreen,_x,_y = World3dToScreen2d(x,y,z)
	SetTextFont(4)
	SetTextScale(0.35,0.35)
	SetTextColour(255,255,255,150)
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x,_y)
	local factor = (string.len(text))/370
	DrawRect(_x,_y+0.0125,0.01+factor,0.03,0,0,0,80)
end

function func.getWaypoint()
	return GetFirstBlipInfoId(8)
end