local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
emP = Tunnel.getInterface("emp_assassino")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local pedlist = {}
local progress = false
local segundos = 0
local selectnpc = nil
local emservico = false
local CoordenadaX = -287.29
local CoordenadaY = -1062.87
local CoordenadaZ = 27.20
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRABALHAR
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if not emservico then
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(CoordenadaX,CoordenadaY,CoordenadaZ)
			local distance = GetDistanceBetweenCoords(CoordenadaX,CoordenadaY,cdz,x,y,z,true)

			if distance <= 30.0 then
				DrawMarker(23,CoordenadaX,CoordenadaY,CoordenadaZ-0.97,0,0,0,0,0,0,1.0,1.0,0.5,240,200,80,20,0,0,0,0)
				if distance <= 1.2 then
					drawTxt("PRESSIONE  ~b~E~w~  PARA INICIAR A RETIRADA DOS ÓRGÃOS",4,0.5,0.93,0.50,255,255,255,180)
					if IsControlJustPressed(0,38) then
						emservico = true
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PROCESSO
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if emservico then
			local ped = PlayerPedId()
			local distance = GetDistanceBetweenCoords(GetEntityCoords(ped),-186.1,-893.5,29.3,true)
			if distance <= 2100 then
				local random,npc = FindFirstPed()
				repeat
					local distancia = GetDistanceBetweenCoords(GetEntityCoords(ped),GetEntityCoords(npc),true)
					if IsPedDeadOrDying(npc) and not IsPedAPlayer(npc) and distancia <= 1.5 and not IsPedInAnyVehicle(ped) and not IsPedInAnyVehicle(npc) and not selectnpc and GetPedType(npc) ~= 28 and not pedlist[npc] then
						drawTxt("PRESSIONE  ~b~E~w~  PARA RETIRAR OS ÓRGÃOS",4,0.5,0.93,0.50,255,255,255,180)
						if IsControlJustPressed(0,38) then
							if GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_KNIFE") or GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_DAGGER") or GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_MACHETE") or GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_SWITCHBLADE") or GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_HATCHET") or GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_BATTLEAXE") or GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_STONE_HATCHET") then
								if emP.checkPayment() then
									selectnpc = npc
									pedlist[npc] = true
									segundos = 3
									vRP._playAnim(false,{{"amb@medic@standing@kneel@idle_a","idle_a"}},true)
									SetEntityHeading(ped,GetEntityHeading(npc))
									TriggerServerEvent("trydeleteped",PedToNet(npc))
									TriggerEvent('cancelando',true)

									local random = math.random(100)
									if random >= 90 then
										emP.MarcarOcorrencia()
									end

									repeat
										Citizen.Wait(10)
									until not selectnpc

									vRP._stopAnim(false)
									vRP._DeletarObjeto()
									concluido = true
								end
							end
						end
					end
					concluido,npc = FindNextPed(random)
				until not concluido
				EndFindPed(random)
			end
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- TEXTO
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if segundos > 0 then
			drawTxt("AGUARDE ~b~"..segundos.."~w~ SEGUNDOS ATÉ FINALIZAR A RETIRADA DOS ÓRGÃOS",4,0.5,0.93,0.50,255,255,255,180)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DIMINUINDO O TEMPO
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if emservico then
			if segundos > 0 then
				segundos = segundos - 1
				if segundos == 0 then
					selectnpc = nil
					TriggerEvent('cancelando',false)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CANCELAR
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if emservico then
			if IsControlJustPressed(0,121) then
				emservico = false
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