local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
func = Tunnel.getInterface("vrp_caixaeletronico")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local andamento = false
local segundos = 0
-----------------------------------------------------------------------------------------------------------------------------------------
-- GERANDO LOCAL DO ROUBO
-----------------------------------------------------------------------------------------------------------------------------------------
local locais = {
	{ ['id'] = 1, ['x'] = 119.10, ['y'] = -883.70, ['z'] = 31.12, ['h'] = 71.0 },
	{ ['id'] = 2, ['x'] = -1315.80, ['y'] = -834.76, ['z'] = 16.96, ['h'] = 305.0 },
	{ ['id'] = 3, ['x'] = 285.44, ['y'] = 143.38, ['z'] = 104.17, ['h'] = 159.0 },
	{ ['id'] = 4, ['x'] = 1138.23, ['y'] = -468.89, ['z'] = 66.73, ['h'] = 74.0 },
	{ ['id'] = 5, ['x'] = 1077.70, ['y'] = -776.54, ['z'] = 58.24, ['h'] = 182.0 },
	{ ['id'] = 6, ['x'] = -710.03, ['y'] = -818.90, ['z'] = 23.72, ['h'] = 0.0 },
	{ ['id'] = 7, ['x'] = -821.63, ['y'] = -1081.89, ['z'] = 11.13, ['h'] = 31.0 },
	{ ['id'] = 8, ['x'] = -1409.75, ['y'] = -100.44, ['z'] = 52.38, ['h'] = 107.0 },
	{ ['id'] = 9, ['x'] = -846.29, ['y'] = -341.28, ['z'] = 38.68, ['h'] = 116.0 },
	{ ['id'] = 10, ['x'] = -2072.36, ['y'] = -317.29, ['z'] = 13.31, ['h'] = 260.0 },
	{ ['id'] = 11, ['x'] = -526.64, ['y'] = -1222.97, ['z'] = 18.45, ['h'] = 153.0 },
	{ ['id'] = 12, ['x'] = -254.41, ['y'] = -692.46, ['z'] = 33.60, ['h'] = 159.0 },
	{ id=13, x=-31.508354187012, y=-1121.5895996094, z=26.549896240234, h=0.0022461747889437},

	-- NORTE PALETO
	{ id=14, x=1968.0163574219, y=3743.6611328125, z=32.343753814697, h=200.07081604004},
	{ id=15, x=-386.83471679688, y=6046.09375, z=31.501720428467, h=306.77044677734},
	{ id=16, x=-283.05169677734, y=6226.0903320313, z=31.49315071106, h=319.97229003906},
	{ id=17, x=-133.04887390137, y=6366.5297851563, z=31.475778579712, h=314.56771850586},
	{ id=18, x=155.7806854248, y=6642.9204101563, z=31.601228713989, h=310.40545654297},
	{ id=19, x=1686.8049316406, y=4815.8999023438, z=42.008411407471, h=273.85244750977},
	{ id=20, x=1702.9619140625, y=4933.54296875, z=42.063671112061, h=325.34121704102},

	-- CAixas de lojas
	{id = 21, x=33.13, y=-1348.21, z=29.5, h=187.16},
	{id = 22, x=380.81, y=323.47, z=103.57, h=157.77},
	{id = 23, x=418.94, y=-986.13, z=29.39, h=265.84},
	
}

-----------------------------------------------------------------------------------------------------------------------------------------
-- INICIO/CANCELAR
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		local ped = PlayerPedId()
		local x,y,z = GetEntityCoords(ped)
		if GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_UNARMED") and not IsPedInAnyVehicle(ped) then
			for k,v in pairs(locais) do
				if Vdist(v.x,v.y,v.z,x,y,z) <= 1.2 and not andamento then
					drawTxt("PRESSIONE  ~b~G~w~  PARA INICIAR O ROUBO",4,0.5,0.93,0.50,255,255,255,180)
					if IsControlJustPressed(0,47) then
						-- local distance = GetDistanceBetweenCoords(x,y,z,-186.1,-893.5,29.3, true)
						func.checkRobbery(v.id,v.x,v.y,v.z,v.h)
					end
				end
			end
			if andamento then
				drawTxt("APERTE ~r~M~w~ PARA CANCELAR O ROUBO EM ANDAMENTO",4,0.5,0.91,0.35,255,255,255,80)
				drawTxt("RESTAM ~g~"..segundos.." SEGUNDOS ~w~PARA TERMINAR",4,0.5,0.93,0.50,255,255,255,180)
				if IsControlJustPressed(0,244) or GetEntityHealth(ped) <= 100 then
					andamento = false
					ClearPedTasks(ped)
					func.cancelRobbery()
					TriggerEvent('cancelando',false)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INICIADO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("iniciandocaixaeletronico")
AddEventHandler("iniciandocaixaeletronico",function(x,y,z,secs,head)
	segundos = secs
	andamento = true
	SetEntityHeading(PlayerPedId(),head)
	SetEntityCoords(PlayerPedId(),x,y,z-1,false,false,false,false)
	TriggerEvent("global:getMochilaRoubo")
	TriggerEvent('cancelando',true)
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