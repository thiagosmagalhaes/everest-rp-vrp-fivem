-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
local idgens = Tools.newIDGenerator()
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONEXÃO
-----------------------------------------------------------------------------------------------------------------------------------------
src = {}
Tunnel.bindInterface("vrp_robnpcs",src)
vCLIENT = Tunnel.getInterface("vrp_robnpcs")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local pedlist = {}
local blips = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PEDLIST
-----------------------------------------------------------------------------------------------------------------------------------------
function src.checkPedlist(npc)
	if pedlist[npc] then
		return true
	else
		return false
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PRESSEDPEDLIST
-----------------------------------------------------------------------------------------------------------------------------------------
function src.pressedPedlist(npc)
	pedlist[npc] = true
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMLIST
-----------------------------------------------------------------------------------------------------------------------------------------
local itemlist = {
	[1] = { ['index'] = "dinheirosujo", ['qtd'] = 1, ['name'] = "Dólares" },
	[2] = { ['index'] = "relogioroubado", ['qtd'] = 1, ['name'] = "Relógio" },
	[3] = { ['index'] = "pulseiraroubada", ['qtd'] = 1, ['name'] = "Pulseira" },
	[4] = { ['index'] = "anelroubado", ['qtd'] = 1, ['name'] = "Anel" },
	[5] = { ['index'] = "colarroubado", ['qtd'] = 1, ['name'] = "Colar" },
	[6] = { ['index'] = "brincoroubado", ['qtd'] = 2, ['name'] = "Brincos" },
	[7] = { ['index'] = "carteiraroubada", ['qtd'] = 1, ['name'] = "Carteira" },
	[8] = { ['index'] = "tabletroubado", ['qtd'] = 1, ['name'] = "Tablet" },
	[8] = { ['index'] = "vodka", ['qtd'] = 1, ['name'] = "Vodka" },
	[8] = { ['index'] = "cerveja", ['qtd'] = 1, ['name'] = "Cerveja" },
	[8] = { ['index'] = "celular", ['qtd'] = 1, ['name'] = "iPhone" },
	[8] = { ['index'] = "maconha", ['qtd'] = 1, ['name'] = "Maconha" },
	[8] = { ['index'] = "metanfetamina", ['qtd'] = 1, ['name'] = "Metanfetamina" },
	[8] = { ['index'] = "cocaina", ['qtd'] = 1, ['name'] = "Cocaina" },
}

function src.checkPolice()
	local policia = vRP.getUsersByPermission("policia.permissao")
	return #policia
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKPAYMENT
-----------------------------------------------------------------------------------------------------------------------------------------
function src.checkPayment()
	local source = source
	local user_id = vRP.getUserId(source)
	local x,y,z = vRPclient.getPosition(source)
	if user_id then
		local randlist = math.random(100)
		if randlist >= 40 and randlist <= 89 then
			local randitem = math.random(#itemlist)

			local qtd = itemlist[randitem].qtd
			if itemlist[randitem].index == "dinheirosujo" then
				qtd = math.random(100,300)
			end

			vRP.giveInventoryItem(user_id,itemlist[randitem].index,qtd)

			TriggerClientEvent("Notify",source,"sucesso","Você recebeu "..itemlist[randitem].qtd.."x <b>"..itemlist[randitem].name.."</b>.",8000)
		elseif randlist >= 90 then
			-- TriggerClientEvent("Notify",source,"aviso","A policia foi acionada.",8000)
			TriggerEvent("global:avisarPolicia", "Recebemos uma denuncia de roubo, verifique o ocorrido.",x,y,z, 1)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PEDRESET
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1200000)
		pedlist = {}
	end
end)