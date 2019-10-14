local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- ARRAY
-----------------------------------------------------------------------------------------------------------------------------------------
local valores = {
	{ item = "relogioroubado", venda = 850 },
	{ item = "pulseiraroubada", venda = 550 },
	{ item = "anelroubado", venda = 550 },
	{ item = "colarroubado", venda = 750 },
	{ item = "brincoroubado", venda = 300 },
	{ item = "carregadorroubado", venda = 150 },
	{ item = "carteiraroubada", venda = 1000 },
	{ item = "tabletroubado", venda = 2500 },
	{ item = "sapatosroubado", venda = 150 },
	{ item = "maquiagemroubada", venda = 200 },
	{ item = "vibradorroubado", venda = 350 },
	{ item = "perfumeroubado", venda = 450 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- VENDER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("jewelry-vender")
AddEventHandler("jewelry-vender",function(item)
	local source = source
	local user_id = vRP.getUserId(source)
	local data = vRP.getUserDataTable(user_id)
	local quantidade = 0
	if data and data.inventory then
		for k,v in pairs(valores) do
			if item == v.item then
				for i,o in pairs(data.inventory) do
					if i == item then
						quantidade = o.amount
					end
				end
				if parseInt(quantidade) > 0 then
					if vRP.tryGetInventoryItem(user_id,v.item,quantidade) then
						vRP.giveInventoryItem(user_id,"dinheirosujo",parseInt(v.venda*quantidade))
						TriggerClientEvent("Notify",source,"sucesso","Vendeu <b>"..quantidade.."x "..vRP.getItemName(v.item).."</b> por <b>$"..vRP.format(parseInt(v.venda*quantidade)).." dólares</b>.")
					end
				else
					TriggerClientEvent("Notify",source,"negado","Não possui <b>"..vRP.getItemName(v.item).."s</b> em sua mochila.")
				end
			end
		end
	end
end)