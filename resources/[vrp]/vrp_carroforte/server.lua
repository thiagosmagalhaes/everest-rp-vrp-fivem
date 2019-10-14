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
Tunnel.bindInterface("vrp_stockade",src)
vCLIENT = Tunnel.getInterface("vrp_stockade")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local timers = 0
local blips = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKTIMERS
-----------------------------------------------------------------------------------------------------------------------------------------
function src.checkTimers()
	local policia = vRP.getUsersByPermission("policia.permissao")
	if #policia < 4 then
		TriggerClientEvent("Notify",source,"aviso","Número insuficiente de policiais no momento.",8000)
		return false
	elseif (os.time()-timers) <= 7200 then
		TriggerClientEvent("Notify",source,"aviso","O sistema foi hackeado, aguarde <b>"..vRP.format(parseInt((7200-(os.time()-timers)))).." segundos</b> até que o mesmo retorne a funcionar.",8000)
		return false
	elseif src.possuiItem("pendrive32") then
		timers = os.time()
		return true	
	else
		TriggerClientEvent("Notify", source,"negado","Você não possui um Pendrive 32GB!")
		return false
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKSTOCKADE
-----------------------------------------------------------------------------------------------------------------------------------------
function src.checkStockade()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		vCLIENT.startStockade(source)
	end
end

function src.possuiItem(item)
	local source = source
	local user_id = vRP.getUserId(source)
	return vRP.getInventoryItemAmount(user_id, item) >= 1
end

function src.removeItem(item)
	local source = source
	local user_id = vRP.getUserId(source)
	return vRP.tryGetInventoryItem(user_id,item,1)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DROPAR
-----------------------------------------------------------------------------------------------------------------------------------------
function src.dropSystem(x,y,z)
	TriggerEvent("DropSystem:create","dinheirosujo",math.random(250000,350000),x,y,z)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DROPAR
-----------------------------------------------------------------------------------------------------------------------------------------
function src.resetTimer()
	timers = 0
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- MARCAROCORRENCIA
-----------------------------------------------------------------------------------------------------------------------------------------
function src.markOcorrency(x,y,z)
	TriggerEvent("global:avisarPolicia", "Recebemos uma denuncia de que um ^1Carro Forte^0 está sendo interceptado.",x,y,z, 1)
end