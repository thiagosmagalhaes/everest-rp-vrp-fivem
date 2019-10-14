local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
emP = {}
Tunnel.bindInterface("emp_minerador",emP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local qtdIlegal = 0
local quantidade = {}
local random = 0
function emP.Quantidade()
	local source = source
	if quantidade[source] == nil then
		quantidade[source] = math.random(2, 3)
	end
end


local itemlist = {
	[1] = { ['name'] = "Minério de Diamante", ['index'] = "diamante" },
	[2] = { ['name'] = "Minério de Ouro", ['index'] = "ouro" },
	[3] = { ['name'] = "Minério de Bronze", ['index'] = "bronze" },
	[4] = { ['name'] = "Minério de Ferro", ['index'] = "ferro" },
	[5] = { ['name'] = "Minério de Rubi", ['index'] = "rubi" },
	-- [5] = { ['name'] = "Nitrato de Potássio", ['index'] = "potassio" },
	-- [6] = { ['name'] = "Minério de Esmeralda", ['index'] = "esmeralda" },
	-- [7] = { ['name'] = "Minério de Safira", ['index'] = "safira" },
	-- [8] = { ['name'] = "Minério de Topazio", ['index'] = "topazio" },
	-- [9] = { ['name'] = "Minério de Ametista", ['index'] = "ametista" }
}
local itemlistMafia = {
	[1] = { ['name'] = "Nitrato de Potássio", ['index'] = "potassio", min=3, max=5 },
	[2] = { ['name'] = "Minério de Ferro", ['index'] = "ferro", min=3, max=5 },
}

function emP.checkPermissionMafia()
	local source = source
	local user_id = vRP.getUserId(source)
	return vRP.hasPermission(user_id,"mafia.permissao") or vRP.hasPermission(user_id,"bloods.permissao")
end

function emP.checkWeight()
	emP.Quantidade()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		random = math.random(#itemlist)
		return vRP.getInventoryWeight(user_id)+vRP.getItemWeight(itemlist[random].index)*quantidade[source] <= vRP.getInventoryMaxWeight(user_id) 
	end   
end

function emP.checkWeightIlegal()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		random = math.random(#itemlistMafia)
		qtdIlegal = math.random(itemlistMafia[random].min, itemlistMafia[random].max)
	
		return vRP.getInventoryWeight(user_id)+vRP.getItemWeight(itemlistMafia[random].index)*qtdIlegal <= vRP.getInventoryMaxWeight(user_id) 
	end   
end

function emP.checkPayment()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if emP.checkPermissionMafia() then
			if emP.checkWeightIlegal() then
				vRP.giveInventoryItem(user_id,itemlistMafia[random].index,qtdIlegal)
				TriggerClientEvent("Notify",source,"sucesso","Encontrou <b>"..qtdIlegal.."x "..itemlistMafia[random].name.."</b>.",8000)
			else
				TriggerClientEvent("Notify",source,"aviso","Inventário cheio!",8000)
			end
		else
			if emP.checkWeight() then
				vRP.giveInventoryItem(user_id,itemlist[random].index,quantidade[source])
				TriggerClientEvent("Notify",source,"sucesso","Encontrou <b>"..quantidade[source].."x "..itemlist[random].name.."</b>.",8000)
				quantidade[source] = nil
			else
				TriggerClientEvent("Notify",source,"aviso","Inventário cheio!",8000)
			end
		end
		
	end
end