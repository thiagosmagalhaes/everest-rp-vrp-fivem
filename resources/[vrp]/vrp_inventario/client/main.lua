local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

func = {}
Tunnel.bindInterface("vrp_inventario",func)

funcServ = Tunnel.getInterface("vrp_inventario")

local Keys = {
    ["ESC"] = 322,
    ["F1"] = 288,
    ["F2"] = 289,
    ["F3"] = 170,
    ["F5"] = 166,
    ["F6"] = 167,
    ["F7"] = 168,
    ["F8"] = 169,
    ["F9"] = 56,
    ["F10"] = 57,
    ["~"] = 243,
    ["1"] = 157,
    ["2"] = 158,
    ["3"] = 160,
    ["4"] = 164,
    ["5"] = 165,
    ["6"] = 159,
    ["7"] = 161,
    ["8"] = 162,
    ["9"] = 163,
    ["-"] = 84,
    ["="] = 83,
    ["BACKSPACE"] = 177,
    ["TAB"] = 37,
    ["Q"] = 44,
    ["W"] = 32,
    ["E"] = 38,
    ["R"] = 45,
    ["T"] = 245,
    ["Y"] = 246,
    ["U"] = 303,
    ["P"] = 199,
    ["["] = 39,
    ["]"] = 40,
    ["ENTER"] = 18,
    ["CAPS"] = 137,
    ["A"] = 34,
    ["S"] = 8,
    ["D"] = 9,
    ["F"] = 23,
    ["G"] = 47,
    ["H"] = 74,
    ["K"] = 311,
    ["L"] = 182,
    ["LEFTSHIFT"] = 21,
    ["Z"] = 20,
    ["X"] = 73,
    ["C"] = 26,
    ["V"] = 0,
    ["B"] = 29,
    ["N"] = 249,
    ["M"] = 244,
    [","] = 82,
    ["."] = 81,
    ["LEFTCTRL"] = 36,
    ["LEFTALT"] = 19,
    ["SPACE"] = 22,
    ["RIGHTCTRL"] = 70,
    ["HOME"] = 213,
    ["PAGEUP"] = 10,
    ["PAGEDOWN"] = 11,
    ["DELETE"] = 178,
    ["LEFT"] = 174,
    ["RIGHT"] = 175,
    ["TOP"] = 27,
    ["DOWN"] = 173,
    ["NENTER"] = 201,
    ["N4"] = 108,
    ["N5"] = 60,
    ["N6"] = 107,
    ["N+"] = 96,
    ["N-"] = 97,
    ["N7"] = 117,
    ["N8"] = 61,
    ["N9"] = 118
}

local trunkData = nil
local isInInventory = false

-----------------------------------------------------------------------------------------------------------------------------------------
-- /MOC
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('moc',function(source,args,rawCommand)
	openInventory()
end)

function openInventory()
    loadPlayerInventory()
    isInInventory = true
    SendNUIMessage(
        {
            action = "display",
            type = "normal"
        }
    )
    SetNuiFocus(true, true)
end


function closeInventory()
    isInInventory = false
    SendNUIMessage(
        {
            action = "hide"
        }
    )
    SetNuiFocus(false, false)
end

RegisterNUICallback(
    "NUIFocusOff",
    function()
        closeInventory()
    end
)


RegisterNUICallback(
    "UseItem",
    function(data, cb)
        funcServ.userItem(data.item.type, data.item.nome, data.number)
        Citizen.Wait(500)
        loadPlayerInventory()

        cb("ok")
    end
)

RegisterNUICallback(
    "DropItem",
    function(data, cb)
        if IsPedSittingInAnyVehicle(playerPed) then
            return
        end
        if type(data.number) == "number" and math.floor(data.number) == data.number then
            -- TriggerServerEvent("esx:removeInventoryItem", data.item.type, data.item.name, data.number)
            funcServ.droparItem(data.item.type, data.item.nome, data.number)
        end

        Wait(500)
        loadPlayerInventory()

        cb("ok")
    end
)

RegisterNUICallback(
    "GiveItem",
    function(data, cb)
        local count = tonumber(data.number)

        if data.item.type == "item_weapon" then
            count = GetAmmoInPedWeapon(PlayerPedId(), GetHashKey(data.item.nome))
        end

        funcServ.enviarItem(data.item.type, data.item.nome, count)
        Wait(500)
        loadPlayerInventory()
        cb("ok")
    end
)

function shouldSkipAccount(accountName)
    for index, value in ipairs(Config.ExcludeAccountsList) do
        if value == accountName then
            return true
        end
    end

    return false
end



