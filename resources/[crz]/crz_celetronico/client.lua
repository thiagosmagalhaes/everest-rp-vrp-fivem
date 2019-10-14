-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local roubando = false
local atmRoubando = 0
-----------------------------------------------------------------------------------------------------------------------------------------
-- DEFINIÇÃO
-----------------------------------------------------------------------------------------------------------------------------------------
local atms = {
   -- {atms = 1, x=119.19,y=-883.72, z=30.70, nivel = 2, subnivel = 3}, -- okay timing
	{atms = 2,x=-1316.06,y=-834.92,z=16.96, nivel = 9, subnivel = 2}, -- OKAY TIMING
	--{atms = 3,x=158.45,y=233.79,z=106.62, nivel = 9, subnivel = 3}, -- OKAY TIMING
	{atms = 4,x=1138.61,y=-468.97,z=66.73, nivel = 7, subnivel = 3}, -- OKAY TIMING 
	{atms = 5,x=1077.67,y=-776.06,z=58.22, nivel = 8, subnivel = 3}, -- OKAY TIMING
	--{atms = 6,x=-712.86,y=-819.16,z=23.72, nivel = 8, subnivel = 3}, -- OKAY TIMING
	{atms = 7,x=-821.44,y=-1082.21,z=11.13, nivel = 7, subnivel = 3}, -- OKAY TIMING
	--{atms = 8,x=-1429.99,y=-210.97,z=46.50, nivel = 4, subnivel = 2}, -- OKAY TIMING
	{atms = 9,x=-2072.85,y= -317.20,z=13.31, nivel = 9, subnivel = 3},-- OKAY TIMING
	{atms = 10,x=-526.51,y=-1222.72,z=18.45, nivel = 7, subnivel = 2}, -- OKAY TIMING
    {atms = 11,x=-254.30,y=-692.16,z=33.60, nivel = 8, subnivel = 3}, -- OKAY TIMING 
    {atms = 12,x=146.71, y=-1045.89, z=29.36, nivel = 9, subnivel = 2}, -- BANCO PRACA
}

-----------------------------------------------------------------------------------------------------------------------------------------
-- INICIO DO ROUBO
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
        Citizen.Wait(1)
        for _,atm in pairs(atms) do
			local ped = PlayerPedId()
			local px,py,pz = table.unpack(GetEntityCoords(ped,true))
            local distancia = GetDistanceBetweenCoords(atm.x,atm.y,atm.z,px,py,pz,true)
            if not roubando then
                if distancia <= 50 then
                    if distancia <= 1.5 then
                        DrawText3Ds(atm.x,atm.y,atm.z+0.5,"PRESSIONE ~r~G~w~ PARA INICIAR INVASÃO")
                        if IsControlJustPressed(0,47) and not IsPedInAnyVehicle(ped,false) then
                            TriggerServerEvent('crz_celetronico:iniciandoInvasao',atm.atms)
                            atmRoubando = atm.atms
						end
					end
				end
            else
                if atm.atms == atmRoubando then
                    SendNUIMessage({
                        action = "receiveDados",
                        nivel = atm.nivel,
                        subnivel = atm.subnivel
                    })
					DrawText3Ds(atm.x,atm.y,atm.z,"VOCÊ ESTÁ INVADINDO O SISTEMA")
                end
                local ui = GetMinimapAnchor()
				drawTxt(ui.right_x+0.670,ui.bottom_y-0.046,1.0,1.0,0.45,"PRESSIONE ~r~F9 ~w~PARA CANCELAR A INVASÃO",255,255,255,150)
                if IsControlJustPressed(0,56) and not IsPedInAnyVehicle(ped,false) then
					local ped = PlayerPedId()
					roubando = false
					local px,py,pz = table.unpack(GetEntityCoords(ped,true))
					TriggerServerEvent('crz_celetronico:perdeuRoubo',atmRoubando, px,py,pz)
					PlaySoundFrontend( -1, "ATM_WINDOW", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1 )
					SetNuiFocus(false, false)
                    SendNUIMessage({
                        action = "close"
                    })
                end
            end
        end
    end
end)

RegisterNetEvent('crz_celetronico:abrirPainel')
AddEventHandler('crz_celetronico:abrirPainel', function(id)
    for _,atm in pairs(atms) do
        if atm.atms == id then
            SetNuiFocus(true, true)
            roubando = true
            SendNUIMessage({
                action = "start",
            })
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- NUI FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback('escape', function()
    roubando = false
	SetNuiFocus(false, false)
end)
RegisterNUICallback('perdeu', function()
    local ped = PlayerPedId()
    roubando = false
    local px,py,pz = table.unpack(GetEntityCoords(ped,true))
    TriggerServerEvent('crz_celetronico:perdeuRoubo',atmRoubando, px,py,pz)
    PlaySoundFrontend( -1, "ATM_WINDOW", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1 )
	SetNuiFocus(false, false)
end)

--already okay
RegisterNUICallback('ganhou', function()
    local ped = PlayerPedId()
    roubando = false
    local px,py,pz = table.unpack(GetEntityCoords(ped,true))
    TriggerServerEvent('crz_celetronico:finalizouRoubo',atmRoubando,px,py,pz)
    PlaySoundFrontend( -1, "CHECKPOINT_PERFECT", "HUD_MINI_GAME_SOUNDSET", 1 )
	SetNuiFocus(false, false)
end)
--already okay
RegisterNUICallback('policia', function()
    local ped = PlayerPedId()
    roubando = false
    local px,py,pz = table.unpack(GetEntityCoords(ped,true))
    TriggerServerEvent('crz_celetronico:chamarPolicia',atmRoubando, px,py,pz)
    PlaySoundFrontend( -1, "TIMER_STOP", "HUD_MINI_GAME_SOUNDSET", 1 )
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
function DrawText3Ds(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end

function drawTxt(x,y,width,height,scale,text,r,g,b,a)
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
    local safezone_y=1.0 / 20.0
    local aspect_ratio = GetAspectRatio(0)
    local res_x, res_y=GetActiveScreenResolution()
    local xscale = 1.0 / res_x
    local yscale = 1.0 / res_y
    local Minimap = {}
    Minimap.width = xscale * (res_x / (4 * aspect_ratio))
    Minimap.height = yscale * (res_y / 5.674)
    Minimap.left_x = xscale * (res_x * (safezone_x * ((math.abs(safezone - 1.0)) * 10)))
    Minimap.bottom_y=1.0 - yscale * (res_y * (safezone_y * ((math.abs(safezone - 1.0)) * 10)))
    Minimap.right_x = Minimap.left_x + Minimap.width
    Minimap.top_y=Minimap.bottom_y - Minimap.height
    Minimap.x = Minimap.left_x
    Minimap.y=Minimap.top_y
    Minimap.xunit = xscale
    Minimap.yunit = yscale
    return Minimap
end



RegisterNetEvent('criarblip')
AddEventHandler('criarblip',function(x,y,z)
	if not DoesBlipExist(blip) then
		blip = AddBlipForCoord(x,y,z)
		SetBlipScale(blip,0.5)
		SetBlipSprite(blip,1)
		SetBlipColour(blip,59)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Roubo em andamento")
		EndTextCommandSetBlipName(blip)
		SetBlipAsShortRange(blip,false)
		SetBlipRoute(blip,true)
	end
end)

RegisterNetEvent('removerblip')
AddEventHandler('removerblip',function()
	if DoesBlipExist(blip) then
		RemoveBlip(blip)
		blip = nil
	end
end)