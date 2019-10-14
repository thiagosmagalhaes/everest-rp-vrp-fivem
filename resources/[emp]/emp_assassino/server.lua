local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")
local idgens = Tools.newIDGenerator()
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

emP = {}
Tunnel.bindInterface("emp_assassino",emP)

-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
function emP.checkPayment()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("orgao") <= vRP.getInventoryMaxWeight(user_id) then
			vRP.giveInventoryItem(user_id,"orgao",1)
			vRPclient.setStandBY(source,parseInt(30))
			return true
		end
	end
end

-- local blips = {}
local radiusBlips = {}
function emP.MarcarOcorrencia()
	local source = source
	local user_id = vRP.getUserId(source)
	local x,y,z = vRPclient.getPosition(source)
	if user_id then
		local soldado = vRP.getUsersByPermission("policia.permissao")
		for l,w in pairs(soldado) do
			local player = vRP.getUserSource(parseInt(w))
			if player then
				async(function()
					local id = idgens:gen()
					-- blips[id] = vRPclient.addBlip(player,x,y,z,153,2,"Ocorrência",0.5,true)	
					radiusBlips[id] = vRPclient.addRadiusBlip(player, x, y, z, 1, 150.0, 60)	
					
				
					vRPclient._playSound(player,"CONFIRM_BEEP","HUD_MINI_GAME_SOUNDSET")
					TriggerClientEvent('chatMessage',player,"911",{65,130,255},"Recebemos a denuncia de um assassinato, verifique o ocorrido.")
					SetTimeout(15000,function() 
						-- vRPclient.removeBlip(player,blips[id]) 
						vRPclient.removeBlip(player,radiusBlips[id]) 
						idgens:free(id) 
					end)
				end)
			end
		end
	end
end