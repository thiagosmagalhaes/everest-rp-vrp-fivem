local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
func = Tunnel.getInterface("vrp_jewelry")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local andamento = false
local tipo = 0
local segundos = 0
local coordenadaX = -631.39
local coordenadaY = -230.25
local coordenadaZ = 38.05
-----------------------------------------------------------------------------------------------------------------------------------------
-- GERANDO LOCAL DO ROUBO
-----------------------------------------------------------------------------------------------------------------------------------------
local locais = {
	{ ['id'] = 1 , ['x'] = -626.69 , ['y'] = -238.60 , ['z'] = 38.05 , ['h'] = 213.77 },
	{ ['id'] = 2 , ['x'] = -625.63 , ['y'] = -237.83 , ['z'] = 38.05 , ['h'] = 214.21 },
	{ ['id'] = 3 , ['x'] = -625.78 , ['y'] = -234.56 , ['z'] = 38.05 , ['h'] = 31.36 },
	{ ['id'] = 4 , ['x'] = -626.84 , ['y'] = -235.33 , ['z'] = 38.05 , ['h'] = 31.36 },
	{ ['id'] = 5 , ['x'] = -627.95 , ['y'] = -233.90 , ['z'] = 38.05 , ['h'] = 212.49 },
	{ ['id'] = 6 , ['x'] = -626.90 , ['y'] = -233.15 , ['z'] = 38.05 , ['h'] = 220.39 },
	{ ['id'] = 7 , ['x'] = -620.21 , ['y'] = -234.46 , ['z'] = 38.05 , ['h'] = 218.81 },
	{ ['id'] = 8 , ['x'] = -619.16 , ['y'] = -233.70 , ['z'] = 38.05 , ['h'] = 214.12 },
	{ ['id'] = 9 , ['x'] = -617.54 , ['y'] = -230.52 , ['z'] = 38.05 , ['h'] = 303.29 },
	{ ['id'] = 10 , ['x'] = -618.27 , ['y'] = -229.50 , ['z'] = 38.05 , ['h'] = 302.42 },
	{ ['id'] = 11 , ['x'] = -619.64 , ['y'] = -227.63 , ['z'] = 38.05 , ['h'] = 301.53 },
	{ ['id'] = 12 , ['x'] = -620.40 , ['y'] = -226.56 , ['z'] = 38.05 , ['h'] = 306.27 },
	{ ['id'] = 13 , ['x'] = -623.90 , ['y'] = -227.06 , ['z'] = 38.05 , ['h'] = 34.69 },
	{ ['id'] = 14 , ['x'] = -624.94 , ['y'] = -227.86 , ['z'] = 38.05 , ['h'] = 33.12 },
	{ ['id'] = 15 , ['x'] = -624.40 , ['y'] = -231.09 , ['z'] = 38.05 , ['h'] = 306.53 },
	{ ['id'] = 16 , ['x'] = -623.99 , ['y'] = -228.19 , ['z'] = 38.05 , ['h'] = 212.40 },
	{ ['id'] = 17 , ['x'] = -621.07 , ['y'] = -228.57 , ['z'] = 38.05 , ['h'] = 121.42 },
	{ ['id'] = 18 , ['x'] = -619.72 , ['y'] = -230.43 , ['z'] = 38.05 , ['h'] = 123.59 },
	{ ['id'] = 19 , ['x'] = -620.15 , ['y'] = -233.33 , ['z'] = 38.05 , ['h'] = 33.98 },
	{ ['id'] = 20 , ['x'] = -623.05 , ['y'] = -232.93 , ['z'] = 38.05 , ['h'] = 302.85 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- HACKEAR O SISTEMA
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		local ped = PlayerPedId()
		if Vdist(coordenadaX,coordenadaY,coordenadaZ,GetEntityCoords(ped)) <= 1.1 and not andamento then
			drawTxt("PRESSIONE  ~b~E~w~  PARA HACKEAR AS CÂMERAS DE SEGURANÇA",4,0.5,0.93,0.50,255,255,255,180)
			if IsControlJustPressed(0,38) and not IsPedInAnyVehicle(ped) and GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_UNARMED") then
				func.checkJewelry(coordenadaX,coordenadaY,coordenadaZ,213.52,30,1)
			end
		end

		if andamento and tipo == 1 then
			drawTxt("FALTAM ~g~"..segundos.." SEGUNDOS ~w~PARA TERMINAR DE HACKEAR AS CÂMERAS DE SEGURANÇA",4,0.5,0.93,0.50,255,255,255,180)
		elseif andamento and tipo == 2 then
			drawTxt("FALTAM ~g~"..segundos.." SEGUNDOS ~w~PARA TERMINAR DE ROUBAR AS JOIAS",4,0.5,0.93,0.50,255,255,255,180)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ROUBANDO AS JOIAS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		local ped = PlayerPedId()
		for _,v in pairs(locais) do
			if Vdist2(v.x,v.y,v.z,GetEntityCoords(ped)) <= 1.1 and not andamento then
				drawTxt("PRESSIONE  ~b~E~w~  PARA ROUBAR AS JOIAS",4,0.5,0.93,0.50,255,255,255,180)
				if IsControlJustPressed(0,38) and not IsPedInAnyVehicle(ped) then
					if func.returnJewelry() then
						func.checkJewels(v.id,v.x,v.y,v.z,v.h,2)
					else
						TriggerEvent("Notify","negado","Hackeie as câmeras de segurança.",8000)
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INICIANDO O ROUBO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("iniciandojewelry")
AddEventHandler("iniciandojewelry",function(x,y,z,h,sec,mod,status)
	andamento = status
	if status then
		tipo = mod
		segundos = sec
		ClearPedTasks(PlayerPedId())
		SetEntityHeading(PlayerPedId(),h)
		SetEntityCoords(PlayerPedId(),x,y,z-1,false,false,false,false)
		TriggerEvent('cancelando',true)
	else
		TriggerEvent('cancelando',false)
		ClearPedTasks(PlayerPedId())
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONTAGEM
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if andamento then
			segundos = segundos - 1
			if segundos <= 0 then
				tipo = 0
				andamento = false
				ClearPedTasks(PlayerPedId())
				TriggerEvent('cancelando',false)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
function drawTxt(text,font,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextScale(scale,scale)
	SetTextColour(r,g,b,a)
	SetTextOutline()
	SetTextCentre(1)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x,y)
end