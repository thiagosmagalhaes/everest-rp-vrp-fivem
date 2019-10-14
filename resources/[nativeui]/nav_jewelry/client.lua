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
	if data == "relogioroubado" then
		TriggerServerEvent("jewelry-vender","relogioroubado")
	elseif data == "pulseiraroubada" then
		TriggerServerEvent("jewelry-vender","pulseiraroubada")
	elseif data == "anelroubado" then
		TriggerServerEvent("jewelry-vender","anelroubado")
	elseif data == "colarroubado" then
		TriggerServerEvent("jewelry-vender","colarroubado")
	elseif data == "brincoroubado" then
		TriggerServerEvent("jewelry-vender","brincoroubado")
	elseif data == "carregadorroubado" then
		TriggerServerEvent("jewelry-vender","carregadorroubado")
	elseif data == "carteiraroubada" then
		TriggerServerEvent("jewelry-vender","carteiraroubada")
	elseif data == "tabletroubado" then
		TriggerServerEvent("jewelry-vender","tabletroubado")
	elseif data == "sapatosroubado" then
		TriggerServerEvent("jewelry-vender","sapatosroubado")
	elseif data == "maquiagemroubada" then
		TriggerServerEvent("jewelry-vender","maquiagemroubada")
	elseif data == "vibradorroubado" then
		TriggerServerEvent("jewelry-vender","vibradorroubado")
	elseif data == "perfumeroubado" then
		TriggerServerEvent("jewelry-vender","perfumeroubado")

	elseif data == "fechar" then
		ToggleActionMenu()
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCAIS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	SetNuiFocus(false,false)
	local time = 10000
	while true do
		
		time = 10000
		local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),707.31,-966.99,30.41,true)
		if distance <= 30 then
			time = 1
			DrawMarker(23,707.31,-966.99,30.41-0.97,0,0,0,0,0,0,1.0,1.0,0.5,240,200,80,20,0,0,0,0)
			if distance <= 1.2 then
				if IsControlJustPressed(0,38) then
					ToggleActionMenu()
				end
			end
		end

		local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),-69.24,6255.73,31.09,true)
		if distance <= 30 then
			time = 1
			DrawMarker(23,-69.24,6255.73,31.09-0.97,0,0,0,0,0,0,1.0,1.0,0.5,240,200,80,20,0,0,0,0)
			if distance <= 1.2 then
				if IsControlJustPressed(0,38) then
					ToggleActionMenu()
				end
			end
		end
		Citizen.Wait(time)
	end
end)