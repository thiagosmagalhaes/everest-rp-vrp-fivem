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
	if data == "dourado" then
		TriggerServerEvent("pescador-vender","dourado")
	elseif data == "corvina" then
		TriggerServerEvent("pescador-vender","corvina")
	elseif data == "salmao" then
		TriggerServerEvent("pescador-vender","salmao")
	elseif data == "pacu" then
		TriggerServerEvent("pescador-vender","pacu")
	elseif data == "pintado" then
		TriggerServerEvent("pescador-vender","pintado")
	elseif data == "pirarucu" then
		TriggerServerEvent("pescador-vender","pirarucu")
	elseif data == "tilapia" then
		TriggerServerEvent("pescador-vender","tilapia")
	elseif data == "tucunare" then
		TriggerServerEvent("pescador-vender","tucunare")


	elseif data == "fechar" then
		ToggleActionMenu()
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCAIS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	SetNuiFocus(false,false)
	while true do
		Citizen.Wait(1)
		local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),-1816.72,-1193.83,14.30,true)
		if distance <= 30 then
			DrawMarker(23,-2223.14,-365.70,13.32-0.97,0,0,0,0,0,0,1.0,1.0,0.5,240,200,80,20,0,0,0,0)
			if distance <= 1.2 then
				if IsControlJustPressed(0,38) then
					ToggleActionMenu()
				end
			end
		end
	end
end)