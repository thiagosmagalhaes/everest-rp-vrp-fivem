local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
emP = Tunnel.getInterface("emp_paramedico")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local blips = nil
local selecionado = 0
local CoordenadaX = 304.01
local CoordenadaY = -597.35
local CoordenadaZ = 43.29
local passageiro = nil
local lastpassageiro = nil
local checkped = true
local maxlocs = 28
local payment = 10
local inService = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCALIDADES
-----------------------------------------------------------------------------------------------------------------------------------------
local locs = {
	[1] = { ['x'] = 151.30, ['y'] = -1028.63, ['z'] = 28.84, ['xp'] = 152.45, ['yp'] = -1041.24, ['zp'] = 29.37, ['h'] = 252.0 },
	[2] = { ['x'] = 423.84, ['y'] = -959.30, ['z'] = 28.81, ['xp'] = 437.37, ['yp'] = -979.03, ['zp'] = 30.68, ['h'] = 271.0 },
	[3] = { ['x'] = 1.03, ['y'] = -1510.86, ['z'] = 29.40, ['xp'] = 20.67, ['yp'] = -1505.62, ['zp'] = 31.85, ['h'] = 319.0 },
	[4] = { ['x'] = -188.07, ['y'] = -1612.28, ['z'] = 33.39, ['xp'] = -189.55, ['yp'] = -1585.80, ['zp'] = 34.76, ['h'] = 178.0 },
	[5] = { ['x'] = 98.88, ['y'] = -1927.16, ['z'] = 20.25, ['xp'] = 101.02, ['yp'] = -1912.35, ['zp'] = 21.40, ['h'] = 70.0 },
	[6] = { ['x'] = 320.98, ['y'] = -2022.02, ['z'] = 20.40, ['xp'] = 335.73, ['yp'] = -2010.77, ['zp'] = 22.31, ['h'] = 321.0 },
	[7] = { ['x'] = 755.53, ['y'] = -2486.26, ['z'] = 19.54, ['xp'] = 774.34, ['yp'] = -2475.07, ['zp'] = 20.14, ['h'] = 356.0 },
	[8] = { ['x'] = 1057.66, ['y'] = -2124.80, ['z'] = 32.20, ['xp'] = 1040.09, ['yp'] = -2115.65, ['zp'] = 32.84, ['h'] = 175.0 },
	[9] = { ['x'] = 1377.08, ['y'] = -1530.01, ['z'] = 56.07, ['xp'] = 1379.33, ['yp'] = -1514.99, ['zp'] = 58.43, ['h'] = 119.0 },
	[10] = { ['x'] = 1260.24, ['y'] = -588.15, ['z'] = 68.53, ['xp'] = 1240.60, ['yp'] = -601.63, ['zp'] = 69.78, ['h'] = 193.0 },
	[11] = { ['x'] = 899.58, ['y'] = -590.58, ['z'] = 56.85, ['xp'] = 886.76, ['yp'] = -608.20, ['zp'] = 58.44, ['h'] = 238.0 },
	[12] = { ['x'] = 945.18, ['y'] = -140.04, ['z'] = 74.07, ['xp'] = 959.34, ['yp'] = -121.23, ['zp'] = 74.96, ['h'] = 60.0 },
	[13] = { ['x'] = 84.44, ['y'] = 476.19, ['z'] = 146.91, ['xp'] = 80.10, ['yp'] = 486.12, ['zp'] = 148.20, ['h'] = 118.0 },
	[14] = { ['x'] = -720.03, ['y'] = 482.23, ['z'] = 107.10, ['xp'] = -721.10, ['yp'] = 489.75, ['zp'] = 109.38, ['h'] = 110.0 },
	[15] = { ['x'] = -1244.39, ['y'] = 497.98, ['z'] = 93.86, ['xp'] = -1229.15, ['yp'] = 515.72, ['zp'] = 95.42, ['h'] = 359.0 },
	[16] = { ['x'] = -1514.99, ['y'] = 442.97, ['z'] = 109.70, ['xp'] = -1495.97, ['yp'] = 437.10, ['zp'] = 112.49, ['h'] = 296.0 },
	[17] = { ['x'] = -1684.14, ['y'] = -308.47, ['z'] = 51.41, ['xp'] = -1684.87, ['yp'] = -291.66, ['zp'] = 51.89, ['h'] = 234.0 },
	[18] = { ['x'] = -1413.14, ['y'] = -531.91, ['z'] = 30.98, ['xp'] = -1447.29, ['yp'] = -537.71, ['zp'] = 34.74, ['h'] = 215.0 },
	[19] = { ['x'] = -1036.80, ['y'] = -492.27, ['z'] = 36.15, ['xp'] = -1007.32, ['yp'] = -486.80, ['zp'] = 39.97, ['h'] = 27.0 },
	[20] = { ['x'] = -551.46, ['y'] = -648.64, ['z'] = 32.73, ['xp'] = -533.39, ['yp'] = -622.87, ['zp'] = 34.67, ['h'] = 92.0 },
	[21] = { ['x'] = -616.30, ['y'] = -920.80, ['z'] = 22.98, ['xp'] = -598.49, ['yp'] = -929.96, ['zp'] = 23.86, ['h'] = 291.0 },
	[22] = { ['x'] = -752.13, ['y'] = -1041.29, ['z'] = 12.25, ['xp'] = -759.21, ['yp'] = -1047.16, ['zp'] = 13.50, ['h'] = 117.0 },
	[23] = { ['x'] = -1155.20, ['y'] = -1413.48, ['z'] = 4.46, ['xp'] = -1150.56, ['yp'] = -1426.38, ['zp'] = 4.95, ['h'] = 247.0 },
	[24] = { ['x'] = -997.88, ['y'] = -1599.65, ['z'] = 4.59, ['xp'] = -989.04, ['yp'] = -1575.82, ['zp'] = 5.17, ['h'] = 271.0 },
	[25] = { ['x'] = -829.38, ['y'] = -1218.09, ['z'] = 6.54, ['xp'] = -822.50, ['yp'] = -1223.35, ['zp'] = 7.36, ['h'] = 319.0 },
	[26] = { ['x'] = -334.47, ['y'] = -1418.13, ['z'] = 29.71, ['xp'] = -320.10, ['yp'] = -1389.73, ['zp'] = 36.50, ['h'] = 91.0 },
	[27] = { ['x'] = 135.28, ['y'] = -1306.46, ['z'] = 28.65, ['xp'] = 132.91, ['yp'] = -1293.90, ['zp'] = 29.26, ['h'] = 119.0 },
	[28] = { ['x'] = -34.00, ['y'] = -1079.86, ['z'] = 26.26, ['xp'] = -39.02, ['yp'] = -1082.46, ['zp'] = 26.42, ['h'] = 69.0 },
	[29] = { ['x'] = 296.15, ['y'] = -582.48, ['z'] = 42.93, ['xp'] = 296.15, ['yp'] = -582.48, ['zp'] = 42.93, ['h'] = 343.0 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PEDLIST
-----------------------------------------------------------------------------------------------------------------------------------------
local pedlist = {
	[1] = { ['model'] = "ig_abigail", ['hash'] = 0x400AEC41 },
	[2] = { ['model'] = "a_m_o_acult_02", ['hash'] = 0x4BA14CCA },
	[3] = { ['model'] = "a_m_m_afriamer_01", ['hash'] = 0xD172497E },
	[4] = { ['model'] = "ig_mp_agent14", ['hash'] = 0xFBF98469 },
	[5] = { ['model'] = "u_m_m_aldinapoli", ['hash'] = 0xF0EC56E2 },
	[6] = { ['model'] = "ig_amandatownley", ['hash'] = 0x6D1E15F7 },
	[7] = { ['model'] = "ig_andreas", ['hash'] = 0x47E4EEA0 },
	[8] = { ['model'] = "csb_anita", ['hash'] = 0x0703F106 },
	[9] = { ['model'] = "u_m_y_antonb", ['hash'] = 0xCF623A2C },
	[10] = { ['model'] = "g_m_y_armgoon_02", ['hash'] = 0xC54E878A },
	[11] = { ['model'] = "ig_ashley", ['hash'] = 0x7EF440DB },
	[12] = { ['model'] = "s_m_m_autoshop_01", ['hash'] = 0x040EABE3 },
	[13] = { ['model'] = "g_m_y_ballaeast_01", ['hash'] = 0xF42EE883 },
	[14] = { ['model'] = "g_m_y_ballaorig_01", ['hash'] = 0x231AF63F },
	[15] = { ['model'] = "s_m_y_barman_01", ['hash'] = 0xE5A11106 },
	[16] = { ['model'] = "u_m_y_baygor", ['hash'] = 0x5244247D },
	[17] = { ['model'] = "a_m_o_beach_01", ['hash'] = 0x8427D398 },
	[18] = { ['model'] = "a_m_y_beachvesp_01", ['hash'] = 0x7E0961B8 },
	[19] = { ['model'] = "ig_bestmen", ['hash'] = 0x5746CD96 },
	[20] = { ['model'] = "a_f_y_bevhills_01", ['hash'] = 0x445AC854 },
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRABALHAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("hospital", function(source, args, raw)
	if emP.checkPermission() then
		inService = not inService
		
		if inService then
			
			selecionado = math.random(maxlocs)
			CriandoBlip(locs,selecionado)
			Passageiro()
			
			TriggerEvent("Notify", "sucesso", "Iniciou as rotas!")
		else

			Citizen.Wait(500)
			RemoveBlip(blips)
			if DoesEntityExist(passageiro) then
				TaskLeaveVehicle(passageiro,vehicle,262144)
				TaskWanderStandard(passageiro,10.0,10)
				Citizen.Wait(1100)
				SetVehicleDoorShut(vehicle,3,0)
				FreezeEntityPosition(vehicle,false)
			end
			blips = nil
			selecionado = 0
			passageiro = nil
			checkped = true

			TriggerEvent("Notify", "aviso", "Desativou as rotas!")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PASSAGEIRO
-----------------------------------------------------------------------------------------------------------------------------------------
function Passageiro()
	async(function()
		while inService do
			Citizen.Wait(1)
			local ped = PlayerPedId()
			local vehicle = GetVehiclePedIsUsing(ped)
			local vehiclespeed = GetEntitySpeed(vehicle)*3.6
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(locs[selecionado].x,locs[selecionado].y,locs[selecionado].z)
			local distance = GetDistanceBetweenCoords(locs[selecionado].x,locs[selecionado].y,cdz,x,y,z,true)

			if distance <= 50.0 and IsVehicleModel(vehicle,GetHashKey("ambulance")) then
				DrawMarker(21,locs[selecionado].x,locs[selecionado].y,locs[selecionado].z+0.20,0,0,0,0,180.0,130.0,2.0,2.0,1.0,240,200,80,20,1,0,0,1)
				if distance <= 2.5 then
					if IsControlJustPressed(0,38)then
						RemoveBlip(blips)
						FreezeEntityPosition(vehicle,true)
						if DoesEntityExist(passageiro) then
							emP.checkPayment(payment)
							Citizen.Wait(3000)
							TaskLeaveVehicle(passageiro,vehicle,262144)
							TaskWanderStandard(passageiro,10.0,10)
							Citizen.Wait(1100)
							SetVehicleDoorShut(vehicle,3,0)
							Citizen.Wait(1000)

							SetEntityAsNoLongerNeeded(passageiro)
						end

						if checkped then
							local pmodel = math.random(#pedlist)
							modelRequest(pedlist[pmodel].model)

							RequestAnimSet("move_m@injured")
							while not HasAnimSetLoaded("move_m@injured") do
								Citizen.Wait(10)
							end

							passageiro = CreatePed(4,pedlist[pmodel].hash,locs[selecionado].xp,locs[selecionado].yp,locs[selecionado].zp,3374176,true,false)
							SetEntityInvincible(passageiro,true)
							TaskEnterVehicle(passageiro,vehicle,-1,2,1.0,1,0)
							SetPedMovementClipset(passageiro,"move_m@injured",0.25)
							checkped = false
							payment = 10
							lastpassageiro = passageiro
						else
							passageiro = nil
							checkped = true
							FreezeEntityPosition(vehicle,false)
						end

						if checkped then
							lselecionado = selecionado
							while true do
								if lselecionado == selecionado then
									selecionado = math.random(maxlocs)
								else
									break
								end
								Citizen.Wait(1)
							end
						else
							selecionado = 29
						end

						CriandoBlip(locs,selecionado)

						if DoesEntityExist(passageiro) then
							while true do
								Citizen.Wait(1)
								local x2,y2,z2 = table.unpack(GetEntityCoords(passageiro))
								if not IsPedSittingInVehicle(passageiro,vehicle) then
									DrawMarker(21,x2,y2,z2+1.3,0,0,0,0,180.0,130.0,0.6,0.8,0.5,240,200,80,50,1,0,0,1)
								end
								if IsPedSittingInVehicle(passageiro,vehicle) then
									FreezeEntityPosition(vehicle,false)
									break
								end
							end
						end
					end
				end
			end
		end
	end)
end


-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÃO
-----------------------------------------------------------------------------------------------------------------------------------------
function modelRequest(model)
	RequestModel(GetHashKey(model))
	while not HasModelLoaded(GetHashKey(model)) do
		Citizen.Wait(10)
	end
end

function CriandoBlip(locs,selecionado)
	blips = AddBlipForCoord(locs[selecionado].x,locs[selecionado].y,locs[selecionado].z)
	SetBlipSprite(blips,1)
	SetBlipColour(blips,5)
	SetBlipScale(blips,0.4)
	SetBlipAsShortRange(blips,false)
	SetBlipRoute(blips,true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Transporte de Paciente")
	EndTextCommandSetBlipName(blips)
end