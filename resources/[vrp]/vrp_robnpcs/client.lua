-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONEXÃO
-----------------------------------------------------------------------------------------------------------------------------------------
src = {}
Tunnel.bindInterface("vrp_robnpcs", src)
vSERVER = Tunnel.getInterface("vrp_robnpcs")
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
local rendendo = false
local selectnpc = nil
local mirando = false

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        local ped = PlayerPedId()
        local x, y, z = table.unpack(GetEntityCoords(PlayerPedId()))
        if Vdist(x, y, z, -186.1, -893.5, 29.3) <= 21000.0 then
            local aim, npc = GetEntityPlayerIsFreeAimingAt(PlayerId())

			
            if aim and Vdist(GetEntityCoords(ped), GetEntityCoords(npc)) <= 6.0 then
                
                if not IsPedDeadOrDying(npc) and not IsPedAPlayer(npc) and
                    not rendendo and not IsPedInAnyVehicle(ped) and
                    not IsPedInAnyVehicle(npc) and GetPedType(npc) ~= 28 and
                    (GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_PISTOL") or
                        GetSelectedPedWeapon(ped) ==
                        GetHashKey("WEAPON_PISTOL_MK2") or
                        GetSelectedPedWeapon(ped) ==
                        GetHashKey("WEAPON_SNSPISTOL") or
                        GetSelectedPedWeapon(ped) ==
                        GetHashKey("WEAPON_VINTAGEPISTOL") or
                        GetSelectedPedWeapon(ped) ==
                        GetHashKey("WEAPON_REVOLVER")) then
                    if vSERVER.checkPolice() < 2 then
                        if not mirando then
							mirando = true
                            atacar(npc)
                            TriggerEvent("Notify", "negado",
                                         "Sem policia em patrulha")
                        end
                    else

                        if vSERVER.checkPedlist(npc) then
                            distance = GetDistanceBetweenCoords(
                                           GetEntityCoords(GetPlayerPed(-1)),
                                           943.36, -1953.88, 30.68, true)
                            if distance < 350.0 then
                                atacar(npc)
                            end
                        else

                            rendendo = true
                            selectnpc = npc

                            vSERVER.pressedPedlist(npc)

                            request("random@mugging3")
                            request("mp_common")

                            ClearPedTasks(npc)
                            TaskSetBlockingOfNonTemporaryEvents(npc, true)
                            SetEntityAsMissionEntity(npc, true, true)
                            FreezeEntityPosition(npc, true)
                            TaskPlayAnim(npc, "random@mugging3",
                                         "handsup_standing_base", 8.0, 8.0, -1,
                                         49, 10, 0, 0, 0)
                            PlayAmbientSpeech1(npc, "GUN_BEG",
                                               "SPEECH_PARAMS_FORCE_NORMAL_CLEAR")

                            SetTimeout(10000, function()
                                if rendendo then
                                    selectnpc = nil
                                    rendendo = false
                                    vSERVER.checkPayment()
                                    TaskPlayAnim(npc, "mp_common",
                                                 "givetake1_a", 8.0, 8.0, -1,
                                                 49, 10, 0, 0, 0)
                                    Citizen.Wait(1300)
                                    ClearPedTasks(npc)
                                    FreezeEntityPosition(npc, false)
                                    TaskWanderStandard(npc, 10.0, 10)
                                    SetEntityAsNoLongerNeeded(npc)
                                end
                            end)
                        end
                    end
                end
            else
                if mirando then mirando = false end
            end
        end
    end
end)

function atacar(npc)
    setPedPropertys(npc, "WEAPON_PISTOL_MK2")
    TaskCombatPed(npc, GetPlayerPed(-1), 0, 16)
end

function setPedPropertys(npc, weapon)
    SetPedShootRate(npc, 700)
    SetPedAlertness(npc, 100)
    SetPedAccuracy(npc, 100)
    SetPedCanSwitchWeapon(npc, true)
    SetEntityHealth(npc, 400)
    SetPedFleeAttributes(npc, 0, 0)
    SetPedCombatAttributes(npc, 46, true)
    SetPedCombatAbility(npc, 2)
    SetPedCombatRange(npc, 50)
    SetPedPathAvoidFire(npc, 1)
    SetPedPathCanUseLadders(npc, 1)
    SetPedPathCanDropFromHeight(npc, 1)
    SetPedPathPreferToAvoidWater(npc, 1)
    SetPedGeneratesDeadBodyEvents(npc, 1)
    GiveWeaponToPed(npc, GetHashKey(weapon), 5000, true, true)
    SetPedRelationshipGroupHash(npc, GetHashKey("security_guard"))
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DIMINUINDO O TEMPO
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        if rendendo then
            local x, y, z = table.unpack(GetEntityCoords(PlayerPedId()))
            if Vdist(x, y, z, GetEntityCoords(selectnpc)) >= 6.01 or
                IsPedDeadOrDying(selectnpc) then
                FreezeEntityPosition(selectnpc, false)
                ClearPedTasks(selectnpc)
                TaskWanderStandard(selectnpc, 10.0, 10)
                rendendo = false
                selectnpc = nil
            end
        end
    end
end)

function request(dict)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do Citizen.Wait(10) end
end
