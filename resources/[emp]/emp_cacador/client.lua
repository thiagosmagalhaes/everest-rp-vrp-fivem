local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
emP = Tunnel.getInterface("emp_cacador")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local progress = false
local selectnpc = nil
local inCaca = false

local functions = {
	[1] = { hash = 1457690978, item = "carnedecormorao", nome = "Cormorão" },
	[2] = { hash = 402729631, item = "carnedecorvo", nome = "Corvo" },
	[3] = { hash = -1430839454, item = "carnedeaguia", nome = "Águia" },
	[4] = { hash = -664053099, item = "carnedecervo", nome = "Cervo" },
	[5] = { hash = -541762431, item = "carnedecoelho", nome = "Coelho" },
	[6] = { hash = 1682622302, item = "carnedecoyote", nome = "Coyote" },
	[7] = { hash = 1318032802, item = "carnedelobo", nome = "Lobo" },
	[8] = { hash = 307287994, item = "carnedepuma", nome = "Puma" },
	[9] = { hash = -832573324, item = "carneonca", nome = "Onça" },
}

local cacas = {}

RegisterCommand("caçar", function(source, args, raw)
	inCaca = not inCaca
	if inCaca then
		TriggerEvent("Notify", "sucesso", "Você ativou o modo caçador!")
	else
		TriggerEvent("Notify", "aviso", "Você desativou o modo caçador!")
	end
	verificaAnimalMorto() 
	ativarLojaDeCarnes()
end)


function verificaAnimalMorto() 
	async(function()
		while inCaca do
			Citizen.Wait(1)
			local ped = PlayerPedId()
			local random,npc = FindFirstPed()
			repeat
				local distancia = GetDistanceBetweenCoords(GetEntityCoords(ped),GetEntityCoords(npc),true)
				if not cacas[npc] and IsPedDeadOrDying(npc) and not IsPedAPlayer(npc) and distancia <= 1.5 and not IsPedInAnyVehicle(ped) and not IsPedInAnyVehicle(npc) and not selectnpc then
					for _,cacador in pairs(functions) do
						if GetEntityModel(npc) == cacador.hash then
							drawTxt("PRESSIONE  ~r~E~w~  PARA RETIRAR CARNE ANIMAL",4,0.5,0.93,0.50,255,255,255,180)
							if IsControlJustPressed(0,38) then
								if GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_KNIFE") or GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_DAGGER") or GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_MACHETE") or GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_SWITCHBLADE") or GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_HATCHET") or GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_BATTLEAXE") or GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_STONE_HATCHET") then
									quantidade = math.random(1,3)
									
									if emP.checkPayment(cacador.item,quantidade) then
										selectnpc = npc
	
										cacas[npc] = true
	
										TriggerEvent('cancelando',true)
										vRP._playAnim(false,{{"amb@world_human_gardener_plant@female@base","base_female"}},true)
										-- SetEntityHeading(ped,GetEntityHeading(npc))
	
										TriggerEvent("progress",10000,"COLETANDO CARNE")
										Citizen.Wait(10000)
										
										TriggerEvent('cancelando',false)
										
										emP.cancelarAnimal(npc)									
										ClearPedTasks(PlayerPedId())
				
										concluido = true
										selectnpc = nil
									else
										TriggerEvent("Notify","negado","Sem espaço suficiente na mochila.")
									end
								else
									TriggerEvent("Notify","aviso","Você deve portar uma faca para extração da carne!")
	
								end
							end
						end
					end
				end
				concluido,npc = FindNextPed(random)
			until not concluido
			EndFindPed(random)
		end
	end)
end


RegisterNetEvent("cancelarAnimal")
AddEventHandler("cancelarAnimal",function(npc)
	SetEntityAsNoLongerNeeded(npc)
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

-----------------------------------------------------------------------------------------------------------------------------------------
-- NUI FUNCTIONS
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
	if data == "carnedecormorao" then
		TriggerServerEvent("cacador-vender","carnedecormorao")
	elseif data == "carnedecorvo" then
		TriggerServerEvent("cacador-vender","carnedecorvo")
	elseif data == "carnedeaguia" then
		TriggerServerEvent("cacador-vender","carnedeaguia")
	elseif data == "carnedecervo" then
		TriggerServerEvent("cacador-vender","carnedecervo")
	elseif data == "carnedecoelho" then
		TriggerServerEvent("cacador-vender","carnedecoelho")
	elseif data == "carnedecoyote" then
		TriggerServerEvent("cacador-vender","carnedecoyote")
	elseif data == "carnedelobo" then
		TriggerServerEvent("cacador-vender","carnedelobo")
	elseif data == "carnedepuma" then
		TriggerServerEvent("cacador-vender","carnedepuma")
	elseif data == "carnedejavali" then
		TriggerServerEvent("cacador-vender","carnedejavali")
	elseif data == "etiqueta" then
		TriggerServerEvent("cacador-vender","etiqueta")
	elseif data == "fechar" then
		ToggleActionMenu()
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCAIS
-----------------------------------------------------------------------------------------------------------------------------------------
function ativarLojaDeCarnes()
	async(function()
		SetNuiFocus(false,false)
		local time = 10000
		while inCaca do
			Citizen.Wait(time)
			local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),985.87,-2121.18,30.47,true)
			if distance <= 30 then
				time = 1
				DrawMarker(23,985.87,-2121.18,30.47-0.97,0,0,0,0,0,0,1.0,1.0,0.5,240,200,80,20,0,0,0,0)
				if distance <= 1.2 then
					if IsControlJustPressed(0,38) then
						ToggleActionMenu()
					end
				end
			else
				time = 10000
			end
		end
	end)
end