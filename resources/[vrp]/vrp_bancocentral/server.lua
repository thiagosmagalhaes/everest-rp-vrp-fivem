local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
local idgens = Tools.newIDGenerator()

func = {}
Tunnel.bindInterface("vrp_bancocentral",func)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local timers = 0
local recompensa = 0
local andamento = false
local dinheirosujo = {}
local totalPolicia = 6
local portas = {}

---------------------
-- INIT
---------------------
AddEventHandler("vRP:playerSpawn",function(user_id, source, first_spawn)
	SetTimeout(10000, function()
		for a, porta in pairs(portas) do
			if porta.status then
				TriggerClientEvent("vrp_bancofleeca:openDoorClient", source, porta.porta, porta.status)
			end
		end
	end)
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- HACKEAR
-----------------------------------------------------------------------------------------------------------------------------------------
function func.isStatus()
	local source = source
	local user_id = vRP.getUserId(source)
	local policia = vRP.getUsersByPermission("policia.permissao")
	if user_id then
		if #policia < totalPolicia then
			TriggerClientEvent("Notify",source,"aviso","Número insuficiente de policiais no momento para iniciar o roubo.")
			return false
		elseif (os.time()-timers) <= Config.tempoEntreRoubos*60*60 then
			TriggerClientEvent("Notify",source,"aviso","O cofre está vazio, aguarde <b>"..vRP.format(parseInt((Config.tempoEntreRoubos*60*60-(os.time()-timers))/60)).." minutos</b> até que os civis depositem dinheiro.")
			return false
		else
			return true
		end
	end
end

function func.ChamaPolicia(x,y,x)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		
		if not andamento then
			andamento = true
			TriggerEvent("global:avisarPolicia", "O roubo começou no ^1Banco Central^0, dirija-se até o local e intercepte os assaltantes! ^9RESPEITE AS REGRAS!",x,y,z, 1)
			SetTimeout(5000, function()
				vRPclient.playSound(-1,"BASE_JUMP_PASSED","HUD_AWARDS")
				TriggerClientEvent('chatMessage',-1,"EVEREST",{255,0,0}, "^6UM ROUBO COMEÇOU NO BANCO CENTRAL! EVITE A LOCALIDADE!")
			end)
		end
	end
end

function func.possuiItem(item)
	local source = source
	local user_id = vRP.getUserId(source)
	return vRP.getInventoryItemAmount(user_id, item)
end

function func.removeItem(item, qtd)
	local source = source
	local user_id = vRP.getUserId(source)
	return vRP.tryGetInventoryItem(user_id,item,qtd)
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKROBBERY
-----------------------------------------------------------------------------------------------------------------------------------------
local tempoRoubo = Config.tempoRoubo*60
function func.checkRobbery(id,x,y,z,head)
	local source = source
	local user_id = vRP.getUserId(source)
	local policia = vRP.getUsersByPermission("policia.permissao")

	if user_id then
		-- if func.isStatus() then
		andamento = true
		timers = os.time()
		dinheirosujo = {}
		dinheirosujo[user_id] = tempoRoubo
		vRPclient.setStandBY(source,parseInt(700))
		recompensa = parseInt(math.random(1500000,1800000)/tempoRoubo)
		TriggerClientEvent('iniciandoroubobancocentral',source,x,y,z,tempoRoubo,head)
		vRPclient._playAnim(source,false,{{"anim@heists@ornate_bank@grab_cash_heels","grab"}},true)
		TriggerClientEvent("vrp_sound:source",source,'alarm',0.7)
		
		SetTimeout(tempoRoubo*1000,function()
			if andamento then
				andamento = false
				for l,w in pairs(policia) do
					local player = vRP.getUserSource(parseInt(w))
					if player then
						async(function()
							TriggerClientEvent('chatMessage',player,"911",{65,130,255},"O roubo terminou, os assaltantes estão correndo antes que vocês cheguem.")
						end)
					end
				end
			end
		end)

		SetTimeout(Config.tempoEntreRoubos*60*60*1000, function() -- RESETA O SISTEMA PARA NOVOS ROUBOS
			timers = 0
			recompensa = 0
			andamento = false
			dinheirosujo = {}
			portas = {}
			TriggerClientEvent("vrp_bancocentral:resetBanco", -1)
		end)

	end
end



RegisterServerEvent('vrp_bancocentral:openDoor')
AddEventHandler('vrp_bancocentral:openDoor',function(index)
	while portas do
		portas[index] = { porta = index, status = true}
		TriggerClientEvent("vrp_bancocentral:openDoorClient", -1, index)
		Citizen.Wait(5000)
	end
end)


-----------------------------------------------------------------------------------------------------------------------------------------
-- CANCELROBBERY
-----------------------------------------------------------------------------------------------------------------------------------------
function func.cancelRobbery()
	if andamento then
		andamento = false
		local policia = vRP.getUsersByPermission("policia.permissao")
		for l,w in pairs(policia) do
			local player = vRP.getUserSource(parseInt(w))
			if player then
				async(function()
					TriggerClientEvent('chatMessage',player,"911",{65,130,255},"O assaltante saiu correndo e deixou tudo para trás.")
				end)
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYMENTROBBERY
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if andamento then
			for k,v in pairs(dinheirosujo) do
				if v > 0 then
					dinheirosujo[k] = v - 1
					vRP._giveInventoryItem(k,"dinheirosujo",recompensa)
				end
			end
		end
	end
end)