function loadPlayerInventory()
    
 local data, money = funcServ.getPlayerInventory()
        items = {}
        inventory = data.inventory
        -- accounts = data.accounts
        
        weapons = data.weapons
        moneyData = {
            label = "Dinheiro",
            nome = "money",
            type = "money",
            count = money,
            usable = false,
            rare = false,
            limit = -1,
            canRemove = true,
            dropar = false
        }
        table.insert(items, moneyData)
        
        if inventory ~= nil then
            for key, value in pairs(inventory) do
                if itemlist[key] then
                    if inventory[key].amount <= 0 then
                        inventory[key] = nil
                    else
                        local use = true
                        if itemlist[key].index == "celular" then
                            use = false
                        end
                        item = {
                            label = itemlist[key].nome,
                            nome = itemlist[key].index,
                            type = itemlist[key].type,
                            count = value.amount,
                            usable = use,
                            rare = false,
                            limit = -1,
                            canRemove = true,
                            dropar = true
                        }
                        table.insert(items, item)
                    end
                end
            end
        end

        -- if Config.IncludeWeapons and weapons ~= nil then
        --     for key, value in pairs(weapons) do
        --         local weaponHash = GetHashKey(weapons[key].name)
        --         local playerPed = PlayerPedId()
        --         if HasPedGotWeapon(playerPed, weaponHash, false) and weapons[key].name ~= "WEAPON_UNARMED" then
        --             local ammo = GetAmmoInPedWeapon(playerPed, weaponHash)
        --             table.insert(
        --                 items,
        --                 {
        --                     label = weapons[key].label,
        --                     count = ammo,
        --                     limit = -1,
        --                     type = "item_weapon",
        --                     name = weapons[key].name,
        --                     usable = false,
        --                     rare = false,
        --                     canRemove = true
        --                 }
        --             )
        --         end
        --     end
        -- end
        

        SendNUIMessage(
            {
                action = "setItems",
                itemList = items,
                capacidade = funcServ.getCapacidade()
            }
        )
    
end

Citizen.CreateThread(function()
    closeInventory()
        while true do
            Citizen.Wait(1)
            if isInInventory then
                local playerPed = PlayerPedId()
                DisableControlAction(0, 1, true) -- Disable pan
                DisableControlAction(0, 2, true) -- Disable tilt
                DisableControlAction(0, 24, true) -- Attack
                DisableControlAction(0, 257, true) -- Attack 2
                DisableControlAction(0, 25, true) -- Aim
                DisableControlAction(0, 263, true) -- Melee Attack 1
                DisableControlAction(0, Keys["W"], true) -- W
                DisableControlAction(0, Keys["A"], true) -- A
                DisableControlAction(0, 31, true) -- S (fault in Keys table!)
                DisableControlAction(0, 30, true) -- D (fault in Keys table!)

                DisableControlAction(0, Keys["R"], true) -- Reload
                DisableControlAction(0, Keys["SPACE"], true) -- Jump
                DisableControlAction(0, Keys["Q"], true) -- Cover
                DisableControlAction(0, Keys["TAB"], true) -- Select Weapon
                DisableControlAction(0, Keys["F"], true) -- Also 'enter'?

                DisableControlAction(0, Keys["F1"], true) -- Disable phone
                DisableControlAction(0, Keys["F2"], true) -- Inventory
                DisableControlAction(0, Keys["F3"], true) -- Animations
                DisableControlAction(0, Keys["F6"], true) -- Job

                DisableControlAction(0, Keys["V"], true) -- Disable changing view
                DisableControlAction(0, Keys["C"], true) -- Disable looking behind
                DisableControlAction(0, Keys["X"], true) -- Disable clearing animation
                DisableControlAction(2, Keys["P"], true) -- Disable pause screen

                DisableControlAction(0, 59, true) -- Disable steering in vehicle
                DisableControlAction(0, 71, true) -- Disable driving forward in vehicle
                DisableControlAction(0, 72, true) -- Disable reversing in vehicle

                DisableControlAction(2, Keys["LEFTCTRL"], true) -- Disable going stealth

                DisableControlAction(0, 47, true) -- Disable weapon
                DisableControlAction(0, 264, true) -- Disable melee
                DisableControlAction(0, 257, true) -- Disable melee
                DisableControlAction(0, 140, true) -- Disable melee
                DisableControlAction(0, 141, true) -- Disable melee
                DisableControlAction(0, 142, true) -- Disable melee
                DisableControlAction(0, 143, true) -- Disable melee
                DisableControlAction(0, 75, true) -- Disable exit vehicle
                DisableControlAction(27, 75, true) -- Disable exit vehicle
            end
        end
    end
)


function func.temArma(v)
    return HasPedGotWeapon(PlayerPedId(),GetHashKey(v),false) == 1
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- BEBIDAS ENERGETICAS
-----------------------------------------------------------------------------------------------------------------------------------------
local energetico = false
RegisterNetEvent('energeticos')
AddEventHandler('energeticos',function(status)
	energetico = status
	if energetico then
		SetRunSprintMultiplierForPlayer(PlayerId(),1.15)
	else
		SetRunSprintMultiplierForPlayer(PlayerId(),1.0)
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if energetico then
			RestorePlayerStamina(PlayerId(),1.0)
		end
	end
end)