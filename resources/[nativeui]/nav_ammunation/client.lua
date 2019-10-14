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
	--if data == "armamentos-comprar-m1922" then
		--TriggerServerEvent("armamentos-comprar","wbody|WEAPON_VINTAGEPISTOL")
	--elseif data == "armamentos-comprar-m1911" then
		--TriggerServerEvent("armamentos-comprar","wbody|WEAPON_PISTOL")
	--elseif data == "armamentos-comprar-fnfiveseven" then
		--TriggerServerEvent("armamentos-comprar","wbody|WEAPON_PISTOL_MK2")
	if data == "armamentos-comprar-winchester22" then
		TriggerServerEvent("armamentos-comprar","wbody|WEAPON_MUSKET")
	elseif data == "armamentos-comprar-sinalizador" then
		TriggerServerEvent("armamentos-comprar","wbody|WEAPON_FLAREGUN")

	--elseif data == "armamentos-vender-m1922" then
		--TriggerServerEvent("armamentos-vender","wbody|WEAPON_VINTAGEPISTOL")
	--elseif data == "armamentos-vender-m1911" then
		--TriggerServerEvent("armamentos-vender","wbody|WEAPON_PISTOL")
	--elseif data == "armamentos-vender-fnfiveseven" then
		--TriggerServerEvent("armamentos-vender","wbody|WEAPON_PISTOL_MK2")
	elseif data == "armamentos-vender-winchester22" then
		TriggerServerEvent("armamentos-vender","wbody|WEAPON_MUSKET")
	elseif data == "armamentos-vender-sinalizador" then
		TriggerServerEvent("armamentos-vender","wbody|WEAPON_FLAREGUN")


	--elseif data == "municoes-comprar-m1922" then
		--TriggerServerEvent("armamentos-comprar","wammo|WEAPON_VINTAGEPISTOL")
	--elseif data == "municoes-comprar-m1911" then
		--TriggerServerEvent("armamentos-comprar","wammo|WEAPON_PISTOL")
	--elseif data == "municoes-comprar-fnfiveseven" then
		--TriggerServerEvent("armamentos-comprar","wammo|WEAPON_PISTOL_MK2")
	elseif data == "municoes-comprar-winchester22" then
		TriggerServerEvent("armamentos-comprar","wammo|WEAPON_MUSKET")
	elseif data == "municoes-comprar-sinalizador" then
		TriggerServerEvent("armamentos-comprar","wammo|WEAPON_FLAREGUN")

	--elseif data == "municoes-vender-m1922" then
		--TriggerServerEvent("armamentos-vender","wammo|WEAPON_VINTAGEPISTOL")
	--elseif data == "municoes-vender-m1911" then
		--TriggerServerEvent("armamentos-vender","wammo|WEAPON_PISTOL")
	--elseif data == "municoes-vender-fnfiveseven" then
		--TriggerServerEvent("armamentos-vender","wammo|WEAPON_PISTOL_MK2")
	--elseif data == "municoes-vender-winchester22" then
		--TriggerServerEvent("armamentos-vender","wammo|WEAPON_MUSKET")
	elseif data == "municoes-vender-sinalizador" then
		TriggerServerEvent("armamentos-vender","wammo|WEAPON_FLAREGUN")


	elseif data == "armamentos-comprar-faca" then
		TriggerServerEvent("armamentos-comprar","wbody|WEAPON_KNIFE")
	elseif data == "armamentos-comprar-adaga" then
		TriggerServerEvent("armamentos-comprar","wbody|WEAPON_DAGGER")
	elseif data == "armamentos-comprar-ingles" then
		TriggerServerEvent("armamentos-comprar","wbody|WEAPON_KNUCKLE")
	elseif data == "armamentos-comprar-machete" then
		TriggerServerEvent("armamentos-comprar","wbody|WEAPON_MACHETE")
	elseif data == "armamentos-comprar-canivete" then
		TriggerServerEvent("armamentos-comprar","wbody|WEAPON_SWITCHBLADE")
	elseif data == "armamentos-comprar-grifo" then
		TriggerServerEvent("armamentos-comprar","wbody|WEAPON_WRENCH")
	elseif data == "armamentos-comprar-martelo" then
		TriggerServerEvent("armamentos-comprar","wbody|WEAPON_HAMMER")
	elseif data == "armamentos-comprar-golf" then
		TriggerServerEvent("armamentos-comprar","wbody|WEAPON_GOLFCLUB")
	elseif data == "armamentos-comprar-cabra" then
		TriggerServerEvent("armamentos-comprar","wbody|WEAPON_CROWBAR")
	elseif data == "armamentos-comprar-machado" then
		TriggerServerEvent("armamentos-comprar","wbody|WEAPON_HATCHET")
	elseif data == "armamentos-comprar-lanterna" then
		TriggerServerEvent("armamentos-comprar","wbody|WEAPON_FLASHLIGHT")
	elseif data == "armamentos-comprar-beisebol" then
		TriggerServerEvent("armamentos-comprar","wbody|WEAPON_BAT")
	elseif data == "armamentos-comprar-garrafa" then
		TriggerServerEvent("armamentos-comprar","wbody|WEAPON_BOTTLE")
	elseif data == "armamentos-comprar-batalha" then
		TriggerServerEvent("armamentos-comprar","wbody|WEAPON_BATTLEAXE")
	elseif data == "armamentos-comprar-sinuca" then
		TriggerServerEvent("armamentos-comprar","wbody|WEAPON_POOLCUE")
	elseif data == "armamentos-comprar-pedra" then
		TriggerServerEvent("armamentos-comprar","wbody|WEAPON_STONE_HATCHET")

	elseif data == "armamentos-vender-faca" then
		TriggerServerEvent("armamentos-vender","wbody|WEAPON_KNIFE")
	elseif data == "armamentos-vender-adaga" then
		TriggerServerEvent("armamentos-vender","wbody|WEAPON_DAGGER")
	elseif data == "armamentos-vender-ingles" then
		TriggerServerEvent("armamentos-vender","wbody|WEAPON_KNUCKLE")
	elseif data == "armamentos-vender-machete" then
		TriggerServerEvent("armamentos-vender","wbody|WEAPON_MACHETE")
	elseif data == "armamentos-vender-canivete" then
		TriggerServerEvent("armamentos-vender","wbody|WEAPON_SWITCHBLADE")
	elseif data == "armamentos-vender-grifo" then
		TriggerServerEvent("armamentos-vender","wbody|WEAPON_WRENCH")
	elseif data == "armamentos-vender-martelo" then
		TriggerServerEvent("armamentos-vender","wbody|WEAPON_HAMMER")
	elseif data == "armamentos-vender-golf" then
		TriggerServerEvent("armamentos-vender","wbody|WEAPON_GOLFCLUB")
	elseif data == "armamentos-vender-cabra" then
		TriggerServerEvent("armamentos-vender","wbody|WEAPON_CROWBAR")
	elseif data == "armamentos-vender-machado" then
		TriggerServerEvent("armamentos-vender","wbody|WEAPON_HATCHET")
	elseif data == "armamentos-vender-lanterna" then
		TriggerServerEvent("armamentos-vender","wbody|WEAPON_FLASHLIGHT")
	elseif data == "armamentos-vender-beisebol" then
		TriggerServerEvent("armamentos-vender","wbody|WEAPON_BAT")
	elseif data == "armamentos-vender-garrafa" then
		TriggerServerEvent("armamentos-vender","wbody|WEAPON_BOTTLE")
	elseif data == "armamentos-vender-batalha" then
		TriggerServerEvent("armamentos-vender","wbody|WEAPON_BATTLEAXE")
	elseif data == "armamentos-vender-sinuca" then
		TriggerServerEvent("armamentos-vender","wbody|WEAPON_POOLCUE")
	elseif data == "armamentos-vender-pedra" then
		TriggerServerEvent("armamentos-vender","wbody|WEAPON_STONE_HATCHET")


	elseif data == "utilidades-comprar-paraquedas" then
		TriggerServerEvent("armamentos-comprar","wbody|GADGET_PARACHUTE")
	elseif data == "armamentos-comprar-colete" then
		TriggerServerEvent("armamentos-comprar","colete")
	elseif data == "utilidades-vender-paraquedas" then
		TriggerServerEvent("armamentos-vender","wbody|GADGET_PARACHUTE")

	elseif data == "utilidades-comprar-lancador" then
		TriggerServerEvent("armamentos-comprar","wbody|WEAPON_FIREWORK")
	elseif data == "utilidades-comprar-mlancador" then
		TriggerServerEvent("armamentos-comprar","wammo|WEAPON_FIREWORK")


	elseif data == "fechar" then
		ToggleActionMenu()
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCAIS
-----------------------------------------------------------------------------------------------------------------------------------------
local marcacoes = {
	{ 1692.62,3759.50,34.70 },
	{ 252.89,-49.25,69.94 },
	{ 843.28,-1034.02,28.19 },
	{ -331.35,6083.45,31.45 },
	{ -663.15,-934.92,21.82 },
	{ -1305.18,-393.48,36.69 },
	{ -1118.80,2698.22,18.55 },
	{ 2568.83,293.89,108.73 },
	{ -3172.68,1087.10,20.83 },
	{ 21.32,-1106.44,29.79 },
	{ 811.19,-2157.67,29.61 }
}

Citizen.CreateThread(function()
	SetNuiFocus(false,false)
	while true do
		Citizen.Wait(1)
		for _,mark in pairs(marcacoes) do
			local x,y,z = table.unpack(mark)
			local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),x,y,z,true)
			if distance <= 1.2 then
				if IsControlJustPressed(0,38) then
					ToggleActionMenu()
				end
			end
		end
	end
end)