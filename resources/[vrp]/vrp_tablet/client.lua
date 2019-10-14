local menuEnabled = false
function ToggleActionMenu()
	menuEnabled = not menuEnabled
	if menuEnabled then
		SetNuiFocus(true,true)
		SendNUIMessage({ showmenu = true })
	else
		SetNuiFocus(false,false)
		SendNUIMessage({ hidemenu = true })
	end
end

RegisterNUICallback("ButtonClick",function(data,cb)
	if data == "exit" then
		ToggleActionMenu()
	end
end)

Citizen.CreateThread(function()
	SetNuiFocus(false,false)
	while true do
		Citizen.Wait(1)
		if IsControlJustPressed(0,56) then
			ToggleActionMenu()
		end
	end
end)