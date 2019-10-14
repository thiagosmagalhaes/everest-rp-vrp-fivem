local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
emP = Tunnel.getInterface("emp_desmanche")
vRP = Proxy.getInterface("vRP")

-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local isPermission = false
local segundos = 0
local roubando = false

local entrada = {x=1175.06, y=2640.27, z=37.75}
local desmanche = {x = 977.67, y = -3002.13, z = -39.6}
local saida = {x=1001.24, y=-2992.35, z=-39.65}
-----------------------------------------------------------------------------------------------------------------------------------------
-- GERANDO ENTREGA
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function() init() end)

RegisterNetEvent("global:loadJob")
AddEventHandler("global:loadJob", function() init() end)

function init()
    isPermission = emP.checkPermission()
    async(function()
        while isPermission do
            Wait(1)
            DrawMarker(23, entrada.x, entrada.y, entrada.z - 0.96, 0, 0, 0, 0,
                       0, 0, 5.0, 5.0, 0.5, 211, 176, 72, 20, 0, 0, 0, 0)
            DrawMarker(23, desmanche.x, desmanche.y, desmanche.z - 0.96, 0, 0,
                       0, 0, 0, 0, 5.0, 5.0, 0.5, 211, 176, 72, 20, 0, 0, 0, 0)
            DrawMarker(23, saida.x, saida.y, saida.z - 0.96, 0, 0, 0, 0, 0, 0,
                       5.0, 5.0, 0.5, 211, 176, 72, 20, 0, 0, 0, 0)
        end
    end)

    -- ENTRADA/SAIDA
    async(function()
        local inPort = false
        while isPermission do
            Citizen.Wait(1)
            inPort = false

            local ped = PlayerPedId()
            local vehicle = GetVehiclePedIsUsing(ped)

            local distanceEntrada = GetDistanceBetweenCoords(
                                        GetEntityCoords(ped), entrada.x,
                                        entrada.y, entrada.z, true)
            local distanceSaida = GetDistanceBetweenCoords(GetEntityCoords(ped),
                                                           saida.x, saida.y,
                                                           saida.z, true)

            if not inPort and distanceEntrada <= 5 and IsControlJustPressed(0, 38) then
                if not emP.isProcurado() then
                    inPort = true
                    teleport(971.47, -2990.67, -39.65, 187.35)
                    
                else
                    TriggerEvent("Notify", "negado",
                                 "O veículo ainda está sendo procurado!")
                end
            end

            if not inPort and distanceSaida <= 5 and IsControlJustPressed(0, 38) then
                inPort = true
                teleport(1182.72,2638.14,37.8, 357.71)
                
            end
        end
    end)

    async(function()
        while isPermission do
            Citizen.Wait(1)
            if not roubando then
                local ped = PlayerPedId()
                local vehicle = GetVehiclePedIsUsing(ped)
                local distance = GetDistanceBetweenCoords(GetEntityCoords(ped),
                                                          977.65, -3002.01,
                                                          -40.23, true)

                if distance <= 3.1 and IsControlJustPressed(0, 38) and
                    GetPedInVehicleSeat(vehicle, -1) == ped and
                    emP.checkPermission() then
                    if emP.checkVehicle() then
                        roubando = true
                        segundos = 30
                        FreezeEntityPosition(vehicle, true)
                        desmanchando()
                        repeat Citizen.Wait(10) until segundos == 0

                        local mPlaca, mName, mPrice, mBanido, mNet, mVeh =
                            vRP.ModelName2()
                        if IsEntityAVehicle(mVeh) then
                            TriggerServerEvent("vrp_adv_garages_id", mNet,
                                               GetVehicleEngineHealth(mVeh),
                                               GetVehicleBodyHealth(mVeh),
											   GetVehicleFuelLevel(mVeh))
							
							local chassi = parseInt(GetVehicleBodyHealth(mVeh)*0.1)
							local motor = parseInt(GetVehicleEngineHealth(mVeh)*0.1)
							local integridade = chassi+motor
							if integridade < 0 then integridade = 0 end
                            emP.removeVehicles(mPlaca, mName, mPrice, mNet, integridade)
                        end
                        roubando = false
                    end
                end
            end
        end
    end)
end

function desmanchando()
    async(function()
        while roubando do
            Citizen.Wait(1)
            if segundos > 0 then
                DisableControlAction(0, 75)
                drawTxt("AGUARDE ~y~" .. segundos ..
                            " SEGUNDOS~w~, ESTAMOS DESATIVANDO O ~g~RASTREADOR ~w~DO VEÍCULO",
                        4, 0.5, 0.93, 0.50, 255, 255, 255, 180)
            end
        end
    end)

    async(function()
        while roubando do
            Wait(1000)
            if segundos > 0 then segundos = segundos - 1 end
        end
    end)
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- TELEPORTAR PARA O LOCAL MARCADO
-----------------------------------------------------------------------------------------------------------------------------------------
function teleport(x, y, z, h)
    local ped = PlayerPedId()
    local veh = GetVehiclePedIsUsing(ped)
    if IsPedInAnyVehicle(ped) then ped = veh end

    -- local ground
    -- local groundFound = false
    -- local groundCheckHeights = { 0.0,50.0,100.0,150.0,200.0,250.0,300.0,350.0,400.0,450.0,500.0,550.0,600.0,650.0,700.0,750.0,800.0,850.0,900.0,950.0,1000.0,1050.0,1100.0 }

    -- for i,height in ipairs(groundCheckHeights) do
    -- 	SetEntityCoordsNoOffset(ped,x,y,height,0,0,1)

    -- 	RequestCollisionAtCoord(x,y,z)
    -- 	while not HasCollisionLoadedAroundEntity(ped) do
    -- 		RequestCollisionAtCoord(x,y,z)
    -- 		Citizen.Wait(1)
    -- 	end
    -- 	Citizen.Wait(20)

    -- 	ground,z = GetGroundZFor_3dCoord(x,y,height)
    -- 	if ground then
    -- 		z = z + 1.0
    -- 		groundFound = true
    -- 		break;
    -- 	end
    -- end

    -- if not groundFound then
    -- 	z = 1200
    -- 	GiveDelayedWeaponToPed(PlayerPedId(),0xFBAB5776,1,0)
    -- end

    -- RequestCollisionAtCoord(x,y,z)
    -- while not HasCollisionLoadedAroundEntity(ped) do
    -- 	RequestCollisionAtCoord(x,y,z)
    -- 	Citizen.Wait(1)
    -- end

    SetEntityCoordsNoOffset(ped, x, y, z, 0, 0, 1)
    SetEntityHeading(ped, h)
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
