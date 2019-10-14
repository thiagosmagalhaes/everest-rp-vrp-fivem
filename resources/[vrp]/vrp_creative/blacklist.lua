-----------------------------------------------------------------------------------------------------------------------------------------
-- VEICULOS PROIBIDOS
-----------------------------------------------------------------------------------------------------------------------------------------
blackVehicles = {
-- 	"taco",
-- --	"bus",
-- 	"mule",
-- 	"mule2",
-- 	"mule3",
-- 	"mule4",
-- 	"pounder",
-- 	"biff"
}

-- Citizen.CreateThread(function()
-- 	while true do
-- 		Citizen.Wait(1)
-- 		checkCar(GetVehiclePedIsIn(PlayerPedId()))
-- 		x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
-- 		for k,v in pairs(blackVehicles) do
-- 			checkCar(GetClosestVehicle(x,y,z,300.0,GetHashKey(v),70))
-- 		end
-- 	end
-- end)

-- function checkCar(vehicle)
-- 	if vehicle then
-- 		local model = GetEntityModel(vehicle)
-- 		if isCarBlacklisted(model) then
-- 			Citizen.InvokeNative(0xAE3CBE5BF394C9C9,Citizen.PointerValueIntInitialized(vehicle))
-- 		end
-- 	end
-- end

-- function isCarBlacklisted(model)
-- 	for k,v in pairs(blackVehicles) do
-- 		if model == GetHashKey(v) then
-- 			return true
-- 		end
-- 	end
-- 	return false
-- end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ARMAS PROIBIDAS
-----------------------------------------------------------------------------------------------------------------------------------------
-- blackWeapons = {
	
-- }

-- Citizen.CreateThread(function()
-- 	while true do
-- 		Citizen.Wait(100)
-- 		for k,v in ipairs(blackWeapons) do
-- 			if HasPedGotWeapon(PlayerPedId(),GetHashKey(v),false) == 1 then
-- 				RemoveWeaponFromPed(PlayerPedId(),GetHashKey(v))
-- 			end
-- 		end
-- 	end
-- end)