local dropList = {}

RegisterNetEvent('DropSystem:remove')
AddEventHandler('DropSystem:remove',function(id)
	if dropList[id] ~= nil then
		dropList[id] = nil
	end
end)

RegisterNetEvent('DropSystem:createForAll')
AddEventHandler('DropSystem:createForAll',function(id,marker)
	dropList[id] = marker
end)

local cooldown = false
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		local ped = PlayerPedId()
		local x,y,z = table.unpack(GetEntityCoords(ped))
		for k,v in pairs(dropList) do
			local bowz,cdz = GetGroundZFor_3dCoord(v.x,v.y,v.z)
			if Vdist(v.x,v.y,cdz,x,y,z) <= 150 then
				DrawMarker(25,v.x,v.y,cdz+0.01,0,0,0,0,0,0,0.4,0.4,0.5,255,255,255,15,0,0,2,0,0,0,0)
				DrawMarker(21,v.x,v.y,cdz+0.60,0,0,0,0,180.0,130.0,0.6,0.8,0.5,21,142,255,50,1,0,0,1)
				if Vdist(v.x,v.y,cdz,x,y,z) <= 1.2 and v.count ~= nil and v.name ~= nil then
					drawTxt("PRESSIONE  ~b~E~w~  PARA PEGAR~g~ "..v.count.."X "..string.upper(v.name),4,0.5,0.93,0.50,255,255,255,180)
					if IsControlJustPressed(1,38) and not cooldown and not IsPedInAnyVehicle(ped) then
						cooldown = true
						TriggerServerEvent('DropSystem:take',k)
						SetTimeout(3000,function()
							cooldown = false
						end)
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