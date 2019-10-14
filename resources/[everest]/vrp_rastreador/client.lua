local Proxy = module("vrp", "lib/Proxy")
local Tunnel = module("vrp", "lib/Tunnel")
vRP = Proxy.getInterface("vRP")

vRPNserver = Tunnel.getInterface("vrp_rastreador")

RegisterNetEvent("vrp_rastreador:add_rastreador")
AddEventHandler("vrp_rastreador:add_rastreador", function(index, model)
    -- if NetworkDoesNetworkIdExist(index) then
    --     local v = NetToEnt(index)
    --     if DoesEntityExist(v) then
    --         if IsEntityAVehicle(v) then
    --             totalBlips = 0
    --             ativarRastreador(v, model)
    --         end
    --     end
    -- end
end)

local totalBlips = 0
function ativarRastreador(veiculo, model)
    -- if DoesEntityExist(veiculo) then
    --     if IsEntityAVehicle(veiculo) then
    --         totalBlips = totalBlips + 1

    --         local coord = GetOffsetFromEntityInWorldCoords(veiculo, 0.0, 1.0,
    --                                                        -0.94)

    --         local blip = vRP.addRadiusBlip(coord.x, coord.y, coord.z, 3, 75.0,
    --                                        60)
    --         vRP.playSound("CONFIRM_BEEP", "HUD_MINI_GAME_SOUNDSET")
    --         TriggerEvent("Notify", "importante",
    --                      "A última localização do seu veículo " .. model ..
    --                          " foi recebida no seu GPS!")

    --         SetTimeout(1000 * 30, function()
    --             vRP.removeBlip(blip)
    --             if totalBlips <= 10 then
    --                 ativarRastreador(veiculo, model)
    --             else
    --                 totalBlips = 0
    --             end
    --         end)
    --     end
    -- end
end
