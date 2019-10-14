local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
func = Tunnel.getInterface("vrp_player")

funcServer = {}
Tunnel.bindInterface("vrp_player", funcServer)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SALÁRIO
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(30*60000)
		TriggerServerEvent('salario:pagamento')
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- NOCARJACK
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if DoesEntityExist(GetVehiclePedIsTryingToEnter(PlayerPedId())) then
			local veh = GetVehiclePedIsTryingToEnter(PlayerPedId())
			if GetVehicleDoorLockStatus(veh) >= 2 or GetPedInVehicleSeat(veh,-1) then
				TriggerServerEvent("TryDoorsEveryone",veh,2,GetVehicleNumberPlateText(veh))
			end
		end
	end
end)

RegisterNetEvent("SyncDoorsEveryone")
AddEventHandler("SyncDoorsEveryone",function(veh,doors)
	SetVehicleDoorsLocked(veh,doors)
end)

------------------------------
-- /vtuning
------------------------------
RegisterCommand("vtuning",function(source,args)
    local vehicle = vRP.getNearestVehicle(7)
    local transmissao = "Desativado"
    local motor = "Desativado"
    local freio = "Desativado"
    local suspensao = "Desativado"
    local blindagem = "Desativado"
    if IsEntityAVehicle(vehicle) then
    	if IsToggleModOn(vehicle,18) then
    		turbo = "Ativado"
		else
			turbo = "Desativado"
		end
		if GetVehicleMod(vehicle,11) == 0 then
			motor = "Nível 1/4"
		elseif GetVehicleMod(vehicle,11) == 1 then
			motor = "Nível 2/4"
		elseif GetVehicleMod(vehicle,11) == 2 then
			motor = "Nível 3/4"
		elseif GetVehicleMod(vehicle,11) == 3 then
			motor = "Nível 4/4"
		end
		if GetVehicleMod(vehicle,13) == 0 then
			transmissao = "Nível 1/3"
		elseif GetVehicleMod(vehicle,13) == 1 then
			transmissao = "Nível 2/3"
		elseif GetVehicleMod(vehicle,13) == 2 then
			transmissao = "Nível 3/3"
		end
		if GetVehicleMod(vehicle,12) == 0 then
			freio = "Nível 1/3"
		elseif GetVehicleMod(vehicle,12) == 1 then
			freio = "Nível 2/3"
		elseif GetVehicleMod(vehicle,12) == 2 then
			freio = "Nível 3/3"
		end
		if GetVehicleMod(vehicle,15) == 0 then
			suspensao = "Nível 1/4"
		elseif GetVehicleMod(vehicle,15) == 1 then
			suspensao = "Nível 2/4"
		elseif GetVehicleMod(vehicle,15) == 2 then
			suspensao = "Nível 3/4"
		elseif GetVehicleMod(vehicle,15) == 3 then
			suspensao = "Nível 4/4"
		end
		if GetVehicleMod(vehicle,16) == 0 then 
			blindagem = "Nível 1/5"
		elseif GetVehicleMod(vehicle,16) == 1 then 
			blindagem = "Nível 2/5"
		elseif GetVehicleMod(vehicle,16) == 2 then 
			blindagem = "Nível 3/5"
		elseif GetVehicleMod(vehicle,16) == 3 then 
			blindagem = "Nível 4/5"
		elseif GetVehicleMod(vehicle,16) == 4 then 
			blindagem = "Nível 5/5"
		end
		
		TriggerEvent("Notify","importante2","<b>Motor</b>: "..motor.."<br><b>Turbo</b>: "..turbo.."<br><b>Trasmissão</b>: "..transmissao.."<br><b>Freio</b>: "..freio.."<br><b>Suspensão</b>: "..suspensao.."<br><b>Blindagem</b>: "..blindagem.."<br><b>Chassi</b>: "..parseInt(GetVehicleBodyHealth(vehicle)*0.1).."%<br><b>Motor</b>: "..parseInt(GetVehicleEngineHealth(vehicle)*0.1).."%<br><b>Gasolina</b>: "..parseInt(GetVehicleFuelLevel(vehicle)).."%")
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /ATTACHS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("attachs",function(source,args)
	local ped = PlayerPedId()
	if GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_COMBATPISTOL") then
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_COMBATPISTOL"),GetHashKey("COMPONENT_AT_PI_FLSH"))
	elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_SMG") then
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SMG"),GetHashKey("COMPONENT_AT_AR_FLSH"))
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SMG"),GetHashKey("COMPONENT_AT_SCOPE_MACRO_02"))
	elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_COMBATPDW") then
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_COMBATPDW"),GetHashKey("COMPONENT_AT_AR_FLSH"))
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_COMBATPDW"),GetHashKey("COMPONENT_AT_SCOPE_SMALL"))
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_COMBATPDW"),GetHashKey("COMPONENT_AT_AR_AFGRIP"))
	elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_PUMPSHOTGUN_MK2") then
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_PUMPSHOTGUN_MK2"),GetHashKey("COMPONENT_AT_SIGHTS"))
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_PUMPSHOTGUN_MK2"),GetHashKey("COMPONENT_AT_SCOPE_SMALL_MK2"))
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_PUMPSHOTGUN_MK2"),GetHashKey("COMPONENT_AT_AR_FLSH"))
	elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_CARBINERIFLE") then
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_CARBINERIFLE"),GetHashKey("COMPONENT_AT_AR_FLSH"))
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_CARBINERIFLE"),GetHashKey("COMPONENT_AT_SCOPE_MEDIUM"))
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_CARBINERIFLE"),GetHashKey("COMPONENT_AT_AR_AFGRIP"))
	elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_MICROSMG") then
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_MICROSMG"),GetHashKey("COMPONENT_AT_PI_FLSH"))
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_MICROSMG"),GetHashKey("COMPONENT_AT_SCOPE_MACRO"))
	elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_ASSAULTRIFLE") then
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_ASSAULTRIFLE"),GetHashKey("COMPONENT_AT_AR_FLSH"))
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_ASSAULTRIFLE"),GetHashKey("COMPONENT_AT_SCOPE_MACRO"))
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_ASSAULTRIFLE"),GetHashKey("COMPONENT_AT_AR_AFGRIP"))
	elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_PISTOL_MK2") then
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_PISTOL_MK2"),GetHashKey("COMPONENT_AT_PI_RAIL"))
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_PISTOL_MK2"),GetHashKey("COMPONENT_AT_PI_FLSH_02"))
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_PISTOL_MK2"),GetHashKey("COMPONENT_AT_PI_COMP"))
	elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_PISTOL_MK2") then
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_PISTOL_MK2"),GetHashKey("COMPONENT_AT_PI_RAIL"))
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_PISTOL_MK2"),GetHashKey("COMPONENT_AT_PI_FLSH_02"))
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_PISTOL_MK2"),GetHashKey("COMPONENT_AT_PI_COMP"))
	elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_ASSAULTSMG") then
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_ASSAULTSMG"),GetHashKey("COMPONENT_AT_AR_FLSH"))
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_ASSAULTSMG"),GetHashKey("COMPONENT_AT_SCOPE_MACRO"))
	elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_PISTOL") then
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_PISTOL"),GetHashKey("COMPONENT_AT_PI_FLSH"))
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- CANCELANDO O F6
-----------------------------------------------------------------------------------------------------------------------------------------
local cancelando = false
RegisterNetEvent('cancelando')
AddEventHandler('cancelando',function(status)
    cancelando = status
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if cancelando then
			BlockWeaponWheelThisFrame()
			DisableControlAction(0,288,true)
			DisableControlAction(0,289,true)
			DisableControlAction(0,170,true)
			DisableControlAction(0,166,true)
			DisableControlAction(0,187,true)
			DisableControlAction(0,189,true)
			DisableControlAction(0,190,true)
			DisableControlAction(0,188,true)
			DisableControlAction(0,57,true)
			DisableControlAction(0,73,true)
			DisableControlAction(0,167,true)
			DisableControlAction(0,311,true)
			DisableControlAction(0,344,true)
			DisableControlAction(0,29,true)
			DisableControlAction(0,182,true)
			DisableControlAction(0,245,true)
			DisableControlAction(0,257,true)
			DisableControlAction(0,47,true)
			DisableControlAction(0,38,true)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- AFKSYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	local tempo = 1200
	local lastLoc
	while true do
		
		Citizen.Wait(1000)
		local loc = GetEntityCoords(PlayerPedId())
		if lastLoc == nil then lastLoc = loc end

		local distance = GetDistanceBetweenCoords(loc, lastLoc, true)
		if distance > 0 and distance <= 1 then
			if tempo > 0 then
				tempo = tempo - 1
			else
				TriggerServerEvent("kickAFK")
				tempo = 1200
			end
		else
			tempo = 1200
		end
		lastLoc = loc
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ABRIR PORTA-MALAS DO VEICULO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("trunk",function(source,args)
	local vehicle = vRP.getNearestVehicle(7)
	local locked = GetVehicleDoorLockStatus(vehicle) >= 2
	if not locked and IsEntityAVehicle(vehicle) then
		TriggerServerEvent("trytrunk",VehToNet(vehicle))
	end
end)

RegisterNetEvent("synctrunk")
AddEventHandler("synctrunk",function(index)
	if NetworkDoesNetworkIdExist(index) then
		local v = NetToEnt(index)
		local isopen = GetVehicleDoorAngleRatio(v,5)
		if DoesEntityExist(v) then
			if IsEntityAVehicle(v) then
				if isopen == 0 then
					SetVehicleDoorOpen(v,5,0,0)
				else
					SetVehicleDoorShut(v,5,0)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ABRIR CAPO DO VEICULO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("hood",function(source,args)
	local vehicle = vRP.getNearestVehicle(7)
	local locked = GetVehicleDoorLockStatus(vehicle) >= 2
	if not locked and IsEntityAVehicle(vehicle) then
		TriggerServerEvent("tryhood",VehToNet(vehicle))
	end
end)

RegisterNetEvent("synchood")
AddEventHandler("synchood",function(index)
	if NetworkDoesNetworkIdExist(index) then
		local v = NetToEnt(index)
		local isopen = GetVehicleDoorAngleRatio(v,4)
		if DoesEntityExist(v) then
			if IsEntityAVehicle(v) then
				if isopen == 0 then
					SetVehicleDoorOpen(v,4,0,0)
				else
					SetVehicleDoorShut(v,4,0)
				end
			end
		end
	end
end)


-----------------------------------------------------------------------------------------------------------------------------------------
-- ABRE E FECHA OS VIDROS
-----------------------------------------------------------------------------------------------------------------------------------------
local vidros = false
RegisterCommand("wins",function(source,args)
	local vehicle = vRP.getNearestVehicle(7)
	local locked = GetVehicleDoorLockStatus(vehicle) >= 2
	if not locked and IsEntityAVehicle(vehicle) then
		TriggerServerEvent("trywins",VehToNet(vehicle))
	end
end)

RegisterNetEvent("syncwins")
AddEventHandler("syncwins",function(index)
	if NetworkDoesNetworkIdExist(index) then
		local v = NetToEnt(index)
		if DoesEntityExist(v) then
			if IsEntityAVehicle(v) then
				if vidros then
					vidros = false
					RollUpWindow(v,0)
					RollUpWindow(v,1)
					RollUpWindow(v,2)
					RollUpWindow(v,3)
				else
					vidros = true
					RollDownWindow(v,0)
					RollDownWindow(v,1)
					RollDownWindow(v,2)
					RollDownWindow(v,3)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ABRIR PORTAS DO VEICULO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("doors",function(source,args)
	local vehicle = vRP.getNearestVehicle(7)
	local locked = GetVehicleDoorLockStatus(vehicle) >= 2
	if not locked and IsEntityAVehicle(vehicle) then
		TriggerServerEvent("trydoors",VehToNet(vehicle),args[1])
	end
end)

RegisterNetEvent("syncdoors")
AddEventHandler("syncdoors",function(index,door)
	if NetworkDoesNetworkIdExist(index) then
		local v = NetToEnt(index)
		local isopen = GetVehicleDoorAngleRatio(v,0) and GetVehicleDoorAngleRatio(v,1)
		if DoesEntityExist(v) then
			if IsEntityAVehicle(v) then
				if door == "1" then
					if GetVehicleDoorAngleRatio(v,0) == 0 then
						SetVehicleDoorOpen(v,0,0,0)
					else
						SetVehicleDoorShut(v,0,0)
					end
				elseif door == "2" then
					if GetVehicleDoorAngleRatio(v,1) == 0 then
						SetVehicleDoorOpen(v,1,0,0)
					else
						SetVehicleDoorShut(v,1,0)
					end
				elseif door == "3" then
					if GetVehicleDoorAngleRatio(v,2) == 0 then
						SetVehicleDoorOpen(v,2,0,0)
					else
						SetVehicleDoorShut(v,2,0)
					end
				elseif door == "4" then
					if GetVehicleDoorAngleRatio(v,3) == 0 then
						SetVehicleDoorOpen(v,3,0,0)
					else
						SetVehicleDoorShut(v,3,0)
					end
				elseif door == nil then
					if isopen == 0 then
						SetVehicleDoorOpen(v,0,0,0)
						SetVehicleDoorOpen(v,1,0,0)
						SetVehicleDoorOpen(v,2,0,0)
						SetVehicleDoorOpen(v,3,0,0)
					else
						SetVehicleDoorShut(v,0,0)
						SetVehicleDoorShut(v,1,0)
						SetVehicleDoorShut(v,2,0)
						SetVehicleDoorShut(v,3,0)
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /ME
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('chatME')
AddEventHandler('chatME',function(id,name,message)
	local myId = PlayerId()
	local pid = GetPlayerFromServerId(id)
	if pid == myId then
		TriggerEvent('chatMessage',"",{},"* "..name.." "..message)
	elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)),GetEntityCoords(GetPlayerPed(pid))) < 3.999 then
		TriggerEvent('chatMessage',"",{},"* "..name.." "..message)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /mascara
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("mascara",function(source,args)
	local ped = PlayerPedId()
	if GetEntityHealth(ped) > 100 then
		if args[1] == nil then
			vRP._playAnim(true,{{"misscommon@std_take_off_masks","take_off_mask_ps"}},false)
			Wait(700)
			ClearPedTasks(ped)
			SetPedComponentVariation(ped,1,0,0,2)
			return
		end
		if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") or GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
			vRP._playAnim(true,{{"misscommon@van_put_on_masks","put_on_mask_ps"}},false)
			Wait(1500)
			ClearPedTasks(ped)
			SetPedComponentVariation(ped,1,parseInt(args[1]),parseInt(args[2]),2)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /blusa
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("blusa",function(source,args)
	local ped = PlayerPedId()
	if GetEntityHealth(ped) > 100 and not func.check_procurado(source, nil) then
		if not args[1] then
			SetPedComponentVariation(ped,8,15,0,2)
			return
		end
		if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
			SetPedComponentVariation(ped,8,parseInt(args[1]),parseInt(args[2]),2)
		elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
			SetPedComponentVariation(ped,8,parseInt(args[1]),parseInt(args[2]),2)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /jaqueta
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("jaqueta",function(source,args)
		local ped = PlayerPedId()
		
		if GetEntityHealth(ped) > 100 and not func.check_procurado(nil) then
			if not args[1] then
				SetPedComponentVariation(ped,11,15,0,2)
				return
			end
			if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
				SetPedComponentVariation(ped,11,parseInt(args[1]),parseInt(args[2]),2)
			elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
				SetPedComponentVariation(ped,11,parseInt(args[1]),parseInt(args[2]),2)
			end
		else
			TriggerEvent("Notify","importante","Você está sendo procurado!")
		end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /calca
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("calca",function(source,args)
		local ped = PlayerPedId()
		if GetEntityHealth(ped) > 100 and not func.check_procurado(nil) then
			if not args[1] then
				if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
					SetPedComponentVariation(ped,4,18,0,2)
				elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
					SetPedComponentVariation(ped,4,15,0,2)
				end
				return
			end
			if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
				SetPedComponentVariation(ped,4,parseInt(args[1]),parseInt(args[2]),2)
			elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
				SetPedComponentVariation(ped,4,parseInt(args[1]),parseInt(args[2]),2)
			end
		end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /maos
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("maos",function(source,args)
		local ped = PlayerPedId()
		if GetEntityHealth(ped) > 100 and not func.check_procurado(nil) then
			if not args[1] then
				SetPedComponentVariation(ped,3,15,0,2)
				return
			end
			if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
				SetPedComponentVariation(ped,3,parseInt(args[1]),parseInt(args[2]),2)
			elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
				SetPedComponentVariation(ped,3,parseInt(args[1]),parseInt(args[2]),2)
			end
		end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /acess
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("acessorios",function(source,args)
		local ped = PlayerPedId()
		if GetEntityHealth(ped) > 100 and not func.check_procurado(nil) then
			if not args[1] then
				SetPedComponentVariation(ped,7,0,0,2)
				return
			end
			if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
				SetPedComponentVariation(ped,7,parseInt(args[1]),parseInt(args[2]),2)
			elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
				SetPedComponentVariation(ped,7,parseInt(args[1]),parseInt(args[2]),2)
			end
		end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /acess
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("sapatos",function(source,args)
		local ped = PlayerPedId()
		if GetEntityHealth(ped) > 100 and not func.check_procurado(nil) then
			if not args[1] then
				if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
					SetPedComponentVariation(ped,6,34,0,2)
				elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
					SetPedComponentVariation(ped,6,35,0,2)
				end
				return
			end
			if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
				SetPedComponentVariation(ped,6,parseInt(args[1]),parseInt(args[2]),2)
			elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
				SetPedComponentVariation(ped,6,parseInt(args[1]),parseInt(args[2]),2)
			end
		end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /CHAPEU
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("chapeu",function(source,args)
		local ped = PlayerPedId()
		if GetEntityHealth(ped) > 100 and not func.check_procurado(nil) then
			if not args[1] then
				vRP._playAnim(true,{{"veh@common@fp_helmet@","take_off_helmet_stand"}},false)
				Wait(700)
				ClearPedProp(ped,0)
				return
			end
			if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
				vRP._playAnim(true,{{"veh@common@fp_helmet@","put_on_helmet"}},false)
				Wait(1700)
				SetPedPropIndex(ped,0,parseInt(args[1]),parseInt(args[2]),2)
			elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
				vRP._playAnim(true,{{"veh@common@fp_helmet@","put_on_helmet"}},false)
				Wait(1700)
				SetPedPropIndex(ped,0,parseInt(args[1]),parseInt(args[2]),2)
			end
		end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /OCULOS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("oculos",function(source,args)
		local ped = PlayerPedId()
		if GetEntityHealth(ped) > 100 then
			if not args[1] then
				vRP._playAnim(true,{{"misscommon@std_take_off_masks","take_off_mask_ps"}},false)
				Wait(400)
				ClearPedTasks(ped)
				ClearPedProp(ped,1)
				return
			end
			if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
				vRP._playAnim(true,{{"misscommon@van_put_on_masks","put_on_mask_ps"}},false)
				Wait(800)
				ClearPedTasks(ped)
				SetPedPropIndex(ped,1,parseInt(args[1]),parseInt(args[2]),2)
			elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
				vRP._playAnim(true,{{"misscommon@van_put_on_masks","put_on_mask_ps"}},false)
				Wait(800)
				ClearPedTasks(ped)
				SetPedPropIndex(ped,1,parseInt(args[1]),parseInt(args[2]),2)
			end
		end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ANDAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("homem",function(source,args)
	vRP.loadAnimSet("move_m@confident")
end)

RegisterCommand("mulher",function(source,args)
	vRP.loadAnimSet("move_f@heels@c")
end)

RegisterCommand("depressivo",function(source,args)
	vRP.loadAnimSet("move_m@depressed@a")
end)

RegisterCommand("depressiva",function(source,args)
	vRP.loadAnimSet("move_f@depressed@a")
end)

RegisterCommand("empresario",function(source,args)
	vRP.loadAnimSet("move_m@business@a")
end)

RegisterCommand("determinado",function(source,args)
	vRP.loadAnimSet("move_m@brave@a")
end)

RegisterCommand("descontraido",function(source,args)
	vRP.loadAnimSet("move_m@casual@a")
end)

RegisterCommand("farto",function(source,args)
	vRP.loadAnimSet("move_m@fat@a")
end)

RegisterCommand("estiloso",function(source,args)
	vRP.loadAnimSet("move_m@hipster@a")
end)

RegisterCommand("ferido",function(source,args)
	vRP.loadAnimSet("move_m@injured")
end)

RegisterCommand("nervoso",function(source,args)
	vRP.loadAnimSet("move_m@hurry@a")
end)

RegisterCommand("desleixado",function(source,args)
	vRP.loadAnimSet("move_m@hobo@a")
end)

RegisterCommand("infeliz",function(source,args)
	vRP.loadAnimSet("move_m@sad@a")
end)

RegisterCommand("musculoso",function(source,args)
	vRP.loadAnimSet("move_m@muscle@a")
end)

RegisterCommand("desligado",function(source,args)
	vRP.loadAnimSet("move_m@shadyped@a")
end)

RegisterCommand("fadiga",function(source,args)
	vRP.loadAnimSet("move_m@buzzed")
end)

RegisterCommand("apressado",function(source,args)
	vRP.loadAnimSet("move_m@hurry_butch@a")
end)

RegisterCommand("descolado",function(source,args)
	vRP.loadAnimSet("move_m@money")
end)

RegisterCommand("corridinha",function(source,args)
	vRP.loadAnimSet("move_m@quick")
end)

RegisterCommand("piriguete",function(source,args)
	vRP.loadAnimSet("move_f@maneater")
end)

RegisterCommand("petulante",function(source,args)
	vRP.loadAnimSet("move_f@sassy")
end)

RegisterCommand("arrogante",function(source,args)
	vRP.loadAnimSet("move_f@arrogant@a")
end)

RegisterCommand("bebado",function(source,args)
	vRP.loadAnimSet("move_m@drunk@slightlydrunk")
end)

RegisterCommand("bebado2",function(source,args)
	vRP.loadAnimSet("move_m@drunk@verydrunk")
end)

RegisterCommand("bebado3",function(source,args)
	vRP.loadAnimSet("move_m@drunk@moderatedrunk")
end)

RegisterCommand("irritado",function(source,args)
	vRP.loadAnimSet("move_m@fire")
end)

RegisterCommand("intimidado",function(source,args)
	vRP.loadAnimSet("move_m@intimidation@cop@unarmed")
end)

RegisterCommand("poderosa",function(source,args)
	vRP.loadAnimSet("move_f@handbag")
end)

RegisterCommand("chateado",function(source,args)
	vRP.loadAnimSet("move_f@injured")
end)

RegisterCommand("estilosa",function(source,args)
	vRP.loadAnimSet("move_f@posh@")
end)

RegisterCommand("sensual",function(source,args)
	vRP.loadAnimSet("move_f@sexy@a")
end)
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- -- /TOW
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- local reboque = nil
-- local rebocado = nil
-- RegisterCommand("tow",function(source,args)
-- 	local vehicle = GetPlayersLastVehicle()
-- 	local vehicletow = IsVehicleModel(vehicle,GetHashKey("flatbed"))

-- 	if vehicletow and not IsPedInAnyVehicle(PlayerPedId()) then
-- 		rebocado = getVehicleInDirection(GetEntityCoords(PlayerPedId()),GetOffsetFromEntityInWorldCoords(PlayerPedId(),0.0,5.0,0.0))
-- 		if reboque == nil then
-- 			if vehicle ~= rebocado then
-- 				local min,max = GetModelDimensions(GetEntityModel(rebocado))
-- 				AttachEntityToEntity(rebocado,vehicle,GetEntityBoneIndexByName(vehicle,"bodyshell"),0,-2.2,0.4-min.z,0,0,0,1,1,0,1,0,1)
-- 				reboque = rebocado
-- 			end
-- 		else
-- 			AttachEntityToEntity(reboque,vehicle,20,-0.5,-15.0,-0.3,0.0,0.0,0.0,false,false,true,false,20,true)
-- 			DetachEntity(reboque,false,false)
-- 			PlaceObjectOnGroundProperly(reboque)
-- 			reboque = nil
-- 			rebocado = nil
-- 		end
-- 	end
-- end)

function getVehicleInDirection(coordsfrom,coordsto)
	local handle = CastRayPointToPoint(coordsfrom.x,coordsfrom.y,coordsfrom.z,coordsto.x,coordsto.y,coordsto.z,10,PlayerPedId(),false)
	local a,b,c,d,vehicle = GetRaycastResult(handle)
	return vehicle
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REPARAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('reparar')
AddEventHandler('reparar',function(isMotoClub)
	local vehicle = vRP.getNearestVehicle(7)
	if IsEntityAVehicle(vehicle) then
		TriggerServerEvent("tryreparar",VehToNet(vehicle))
	end
end)

RegisterNetEvent('syncreparar')
AddEventHandler('syncreparar',function(index)
	if NetworkDoesNetworkIdExist(index) then
		local v = NetToEnt(index)
		if DoesEntityExist(v) then
			if IsEntityAVehicle(v) then
				-- local oldFuel = DecorGetFloat(v,"FUEL_LEVEL")
				SetVehicleFixed(v)
				SetVehicleDirtLevel(v,0.0)
				SetVehicleUndriveable(v,false)
				SetEntityAsMissionEntity(v,true,true)
				SetVehicleOnGroundProperly(v)
				-- SetVehicleFuelLevel(v,oldFuel)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REPARAR MOTOR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('repararmotor')
AddEventHandler('repararmotor',function()
	local vehicle = vRP.getNearestVehicle(7)
	if IsEntityAVehicle(vehicle) then
		TriggerServerEvent("trymotor",VehToNet(vehicle))
	end
end)

RegisterNetEvent('syncmotor')
AddEventHandler('syncmotor',function(index)
	if NetworkDoesNetworkIdExist(index) then
		local v = NetToEnt(index)
		if DoesEntityExist(v) then
			if IsEntityAVehicle(v) then
				SetVehicleEngineHealth(v,1000.0)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BANDAGEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('bandagem')
AddEventHandler('bandagem',function()
	local bandagem = 0
	repeat
		bandagem = bandagem + 1
		SetEntityHealth(PlayerPedId(),GetEntityHealth(PlayerPedId())+1)
		Citizen.Wait(600)
	until GetEntityHealth(PlayerPedId()) >= 400 or GetEntityHealth(PlayerPedId()) <= 100 or bandagem == 100
		TriggerEvent("Notify","sucesso","Tratamento concluido.")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BANDAGEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('tratamento')
AddEventHandler('tratamento',function()
	repeat
		SetEntityHealth(PlayerPedId(),GetEntityHealth(PlayerPedId())+1)
		Citizen.Wait(600)
	until GetEntityHealth(PlayerPedId()) >= 400 or GetEntityHealth(PlayerPedId()) <= 100
		TriggerEvent("Notify","sucesso","Tratamento concluido.")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /CARTAS
-----------------------------------------------------------------------------------------------------------------------------------------
local card = {
	[1] = "A",
	[2] = "2",
	[3] = "3",
	[4] = "4",
	[5] = "5",
	[6] = "6",
	[7] = "7",
	[8] = "8",
	[9] = "9",
	[10] = "10",
	[11] = "J",
	[12] = "Q",
	[13] = "K"
}

local tipos = {
	[1] = "^8♣",
	[2] = "^8♠",
	[3] = "^9♦",
	[4] = "^9♥"
}

RegisterNetEvent('CartasMe')
AddEventHandler('CartasMe',function(id,name,cd,naipe)
	local monid = PlayerId()
	local sonid = GetPlayerFromServerId(id)
	if sonid == monid then
		TriggerEvent('chatMessage',"",{},"^3* "..name.." tirou do baralho a carta: "..card[cd]..""..tipos[naipe])
	elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(monid)),GetEntityCoords(GetPlayerPed(sonid)),true) < 5.999 then
		TriggerEvent('chatMessage',"",{},"^3* "..name.." tirou do baralho a carta: "..card[cd]..""..tipos[naipe])
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /CARREGAR
-----------------------------------------------------------------------------------------------------------------------------------------
local carregado = false
RegisterCommand("carregar",function(source,args)
	local ped = PlayerPedId()
	local randomico,npcs = FindFirstPed()
	repeat
		local distancia = GetDistanceBetweenCoords(GetEntityCoords(ped),GetEntityCoords(npcs),true)
		if not IsPedAPlayer(npcs) and distancia <= 3 and not IsPedInAnyVehicle(ped) and not IsPedInAnyVehicle(npcs) then
			if carregado then
				ClearPedTasksImmediately(carregado)
				DetachEntity(carregado,true,true)
				TaskWanderStandard(carregado,10.0,10)
				SetEntityAsMissionEntity(carregado,false,true)
				carregado = false
			else
				SetEntityAsMissionEntity(npcs,true,true)
				AttachEntityToEntity(npcs,ped,4103,11816,0.48,0.0,0.0,0.0,0.0,0.0,false,false,true,false,2,true)
				carregado = npcs
				sucess = true
			end
		end
	sucess,npcs = FindNextPed(randomico)
	until not sucess
	EndFindPed(randomico)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /sequestro2
-----------------------------------------------------------------------------------------------------------------------------------------
local sequestrado = nil
RegisterCommand("sequestro2",function(source,args)
	local ped = PlayerPedId()
	local random,npc = FindFirstPed()
	repeat
		local distancia = GetDistanceBetweenCoords(GetEntityCoords(ped),GetEntityCoords(npc),true)
		if not IsPedAPlayer(npc) and distancia <= 3 and not IsPedInAnyVehicle(npc) then
			vehicle = vRP.getNearestVehicle(7)
			if IsEntityAVehicle(vehicle) then
				if vRP.getCarroClass(vehicle) then
					if sequestrado then
						AttachEntityToEntity(sequestrado,vehicle,GetEntityBoneIndexByName(vehicle,"bumper_r"),0.6,-1.2,-0.6,60.0,-90.0,180.0,false,false,false,true,2,true)
						DetachEntity(sequestrado,true,true)
						SetEntityVisible(sequestrado,true)
						SetEntityInvincible(sequestrado,false)
						SetEntityAsMissionEntity(sequestrado,false,true)
						ClearPedTasksImmediately(sequestrado)
						sequestrado = nil
					elseif not sequestrado then
						SetEntityAsMissionEntity(npc,true,true)
						AttachEntityToEntity(npc,vehicle,GetEntityBoneIndexByName(vehicle,"bumper_r"),0.6,-0.4,-0.1,60.0,-90.0,180.0,false,false,false,true,2,true)
						SetEntityVisible(npc,false)
						SetEntityInvincible(npc,true)
						sequestrado = npc
						complet = true
					end
					TriggerServerEvent("trymala",VehToNet(vehicle))
				end
			end
		end
		complet,npc = FindNextPed(random)
	until not complet
	EndFindPed(random)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- EMPURRAR
-----------------------------------------------------------------------------------------------------------------------------------------
local entityEnumerator = {
	__gc = function(enum)
		if enum.destructor and enum.handle then
			enum.destructor(enum.handle)
		end
		enum.destructor = nil
		enum.handle = nil
	end
}

local function EnumerateEntities(initFunc,moveFunc,disposeFunc)
	return coroutine.wrap(function()
		local iter, id = initFunc()
		if not id or id == 0 then
			disposeFunc(iter)
			return
		end

		local enum = { handle = iter, destructor = disposeFunc }
		setmetatable(enum, entityEnumerator)

		local next = true
		repeat
		coroutine.yield(id)
		next,id = moveFunc(iter)
		until not next

		enum.destructor,enum.handle = nil,nil
		disposeFunc(iter)
	end)
end

function EnumerateVehicles()
	return EnumerateEntities(FindFirstVehicle,FindNextVehicle,EndFindVehicle)
end

function GetVeh()
    local vehicles = {}
    for vehicle in EnumerateVehicles() do
        table.insert(vehicles,vehicle)
    end
    return vehicles
end

function GetClosestVeh(coords)
	local vehicles = GetVeh()
	local closestDistance = -1
	local closestVehicle = -1
	local coords = coords

	if coords == nil then
		local ped = PlayerPedId()
		coords = GetEntityCoords(ped)
	end

	for i=1,#vehicles,1 do
		local vehicleCoords = GetEntityCoords(vehicles[i])
		local distance = GetDistanceBetweenCoords(vehicleCoords,coords.x,coords.y,coords.z,true)
		if closestDistance == -1 or closestDistance > distance then
			closestVehicle  = vehicles[i]
			closestDistance = distance
		end
	end
	return closestVehicle,closestDistance
end

local First = vector3(0.0,0.0,0.0)
local Second = vector3(5.0,5.0,5.0)
local Vehicle = { Coords = nil, Vehicle = nil, Dimension = nil, IsInFront = false, Distance = nil }

Citizen.CreateThread(function()
	while true do
		local ped = PlayerPedId()
		local closestVehicle,Distance = GetClosestVeh()
		if Distance < 6.1 and not IsPedInAnyVehicle(ped) then
			Vehicle.Coords = GetEntityCoords(closestVehicle)
			Vehicle.Dimensions = GetModelDimensions(GetEntityModel(closestVehicle),First,Second)
			Vehicle.Vehicle = closestVehicle
			Vehicle.Distance = Distance
			if GetDistanceBetweenCoords(GetEntityCoords(closestVehicle) + GetEntityForwardVector(closestVehicle), GetEntityCoords(ped), true) > GetDistanceBetweenCoords(GetEntityCoords(closestVehicle) + GetEntityForwardVector(closestVehicle) * -1, GetEntityCoords(ped), true) then
				Vehicle.IsInFront = false
			else
				Vehicle.IsInFront = true
			end
		else
			Vehicle = { Coords = nil, Vehicle = nil, Dimensions = nil, IsInFront = false, Distance = nil }
		end
		Citizen.Wait(500)
	end
end)

Citizen.CreateThread(function()
	while true do 
		Citizen.Wait(500)
		if Vehicle.Vehicle ~= nil then
			local ped = PlayerPedId()
			roll = GetEntityRoll(Vehicle.Vehicle)
			if IsControlPressed(0,244) and IsVehicleSeatFree(Vehicle.Vehicle,-1) and not IsEntityAttachedToEntity(ped,Vehicle.Vehicle) and not (roll > 75.0 or roll < -75.0) then
				RequestAnimDict('missfinale_c2ig_11')
				TaskPlayAnim(ped,'missfinale_c2ig_11','pushcar_offcliff_m',2.0,-8.0,-1,35,0,0,0,0)
				NetworkRequestControlOfEntity(Vehicle.Vehicle)

				if Vehicle.IsInFront then
					AttachEntityToEntity(ped,Vehicle.Vehicle,GetPedBoneIndex(6286),0.0,Vehicle.Dimensions.y*-1+0.1,Vehicle.Dimensions.z+1.0,0.0,0.0,180.0,0.0,false,false,true,false,true)
				else
					AttachEntityToEntity(ped,Vehicle.Vehicle,GetPedBoneIndex(6286),0.0,Vehicle.Dimensions.y-0.3,Vehicle.Dimensions.z+1.0,0.0,0.0,0.0,0.0,false,false,true,false,true)
				end

				while true do
					Citizen.Wait(5)
					if IsDisabledControlPressed(0,34) then
						TaskVehicleTempAction(ped,Vehicle.Vehicle,11,100)
					end

					if IsDisabledControlPressed(0,9) then
						TaskVehicleTempAction(ped,Vehicle.Vehicle,10,100)
					end

					if Vehicle.IsInFront then
						SetVehicleForwardSpeed(Vehicle.Vehicle,-1.0)
					else
						SetVehicleForwardSpeed(Vehicle.Vehicle,1.0)
					end

					if not IsDisabledControlPressed(0,244) then
						DetachEntity(ped,false,false)
						StopAnimTask(ped,'missfinale_c2ig_11','pushcar_offcliff_m',2.0)
						break
					end
				end
			end
		end
	end
end)
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Boca dos Personagem mexendo
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function GetPlayers()
  local players = {}
  for i = 0, 256 do
      if NetworkIsPlayerActive(i) then
          players[#players + 1] = i
      end
  end
  return players
end

Citizen.CreateThread(function()
  RequestAnimDict("facials@gen_male@variations@normal")
  RequestAnimDict("mp_facial")

  local talkingPlayers = {}
  while true do
      Citizen.Wait(300)

      for k,v in pairs(GetPlayers()) do
          local boolTalking = NetworkIsPlayerTalking(v)
          if v ~= PlayerId() then
              if boolTalking and not talkingPlayers[v] then
                  PlayFacialAnim(GetPlayerPed(v), "mic_chatter", "mp_facial")
                  talkingPlayers[v] = true
              elseif not boolTalking and talkingPlayers[v] then
                  PlayFacialAnim(GetPlayerPed(v), "mood_normal_1", "facials@gen_male@variations@normal")
                  talkingPlayers[v] = nil
              end
          end
      end
  end
end)


-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- PEGAR NEVE
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("neve", function(source,args)
    RequestAnimDict('anim@mp_snowball')
    if IsNextWeatherType('XMAS') and not IsPedInAnyVehicle(GetPlayerPed(-1), true) and not IsPlayerFreeAiming(PlayerId()) and not IsPedSwimming(PlayerPedId()) and not IsPedSwimmingUnderWater(PlayerPedId()) and not IsPedRagdoll(PlayerPedId()) and not IsPedFalling(PlayerPedId()) and not IsPedRunning(PlayerPedId()) and not IsPedSprinting(PlayerPedId()) and GetInteriorFromEntity(PlayerPedId()) == 0 and not IsPedShooting(PlayerPedId()) and not IsPedUsingAnyScenario(PlayerPedId()) and not IsPedInCover(PlayerPedId(), 0) then -- check if the snowball should be picked up
        TaskPlayAnim(PlayerPedId(), 'anim@mp_snowball', 'pickup_snowball', 8.0, -1, -1, 0, 1, 0, 0, 0) -- pickup the snowball
        Citizen.Wait(1950) -- wait 1.95 seconds to prevent spam clicking and getting a lot of snowballs without waiting for animatin to finish.
        GiveWeaponToPed(GetPlayerPed(-1), GetHashKey('WEAPON_SNOWBALL'), 5, false, true) -- get 2 snowballs each time.
    end
end)


RegisterNetEvent("sendMsg")
AddEventHandler("sendMsg",function(number, message)
	TriggerServerEvent('gcPhone:sendMessage', number, message)
end)

function funcServer.podeReparar()
	local vehicle = vRP.getNearestVehicle(7)
	local vehicleClass = GetVehicleClass(vehicle)

	if vehicleClass ~= 8 then
		return false
	end

	return true
end

function funcServer.getLifePed() return GetEntityHealth(PlayerPedId()) end

