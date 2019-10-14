local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local sBuffer = {}
local vBuffer = {}
local CintoSeguranca = false
local ExNoCarro = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD
-----------------------------------------------------------------------------------------------------------------------------------------
local player = 0
local carro = 0
local speed = 0
local health = 0
local fuel = 0
local armor = 0
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		player = PlayerPedId()
		health = GetEntityHealth(player)-100
		armor = GetPedArmour(player)
		if IsPedInAnyVehicle(player) then
			carro = GetVehiclePedIsIn(player)
			speed = GetEntitySpeed(carro)*3.6
			fuel = GetVehicleFuelLevel(carro)
		end
	end
end)

local speedHacking = false
Citizen.CreateThread(function()
	while true do
		-- Citizen.Wait(1)

		if speed > 250 then
			if not speedHacking then
				speedHacking = true
				local fmodel = GetDisplayNameFromVehicleModel(GetEntityModel(carro))
				TriggerServerEvent("AntiCheese:SpeedFlag", parseInt(speed), fmodel)
			end
		else
			speedHacking = false
		end

		local ui = GetMinimapAnchor()

		if armor > 100.0 then
			armor = 100.0
		end
		-- print(health)
		health = (health * 100)/300
		
		local varHealth = (ui.width/2)*(health/100)
		local varArmor =((ui.width/2)/100)*armor
		if varArmor == nil then varArmor = 0 end

		if IsPedInAnyVehicle(player) then
			drawTxt(ui.right_x-0.052,ui.bottom_y-0.062,0.42,"~w~"..math.ceil(speed),255,255,255,255)

			drawRct(ui.right_x-0.006,ui.bottom_y-0.177,0.006,0.16,30,30,30,255)
			drawRct(ui.right_x-0.004,ui.top_y+0.003,0.002,0.16,255,0,0,150)
			drawRct(ui.right_x-0.004,ui.top_y+0.003,0.002,0.16/100*(parseInt(100-fuel)),30,30,30,255)
			drawRct(ui.right_x-0.004,ui.top_y+0.003,0.002,0.16,255,255,255,30)
			drawRct(ui.right_x-0.004,ui.bottom_y-0.158,0.002,0.001,255,255,255,100)
			drawRct(ui.right_x-0.004,ui.bottom_y-0.142,0.002,0.0009,255,255,255,100)
			drawRct(ui.right_x-0.004,ui.bottom_y-0.127,0.002,0.0009,255,255,255,100)
			drawRct(ui.right_x-0.004,ui.bottom_y-0.111,0.002,0.001,255,255,255,100)
			drawRct(ui.right_x-0.004,ui.bottom_y-0.095,0.002,0.001,255,255,255,100)
			drawRct(ui.right_x-0.004,ui.bottom_y-0.079,0.002,0.0009,255,255,255,100)
			drawRct(ui.right_x-0.004,ui.bottom_y-0.064,0.002,0.001,255,255,255,100)
			drawRct(ui.right_x-0.004,ui.bottom_y-0.048,0.002,0.0009,255,255,255,100)
			drawRct(ui.right_x-0.004,ui.bottom_y-0.032,0.002,0.0009,255,255,255,100)

			if CintoSeguranca then
				drawTxt(ui.right_x-0.034,ui.bottom_y-0.062,0.42,"~g~KM/h",255,255,255,255)
			else
				drawTxt(ui.right_x-0.034,ui.bottom_y-0.062,0.42,"~o~KM/h",255,255,255,255)
			end
		end

		local tamanhoBarra = ui.width/2-0.003
		local armorX = ui.x+ui.width/2+0.001
		drawRct(ui.x,ui.bottom_y-0.017,ui.width,0.015,30,30,30,255)
		drawRct(ui.x+0.002,ui.bottom_y-0.014,tamanhoBarra,0.009,50,100,50,255)
		if varHealth > 0 then
			drawRct(ui.x+0.002,ui.bottom_y-0.014,varHealth-0.003,0.009,80,156,81,255)
		end
		drawRct(armorX,ui.bottom_y-0.014,tamanhoBarra,0.009,40,90,117,255)
		if varArmor > 0 then
			drawRct(armorX,ui.bottom_y-0.014,varArmor-0.003,0.009,66,140,180,255)
		end

		Citizen.Wait(1)
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if IsPedInAnyVehicle(player) then
			if not IsRadarEnabled() then
				DisplayRadar(true)
			end
		else
			if not IsEntityPlayingAnim(player,"cellphone@","cellphone_text_in",3) then
				DisplayRadar(false)
				CintoSeguranca = false
			end
		end
		if IsRadarEnabled() then
			SetRadarZoom(1000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CINTO DE SEGURANÇA
-----------------------------------------------------------------------------------------------------------------------------------------
IsCar = function(veh)
	local vc = GetVehicleClass(veh)
	return (vc >= 0 and vc <= 7) or (vc >= 9 and vc <= 12) or (vc >= 17 and vc <= 20)
end	

Fwv = function (entity)
	local hr = GetEntityHeading(entity) + 90.0
	if hr < 0.0 then
		hr = 360.0 + hr
	end
	hr = hr * 0.0174533
	return { x = math.cos(hr) * 2.0, y = math.sin(hr) * 2.0 }
end

local segundos = 0
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		local car = GetVehiclePedIsIn(player)

		if car ~= 0 and (ExNoCarro or IsCar(car)) then
			ExNoCarro = true
			if CintoSeguranca then
				DisableControlAction(0,75)
			end

			sBuffer[2] = sBuffer[1]
			sBuffer[1] = GetEntitySpeed(car)

			if sBuffer[2] ~= nil and not CintoSeguranca and GetEntitySpeedVector(car,true).y > 1.0 and sBuffer[1] > 10.25 and (sBuffer[2] - sBuffer[1]) > (sBuffer[1] * 0.255) then
				local co = GetEntityCoords(player)
				local fw = Fwv(player)
				SetEntityHealth(player,GetEntityHealth(player)-150)
				SetEntityCoords(player,co.x+fw.x,co.y+fw.y,co.z-0.47,true,true,true)
				SetEntityVelocity(player,vBuffer[2].x,vBuffer[2].y,vBuffer[2].z)
				segundos = 20
			end

			vBuffer[2] = vBuffer[1]
			vBuffer[1] = GetEntityVelocity(car)

			if IsControlJustReleased(1,47) then
				TriggerEvent("cancelando",true)
				if CintoSeguranca then
					TriggerEvent("vrp_sound:source",'unbelt',0.5)
					SetTimeout(2000,function()
						CintoSeguranca = false
						TriggerEvent("cancelando",false)
					end)
				else
					TriggerEvent("vrp_sound:source",'belt',0.5)
					SetTimeout(3000,function()
						CintoSeguranca = true
						TriggerEvent("cancelando",false)
					end)
				end
			end
		elseif ExNoCarro then
			ExNoCarro = false
			CintoSeguranca = false
			sBuffer[1],sBuffer[2] = 0.0,0.0
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONTAGEM
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if segundos > 0 then
			segundos = segundos - 1
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RAGDOLL
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		if segundos > 0 and GetEntityHealth(player) > 100 then
			SetPedToRagdoll(player,1000,1000,0,0,0,0)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- AGACHAR
-----------------------------------------------------------------------------------------------------------------------------------------
local agachar = false
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		local ped = PlayerPedId()
		DisableControlAction(0,36,true)
		if not IsPedInAnyVehicle(ped) then
			RequestAnimSet("move_ped_crouched")
			RequestAnimSet("move_ped_crouched_strafing")
			if IsDisabledControlJustPressed(0,36) then
				if agachar then
					ResetPedMovementClipset(ped,0.25)
					ResetPedStrafeClipset(ped)
					agachar = false
				else
					SetPedMovementClipset(ped,"move_ped_crouched",0.25)
					SetPedStrafeClipset(ped,"move_ped_crouched_strafing")
					agachar = true
				end
				TriggerServerEvent("emp_residencia:abaixar", agachar)
			end
		end
	end
end)

-- FERIDO
local isFerido = false	
Citizen.CreateThread(function()
	
	while true do
		player = PlayerPedId()
		local vida = GetEntityHealth(player)
		if vida < 400*0.7 then
			if agachar == false then
				isFerido = true
				vRP.loadAnimSet("move_m@injured")
			end
		else
			if isFerido then
				ResetPedMovementClipset(player, 0.0)
				isFerido = false
			end
		end
		
		Citizen.Wait(1000)
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
function drawRct(x,y,width,height,r,g,b,a)
	DrawRect(x+width/2,y+height/2,width,height,r,g,b,a)
end

function drawTxt(x,y,scale,text,r,g,b,a)
	SetTextFont(4)
	SetTextScale(scale,scale)
	SetTextColour(r,g,b,a)
	SetTextOutline()
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x,y)
end

function GetMinimapAnchor()
    local safezone = GetSafeZoneSize()
    local safezone_x = 1.0 / 20.0
    local safezone_y = 1.0 / 20.0
    local aspect_ratio = GetAspectRatio(0)
    local res_x, res_y = GetActiveScreenResolution()
    local xscale = 1.0 / res_x
    local yscale = 1.0 / res_y
    local Minimap = {}
    Minimap.width = xscale * (res_x / (4 * aspect_ratio))
    Minimap.height = yscale * (res_y / 5.674)
    Minimap.left_x = xscale * (res_x * (safezone_x * ((math.abs(safezone - 1.0)) * 10)))
    Minimap.bottom_y = 1.0 - yscale * (res_y * (safezone_y * ((math.abs(safezone - 1.0)) * 10)))
    Minimap.right_x = Minimap.left_x + Minimap.width
    Minimap.top_y = Minimap.bottom_y - Minimap.height
    Minimap.x = Minimap.left_x
    Minimap.y = Minimap.top_y
    Minimap.xunit = xscale
    Minimap.yunit = yscale
    return Minimap
end

