local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- ARRAY
-----------------------------------------------------------------------------------------------------------------------------------------
local valores = {
	{ item = "isca", quantidade = 10, compra = 500, venda = 250 },
	{ item = "garrafavazia", quantidade = 1, compra = 15, venda = 7 },
	{ item = "ferramenta", quantidade = 1, compra = 20, venda = 10 },

	{ item = "mochila", quantidade = 1, compra = 10000, venda = 5000 },
	{ item = "alianca", quantidade = 1, compra = 300, venda = 150 },

	{ item = "cerveja", quantidade = 3, compra = 18, venda = 9 },
	{ item = "tequila", quantidade = 3, compra = 30, venda = 15 },
	{ item = "vodka", quantidade = 3, compra = 48, venda = 24 },
	{ item = "whisky", quantidade = 3, compra = 60, venda = 30 },
	{ item = "conhaque", quantidade = 3, compra = 72, venda = 36 },
	{ item = "absinto", quantidade = 3, compra = 90, venda = 45 },
	{ item = "energetico", quantidade = 3, compra = 150, venda = 75 },
	{ item = "celular", quantidade = 1, compra = 1500, venda = 500 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- COMPRAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("departamento-comprar")
AddEventHandler("departamento-comprar",function(item)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
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
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VENDER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("departamento-vender")
AddEventHandler("departamento-vender",function(item)
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