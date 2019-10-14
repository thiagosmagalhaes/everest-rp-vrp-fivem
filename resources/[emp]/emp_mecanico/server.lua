local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
emP = {}
Tunnel.bindInterface("emp_mecanico",emP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
function emP.checkPermission()
	local source = source
	local user_id = vRP.getUserId(source)
	return vRP.hasPermission(user_id,"mecanico.permissao")
end

function emP.checkPayment()
	local source = source
	local user_id = vRP.getUserId(source)
	local qtd = math.random(1, 3)
	if user_id then
		if vRP.tryGetInventoryItem(user_id,"ferramenta",qtd) then
			vRP.giveMoney(user_id,math.random(150,200)*qtd)
			return true
		else
			TriggerClientEvent("Notify",source,"aviso","Você precisa de <b>"..qtd.."x Ferramenta</b>.")
		end
	end
end