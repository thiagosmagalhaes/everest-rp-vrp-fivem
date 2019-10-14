local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRPclient = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")


func = {}
Tunnel.bindInterface("vrp_radinho", func)

function func.permissao(permissao)
    local source = source
    local user_id = vRP.getUserId(source)
    return vRP.hasPermission(user_id, permissao)
end