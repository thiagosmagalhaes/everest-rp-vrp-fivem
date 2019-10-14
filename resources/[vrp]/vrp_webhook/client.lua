local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPServer = Tunnel.getInterface("vrp_webhook")

BlacklistedWeapons = { 
	"WEAPON_APPISTOL",
	"WEAPON_PISTOL50",
	"WEAPON_SNSPISTOL_MK2",
	"WEAPON_HEAVYPISTOL",
	-- "WEAPON_FLAREGUN",
	"WEAPON_MARKSMANPISTOL",
	-- "WEAPON_REVOLVER_MK2",
	"WEAPON_DOUBLEACTION",
	"WEAPON_RAYPISTOL",
	"WEAPON_SMG_MK2",
	"WEAPON_MACHINEPISTOL",
	"WEAPON_MINISMG",
	"WEAPON_RAYCARBINE",
	"WEAPON_PUMPSHOTGUN",
	"WEAPON_SAWNOFFSHOTGUN",
	"WEAPON_ASSAULTSHOTGUN",
	"WEAPON_BULLPUPSHOTGUN",
	"WEAPON_HEAVYSHOTGUN",
	"WEAPON_DBSHOTGUN",
	-- "WEAPON_GUSENBERG",
	"WEAPON_ASSAULTRIFLE_MK2",
	"WEAPON_CARBINERIFLE_MK2",
	"WEAPON_ADVANCEDRIFLE",
	"WEAPON_SPECIALCARBINE",
	"WEAPON_SPECIALCARBINE_MK2",
	"WEAPON_BULLPUPRIFLE",
	"WEAPON_BULLPUPRIFLE_MK2",
	-- "WEAPON_COMPACTRIFLE",
	"WEAPON_MG",
	"WEAPON_COMBATMG",
	"WEAPON_COMBATMG_MK2",
	"WEAPON_SNIPERRIFLE",
	"WEAPON_HEAVYSNIPER",
	"WEAPON_HEAVYSNIPER_MK2",
	"WEAPON_MARKSMANRIFLE",
	"WEAPON_MARKSMANRIFLE_MK2",
	"WEAPON_RPG",
	"WEAPON_GRENADELAUNCHER",
	"WEAPON_GRENADELAUNCHER_SMOKE",
	"WEAPON_MINIGUN",
	-- "WEAPON_FIREWORK",
	"WEAPON_RAILGUN",
	"WEAPON_HOMINGLAUNCHER",
	"WEAPON_COMPACTLAUNCHER",
	"WEAPON_RAYMINIGUN",
	"WEAPON_GRENADE",
	-- "WEAPON_BZGAS",
	-- "WEAPON_MOLOTOV",
	"WEAPON_STICKYBOMB",
	"WEAPON_PROXMINE",
	-- "WEAPON_SNOWBALL",
	"WEAPON_PIPEBOMB",
	"WEAPON_BALL",
	-- "WEAPON_SMOKEGRENADE",
	"WEAPON_PISTOL",
}

CageObjs = {
	"prop_gold_cont_01",
	"p_cablecar_s",
	"stt_prop_stunt_tube_l",
	"stt_prop_stunt_track_dwuturn",
	"prop_beach_fire"
}


Citizen.CreateThread(function()
	while true do
		Wait(30000)
		TriggerServerEvent("anticheese:timer:b2k")
	end
end)

