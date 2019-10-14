local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- ARRAY
-----------------------------------------------------------------------------------------------------------------------------------------
local valores = {
--	{ item = "wbody|WEAPON_VINTAGEPISTOL", quantidade = 1, compra = 25000, venda = 12500 },
--	{ item = "wbody|WEAPON_PISTOL", quantidade = 1, compra = 30000, venda = 15000 },
--	{ item = "wbody|WEAPON_PISTOL_MK2", quantidade = 1, compra = 35000, venda = 17500 },
	{ item = "wbody|WEAPON_MUSKET", quantidade = 1, compra = 50000, venda = 25000 },
	{ item = "wbody|WEAPON_FLAREGUN", quantidade = 1, compra = 1000, venda = 500 },

--	{ item = "wammo|WEAPON_VINTAGEPISTOL", quantidade = 50, compra = 1000, venda = 500 },
--	{ item = "wammo|WEAPON_PISTOL", quantidade = 50, compra = 1250, venda = 625 },
--	{ item = "wammo|WEAPON_PISTOL_MK2", quantidade = 50, compra = 1500, venda = 750 },
	{ item = "wammo|WEAPON_MUSKET", quantidade = 50, compra = 5000, venda = 1500 },
	{ item = "wammo|WEAPON_FLAREGUN", quantidade = 10, compra = 1000, venda = 500 },

	{ item = "wbody|WEAPON_KNIFE", quantidade = 1, compra = 3150, venda = 1000 },
	{ item = "wbody|WEAPON_DAGGER", quantidade = 1, compra = 3300, venda = 1000 },
	{ item = "wbody|WEAPON_KNUCKLE", quantidade = 1, compra = 3500, venda = 1000 },
	{ item = "wbody|WEAPON_MACHETE", quantidade = 1, compra = 3700, venda = 1000 },
	{ item = "wbody|WEAPON_SWITCHBLADE", quantidade = 1, compra = 3600, venda = 1000 },
	{ item = "wbody|WEAPON_WRENCH", quantidade = 1, compra = 2400, venda = 1000 },
	{ item = "wbody|WEAPON_HAMMER", quantidade = 1, compra = 2800, venda = 1000 },
	{ item = "wbody|WEAPON_GOLFCLUB", quantidade = 1, compra = 2500, venda = 1000 },
	{ item = "wbody|WEAPON_CROWBAR", quantidade = 1, compra = 2200, venda = 1000 },
	{ item = "wbody|WEAPON_HATCHET", quantidade = 1, compra = 3900, venda = 1000 },
	{ item = "wbody|WEAPON_FLASHLIGHT", quantidade = 1, compra = 2000, venda = 1000 },
	{ item = "wbody|WEAPON_BAT", quantidade = 1, compra = 2700, venda = 1000 },
	{ item = "wbody|WEAPON_BOTTLE", quantidade = 1, compra = 2100, venda = 1000 },
	{ item = "wbody|WEAPON_BATTLEAXE", quantidade = 1, compra = 4000, venda = 1000 },
	{ item = "wbody|WEAPON_POOLCUE", quantidade = 1, compra = 3000, venda = 1000 },
	{ item = "wbody|WEAPON_STONE_HATCHET", quantidade = 1, compra = 3800, venda = 1500 },

	{ item = "wbody|GADGET_PARACHUTE", quantidade = 1, compra = 5000, venda = 500 },
	{ item = "wbody|WEAPON_FIREWORK", quantidade = 1, compra = 5000, venda = 0 },
	{ item = "wammo|WEAPON_FIREWORK", quantidade = 3, compra = 500, venda = 0 },
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- COMPRAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("armamentos-comprar")
AddEventHandler("armamentos-comprar",function(item)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if item == "colete" then
			if vRP.tryPayment(user_id,10000) then
				vRPclient.setArmour(source,100)
				TriggerClientEvent("Notify",source,"sucesso","Comprou <b>1x Colete</b> por <b>$10.000 dólares</b>.")
			else
				TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.")
			end
		else
			for k,v in pairs(valores) do
				if item == v.item then
					if vRP.getInventoryWeight(user_id)+vRP.getItemWeight(v.item)*v.quantidade <= vRP.getInventoryMaxWeight(user_id) then
						if vRP.tryPayment(user_id,parseInt(v.compra)) then
							vRP.giveInventoryItem(user_id,v.item,parseInt(v.quantidade))
							TriggerClientEvent("Notify",source,"sucesso","Comprou <b>"..parseInt(v.quantidade).."x "..vRP.getItemName(v.item).."</b> por <b>$"..vRP.format(parseInt(v.compra)).." dólares</b>.")
						else
							TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.")
						end
					else
						TriggerClientEvent("Notify",source,"negado","Espaço insuficiente.")
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VENDER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("armamentos-vender")
AddEventHandler("armamentos-vender",function(item)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		for k,v in pairs(valores) do
			if item == v.item then
				if vRP.tryGetInventoryItem(user_id,v.item,parseInt(v.quantidade)) then
					vRP.giveMoney(user_id,parseInt(v.venda))
					TriggerClientEvent("Notify",source,"sucesso","Vendeu <b>"..parseInt(v.quantidade).."x "..vRP.getItemName(v.item).."</b> por <b>$"..vRP.format(parseInt(v.venda)).." dólares</b>.")
				else
					TriggerClientEvent("Notify",source,"negado","Não possui <b>"..parseInt(v.quantidade).."x "..vRP.getItemName(v.item).."</b> em sua mochila.")
				end
			end
		end
	end
end)