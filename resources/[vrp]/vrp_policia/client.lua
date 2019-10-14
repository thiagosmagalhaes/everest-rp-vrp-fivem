local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

func = {}
Tunnel.bindInterface("vrp_policia", func)

-----------------------------------------------------------------------------------------------------------------------------------------
-- REANIMAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('reanimar')
AddEventHandler('reanimar', function()
    local handle, ped = FindFirstPed()
    local finished = false
    local reviver = nil
    repeat
        local distance = GetDistanceBetweenCoords(
                             GetEntityCoords(PlayerPedId()),
                             GetEntityCoords(ped), true)
        if IsPedDeadOrDying(ped) and not IsPedAPlayer(ped) and distance <= 1.5 and
            reviver == nil then
            reviver = ped
            TriggerEvent("cancelando", true)
            vRP._playAnim(false, {
                {"amb@medic@standing@tendtodead@base", "base"},
                {"mini@cpr@char_a@cpr_str", "cpr_pumpchest"}
            }, true)
            SetTimeout(5000, function()
                SetEntityHealth(reviver, 400)
                local newped = ClonePed(reviver, GetEntityHeading(reviver),
                                        true, true)
                TaskWanderStandard(newped, 10.0, 10)
                local model = GetEntityModel(reviver)
                SetModelAsNoLongerNeeded(model)
                SetEntityAsMissionEntity(reviver, true, true)
                TriggerServerEvent("trydeleteentity", PedToNet(reviver))
                vRP._stopAnim(false)
                TriggerServerEvent("reanimar:pagamento")
                TriggerEvent("cancelando", false)
            end)
            finished = true
        end
        finished, ped = FindNextPed(handle)
    until not finished
    EndFindPed(handle)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /RMASCARA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("rmascara")
AddEventHandler("rmascara", function()
    SetPedComponentVariation(PlayerPedId(), 1, 0, 0, 2)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /RCHAPEU
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("rchapeu")
AddEventHandler("rchapeu", function() ClearPedProp(PlayerPedId(), 0) end)
--------------------------------------------------------------------------------------------------------------------------------------------------
-- CARREGAR
--------------------------------------------------------------------------------------------------------------------------------------------------
other = nil
drag = false
carregado = false
RegisterNetEvent("carregar")
AddEventHandler("carregar", function(p1)
    other = p1
    drag = not drag
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        if drag and other then
            local ped = GetPlayerPed(GetPlayerFromServerId(other))
            Citizen.InvokeNative(0x6B9BBD38AB0796DF, PlayerPedId(), ped, 4103,
                                 11816, 0.48, 0.0, 0.0, 0.0, 0.0, 0.0, false,
                                 false, false, false, 2, true)
            carregado = true
        else
            if carregado then
                DetachEntity(PlayerPedId(), true, false)
                carregado = false
            end
        end
    end
end)
--------------------------------------------------------------------------------------------------------------------------------------------------
-- DISPAROS
--------------------------------------------------------------------------------------------------------------------------------------------------
local blacklistedWeapons = {
    "WEAPON_DAGGER", "WEAPON_BAT", "WEAPON_BOTTLE", "WEAPON_CROWBAR",
    "WEAPON_FLASHLIGHT", "WEAPON_GOLFCLUB", "WEAPON_HAMMER", "WEAPON_HATCHET",
    "WEAPON_KNUCKLE", "WEAPON_KNIFE", "WEAPON_MACHETE", "WEAPON_SWITCHBLADE",
    "WEAPON_NIGHTSTICK", "WEAPON_WRENCH", "WEAPON_BATTLEAXE", "WEAPON_POOLCUE",
    "WEAPON_STONE_HATCHET", "WEAPON_STUNGUN", "WEAPON_FLARE",
    "GADGET_PARACHUTE", "WEAPON_FIREEXTINGUISHER", "WEAPON_FIREWORK",
    "WEAPON_SNOWBALL","WEAPON_MUSKET",
}

function GetPeds(ped)
    local peds = {}

    for pedNPC in EnumeratePeds() do
        if IsPedHuman(pedNPC) and not IsPedAPlayer(pedNPC) then
            local distance = GetDistanceBetweenCoords(GetEntityCoords(ped),
                                                      GetEntityCoords(pedNPC),
                                                      true)

            if distance <= 500 then
                table.insert(peds, pedNPC)
            end
        end
    end

    return peds
end

Citizen.CreateThread(function()
    local ultimaArma = nil

    while true do
        Citizen.Wait(1)
        local ped = PlayerPedId()
        local pedShooting = IsPedShooting(ped)
        if pedShooting then

            local peds = GetPeds(ped)

            if #peds > 0 then
                local blacklistweapon = false

                for i, v in ipairs(blacklistedWeapons) do
                    if GetSelectedPedWeapon(ped) == GetHashKey(v) then
                        blacklistweapon = true
                    end
                end

                if not blacklistweapon and GetSelectedPedWeapon(ped) ~=
                    GetHashKey("WEAPON_PETROLCAN") and (ultimaArma ~= GetHashKey("WEAPON_PETROLCAN") and ultimaArma ~= GetHashKey("WEAPON_SNOWBALL")) then
                        local x,y,z = table.unpack(GetEntityCoords(ped))
                        TriggerServerEvent('atirando', x, y, z)
                end

                if IsPedShooting then
                    ultimaArma = GetSelectedPedWeapon(ped)
                end

                blacklistweapon = false
            end
        end
    end
end)

local blips = {}
RegisterNetEvent('notificacao')
AddEventHandler('notificacao', function(x, y, z, user_id)
    -- local distance = GetDistanceBetweenCoords(x,y,z,-186.1,-893.5,29.3,true)
    -- if distance <= 2100 then
    if not DoesBlipExist(blips[user_id]) then
        -- blips[user_id] = vRPclient.addRadiusBlip(PlayerPedId(),x,y,z,1,150.0,60)

        blips[user_id] = AddBlipForRadius(x, y, z, 150.0)
        SetBlipAlpha(blips[user_id], 60)
        SetBlipColour(blips[user_id], 1)

        PlaySoundFrontend(-1, "Enter_1st", "GTAO_FM_Events_Soundset", false)
        TriggerEvent('chatMessage', "911", {65, 130, 255},
                     "Disparos de arma de fogo aconteceram, verifique o ocorrido.")

        SetTimeout(30000, function()
            if DoesBlipExist(blips[user_id]) then
                RemoveBlip(blips[user_id])
            end
        end)
    end
    -- end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONE
-----------------------------------------------------------------------------------------------------------------------------------------
local cone = nil
RegisterNetEvent('cone')
AddEventHandler('cone', function(nome)
    local coord = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 1.0,
                                                   -0.94)
    local prop = "prop_mp_cone_02"
    local h = GetEntityHeading(PlayerPedId())
    if nome ~= "d" then
        cone = CreateObject(GetHashKey(prop), coord.x, coord.y - 0.5, coord.z,
                            true, true, true)
        PlaceObjectOnGroundProperly(cone)
        SetModelAsNoLongerNeeded(cone)

        SetEntityHeading(cone, h)
        -- FreezeEntityPosition(cone,true)
        -- SetEntityAsNoLongerNeeded(cone)
        SetEntityAsMissionEntity(cone, true, false)
    else
        if DoesObjectOfTypeExistAtCoords(coord.x, coord.y, coord.z, 0.9,
                                         GetHashKey(prop), true) then
            cone = GetClosestObjectOfType(coord.x, coord.y, coord.z, 0.9,
                                          GetHashKey(prop), false, false, false)
            TriggerServerEvent("trydeleteobj", ObjToNet(cone))
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BARREIRA
-----------------------------------------------------------------------------------------------------------------------------------------
local barreira = nil
RegisterNetEvent('barreira')
AddEventHandler('barreira', function(nome)
    local coord = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 1.5,
                                                   -0.94)
    local prop = "prop_barrier_work05"
    local h = GetEntityHeading(PlayerPedId())
    if nome ~= "d" then
        barreira = CreateObject(GetHashKey(prop), coord.x, coord.y - 0.95,
                                coord.z, true, true, true)
        PlaceObjectOnGroundProperly(barreira)
        SetModelAsNoLongerNeeded(barreira)

        SetEntityHeading(barreira, h - 180)
        -- FreezeEntityPosition(barreira,true)
        -- SetEntityAsNoLongerNeeded(barreira) -- Marca a entidade especificada (ped, veículo ou objeto) como não é mais necessária. As entidades marcadas como não necessárias, serão excluídas conforme o mecanismo julgar adequado.
        SetEntityAsMissionEntity(cone, true, false)
    else
        if DoesObjectOfTypeExistAtCoords(coord.x, coord.y, coord.z, 0.9,
                                         GetHashKey(prop), true) then
            barreira = GetClosestObjectOfType(coord.x, coord.y, coord.z, 0.9,
                                              GetHashKey(prop), false, false,
                                              false)
            TriggerServerEvent("trydeleteobj", ObjToNet(barreira))
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SPIKE
-----------------------------------------------------------------------------------------------------------------------------------------
local spike = nil
RegisterNetEvent('spike')
AddEventHandler('spike', function(nome)
    local coord = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 2.5, 0.0)
    local prop = "p_ld_stinger_s"
    local h = GetEntityHeading(PlayerPedId())
    if nome ~= "d" then
        spike = CreateObject(GetHashKey(prop), coord.x, coord.y, coord.z, true,
                             true, true)
        PlaceObjectOnGroundProperly(spike)
        SetModelAsNoLongerNeeded(spike)
        SetEntityHeading(spike, h - 180)
        FreezeEntityPosition(spike, true)
        -- SetEntityAsNoLongerNeeded(spike)
        SetEntityAsMissionEntity(cone, true, false)
    else
        if DoesObjectOfTypeExistAtCoords(coord.x, coord.y, coord.z, 0.9,
                                         GetHashKey(prop), true) then
            spike = GetClosestObjectOfType(coord.x, coord.y, coord.z, 0.9,
                                           GetHashKey(prop), false, false, false)
            TriggerServerEvent("trydeleteobj", ObjToNet(spike))
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        local veh = GetVehiclePedIsIn(PlayerPedId(), false)
        local vcoord = GetEntityCoords(veh)
        local coord = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 1.0,
                                                       -0.94)
        if IsPedInAnyVehicle(PlayerPedId()) then
            if DoesObjectOfTypeExistAtCoords(vcoord.x, vcoord.y, vcoord.z, 0.9,
                                             GetHashKey("p_ld_stinger_s"), true) then
                SetVehicleTyreBurst(veh, 0, true, 1000.0)
                SetVehicleTyreBurst(veh, 1, true, 1000.0)
                SetVehicleTyreBurst(veh, 2, true, 1000.0)
                SetVehicleTyreBurst(veh, 3, true, 1000.0)
                SetVehicleTyreBurst(veh, 4, true, 1000.0)
                SetVehicleTyreBurst(veh, 5, true, 1000.0)
                SetVehicleTyreBurst(veh, 6, true, 1000.0)
                SetVehicleTyreBurst(veh, 7, true, 1000.0)
                if DoesObjectOfTypeExistAtCoords(coord.x, coord.y, coord.z, 0.9,
                                                 GetHashKey("p_ld_stinger_s"),
                                                 true) then
                    spike = GetClosestObjectOfType(coord.x, coord.y, coord.z,
                                                   0.9, GetHashKey(
                                                       "p_ld_stinger_s"), false,
                                                   false, false)
                    TriggerServerEvent('trydeleteentity', ObjToNet(spike))
                end
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PRISÃO
-----------------------------------------------------------------------------------------------------------------------------------------
local prisioneiro = false
local reducaopenal = false

RegisterNetEvent('prisioneiro')
AddEventHandler('prisioneiro', function(status)
    prisioneiro = status
    reducaopenal = false
    local ped = PlayerPedId()
    if prisioneiro then
        SetEntityInvincible(ped, true)
        FreezeEntityPosition(ped, true)
        SetEntityVisible(ped, false, false)
        SetTimeout(10000, function()
            SetEntityInvincible(ped, false)
            FreezeEntityPosition(ped, false)
            SetEntityVisible(ped, true, false)
        end)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5000)
        if prisioneiro then
            local distance = GetDistanceBetweenCoords(
                                 GetEntityCoords(PlayerPedId()), 1700.5, 2605.2,
                                 45.5, true)
            if distance >= 200 then
                SetEntityCoords(PlayerPedId(), 1680.1, 2513.0, 45.5)
                TriggerEvent("Notify", "aviso",
                             "O agente penitenciário encontrou você tentando escapar.")
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        if prisioneiro then
            local distance01 = GetDistanceBetweenCoords(
                                   GetEntityCoords(PlayerPedId()), 1691.59,
                                   2566.05, 45.56, true)
            local distance02 = GetDistanceBetweenCoords(
                                   GetEntityCoords(PlayerPedId()), 1669.51,
                                   2487.71, 45.82, true)

            if GetEntityHealth(PlayerPedId()) <= 100 then
                reducaopenal = false
                vRP._DeletarObjeto()
            end

            if distance01 <= 100 and not reducaopenal then
                DrawMarker(21, 1691.59, 2566.05, 45.56, 0, 0, 0, 0, 180.0,
                           130.0, 1.0, 1.0, 0.5, 255, 255, 255, 100, 1, 0, 0, 1)
                if distance01 <= 1.2 then
                    drawTxt("PRESSIONE  ~b~E~w~  PARA CONCLUIR", 4, 0.5, 0.93,
                            0.50, 255, 255, 255, 180)
                    if IsControlJustPressed(0, 38) then
                        reducaopenal = true
                        ResetPedMovementClipset(PlayerPedId(), 0)
                        SetRunSprintMultiplierForPlayer(PlayerId(), 1.0)
                        vRP._CarregarObjeto(true, "anim@heists@box_carry@", "idle",
                                            "hei_prop_heist_box", 50, 28422)
                    end
                end
            end

            if distance02 <= 100 and reducaopenal then
                DrawMarker(21, 1669.51, 2487.71, 45.82, 0, 0, 0, 0, 180.0,
                           130.0, 1.0, 1.0, 0.5, 255, 255, 255, 100, 1, 0, 0, 1)
                if distance02 <= 1.2 then
                    drawTxt("PRESSIONE  ~b~E~w~  PARA CONCLUIR", 4, 0.5, 0.93,
                            0.50, 255, 255, 255, 180)
                    if IsControlJustPressed(0, 38) then
                        reducaopenal = false
                        TriggerServerEvent("diminuirpena")
                        vRP._DeletarObjeto()
                    end
                end
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        if reducaopenal then
            BlockWeaponWheelThisFrame()
            DisableControlAction(0, 21, true)
            DisableControlAction(0, 24, true)
            DisableControlAction(0, 25, true)
            DisableControlAction(0, 58, true)
            DisableControlAction(0, 263, true)
            DisableControlAction(0, 264, true)
            DisableControlAction(0, 257, true)
            DisableControlAction(0, 140, true)
            DisableControlAction(0, 141, true)
            DisableControlAction(0, 142, true)
            DisableControlAction(0, 143, true)
            DisableControlAction(0, 75, true)
            DisableControlAction(0, 22, true)
            DisableControlAction(0, 32, true)
            DisableControlAction(0, 268, true)
            DisableControlAction(0, 33, true)
            DisableControlAction(0, 269, true)
            DisableControlAction(0, 34, true)
            DisableControlAction(0, 270, true)
            DisableControlAction(0, 35, true)
            DisableControlAction(0, 271, true)
            DisableControlAction(0, 288, true)
            DisableControlAction(0, 289, true)
            DisableControlAction(0, 170, true)
            DisableControlAction(0, 166, true)
            DisableControlAction(0, 73, true)
            DisableControlAction(0, 167, true)
            DisableControlAction(0, 177, true)
            DisableControlAction(0, 311, true)
            DisableControlAction(0, 344, true)
            DisableControlAction(0, 29, true)
            DisableControlAction(0, 182, true)
            DisableControlAction(0, 245, true)
            DisableControlAction(0, 246, true)
            DisableControlAction(0, 303, true)
            DisableControlAction(0, 187, true)
            DisableControlAction(0, 189, true)
            DisableControlAction(0, 190, true)
            DisableControlAction(0, 188, true)
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

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        local ped = PlayerPedId()
        if not IsPedInAnyVehicle(ped, true) then
            if IsControlJustPressed(0, 47) then
                TriggerServerEvent("vrp_policia:algemar")
            end
            if IsControlJustPressed(0, 74) then
                TriggerServerEvent("vrp_policia:carregar")
            end
        end
        if IsControlJustPressed(0, 82) then
            TriggerServerEvent("vrp_policia:localizacao")
        end
    end
end)