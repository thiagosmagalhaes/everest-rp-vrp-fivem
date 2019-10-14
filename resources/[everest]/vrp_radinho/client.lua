local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
local Tools = module("vrp", "lib/Tools")

vRP = Proxy.getInterface("vRP")
func = Tunnel.getInterface("vrp_radinho")

WalkieOpened    = false

local permissoes = {
    ["policia.permissao"] = {1, 91, 92}, -- Principal

    ["paramedico.permissao"] = {2},
    ["mafia.permissao"] = {3},
    ["amarelo.permissao"] = {4},
    ["roxo.permissao"] = {5},
    ["verde.permissao"] = {6},
    ["motoclub.permissao"] = {7},
    ["taxista.permissao"] = {8},
    ["desmanche.permissao"] = {9},
    ["mecanico.permissao"] = {10},
    ["all.permissao"] = {11},
    ["bloods.permissao"] = {12},
}

RegisterCommand("radio", function(source, args, raw)
    local frequenciasPermitidas = nil
    for i, frequencias in pairs(permissoes) do
    
        for i2, frequencia in pairs(frequencias) do
            exports.tokovoip_script:removePlayerFromRadio(frequencia)
        end

        if func.permissao(i) then
            if not WalkieOpened or args[1] then
                local freq = args[1] or 1
                if frequencias[parseInt(freq)] then
                    exports.tokovoip_script:addPlayerToRadio(frequencias[parseInt(freq)])
                    WalkieOpened = false
                else
                    TriggerEvent("Notify","negado","Você não pode entrar nesta frequência!")
                end
            end            
        end
    end

    local freq = args[1] or false
    if freq and freq == "carreta" then
        exports.tokovoip_script:addPlayerToRadio(11)
        WalkieOpened = false
    end

    if args[1] == nil then
        WalkieOpened = not WalkieOpened
    end
    
end)

RegisterNetEvent("vrp_radinho:onPlayerJoinChannel");
AddEventHandler("vrp_radinho:onPlayerJoinChannel", function(identity)
    local msg = identity.name .." conectou-se"
    SendNUIMessage({type = 'sendMessage', msg = msg})
end)

RegisterNetEvent("vrp_radinho:onPlayerLeaveChannel");
AddEventHandler("vrp_radinho:onPlayerLeaveChannel", function(identity)
    local msg = identity.name .." desconectou-se"
    SendNUIMessage({type = 'sendMessage', msg = msg})
end)

RegisterNetEvent("vrp_radinho:keyRadio");
AddEventHandler("vrp_radinho:keyRadio", function(identity, show, id)
    local msg = identity.name.." "..identity.firstname
    SendNUIMessage({type = 'keyRadio', msg = msg, show=show, id = id})
end)