Citizen.CreateThread(function()
	Citizen.Wait(5000)
	while true do
		Citizen.Wait(0)
		local ped = PlayerPedId()
		local posx,posy,posz = table.unpack(GetEntityCoords(ped,true))
		local still = IsPedStill(ped)
		local vel = GetEntitySpeed(ped)
		local ped = PlayerPedId()
		local veh = IsPedInAnyVehicle(ped, true)
		local speed = GetEntitySpeed(ped)
		local para = GetPedParachuteState(ped)
		local flyveh = IsPedInFlyingVehicle(ped)
		local rag = IsPedRagdoll(ped)
		local fall = IsPedFalling(ped)
		local parafall = IsPedInParachuteFreeFall(ped)
		--SetEntityVisible(PlayerPedId(), true) -- make sure player is visible
		Wait(3000) -- wait 3 seconds and check again

		local more = speed - 9.0 -- avarage running speed is 7.06 so just incase someone runs a bit faster it wont trigger

		local rounds = tonumber(string.format("%.2f", speed))
		local roundm = tonumber(string.format("%.2f", more))


		--if not IsEntityVisible(PlayerPedId()) then
		--	SetEntityHealth(PlayerPedId(), -100) -- if player is invisible kill him!
		--end

		newx,newy,newz = table.unpack(GetEntityCoords(ped,true))
		newPed = PlayerPedId() -- make sure the peds are still the same, otherwise the player probably respawned
		if GetDistanceBetweenCoords(posx,posy,posz, newx, newy, newz) > 300 and still == IsPedStill(ped) and ped == newPed then
			TriggerServerEvent("AntiCheese:NoclipFlag", GetDistanceBetweenCoords(posx,posy,posz, newx,newy,newz))
		end

		if speed > 9.0 and not veh and (para == -1 or para == 0) and not flyveh and not fall and not parafall and not rag then
			--não ative isso, está quebrado!
			--TriggerServerEvent("AntiCheese:SpeedFlag", rounds, roundm) -- send alert along with the rounded speed and how much faster they are
		end
	end
end)

-- Citizen.CreateThread(function()
-- 	while true do
-- 		Citizen.Wait(60000)
-- 		local curPed = PlayerPedId()
-- 		local curHealth = GetEntityHealth( curPed )
-- 		SetEntityHealth( curPed, curHealth-2)
-- 		local curWait = math.random(10,150)
-- 		-- this will substract 2hp from the current player, wait 50ms and then add it back, this is to check for hacks that force HP at 200
-- 		Citizen.Wait(curWait)

-- 		if PlayerPedId() == curPed and GetEntityHealth(curPed) == curHealth and GetEntityHealth(curPed) ~= 0 then
-- 			TriggerServerEvent("AntiCheese:HealthFlag", false, curHealth-2, GetEntityHealth( curPed ),curWait )
-- 		elseif GetEntityHealth(curPed) == curHealth-2 then
-- 			SetEntityHealth(curPed, GetEntityHealth(curPed)+2)
-- 		end
		
-- 		if GetEntityHealth(curPed) > 400 then
-- 			TriggerServerEvent("AntiCheese:HealthFlag", false, GetEntityHealth( curPed )-200, GetEntityHealth( curPed ),curWait )
-- 		end

-- 		if GetPlayerInvincible(PlayerId() ) then -- if the player is invincible, flag him as a cheater and then disable their invincibility
-- 			TriggerServerEvent("AntiCheese:HealthFlag", true, curHealth-2, GetEntityHealth( curPed ),curWait )
-- 			SetPlayerInvincible(PlayerId(), false )
-- 		end
-- 	end
-- end)

-- previna munição infinita, modo de deus, invisibilidade e ped speed hacks, e teleports
Citizen.CreateThread(function()
    while true do
		Citizen.Wait(0)
		SetPedInfiniteAmmoClip(PlayerPedId(), false)
		-- SetEntityInvincible(PlayerPedId(), false)
		SetEntityCanBeDamaged(PlayerPedId(), true)
		ResetEntityAlpha(PlayerPedId())
		local fallin = IsPedFalling(PlayerPedId())
		local ragg = IsPedRagdoll(PlayerPedId())
		local parac = GetPedParachuteState(PlayerPedId())
		if parac >= 0 or ragg or fallin then
			SetEntityMaxSpeed(PlayerPedId(), 80.0)
		else
			SetEntityMaxSpeed(PlayerPedId(), 7.1)
		end
    end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		local removeAllWeapons = false
		for _,theWeapon in ipairs(BlacklistedWeapons) do
			Citizen.Wait(1)
			if HasPedGotWeapon(PlayerPedId(),GetHashKey(theWeapon),false) == 1 then
					removeAllWeapons = true
					TriggerServerEvent("AntiCheese:WeaponFlag", theWeapon)
			end
		end
		if removeAllWeapons then
			RemoveAllPedWeapons(PlayerPedId(),false)
		end
	end
end)

