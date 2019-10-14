-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local hour = 0
local minute = 0
local month = ""
local dayOfMonth = 0
local proximity = 8.001
local voice = 1
local radio = ""
-----------------------------------------------------------------------------------------------------------------------------------------
-- CalculateTimeToDisplay
-----------------------------------------------------------------------------------------------------------------------------------------
function CalculateTimeToDisplay()
	hour = GetClockHours()
	minute = GetClockMinutes()
	if hour <= 9 then
		hour = "0" .. hour
	end
	if minute <= 9 then
		minute = "0" .. minute
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CalculateDateToDisplay
-----------------------------------------------------------------------------------------------------------------------------------------
function CalculateDateToDisplay()
	month = GetClockMonth()
	dayOfMonth = GetClockDayOfMonth()
	if month == 0 then
		month = "Janeiro"
	elseif month == 1 then
		month = "Fevereiro"
	elseif month == 2 then
		month = "Março"
	elseif month == 3 then
		month = "Abril"
	elseif month == 4 then
		month = "Maio"
	elseif month == 5 then
		month = "Junho"
	elseif month == 6 then
		month = "Julho"
	elseif month == 7 then
		month = "Agosto"
	elseif month == 8 then
		month = "Setembro"
	elseif month == 9 then
		month = "Outubro"
	elseif month == 10 then
		month = "Novembro"
	elseif month == 11 then
		month = "Dezembro"
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATEOVERLAY
-----------------------------------------------------------------------------------------------------------------------------------------
function UpdateOverlay()
	local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
	local street = GetStreetNameFromHashKey(GetStreetNameAtCoord(x,y,z))
	CalculateTimeToDisplay()
	CalculateDateToDisplay()
	
	SendNUIMessage({ dia = dayOfMonth, mes = month, hora = hour, minuto = minute, rua = street, voz = voice, radio = radio })
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- AUTO-UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	-- NetworkSetTalkerProximity(proximity)
	while true do
		Citizen.Wait(1000)
		UpdateOverlay()
	end
end)

RegisterNUICallback("setRadio",function(data,cb)
	radio = data.radio
	UpdateOverlay()
end)

RegisterNetEvent('vrp_simplehud:voice')
AddEventHandler('vrp_simplehud:voice',function(distancia)
	voice = distancia
	UpdateOverlay()
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- HOME-BUTTON
-----------------------------------------------------------------------------------------------------------------------------------------
-- Citizen.CreateThread(function()
-- 	while true do
-- 		Citizen.Wait(5)
-- 		if IsControlJustPressed(1,212) and GetEntityHealth(PlayerPedId()) > 100 then
-- 			if proximity == 3.001 then
-- 				voice = 2
-- 				proximity = 8.001
-- 			elseif proximity == 8.001 then
-- 				voice = 3
-- 				proximity = 15.001
-- 			elseif proximity == 15.001 then
-- 				voice = 4
-- 				proximity = 30.001
-- 			elseif proximity == 30.001 then
-- 				voice = 1
-- 				proximity = 3.001
-- 			end
-- 			UpdateOverlay()
-- 			NetworkClearVoiceChannel()
-- 			NetworkSetTalkerProximity(proximity)

-- 		end
-- 	end
-- end)



-- Citizen.CreateThread(function()
--     while true do
--         for id = 0, 256 do
--             if ((NetworkIsPlayerActive(id))) then
--                 ped = GetPlayerPed(id)

--                 x1, y1, z1 = table.unpack(
--                                  GetEntityCoords(GetPlayerPed(-1), true))
--                 x2, y2, z2 = table.unpack(
--                                  GetEntityCoords(GetPlayerPed(id), true))
--                 distance = math.floor(GetDistanceBetweenCoords(x1, y1, z1, x2,
--                                                                y2, z2, true))
--                 local takeaway = 0.95

--                 if (distance < proximity) then
--                     if NetworkIsPlayerTalking(id) then
--                         DrawMarker(25, x2, y2, z2 - takeaway, 0, 0, 0, 0, 0, 0,
--                                    1.0, 1.0, 5.3, 224, 18, 50, 50, 0, 0, 2,
--                                    0, 0, 0, 0)                    
--                     end
--                 end
--             end
--         end
--         Citizen.Wait(1)
--     end
-- end)