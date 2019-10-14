local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
emP = Tunnel.getInterface("emp_lavardinheirosujo")
vRP = Proxy.getInterface("vRP")
----------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local processo = false
local segundos = 0
-----------------------------------------------------------------------------------------------------------------------------------------
-- CORDENADAS DA LAVAGEM
-----------------------------------------------------------------------------------------------------------------------------------------
local vacas = {
    {1122.40, -3194.3, -40.20}, -- 1122.40,-3193.76,-40.20
	{1123.77, -3194.28, -40.20}, -- 1123.77,-3194.28,-40.39
	{1125.6,-3194.33,-40.4},
	{1126.97,-3194.3,-40.4},

}

RegisterNetEvent("global:loadJob")
AddEventHandler("global:loadJob",
                function() if emP.checkPermission() then init() end end)

Citizen.CreateThread(function() if emP.checkPermission() then init() end end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PROCESSO 
-----------------------------------------------------------------------------------------------------------------------------------------
function init()
    local time = 1
    while true do
        Citizen.Wait(time)
        if not processo then
            for _, func in pairs(vacas) do
                local ped = PlayerPedId()
                local x, y, z = table.unpack(func)
                local distancia = GetDistanceBetweenCoords(GetEntityCoords(ped),
                                                           x, y, z)

                if distancia < 30 then
                    time = 1
                    if distancia <= 1.2 then

                        DrawText3Ds(x, y, z,
                                    "PRESSIONE  ~y~E~w~  PARA LAVAR O DINHEIRO")
                        if IsControlJustPressed(0, 38) then
                            if emP.checkPayment() then
                                processo = true
                                TriggerEvent("animacao", true)
                                TriggerEvent("progress", 10000,
                                             "LAVANDO DINHEIRO")
                                Citizen.Wait(10000)
                                TriggerEvent("animacao", false)
                                processo = false
                            else
                                TriggerEvent("Notify", "aviso",
                                             "Dinheiro Sujo Insuficiente")
                            end
                        end
                    end
                else
                    time = 10000
                end
            end
        end
    end

end

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

AddEventHandler('animacao', function(isPlay)
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