function ReqAndDelete(object, detach)
	if DoesEntityExist(object) then
		NetworkRequestControlOfEntity(object)
		while not NetworkHasControlOfEntity(object) do
			Citizen.Wait(10)
		end
		if detach then
			DetachEntity(object, 0, false)
		end
		SetEntityCollision(object, false, false)
		SetEntityAlpha(object, 0.0, true)
		SetEntityAsMissionEntity(object, true, true)
		SetEntityAsNoLongerNeeded(object)
		DeleteEntity(object)
	end
end


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(500)
		local ped = PlayerPedId()
		local handle, object = FindFirstObject()
		local finished = false
		repeat
			Wait(1)
			-- if IsEntityAttached(object) and DoesEntityExist(object) then
			-- 	if GetEntityModel(object) == GetHashKey("prop_acc_guitar_01") then
			-- 		ReqAndDelete(object, true)
			-- 	end
			-- end
			for i=1,#CageObjs do
				if GetEntityModel(object) == GetHashKey(CageObjs[i]) then
					ReqAndDelete(object, false)
				end
			end
			finished, object = FindNextObject(handle)
		until not finished
		EndFindObject(handle)
	end
end)


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if IsPedJumping(PlayerPedId()) then
			local jumplength = 0
			repeat
				Wait(0)
				jumplength=jumplength+1
				local isStillJumping = IsPedJumping(PlayerPedId())
			until not isStillJumping
			if jumplength > 250 then
				TriggerServerEvent("AntiCheese:JumpFlag", jumplength )
			end
		end
	end
end)

-- Monitorar Spawn de Carro
-- local tryIntroCar = false



local displaying = false
RegisterNetEvent('vrp_webhook:triggerDisplay')
AddEventHandler('vrp_webhook:triggerDisplay', function(enable, source)
    displaying = enable
    Display(GetPlayerFromServerId(source))
end)
local userId = 0
function Display(mePlayer)
	
	while displaying do
		local coords = GetEntityCoords(PlayerPedId(), false)
		for id = 0, 256 do
            if ((NetworkIsPlayerActive(id))) then
                ped = GetPlayerPed(id)

                local coordsMe = GetEntityCoords(GetPlayerPed(id), false)
                distance = math.floor(GetDistanceBetweenCoords(x1, y1, z1, x2,
                                                               y2, z2, true))
				local dist = GetDistanceBetweenCoords(coordsMe['x'], coordsMe['y'], coordsMe['z'], coords['x'], coords['y'], coords['z'], true)
				-- if dist < 150 then
					-- if userId == 0 then
					-- 	userId = vRPServer.getUserId()
					-- end
					-- DrawText3D(coordsMe['x'], coordsMe['y'], coordsMe['z']+0.95, "0")
					if id ~= mePlayer then
						if not IsEntityVisible(ped) then
							DrawMarker(1, coordsMe['x'], coordsMe['y'], coordsMe['z'] -  0.95, 0, 0, 0, 0, 0, 0,
											3.0, 3.0, 150.0, 255, 212, 0, 50, 0, 0, 2,
											0, 0, 0, 0)    
						else
							DrawMarker(1, coordsMe['x'], coordsMe['y'], coordsMe['z'] -  0.95, 0, 0, 0, 0, 0, 0,
											3.0, 3.0, 150.0, 255, 0, 0, 50, 0, 0, 2,
											0, 0, 0, 0)  
						end  
					end
				
            end
		end
		Citizen.Wait(1)
    end
end

function DrawText3D(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.5, 0.5)
    SetTextFont(5)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 255)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    -- local factor = (string.len(text)) / 370
    -- DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 85)
end


local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, 
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, 
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}
