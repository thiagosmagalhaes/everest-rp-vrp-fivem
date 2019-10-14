local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
emP = {}
Tunnel.bindInterface("emp_lavardinheirosujo",emP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
function emP.checkPayment()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        local quantidade = 10000
        if vRP.tryGetInventoryItem(user_id,"dinheirosujo",quantidade) then
            vRP.giveMoney(user_id,quantidade*0.9)
            return true
        end
    end
    return false
end

function emP.checkPermission()
	local source = source
    local user_id = vRP.getUserId(source)
    return vRP.hasPermission(user_id,"motoclub.permissao")
end
