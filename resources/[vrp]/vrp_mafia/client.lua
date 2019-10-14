local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
func = Tunnel.getInterface("vrp_trafico")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- TELEPORT   -517.05,5331.61,80.26
-----------------------------------------------------------------------------------------------------------------------------------------
local Teleport = {
    ["MAFIA"] = {
        positionFrom = {
            x = 2404.3544921875,
            y = 3127.5290527344,
            z = 48.153495788574,
            ['perm'] = "mafia.permissao"
        },
        positionTo = {
            x = 857.58801269531,
            y = -3249.1955566406,
            z = -98.352340698242,
            ['perm'] = "mafia.permissao"
        }
    },

    ["BLOODS"] = {
        positionFrom = {
            x = -50.25,
            y = 1911.19,
            z = 195.71,
            ['perm'] = "bloods.permissao"
        },
        positionTo = {
            x = 2331.31,
            y = 2572.61,
            z = 46.68,
            ['perm'] = "bloods.permissao"
        }
    }
}

Citizen.CreateThread(function()
    
    while true do
        Citizen.Wait(1)
        local ped = PlayerPedId()
        for k, v in pairs(Teleport) do
            local distance = GetDistanceBetweenCoords(v.positionFrom.x,
                                                      v.positionFrom.y,
                                                      v.positionFrom.z,
                                                      GetEntityCoords(ped), true)
            local distance2 = GetDistanceBetweenCoords(v.positionTo.x,
                                                       v.positionTo.y,
                                                       v.positionTo.z,
                                                       GetEntityCoords(ped),
                                                       true)

            if distance <= 1.2 then
                drawTxt("PRESSIONE ~b~E~w~ PARA ENTRAR", 4, 0.5, 0.93, 0.50,
                        255, 255, 255, 180)
                if IsControlJustPressed(0, 38) and
                    func.checkPermission(v.positionTo.perm) then
                    SetEntityCoords(ped, v.positionTo.x,
                                    v.positionTo.y, v.positionTo.z - 0.50)
                end
            end

            if distance2 <= 10 then
                DrawMarker(26, v.positionTo.x, v.positionTo.y,
                           v.positionTo.z - 1, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0,
                           255, 255, 255, 50, 0, 0, 0, 0)
                if distance2 <= 1.5 then
                    if IsControlJustPressed(0, 38) and
                        func.checkPermission(v.positionFrom.perm) then
                        SetEntityCoords(ped, v.positionFrom.x,v.positionFrom.y,
                                        v.positionFrom.z - 0.50)
                    end
                end
            end
        end
    end
end)

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

-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTION
-----------------------------------------------------------------------------------------------------------------------------------------
local menuactive = false
function ToggleActionMenu(type)
    menuactive = not menuactive
    if menuactive then
        SetNuiFocus(true, true)
        SendNUIMessage({showmenu = true, type = type})
    else
        SetNuiFocus(false)
        SendNUIMessage({hidemenu = true})
    end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCAIS 
-----------------------------------------------------------------------------------------------------------------------------------------
local locais = {
    {x = 883.63, y = -3206.70, z = -98.19, type = "mafia"},
    {x = 1221.25, y = -3005.37, z = 5.87, type = "geral"},
    {x = 2328.98, y = 2571.32, z = 46.68, type = "mafia"}
}
Citizen.CreateThread(function()
    SetNuiFocus(false, false)
    menuactive = false
    TriggerEvent("animacao", source, false)
    while true do
        Citizen.Wait(1)

        for i, item in pairs(locais) do
            local distance = GetDistanceBetweenCoords(
                                 GetEntityCoords(PlayerPedId()), item.x, item.y,
                                 item.z, true)
            if distance <= 1 and not menuactive then
                -- DrawMarker(23,566.00,-3124.73,18.76-0.97,0,0,0,0,0,0,1.0,1.0,0.5,240,200,80,20,0,0,0,0)
                drawTxt("PRESSIONE ~b~E~w~ PARA ABRIR O MENU", 4, 0.5, 0.93,
                        0.50, 255, 255, 255, 180)

                if IsControlJustPressed(0, 38) then
                    if item.type == "mafia" and func.checkPermission() then
                        ToggleActionMenu(item.type)
                    else
                        ToggleActionMenu(item.type)
                    end
                end

            end
        end
    end
end)

RegisterNUICallback("ButtonClick", function(data, cb)
    if data == "fechar" then
        ToggleActionMenu()
    else
        TriggerServerEvent("mafia-comprar", data)
    end
end)

RegisterNetEvent('vrp_mafia:fecharMenu')
AddEventHandler('vrp_mafia:fecharMenu', function() ToggleActionMenu() end)

RegisterNetEvent('vrp_mafia:animacao')
AddEventHandler('vrp_mafia:animacao', function(isPlay)
    if isPlay then
        TriggerEvent('cancelando', true)
        vRP._playAnim(false, {
            {"amb@prop_human_parking_meter@female@idle_a", "idle_a_female"}
        }, true)
    else
        TriggerEvent('cancelando', false)
        ClearPedTasks(PlayerPedId())
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
function DrawText3Ds(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local px, py, pz = table.unpack(GetGameplayCamCoords())

    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x, _y)
    local factor = (string.len(text)) / 370
    DrawRect(_x, _y + 0.0125, 0.015 + factor, 0.03, 41, 11, 41, 68)
end
