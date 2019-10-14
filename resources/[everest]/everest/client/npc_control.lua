players = {}
player = {}
vehicles = 0.1
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10000)

        local peds = EnumeratePeds()
        for ped in peds do
            if DoesEntityExist(ped) then
                for i, model in pairs(cfg.peds) do
                    if (GetEntityModel(ped) == GetHashKey(model)) then
                        veh = GetVehiclePedIsIn(ped, false)
                        SetEntityAsNoLongerNeeded(ped)
                        SetEntityCoords(ped, 10000, 10000, 10000, 1, 0, 0, 1)
                        if veh ~= nil then
                            SetEntityAsNoLongerNeeded(veh)
                            SetEntityCoords(veh, 10000, 10000, 10000, 1, 0, 0, 1)
                        end
                    end
                end
                for i, model in pairs(cfg.noguns) do
                    if (GetEntityModel(ped) == GetHashKey(model)) then
                        RemoveAllPedWeapons(ped, true)
                    end
                end

                SetPedDropsWeaponsWhenDead(ped, false)
                -- for i, model in pairs(cfg.nodrops) do
                --     if (GetEntityModel(ped) == GetHashKey(model)) then
                --         SetPedDropsWeaponsWhenDead(ped, false)
                --     end
                -- end
            end
        end

    end

end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(500)
        local peds = EnumeratePeds()
        for ped in peds do
            if DoesEntityExist(ped) then
                SetPedDropsWeaponsWhenDead(ped, false)
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        for i = 0, 256 do
            if NetworkIsPlayerActive(i) then table.insert(players, i) end
        end
        if #players >= 25 then
            if math.random(0, 3) == 1 then
                vehicles = 0.1
            else
                vehicles = 0.0
            end
        end
        Citizen.Wait(60000)
    end
end)

Citizen.CreateThread(function()
    while true do
        -- These natives has to be called every frame.
        local distance = GetDistanceBetweenCoords(
                             GetEntityCoords(GetPlayerPed(-1)), -1122.06,
                             4924.88, 218.60, true)
        local percentagemNPC = cfg.density.peds
        if distance < 150.0 then percentagemNPC = 0.0 end

        -- -- MUITO FLUXO DE PEDESTRES
        -- distance = GetDistanceBetweenCoords(
        --                      GetEntityCoords(GetPlayerPed(-1)), 943.36,-1953.88,30.68, true)
        -- if distance < 350.0 then percentagemNPC = 0.50 end

        SetPedDensityMultiplierThisFrame(percentagemNPC)
        SetScenarioPedDensityMultiplierThisFrame(percentagemNPC, percentagemNPC)
        SetVehicleDensityMultiplierThisFrame(vehicles)
        SetRandomVehicleDensityMultiplierThisFrame(vehicles)
        SetParkedVehicleDensityMultiplierThisFrame(vehicles)
        Citizen.Wait(5)
    end
end)

-- local pedindex = {}

-- function SetWeaponDrops() -- This function will set the closest entity to you as the variable entity.
--     local handle, ped = FindFirstPed()
--     local finished = false -- FindNextPed will turn the first variable to false when it fails to find another ped in the index
--     repeat
--         if not IsEntityDead(ped) then pedindex[ped] = {} end
--         finished, ped = FindNextPed(handle) -- first param returns true while entities are found
--     until not finished
--     EndFindPed(handle)

--     for peds, _ in pairs(pedindex) do
--         if peds ~= nil then -- set all peds to not drop weapons on death.
--             SetPedDropsWeaponsWhenDead(peds, false)
--         end
--     end
-- end

-- Citizen.CreateThread(function()
--     while true do
--         Citizen.Wait(0)
--         SetWeaponDrops()
--     end
-- end)
