local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
emP = Tunnel.getInterface("emp_hospital")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local macas = {
	{ ['x'] = 344.24, ['y'] = -582.21, ['z'] = 43.31, ['x2'] = 344.66, ['y2'] = -580.87, ['z2'] = 44.01, ['h'] = 70.0 },
	{ ['x'] = 348.82, ['y'] = -583.36, ['z'] = 43.31, ['x2'] = 349.71, ['y2'] = -583.56, ['z2'] = 44.01, ['h'] = 330.0 },
	{ ['x'] = 352.31, ['y'] = -584.43, ['z'] = 43.31, ['x2'] = 353.10, ['y2'] = -584.77, ['z2'] = 44.10, ['h'] = 330.0 },
	{ ['x'] = 355.82, ['y'] = -585.73, ['z'] = 43.31, ['x2'] = 356.56, ['y2'] = -585.94, ['z2'] = 44.10, ['h'] = 330.0 },
	{ ['x'] = 359.60, ['y'] = -586.81, ['z'] = 43.31, ['x2'] = 360.55, ['y2'] = -587.08, ['z2'] = 44.01, ['h'] = 330.0 },
	{ ['x'] = 346.12, ['y'] = -590.31, ['z'] = 43.31, ['x2'] = 346.99, ['y2'] = -590.55, ['z2'] = 44.10, ['h'] = 150.0 },
	{ ['x'] = 349.93, ['y'] = -591.46, ['z'] = 43.31, ['x2'] = 350.78, ['y2'] = -591.64, ['z2'] = 44.10, ['h'] = 150.0 },
	{ ['x'] = 353.42, ['y'] = -592.40, ['z'] = 43.31, ['x2'] = 354.26, ['y2'] = -592.52, ['z2'] = 44.10, ['h'] = 150.0 },
	{ ['x'] = 356.51, ['y'] = -593.99, ['z'] = 43.31, ['x2'] = 357.42, ['y2'] = -594.18, ['z2'] = 44.10, ['h'] = 150.0 },  -- 328.42,-570.30,43.31
	{ ['x'] = 328.42, ['y'] = -570.30, ['z'] = 43.31, ['x2'] = 326.81, ['y2'] = -569.85, ['z2'] = 44.01, ['h'] = 70.0 }
}

local hospital = {x=343.49, y=-584.13, z=43.32}
-----------------------------------------------------------------------------------------------------------------------------------------
-- DEITANDO
-----------------------------------------------------------------------------------------------------------------------------------------\
Citizen.CreateThread(function()
	TriggerEvent("cancelando",false)
	local time = 1
	while true do
		Citizen.Wait(time)
		time = 10000

		local ped = PlayerPedId()
		local x,y,z = table.unpack(GetEntityCoords(ped))

		local distance = GetDistanceBetweenCoords(hospital.x,hospital.y,hospital.z, x,y,z,true)
		if distance < 70 then
			time = 1
			
			for k,v in pairs(macas) do
				
				local distance = GetDistanceBetweenCoords(v.x,v.y,v.z, x,y,z,true)
				if distance <= 1.1 then
					drawTxt("~b~E~w~  DEITAR    ~b~G~w~  TRATAMENTO",4,0.5,0.93,0.50,255,255,255,180)
					if IsControlJustPressed(0,38) then
						SetEntityCoords(ped,v.x2,v.y2,v.z2)
						SetEntityHeading(ped,v.h)
						vRP._playAnim(false,{{"amb@world_human_sunbathe@female@back@idle_a","idle_a"}},true)
					end
					if IsControlJustPressed(0,47) then
						if emP.checkServices() then
							TriggerEvent('tratamento-macas')
							SetEntityCoords(ped,v.x2,v.y2,v.z2)
							SetEntityHeading(ped,v.h)
							vRP._playAnim(false,{{"amb@world_human_sunbathe@female@back@idle_a","idle_a"}},true)
						else
							TriggerEvent("Notify","aviso","Existem paramédicos em serviço.")
						end
					end
				end
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

RegisterNetEvent('tratamento-macas')
AddEventHandler('tratamento-macas',function()
	TriggerEvent("cancelando",true)
	repeat
		SetEntityHealth(PlayerPedId(),GetEntityHealth(PlayerPedId())+1)
		Citizen.Wait(300)
	until GetEntityHealth(PlayerPedId()) >= 400 or GetEntityHealth(PlayerPedId()) <= 100
		TriggerEvent("Notify","importante","Tratamento concluido.")
		TriggerEvent("cancelando",false)
end)