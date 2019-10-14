local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
emP = Tunnel.getInterface("emp_mecanico")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local blips = false
local inService = false
local servico = false
local selecionado = 0
local CoordenadaX = -238.77
local CoordenadaY = -1397.71
local CoordenadaZ = 31.28
-----------------------------------------------------------------------------------------------------------------------------------------
-- RESIDENCIAS
-----------------------------------------------------------------------------------------------------------------------------------------
local locs = {
    [1] = {['x'] = 478.51, ['y'] = -1890.44, ['z'] = 26.09},
    [2] = {['x'] = 976.53, ['y'] = -1825.05, ['z'] = 31.15},
    [3] = {['x'] = 1200.32, ['y'] = -1384.76, ['z'] = 35.22},
    [4] = {['x'] = 1140.96, ['y'] = -776.02, ['z'] = 57.59},
    [5] = {['x'] = -561.63, ['y'] = 302.25, ['z'] = 83.17},
    [6] = {['x'] = -1151.40, ['y'] = -206.73, ['z'] = 37.95},
    [7] = {['x'] = -2091.83, ['y'] = -314.17, ['z'] = 13.02},
    [8] = {['x'] = -1608.39, ['y'] = -822.20, ['z'] = 10.04},
    [9] = {['x'] = -522.23, ['y'] = -1212.54, ['z'] = 18.18},
    [10] = {['x'] = -719.60, ['y'] = -933.34, ['z'] = 19.01},
    [11] = {['x'] = -314.40, ['y'] = -1472.76, ['z'] = 30.54},
    [12] = {['x'] = -75.83, ['y'] = -1763.12, ['z'] = 29.49},
    [13] = {['x'] = 490.07, ['y'] = -1312.75, ['z'] = 29.25},
    [14] = {['x'] = 717.47, ['y'] = -1089.01, ['z'] = 22.36},
    [15] = {['x'] = 1184.65, ['y'] = -334.11, ['z'] = 69.17},
    [16] = {['x'] = -744.50, ['y'] = -1503.57, ['z'] = 5.00}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRABALHAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("global:loadJob")
AddEventHandler("global:loadJob", function()
    if emP.checkPermission() then
        init()
    else
        inService = false
    end
end)

Citizen.CreateThread(function()
    if emP.checkPermission() then
        init()
    else
        inService = false
    end
end)

function init()
    inService = true
    async(function()
        time = 1
        while inService do
            Citizen.Wait(time)
            if not servico then
                local ped = PlayerPedId()
                local x, y, z = table.unpack(GetEntityCoords(ped))
                local bowz, cdz = GetGroundZFor_3dCoord(CoordenadaX,
                                                        CoordenadaY, CoordenadaZ)
                local distance = GetDistanceBetweenCoords(CoordenadaX,
                                                          CoordenadaY, cdz, x,
                                                          y, z, true)

                if distance <= 30.0 then
                    time = 1
                    DrawMarker(23, CoordenadaX, CoordenadaY, CoordenadaZ - 0.97,
                               0, 0, 0, 0, 0, 0, 1.0, 1.0, 0.5, 240, 200, 80,
                               20, 0, 0, 0, 0)
                    if distance <= 1.2 then
                        drawTxt("PRESSIONE  ~b~E~w~  PARA INICIAR ENTREGAS", 4,
                                0.5, 0.93, 0.50, 255, 255, 255, 180)
                        if IsControlJustPressed(0, 38) and emP.checkPermission() then
                            servico = true
                            selecionado = math.random(16)
                            CriandoBlip(locs, selecionado)
                        end
                    end
                else
                    time = 10000
                end
            end
        end
    end)

    ----------------------------------------
    -- ENTREGAS
    ----------------------------------------
    async(function()
        while inService do
            Citizen.Wait(1)
            if servico then
                local ped = PlayerPedId()
                local x, y, z = table.unpack(GetEntityCoords(ped))
                local bowz, cdz = GetGroundZFor_3dCoord(locs[selecionado].x,
                                                        locs[selecionado].y,
                                                        locs[selecionado].z)
                local distance = GetDistanceBetweenCoords(locs[selecionado].x,
                                                          locs[selecionado].y,
                                                          cdz, x, y, z, true)

                if distance <= 30.0 then
                    DrawMarker(21, locs[selecionado].x, locs[selecionado].y,
                               locs[selecionado].z + 0.30, 0, 0, 0, 0, 180.0,
                               130.0, 2.0, 2.0, 1.0, 165, 28, 28, 80, 1, 0, 0, 1)
                    if distance <= 2.5 then
                        drawTxt("PRESSIONE  ~b~E~w~  PARA ENTREGAR FERRAMENTA",
                                4, 0.5, 0.93, 0.50, 255, 255, 255, 180)
                        if IsControlJustPressed(0, 38) and emP.checkPermission() then
                            if IsVehicleModel(GetVehiclePedIsUsing(ped),
                                              GetHashKey("flatbed")) then
                                if emP.checkPayment() then
                                    RemoveBlip(blips)
                                    backentrega = selecionado
                                    while true do
                                        if backentrega == selecionado then
                                            selecionado = math.random(16)
                                        else
                                            break
                                        end
                                        Citizen.Wait(1)
                                    end
                                    CriandoBlip(locs, selecionado)
                                end
                            end
                        end
                    end
                end
            end
        end
    end)

    ----------------------------------------
    -- CANCELAR ROTAS
    ----------------------------------------
    async(function()
        while inService do
            Citizen.Wait(1)
            if servico then
                if IsControlJustPressed(0, 168) then
                    servico = false
                    RemoveBlip(blips)
                end
            end
        end
    end)
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
function drawTxt(text, font, x, y, scale, r, g, b, a)
    SetTextFont(font)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextOutline()
    SetTextCentre(1)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x, y)
end

function CriandoBlip(locs, selecionado)
    blips = AddBlipForCoord(locs[selecionado].x, locs[selecionado].y,
                            locs[selecionado].z)
    SetBlipSprite(blips, 1)
    SetBlipColour(blips, 5)
    SetBlipScale(blips, 0.4)
    SetBlipAsShortRange(blips, false)
    SetBlipRoute(blips, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Entrega de Ferramenta")
    EndTextCommandSetBlipName(blips)
end
