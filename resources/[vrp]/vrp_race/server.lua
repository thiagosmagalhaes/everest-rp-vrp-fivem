local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
func = Tunnel.getInterface("vrp_race")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local Races = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- NEWRACE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent('vrp_race:NewRace')
AddEventHandler('vrp_race:NewRace',function(racetable)
	local source = source
	local raceid = math.random(1000,9999)
	local user_id = vRP.getUserId(source)
	if user_id then
		Races[raceid] = racetable
		Races[raceid].creator = GetPlayerIdentifiers(source)[1]
		table.insert(Races[raceid].joined,GetPlayerIdentifiers(source)[1])
		TriggerClientEvent('vrp_race:SetRace',-1,Races)
		TriggerClientEvent('vrp_race:SetRaceId',source,raceid)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RACEWON
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent('vrp_race:RaceWon')
AddEventHandler('vrp_race:RaceWon',function(raceid)
	if Races[raceid] ~= nil then
		local source = source
		local user_id = vRP.getUserId(source)
		local identity = vRP.getUserIdentity(user_id)
		if user_id then
			vRP.giveMoney(user_id,Races[raceid].pot)
			TriggerClientEvent("Notify",source,"sucesso","Recebeu <b>$"..vRP.format(parseInt(Races[raceid].pot)).." dólares</b> na premiação.",10000)
			TriggerClientEvent('vrp_race:SetRace',-1,Races)
			TriggerClientEvent('vrp_race:RaceDone',-1,raceid,identity.name,identity.firstname)
			Races[raceid] = nil
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- JOINRACE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent('vrp_race:JoinRace')
AddEventHandler('vrp_race:JoinRace',function(raceid)
	local source = source
	local user_id = vRP.getUserId(source)
	local nuser_id = GetPlayerIdentifiers(Races[raceid].creator)
	if user_id and nuser_id ~= nil then
		if vRP.tryFullPayment(user_id,parseInt(Races[raceid].amount)) then
			Races[raceid].pot = Races[raceid].pot + Races[raceid].amount
			table.insert(Races[raceid].joined,GetPlayerIdentifiers(source)[1])
			TriggerClientEvent('vrp_race:SetRace',-1,Races)
			TriggerClientEvent('vrp_race:SetRaceId',source,raceid)
		else
			TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.",10000)
		end
	else
		Races[raceid] = {}
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RACE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('race',function(source,args,rawCommand)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if GetJoinRace(GetPlayerIdentifiers(source)[1]) == 0 and parseInt(args[1]) > 0 then
			local waypoint = func.getWaypoint(source)
			if waypoint then
				if vRP.tryFullPayment(user_id,parseInt(args[1])) then
					TriggerClientEvent('vrp_race:CreateRace',source,parseInt(args[1]),waypoint)
				else
					TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.",10000)
				end
			else
				TriggerClientEvent("Notify",source,"aviso","Efetue uma marcação no <b>GPS</b> antes de iniciar uma corrida.",10000)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STOPRACE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('stoprace',function(source,args,rawCommand)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		for key,race in pairs(Races) do
			if Races[key] ~= nil and Races[key].creator and not Races[key].started then
				for _,v in pairs(Races[key].joined) do
					TriggerClientEvent('vrp_race:StopRace',source)
					RemoveFromRace(v)
				end
				Races[key] = nil
			end
		end
		TriggerClientEvent('vrp_race:SetRace',-1,Races)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STARTRACE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('startrace',function(source,args,rawCommand)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local raceid = GetCreatedRace(GetPlayerIdentifiers(source)[1])
		if raceid ~= 0 then
			Races[raceid].started = true
			TriggerClientEvent('vrp_race:SetRace',-1,Races)
			TriggerClientEvent("vrp_race:StartRace",-1,raceid)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVEFROMRACE
-----------------------------------------------------------------------------------------------------------------------------------------
function RemoveFromRace(source)
	for k,v in pairs(Races) do
		if Races[k] ~= nil and not Races[k].started then
			for k2,v2 in pairs(Races[k].joined) do
				if v2 == source then
					table.remove(Races[k].joined,k2)
				end
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETJOINRACE
-----------------------------------------------------------------------------------------------------------------------------------------
function GetJoinRace(source)
	for k,v in pairs(Races) do
		if Races[k] ~= nil and not Races[k].started then
			for k2,v2 in pairs(Races[k].joined) do
				if v2 == source then
					return k
				end
			end
		end
	end
	return 0
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETJOINRACE
-----------------------------------------------------------------------------------------------------------------------------------------
function GetCreatedRace(source)
	for k,v in pairs(Races) do
		if Races[k] ~= nil and Races[k].creator == source and not Races[k].started then
			return k
		end
	end
	return 0
end