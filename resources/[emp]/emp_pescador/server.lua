local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
emP = {}
Tunnel.bindInterface("emp_pescador",emP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
local peixes = {
	[1] = { x = "dourado" },
	[2] = { x = "corvina" },
	[3] = { x = "salmao" },
	[4] = { x = "pacu" },
	[5] = { x = "pintado" },
	[6] = { x = "pirarucu" },
	[7] = { x = "tilapia" },
	[8] = { x = "tucunare" }
}

function emP.checkPayment()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("dourado") <= vRP.getInventoryMaxWeight(user_id) then
			if vRP.tryGetInventoryItem(user_id,"isca",1) then
				vRP.giveInventoryItem(user_id,peixes[math.random(8)].x,1)
				return true
			end
		end
	end
end