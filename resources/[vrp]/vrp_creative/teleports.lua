local Teleport = {
	["HOSPITAL"] = {
		positionFrom = { ['x'] = 340.37, ['y'] = -592.84, ['z'] = 43.28 },
		positionTo = { ['x'] = 338.53, ['y'] = -583.79, ['z'] = 74.16 }
	},
	["ESCRITORIO"] = {
		positionFrom = { ['x'] = -70.93, ['y'] = -801.04, ['z'] = 44.22 },
		positionTo = { ['x'] = -74.57, ['y'] = -820.91, ['z'] = 243.38 }
	},
	["COMEDY"] = {
		positionFrom = { ['x'] = -430.04, ['y'] = 261.80, ['z'] = 83.00 },
		positionTo = { ['x'] = -458.92, ['y'] = 284.85, ['z'] = 78.52 }
	},
	["TELEFERICO"] = {
		positionFrom = { ['x'] = -741.06, ['y'] = 5593.12, ['z'] = 41.65 },
		positionTo = { ['x'] = 446.15, ['y'] = 5571.72, ['z'] = 781.18 }
	},
	["NECROTERIO"] = {
		positionFrom = { ['x'] = 315.57, ['y'] = -583.07, ['z'] = 43.28 },
		positionTo = { ['x'] = 275.74, ['y'] = -1361.42, ['z'] = 24.53 }
	},
	["HUMANLABS"] = {
		positionFrom = { ['x'] = 319.56, ['y'] = -560.00, ['z'] = 28.74 },
		positionTo = { ['x'] = 3558.83, ['y'] = 3696.21, ['z'] = 30.12 }
	},
	["NECROTERIO2"] = {
		positionFrom = { ['x'] = 243.35, ['y'] = -1366.86, ['z'] = 24.53 },
		positionTo = { ['x'] = 251.66, ['y'] = -1366.49, ['z'] = 39.53 }
	},
	["MOTOCLUB"] = {
		positionFrom = { ['x'] = -80.89, ['y'] = 214.78, ['z'] = 96.55 },
		positionTo = { ['x'] = 1120.96, ['y'] = -3152.57, ['z'] = -37.06 }
	},
	["MOTOCLUB2"] = {
		positionFrom = { ['x'] = 13.20, ['y'] = 3732.19, ['z'] = 39.67 }, 
		positionTo = { ['x'] = 1138.12, ['y'] = -3198.88, ['z'] = -39.66 }
	},
	["MAFIA"] = {
		positionFrom = { ['x'] = 1240.61, ['y'] = -3322.07, ['z'] = 6.02 }, 
		positionTo = { ['x'] = 899.55, ['y'] = -3246.03, ['z'] = -98.04 }  
	},
	["ESCRITORIO2"] = {
		positionFrom = { ['x'] = -598.54, ['y'] = -929.93, ['z'] = 23.86 },
		positionTo = { ['x'] = 1173.55, ['y'] = -3196.68, ['z'] = -39.00 }
	},
	["ESCRITORIO3"] = {
		positionFrom = { ['x'] = -1007.12, ['y'] = -486.67, ['z'] = 39.97 },
		positionTo = { ['x'] = -1003.05, ['y'] = -477.92, ['z'] = 50.02 }
	},
	["ESCRITORIO4"] = {
		positionFrom = { ['x'] = -1913.48, ['y'] = -574.11, ['z'] = 11.43 },
		positionTo = { ['x'] = -1902.05, ['y'] = -572.42, ['z'] = 19.09 }
	},
	["FBI"] = {
		positionFrom = { ['x'] = 139.01, ['y'] = -762.909, ['z'] = 45.75 },  
		positionTo = { ['x'] = 136.25, ['y'] = -761.41, ['z'] = 241.15 } 
	},
	["FBIGARAGEM"] = {
		positionFrom = { x=127.11, y=-760.54, z=45.75 },  
		positionTo = { x=109.99, y=-735.93, z=33.13 } 
	},
	["FBIHELI"] = {
		positionFrom = { x=138.28, y=-764.72, z=242.15 },  
		positionTo = { x=-67.21, y=-821.97, z=321.29 } 
	},
	-- ["YAKUSA"] = {
	-- 	positionFrom = { x=-897.02, y=-1446.5, z=7.53 },  
	-- 	positionTo = { x=-893.84, y=-1446.53, z=7.53 } 
	-- }
}

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		local ped = PlayerPedId()
		if not IsPedInAnyVehicle(ped) then
			local x,y,z = table.unpack(GetEntityCoords(ped))
			for k,v in pairs(Teleport) do
				if Vdist(v.positionFrom.x,v.positionFrom.y,v.positionFrom.z,x,y,z) <= 2.1 then
					if IsControlJustPressed(0,38) then
						SetEntityCoords(ped,v.positionTo.x,v.positionTo.y,v.positionTo.z-0.50)
					end
				end

				if Vdist(v.positionTo.x,v.positionTo.y,v.positionTo.z,x,y,z) <= 2.1 then
					if IsControlJustPressed(0,38) then
						SetEntityCoords(ped,v.positionFrom.x,v.positionFrom.y,v.positionFrom.z-0.50)
					end
				end
			end
		end
	end
end)