-- DEFAULT --
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP")

vrpscams = {}
Proxy.addInterface("vrpscams", vrpscams) -- comunicação entre resources
Tunnel.bindInterface("vrpscams", vrpscams) -- comunicação entre client <-> server

function vrpscams.checkIsHackerAndPay()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		-- if vRP.hasPermission({user_id,"hacker.hack"}) and vRP.tryPayment({user_id, 500}) then
		if vRP.hasPermission(user_id,"hacker.hack") or vRP.hasPermission(user_id,"policia.permissao") then
			return true
		end
	end
	return false
end

function vrpscams.checkPermission()
	local source = source
	local user_id = vRP.getUserId(source)
	return vRP.hasPermission(user_id,"policia.permissao")
end
