local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- ARRAY
-----------------------------------------------------------------------------------------------------------------------------------------
local valores = {
	["bronze2"] = { venda = 150 },
	["ferro2"] = { venda = 150 },
	["ouro2"] = { venda = 250 },
	["rubi2"] = { venda = 300 },
	-- ["esmeralda2"] = { venda = 930 },
	-- ["safira2"] = { venda = 820 },
	["diamante2"] = { venda = 300 },
	-- ["topazio2"] = { venda = 930 },
	-- ["ametista2"] = { venda = 830 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- CRAFTING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("minerador-crafting")
AddEventHandler("minerador-crafting",function(item)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.tryGetInventoryItem(user_id,item,3) then
			vRP.giveInventoryItem(user_id,item.."2",1)
			TriggerClientEvent("Notify",source,"sucesso","Forjou <b>3x "..vRP.getItemName(item).."</b> em <b>1x "..vRP.getItemName(item.."2").."</b>.")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VENDER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("minerador-vender")
AddEventHandler("minerador-vender",function(item)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.tryGetInventoryItem(user_id,item,1) then
			TriggerClientEvent("Notify",source,"sucesso","Vendeu <b>1x "..vRP.getItemName(item).."</b> por <b>$"..parseInt(valores[item].venda).."x dólares</b>.")
			vRP.giveMoney(user_id,valores[item].venda)
		end
	end
end)