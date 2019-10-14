local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
func = Tunnel.getInterface("vrp_bancofleeca")

-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local andamento = false
local segundos = 0
-----------------------------------------------------------------------------------------------------------------------------------------
-- GERANDO LOCAL DO ROUBO
-----------------------------------------------------------------------------------------------------------------------------------------


local hackear = Config.hackear

local ped = nil
local timeBank = 1

local indexLocal = 0
local localHacker = nil

Citizen.CreateThread(function()
    vRP._stopAnim(false)
    TriggerEvent('cancelando',false)

    TriggerEvent("vrp_bancofleeca:resetBanco")
    while true do
        ped = PlayerPedId()
        indexLocal = 0
        for a, loc in pairs(hackear) do
            local distance = GetDistanceBetweenCoords(GetEntityCoords(ped), loc.x, loc.y, loc.z, true)
            if distance < 30 then
                indexLocal = a
                localHacker = Config.hackear[indexLocal]
            end
        end
        Citizen.Wait(5000)
    end
end)

Citizen.CreateThread(function()
    while true do
        timeBank = 5000
        if indexLocal > 0 then
            timeBank = 1
            local distance = GetDistanceBetweenCoords(GetEntityCoords(ped),
                                                        localHacker.x, localHacker.y, localHacker.z, true)
                                                        
            if distance <= 0.5 then
                drawTxt("PRESSIONE  ~b~E~w~  PARA HACKEAR", 4, 0.5, 0.93, 0.50, 255, 255, 255, 180)
                if IsControlJustPressed(0, 38) and func.checkTimers(localHacker.roubo.police) then
                    if func.possuiItem("pendrive16") then 
                        vRP._playAnim(false, {
                            {"amb@prop_human_atm@male@idle_a", "idle_a"}
                        }, true)

                        TriggerEvent("mhacking:show")
                        TriggerEvent("mhacking:start", 6, 25, mycallback)
                    else
                        TriggerEvent("Notify","negado","Você não possui um Pendrive 16GB")
                    end
                end
            end
        end
        Citizen.Wait(timeBank)
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- HACKEAR
-----------------------------------------------------------------------------------------------------------------------------------------
function mycallback(success, time)
    if success then
        TriggerEvent("mhacking:hide")
        vRP._stopAnim(false)
        func.removeItem("pendrive16")
        TriggerServerEvent("vrp_bancofleeca:openDoor", indexLocal)
		indexLocal = 0
    else
        TriggerEvent("mhacking:hide")
		vRP._stopAnim(true)
		indexLocal = 0
    end

end

RegisterNetEvent("vrp_bancofleeca:openDoorClient")
AddEventHandler("vrp_bancofleeca:openDoorClient", function(index)
    
    local VaultDoor = GetClosestObjectOfType(hackear[index].x, hackear[index].y, hackear[index].z, 20.0,
	hackear[index].p, false, false, false)
    NetworkRequestControlOfEntity(VaultDoor)
    FreezeEntityPosition(VaultDoor, true)
	local CurrentHeading = GetEntityHeading(VaultDoor)
	
    -- if hackear[index].p == -1185205679 then
    --     if hackear[index].open < 0 then
    --     else
    --         while CurrentHeading < hackear[index].open do -- Open
    --             Citizen.Wait(0)
    --             SetEntityHeading(VaultDoor, round(CurrentHeading, 1) + 0.1)
    --             CurrentHeading = GetEntityHeading(VaultDoor)
    --         end
    --     end
    -- else
    
    while CurrentHeading > hackear[index].open do -- Open
        Citizen.Wait(0)
        SetEntityHeading(VaultDoor, round(CurrentHeading, 1) - 0.1)
        CurrentHeading = GetEntityHeading(VaultDoor)
    end
	
	-- end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INICIO/CANCELAR
-----------------------------------------------------------------------------------------------------------------------------------------

Citizen.CreateThread(function()

    -- loadModel("bkr_prop_bkr_cashpile_04")
    -- loadAnimDict("anim@heists@ornate_bank@grab_cash_heels")

    -- while (not HasAnimDictLoaded("anim@heists@ornate_bank@hack")) do
    -- 	RequestAnimDict("anim@heists@ornate_bank@hack")

    -- 	Citizen.Wait(1)
    -- end

    -- TaskPlayAnim(PlayerPedId(), "anim@heists@ornate_bank@hack", "hack_loop_laptop", 8.0, 8.0, -1, 1, 0, false, false, false)
    -- TaskPlayAnim(PlayerPedId(), "anim@heists@ornate_bank@grab_cash_heels", "grab", 8.0, -8.0, -1, 1, 0, false, false, false)

    -- local CashPile = CreateObject(GetHashKey("bkr_prop_bkr_cashpile_04"), 1173.4510498047,2715.2712402344,38.912742614746, false)
    -- PlaceObjectOnGroundProperly(CashPile)
    -- SetEntityRotation(CashPile, 0, 0, 179.99975585938, 2)
    -- FreezeEntityPosition(CashPile, true)
    -- SetEntityAsMissionEntity(CashPile, true, true)

    -- {lib = “anim@heists@fleeca_bank@drilling”, anim = “drill_straight_idle”} ANIMCAO FURAR

    while true do
        timeBank = 5000
        if indexLocal > 0 then
            timeBank = 1
           
            if andamento then
                drawTxt("APERTE ~r~M~w~ PARA CANCELAR O ROUBO EM ANDAMENTO", 4,0.5, 0.91, 0.35, 255, 255, 255, 80)
                drawTxt("RESTAM ~g~" .. segundos .. " SEGUNDOS ~w~PARA TERMINAR", 4,0.5, 0.93, 0.50, 255, 255, 255, 180)

                if IsControlJustPressed(0, 244) or GetEntityHealth(ped) <= 100 then
                    andamento = false
                    ClearPedTasks(ped)
                    func.cancelRobbery()
                    TriggerEvent('cancelando', false)
                end
            else
                local x, y, z = table.unpack(GetEntityCoords(ped))
                local distance = GetDistanceBetweenCoords(localHacker.roubo.x, localHacker.roubo.y, localHacker.roubo.z, x, y, z,true)

                if distance <= 1.2 then
                    drawTxt("PRESSIONE  ~b~E~w~  PARA INICIAR O ROUBO", 4, 0.5,0.93, 0.50, 255, 255, 255, 180)
                    if IsControlJustPressed(0, 38) and
                        not IsPedInAnyVehicle(ped) and func.checkTimers(localHacker.roubo.police) then
                        if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") or
                            GetEntityModel(ped) ==
                            GetHashKey("mp_f_freemode_01") then
                            func.checkRobbery(localHacker.roubo.x, localHacker.roubo.y, localHacker.roubo.z, localHacker.roubo.h, localHacker.roubo.seconds)
                        end
                    end
                end
            end
        end
        Citizen.Wait(timeBank)
    end
end)

function round(num, numDecimalPlaces)
    local mult = 10 ^ (numDecimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- INICIADO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("iniciandoroubobanco")
AddEventHandler("iniciandoroubobanco", function(x, y, z, secs, head)
    segundos = secs
    andamento = true
    SetEntityHeading(PlayerPedId(), head)
    SetEntityCoords(PlayerPedId(), x, y, z - 1, false, false, false, false)
    TriggerEvent("global:getMochilaRoubo")
    SetCurrentPedWeapon(PlayerPedId(), GetHashKey("WEAPON_UNARMED"), true)
    TriggerEvent('cancelando', true)
    timeRoubo()
end)


RegisterNetEvent("vrp_bancofleeca:resetBanco")
AddEventHandler("vrp_bancofleeca:resetBanco", function()
	for i, porta in pairs(Config.hackear) do
		local VaultDoor = GetClosestObjectOfType(porta.x, porta.y, porta.z, 2.0, porta.p, false, false, false)

		NetworkRequestControlOfEntity(VaultDoor)
		
        FreezeEntityPosition(VaultDoor, false)
        SetEntityHeading(VaultDoor, porta.close)
	
		FreezeEntityPosition(VaultDoor, true)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONTAGEM
-----------------------------------------------------------------------------------------------------------------------------------------
function timeRoubo()
    while andamento do
        Citizen.Wait(1000)
        segundos = segundos - 1
        if segundos <= 0 then
            andamento = false
            ClearPedTasks(PlayerPedId())
            TriggerEvent('cancelando', false)
        end
    end
end
