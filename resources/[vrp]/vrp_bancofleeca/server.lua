local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

func = {}
Tunnel.bindInterface("vrp_bancofleeca", func)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local timers = 0
local recompensa = 0
local andamento = false
local dinheirosujo = {}
local portas = {}

local tempoNextRoubo = 7200
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCALIDADES
-----------------------------------------------------------------------------------------------------------------------------------------

function func.checkTimers(qtdPolicia)
    local policia = vRP.getUsersByPermission("policia.permissao")

    if (os.time() - timers) <= tempoNextRoubo then
        TriggerClientEvent("Notify", source, "aviso",
                           "Os bancos estão vazios, aguarde <b>" ..
                               vRP.format(
                                   parseInt(
                                       (tempoNextRoubo - (os.time() - timers)) /
                                           60)) ..
                               " minutos</b> até que os civis depositem dinheiro.")
        return false
    elseif #policia < qtdPolicia then
        TriggerClientEvent("Notify", source, "aviso",
                           "Número insuficiente de policiais no momento para iniciar o roubo.")
        return false
    end
    return true
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKROBBERY
-----------------------------------------------------------------------------------------------------------------------------------------
function func.checkRobbery(x, y, z, head, seconds)
    local source = source
    local user_id = vRP.getUserId(source)

    if user_id then

        andamento = true
        timers = os.time()
        dinheirosujo[user_id] = {pendrive = 0}
        vRPclient.setStandBY(source, parseInt(600))
        recompensa = parseInt(math.random(400000, 600000) / seconds)

        TriggerEvent('vRP:isProcurado', user_id)
        TriggerClientEvent('iniciandoroubobanco', source, x, y, z, seconds, head)

        vRPclient._playAnim(source, false, {
            {"anim@heists@ornate_bank@grab_cash_heels", "grab"}
        }, true)

        TriggerEvent("global:avisarPolicia",
                     "O roubo começou no ^1Banco^0, dirija-se até o local e intercepte os assaltantes.",
                     x, y, z, 1)

        SetTimeout(seconds * 1000, function()
            if andamento then
                andamento = false
                local policia = vRP.getUsersByPermission("policia.permissao")

                for l, w in pairs(policia) do
                    local player = vRP.getUserSource(parseInt(w))
                    if player then
                        async(function()
                            TriggerClientEvent('chatMessage', player, "911",
                                               {65, 130, 255},
                                               "O roubo terminou, os assaltantes estão correndo antes que vocês cheguem.")
                        end)
                    end
                end
            end
        end)

        SetTimeout(tempoNextRoubo * 1000,
                   function() -- RESETA O SISTEMA PARA NOVOS ROUBOS
            timers = 0
            recompensa = 0
            andamento = false
            dinheirosujo = {}
            portas = {}
            TriggerClientEvent("vrp_bancofleeca:resetBanco", -1)
        end)

    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CANCELROBBERY
-----------------------------------------------------------------------------------------------------------------------------------------
function func.cancelRobbery()
    if andamento then
        andamento = false
        local policia = vRP.getUsersByPermission("policia.permissao")
        for l, w in pairs(policia) do
            local player = vRP.getUserSource(parseInt(w))
            if player then
                async(function()
                    TriggerClientEvent('blip:remover:roubobanco', player)
                    TriggerClientEvent('chatMessage', player, "911",
                                       {65, 130, 255},
                                       "O assaltante saiu correndo e deixou tudo para trás.")
                end)
            end
        end
    end
end

function func.possuiItem(item)
    local source = source
    local user_id = vRP.getUserId(source)
    return vRP.getInventoryItemAmount(user_id, item) >= 1
end

function func.removeItem(item)
    local source = source
    local user_id = vRP.getUserId(source)
    return vRP.tryGetInventoryItem(user_id, item, 1)
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYMENTROBBERY
-----------------------------------------------------------------------------------------------------------------------------------------
local pendrives = {"pendrive32", "pendrive64"}
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        if andamento then
            for k, v in pairs(dinheirosujo) do

                vRP._giveInventoryItem(k, "dinheirosujo", recompensa)

                local random = math.random(0, 100)
                if random == 50 and dinheirosujo[k].pendrive < 2 then
                    vRP._giveInventoryItem(k, pendrives[math.random(1, 2)], 1)

                    dinheirosujo[k].pendrive = dinheirosujo[k].pendrive + 1
                end
            end
        end
    end
end)

RegisterServerEvent('vrp_bancofleeca:openDoor')
AddEventHandler('vrp_bancofleeca:openDoor', function(index)
    portas[index] = {porta = index, status = true}

    TriggerClientEvent("vrp_bancofleeca:openDoorClient", -1, index)

    SetTimeout(600000,
               function() portas[index] = {porta = index, status = false} end)

end)

AddEventHandler("vRP:playerSpawn", function(user_id, source, first_spawn)
    while true do
        for a, porta in pairs(portas) do
            if porta.status then
                TriggerClientEvent("vrp_bancofleeca:openDoorClient", source, a)
            end
        end
        Wait(5000)
    end
end)
