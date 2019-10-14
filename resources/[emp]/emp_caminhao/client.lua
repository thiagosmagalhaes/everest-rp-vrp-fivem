local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
emP = Tunnel.getInterface("emp_caminhao")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local blips = false
local random = 0
local modules = ""
local servico = false
local servehicle = nil
local CoordenadaX = 1159.38
local CoordenadaY = -3273.07
local CoordenadaZ = 5.90
local CoordenadaX2 = 0.0
local CoordenadaY2 = 0.0
local CoordenadaZ2 = 0.0
-----------------------------------------------------------------------------------------------------------------------------------------
-- DIESEL
-----------------------------------------------------------------------------------------------------------------------------------------
local diesel = {
	[1] = { ['x'] = 43.06, ['y'] = 2803.80, ['z'] = 57.87 },
	[2] = { ['x'] = 243.15, ['y'] = 2602.41, ['z'] = 45.11 },
	[3] = { ['x'] = 1059.15, ['y'] = 2660.69, ['z'] = 39.55 },
	[4] = { ['x'] = 1990.22, ['y'] = 3763.54, ['z'] = 32.18 },
	[5] = { ['x'] = 81.23, ['y'] = 6334.27, ['z'] = 31.22 },
	[6] = { ['x'] = 2770.81, ['y'] = 1439.26, ['z'] = 24.51 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- GAS
-----------------------------------------------------------------------------------------------------------------------------------------
local gas = {
	[1] = { ['x'] = -2530.05, ['y'] = 2325.91, ['z'] = 33.05 },
	[2] = { ['x'] = -2082.05, ['y'] = -319.80, ['z'] = 13.05 },
	[3] = { ['x'] = -1413.47, ['y'] = -279.95, ['z'] = 46.33 },
	[4] = { ['x'] = 280.64, ['y'] = -1259.95, ['z'] = 29.21 },
	[5] = { ['x'] = 1208.38, ['y'] = -1402.58, ['z'] = 35.22 },
	[6] = { ['x'] = 1181.46, ['y'] = -334.74, ['z'] = 69.17 },
	[7] = { ['x'] = 2567.72, ['y'] = 362.65, ['z'] = 108.45 },
	[8] = { ['x'] = 183.97, ['y'] = -1554.69, ['z'] = 29.20 },
	[9] = { ['x'] = -331.75, ['y'] = -1479.03, ['z'] = 30.54 },
	[10] = { ['x'] = 2534.50, ['y'] = 2588.13, ['z'] = 37.94 },
	[11] = { ['x'] = 2684.40, ['y'] = 3261.81, ['z'] = 55.24 },
	[12] = { ['x'] = -1803.10, ['y'] = 800.33, ['z'] = 138.51 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- CARS
-----------------------------------------------------------------------------------------------------------------------------------------
local cars = {
	[1] = { ['x'] = -774.19, ['y'] = -254.45, ['z'] = 37.10 },
	[2] = { ['x'] = -231.64, ['y'] = -1170.94, ['z'] = 22.83 },
	[3] = { ['x'] = 925.59, ['y'] = -8.79, ['z'] = 78.76 },
	[4] = { ['x'] = -506.18, ['y'] = -2191.37, ['z'] = 6.53 },
	[5] = { ['x'] = 1209.15, ['y'] = 2712.03, ['z'] = 38.00 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- WOODS
-----------------------------------------------------------------------------------------------------------------------------------------
local woods = {
	[1] = { ['x'] = -581.20, ['y'] = 5317.28, ['z'] = 70.24 },
	[2] = { ['x'] = 2701.74, ['y'] = 3450.62, ['z'] = 55.79 },
	[3] = { ['x'] = 1203.52, ['y'] = -1309.33, ['z'] = 35.22 },
	[4] = { ['x'] = 16.99, ['y'] = -386.11, ['z'] = 39.32 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOWS
-----------------------------------------------------------------------------------------------------------------------------------------
local show = {
	[1] = { ['x'] = 1994.91, ['y'] = 3061.17, ['z'] = 47.04 },
	[2] = { ['x'] = -1397.32, ['y'] = -581.99, ['z'] = 30.28 },
	[3] = { ['x'] = -552.43, ['y'] = 303.34, ['z'] = 83.21 },
	[4] = { ['x'] = -227.52, ['y'] = -2051.27, ['z'] = 27.62 }
}

-----------------------------------------------------------------------------------------------------------------------------------------
-- ENTREGAR
-----------------------------------------------------------------------------------------------------------------------------------------
function emServico()
	async(function()
		local time = 1
		while servico do
			Citizen.Wait(time)
			time = 10000
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(CoordenadaX2,CoordenadaY2,CoordenadaZ2)
			local distance = GetDistanceBetweenCoords(CoordenadaX2,CoordenadaY2,cdz,x,y,z,true)
	
			if distance <= 100.0 then
				time = 1
				DrawMarker(23,CoordenadaX2,CoordenadaY2,CoordenadaZ2-0.96,0,0,0,0,0,0,10.0,10.0,1.0,0,95,140,50,0,0,0,0)
				if distance <= 5.9 then
					if IsControlJustPressed(0,38) then
						local vehicle = getVehicleInDirection(GetEntityCoords(PlayerPedId()),GetOffsetFromEntityInWorldCoords(PlayerPedId(),0.0,5.0,0.0))
						if GetEntityModel(vehicle) == servehicle then
							emP.checkPayment(random,modules,parseInt(GetVehicleBodyHealth(GetPlayersLastVehicle())))
							TriggerServerEvent("trydeleteveh",VehToNet(vehicle))
							Citizen.Wait(1000)
							if DoesEntityExist(vehicle) then
								TriggerServerEvent("trydeleteveh",VehToNet(vehicle))
							end
							RemoveBlip(blips)
							servico = false
						end
					end
				end
			end
		end
	end)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
function getVehicleInDirection(coordsfrom,coordsto)
	local handle = CastRayPointToPoint(coordsfrom.x,coordsfrom.y,coordsfrom.z,coordsto.x,coordsto.y,coordsto.z,10,PlayerPedId(),false)
	local a,b,c,d,vehicle = GetRaycastResult(handle)
	return vehicle
end

function CriandoBlip(x,y,z)
	blips = AddBlipForCoord(x,y,z)
	SetBlipSprite(blips,1)
	SetBlipColour(blips,5)
	SetBlipScale(blips,0.4)
	SetBlipAsShortRange(blips,false)
	SetBlipRoute(blips,true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Entrega de Carga")
	EndTextCommandSetBlipName(blips)
end



-- =======================================================\
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTION
-----------------------------------------------------------------------------------------------------------------------------------------
local menuactive = false
function ToggleActionMenu()
	menuactive = not menuactive
	if menuactive then
		SetNuiFocus(true,true)
		SendNUIMessage({ showmenu = true })
	else
		SetNuiFocus(false)
		SendNUIMessage({ hidemenu = true })
	end
end


-----------------------------------------------------------------------------------------------------------------------------------------
-- BUTTON
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("ButtonClick",function(data,cb)
	if data == "gas-01" then
		iniciarRota("gas")
		spawnVehicle("tanker2",1142.50,-3264.00,5.90)
		
		TriggerEvent("Notify","sucesso","Carga de <b>Combustível</b> liberada. /radio carreta, para entrar na frequência de rádio!")
		ToggleActionMenu()
	elseif data == "gas-02" then
		iniciarRota("gas")
		spawnVehicle("tanker2",1142.50,-3273.00,5.90)
		
		TriggerEvent("Notify","sucesso","Carga de <b>Combustível</b> liberada. /radio carreta, para entrar na frequência de rádio!")
		ToggleActionMenu()
	elseif data == "gas-03" then
		iniciarRota("gas")
		spawnVehicle("tanker2",1142.50,-3282.00,5.90)
		
		TriggerEvent("Notify","sucesso","Carga de <b>Combustível</b> liberada. /radio carreta, para entrar na frequência de rádio!")
		ToggleActionMenu()

	elseif data == "diesel-01" then
		iniciarRota("diesel")
		spawnVehicle("armytanker",1142.50,-3264.00,5.90)
		
		TriggerEvent("Notify","sucesso","Carga de <b>Diesel</b> liberada. /radio carreta, para entrar na frequência de rádio!")
		ToggleActionMenu()
	elseif data == "diesel-02" then
		iniciarRota("diesel")
		spawnVehicle("armytanker",1142.50,-3273.00,5.90)
		
		TriggerEvent("Notify","sucesso","Carga de <b>Diesel</b> liberada. /radio carreta, para entrar na frequência de rádio!")
		ToggleActionMenu()
	elseif data == "diesel-03" then
		iniciarRota("diesel")
		spawnVehicle("armytanker",1142.50,-3282.00,5.90)
		
		TriggerEvent("Notify","sucesso","Carga de <b>Diesel</b> liberada. /radio carreta, para entrar na frequência de rádio!")
		ToggleActionMenu()

	elseif data == "show-01" then
		iniciarRota("show")
		spawnVehicle("tvtrailer",1142.50,-3264.00,5.90)
		
		TriggerEvent("Notify","sucesso","Carga de <b>Shows</b> liberada. /radio carreta, para entrar na frequência de rádio!")
		ToggleActionMenu()
	elseif data == "show-02" then
		iniciarRota("show")
		spawnVehicle("tvtrailer",1142.50,-3273.00,5.90)
		
		TriggerEvent("Notify","sucesso","Carga de <b>Shows</b> liberada. /radio carreta, para entrar na frequência de rádio!")
		ToggleActionMenu()
	elseif data == "show-03" then
		iniciarRota("show")
		spawnVehicle("tvtrailer",1142.50,-3282.00,5.90)
		
		TriggerEvent("Notify","sucesso","Carga de <b>Shows</b> liberada. /radio carreta, para entrar na frequência de rádio!")
		ToggleActionMenu()

	elseif data == "woods-01" then
		iniciarRota("woods")
		spawnVehicle("trailerlogs",1142.50,-3264.00,5.90)
		
		TriggerEvent("Notify","sucesso","Carga de <b>Madeiras</b> liberada. /radio carreta, para entrar na frequência de rádio!")
		ToggleActionMenu()
	elseif data == "woods-02" then
		iniciarRota("woods")
		spawnVehicle("trailerlogs",1142.50,-3273.00,5.90)
		
		TriggerEvent("Notify","sucesso","Carga de <b>Madeiras</b> liberada. /radio carreta, para entrar na frequência de rádio!")
		ToggleActionMenu()
	elseif data == "woods-03" then
		iniciarRota("woods")
		spawnVehicle("trailerlogs",1142.50,-3282.00,5.90)
		
		TriggerEvent("Notify","sucesso","Carga de <b>Madeiras</b> liberada. /radio carreta, para entrar na frequência de rádio!")
		ToggleActionMenu()

	elseif data == "cars-01" then
		iniciarRota("cars")
		spawnVehicle("tr4",1142.50,-3264.00,5.90)
		
		TriggerEvent("Notify","sucesso","Carga de <b>Veículos</b> liberada. /radio carreta, para entrar na frequência de rádio!")
		ToggleActionMenu()
	elseif data == "cars-02" then
		iniciarRota("cars")
		spawnVehicle("tr4",1142.50,-3273.00,5.90)
		
		TriggerEvent("Notify","sucesso","Carga de <b>Veículos</b> liberada. /radio carreta, para entrar na frequência de rádio!")
		ToggleActionMenu()
	elseif data == "cars-03" then
		iniciarRota("cars")
		spawnVehicle("tr4",1142.50,-3282.00,5.90)
		
		TriggerEvent("Notify","sucesso","Carga de <b>Veículos</b> liberada. /radio carreta, para entrar na frequência de rádio!")
		ToggleActionMenu()

	elseif data == "fechar" then
		ToggleActionMenu()
	end
end)

function iniciarRota(rota)
	local ped = PlayerPedId()
	local x,y,z = table.unpack(GetEntityCoords(ped))
	local bowz,cdz = GetGroundZFor_3dCoord(CoordenadaX,CoordenadaY,CoordenadaZ)
	local distance = GetDistanceBetweenCoords(CoordenadaX,CoordenadaY,cdz,x,y,z,true)

	if distance <= 50.1 and not servico then
		if rota == "diesel" then
			servico = true
			modules = rota
			servehicle = -1207431159
			random = emP.getTruckpoint(modules)
			CoordenadaX2 = diesel[random].x
			CoordenadaY2 = diesel[random].y
			CoordenadaZ2 = diesel[random].z
			CriandoBlip(CoordenadaX2,CoordenadaY2,CoordenadaZ2)
			TriggerEvent("Notify","importante","Entrega de <b>Diesel</b> iniciada, pegue o caminhão, a carga e vá até o destino marcado.")
		elseif rota == "gas" then
			servico = true
			modules = rota
			servehicle = 1956216962
			random = emP.getTruckpoint(modules)
			CoordenadaX2 = gas[random].x
			CoordenadaY2 = gas[random].y
			CoordenadaZ2 = gas[random].z
			CriandoBlip(CoordenadaX2,CoordenadaY2,CoordenadaZ2)
			TriggerEvent("Notify","importante","Entrega de <b>Combustível</b> iniciada, pegue o caminhão, a carga e vá até o destino marcado.")
		elseif rota == "cars" then
			servico = true
			modules = rota
			servehicle = 2091594960
			random = emP.getTruckpoint(modules)
			CoordenadaX2 = cars[random].x
			CoordenadaY2 = cars[random].y
			CoordenadaZ2 = cars[random].z
			CriandoBlip(CoordenadaX2,CoordenadaY2,CoordenadaZ2)
			TriggerEvent("Notify","importante","Entrega de <b>Veículos</b> iniciada, pegue o caminhão, a carga e vá até o destino marcado.")
		elseif rota == "woods" then
			servico = true
			modules = rota
			servehicle = 2016027501
			random = emP.getTruckpoint(modules)
			CoordenadaX2 = woods[random].x
			CoordenadaY2 = woods[random].y
			CoordenadaZ2 = woods[random].z
			CriandoBlip(CoordenadaX2,CoordenadaY2,CoordenadaZ2)
			TriggerEvent("Notify","importante","Entrega de <b>Madeiras</b> iniciada, pegue o caminhão, a carga e vá até o destino marcado.")
		elseif rota == "show" then
			servico = true
			modules = rota
			servehicle = -1770643266
			random = emP.getTruckpoint(modules)
			CoordenadaX2 = show[random].x
			CoordenadaY2 = show[random].y
			CoordenadaZ2 = show[random].z
			CriandoBlip(CoordenadaX2,CoordenadaY2,CoordenadaZ2)
			TriggerEvent("Notify","importante","Entrega de <b>Shows</b> iniciada, pegue o caminhão, a carga e vá até o destino marcado.")
		else
			TriggerEvent("Notify","aviso","<b>Disponíveis:</b> diesel, cars, show, woods e gas")
		end

		emServico()

	else
		if servico then
			TriggerEvent("Notify","negado","Você já está em serviço, transporte "..module)
			return
		end
	end
end

function spawnVehicle(name,x,y,z)
	local mhash = GetHashKey(name)
	while not HasModelLoaded(mhash) do
		RequestModel(mhash)
		Citizen.Wait(10)
	end

	if HasModelLoaded(mhash) then
		local nveh = CreateVehicle(mhash,x,y,z+0.5,270.90,true,false)

		SetVehicleOnGroundProperly(nveh)
		SetVehicleNumberPlateText(nveh,vRP.getRegistrationNumber())
		SetEntityAsMissionEntity(nveh,true,true)

		SetModelAsNoLongerNeeded(mhash)
	end
end

function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCAIS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	SetNuiFocus(false,false)
	while true do
		Citizen.Wait(1)
		DrawMarker(21, 1151.91,-3250.26,5.9, 0, 0, 0, 0, 180.0, 130.0, 0.6, 0.8, 0.5, 120, 250, 20, 160, 1, 0, 0, 1, 0, 0, 0)
		local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),1151.90,-3249.53,5.90,true)
		if distance <= 1.2 then
			DisplayHelpText("~f~Pressione ~g~E~f~ para coletar a carga")
			if IsControlJustPressed(0,38) then
				ToggleActionMenu()
			end
		end
	end
end)