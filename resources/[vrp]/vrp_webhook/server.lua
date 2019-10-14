local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "vrp_webhook")

func = {}
Tunnel.bindInterface("vrp_webhook", func)

-- with this you can turn on/off specific anticheese components, note: you can also turn these off while the script is running by using events, see examples for such below
Components = {
	Teleport = true,
	GodMode = true,
	Speedhack = true,
	WeaponBlacklist = true,
	CustomFlag = true,
}

--[[
event examples are:

anticheese:SetComponentStatus( component, state )
	enables or disables specific components
		component:
			an AntiCheese component, such as the ones listed above, must be a string
		state:
			the state to what the component should be set to, accepts booleans such as "true" for enabled and "false" for disabled


anticheese:ToggleComponent( component )
	sets a component to the opposite mode ( e.g. enabled becomes disabled ), there is no reason to use this.
		component:
			an AntiCheese component, such as the ones listed above, must be a string

anticheese:SetAllComponents( state )
	enables or disables **all** components
		state:
			the state to what the components should be set to, accepts booleans such as "true" for enabled and "false" for disabled


These can be used by triggering them like following:
	TriggerEvent("anticheese:SetComponentStatus", "Teleport", false)

Triggering these events from the clientside is not recommended as these get disabled globally and not just for one player.


]]


Users = {}
violations = {}





RegisterServerEvent("anticheese:timer:b2k")
AddEventHandler("anticheese:timer:b2k", function()
	if Users[source] then
		if (os.time() - Users[source]) < 15 and Components.Speedhack then -- impedir que o jogador faça um bom e velho speedhack
			DropPlayer(source, "Speedhacking")
		else
			Users[source] = os.time()
		end
	else
		Users[source] = os.time()
	end
end)

AddEventHandler('playerDropped', function()
	if(Users[source])then
		Users[source] = nil
	end
end)

RegisterServerEvent("anticheese:kick")
AddEventHandler("anticheese:kick", function(reason)
	DropPlayer(source, reason)
end)

RegisterServerEvent("anticheese:SetComponentStatus")
AddEventHandler("anticheese:SetComponentStatus", function(component, state)
	if source ~= "" then
		enviarMsg(GetPlayerName(source), "Tentei ignorar o cheat e foi rapidamente banido", 0, 0, 0)
		TriggerEvent("banCheater", source,"Cheating")
		return
	end
	if type(component) == "string" and type(state) == "boolean" then
		Components[component] = state -- changes the component to the wished status
	end
end)

RegisterServerEvent("anticheese:ToggleComponent")
AddEventHandler("anticheese:ToggleComponent", function(component)
	if source ~= "" then
		enviarMsg(GetPlayerName(source), "Tentei ignorar o cheat e foi rapidamente banido", 0, 0, 0)
		TriggerEvent("banCheater", source,"Cheating")
		return
	end
	if type(component) == "string" then
		Components[component] = not Components[component]
	end
end)

RegisterServerEvent("anticheese:SetAllComponents")
AddEventHandler("anticheese:SetAllComponents", function(state)
	if source ~= "" then
		enviarMsg(GetPlayerName(source), "Tentei ignorar o cheat e foi rapidamente banido", 0, 0, 0)

		TriggerEvent("banCheater", source,"Cheating")
		return
	end
	if type(state) == "boolean" then
		for i,theComponent in pairs(Components) do
			Components[i] = state
		end
	end
end)

Citizen.CreateThread(function()


	function WarnPlayer(playername, reason)
		local isKnown = false
		local isKnownCount = 1
		local isKnownExtraText = ""
		for i,thePlayer in ipairs(violations) do
			if thePlayer.name == name then
				isKnown = true
				if violations[i].count == 3 then
					-- TriggerEvent("banCheater", source,"Cheating")
					isKnownCount = violations[i].count
					table.remove(violations,i)
					isKnownExtraText = ", was banned."
				else
					violations[i].count = violations[i].count+1
					isKnownCount = violations[i].count
				end
			end
		end

		if not isKnown then
			table.insert(violations, { name = name, count = 1 })
		end

		return isKnown, isKnownCount,isKnownExtraText
	end

	function GetPlayerNeededIdentifiers(player)
		local ids = GetPlayerIdentifiers(player)
		for i,theIdentifier in ipairs(ids) do
			if string.find(theIdentifier,"license:") or -1 > -1 then
				license = theIdentifier
			elseif string.find(theIdentifier,"steam:") or -1 > -1 then
				steam = theIdentifier
			end
		end
		if not steam then
			steam = "steam: missing"
		end
		return license, steam
	end

	RegisterServerEvent('AntiCheese:SpeedFlag')
	AddEventHandler('AntiCheese:SpeedFlag', function(speed, model)
		if Components.Speedhack and not IsPlayerAceAllowed(source,"anticheese.bypass") then
			license, steam = GetPlayerNeededIdentifiers(source)

			name = GetPlayerName(source)

			isKnown, isKnownCount, isKnownExtraText = WarnPlayer(name,"Speed Hacking")
			enviarMsg("Speed Hacker!", "Este usuário estava a "..speed.."km/h no veiculo "..model, isKnown, isKnownCount, isKnownExtraText)
		end
	end)



	RegisterServerEvent('AntiCheese:NoclipFlag')
	AddEventHandler('AntiCheese:NoclipFlag', function(distance)
		if Components.Speedhack and not IsPlayerAceAllowed(source,"anticheese.bypass") then
			name = GetPlayerName(source)

			isKnown, isKnownCount, isKnownExtraText = WarnPlayer(name,"Noclip/Teleport Hacking")

			enviarMsg("Noclip/Teleport!", "Caught with "..distance.." units between last checked location", isKnown, isKnownCount, isKnownExtraText)
		end
	end)
	
	
	RegisterServerEvent('AntiCheese:CustomFlag')
	AddEventHandler('AntiCheese:CustomFlag', function(reason,extrainfo)
		if Components.CustomFlag and not IsPlayerAceAllowed(source,"anticheese.bypass") then
			name = GetPlayerName(source)
			if not extrainfo then extrainfo = "no extra informations provided" end
			isKnown, isKnownCount, isKnownExtraText = WarnPlayer(name,reason)

			enviarMsg(reason, extrainfo, isKnown, isKnownCount, isKnownExtraText)

		end
	end)

	RegisterServerEvent('AntiCheese:HealthFlag')
	AddEventHandler('AntiCheese:HealthFlag', function(invincible,oldHealth, newHealth, curWait)
		if Components.GodMode and not IsPlayerAceAllowed(source,"anticheese.bypass") then
			name = GetPlayerName(source)

			isKnown, isKnownCount, isKnownExtraText = WarnPlayer(name,"Health Hacking")

			if invincible then
				enviarMsg("Health Hack!", "Regenerated "..newHealth-oldHealth.."hp ( to reach "..newHealth.."hp ) in "..curWait.."ms! ( PlayerPed was invincible )", isKnown, isKnownCount, isKnownExtraText)
			else
				enviarMsg("Health Hack!", "Regenerated "..newHealth-oldHealth.."hp ( to reach "..newHealth.."hp ) in "..curWait.."ms! ( Health was Forced )", isKnown, isKnownCount, isKnownExtraText)
			end
		end
	end)

	RegisterServerEvent('AntiCheese:JumpFlag')
	AddEventHandler('AntiCheese:JumpFlag', function(jumplength)
		if Components.SuperJump and not IsPlayerAceAllowed(source,"anticheese.bypass") then
			name = GetPlayerName(source)

			isKnown, isKnownCount, isKnownExtraText = WarnPlayer(name,"SuperJump Hacking")

			enviarMsg("SuperJump Hack!", "Jumped "..jumplength.."ms long", isKnown, isKnownCount, isKnownExtraText)
		end
	end)

	RegisterServerEvent('AntiCheese:WeaponFlag')
	AddEventHandler('AntiCheese:WeaponFlag', function(weapon)
		local user_id = vRP.getUserId(source)
		if Components.WeaponBlacklist and not IsPlayerAceAllowed(source,"anticheese.bypass") then
			name = GetPlayerName(source)

			isKnown, isKnownCount, isKnownExtraText = WarnPlayer(name,"Inventory Cheating")

			enviarMsg("Hack de inventário!", "Got Weapon: "..weapon.."( Blacklisted )", isKnown, isKnownCount, isKnownExtraText)

			vRP.setBanned(user_id,true)
			DropPlayer(source,"Hack de inventário!")
			
			
		end
	end)

end)

local idsEnable = false


AddEventHandler("playerDropped",function(reason)
	local source = source
    local user_id = vRP.getUserId(source)
    
    name = GetPlayerName(source)

	isKnown, isKnownCount, isKnownExtraText = WarnPlayer(name,"SAIU")

	enviarMsg("Deslogou", "Deslogou da cidade", isKnown, isKnownCount, isKnownExtraText, "https://discordapp.com/api/webhooks/621889886563336223/O1Q1FA6PxQCTJRH0jpXomOihrXhfDj0orIPDhSD6j_PtPiX7YQgmuUyvj-ebJv7r9Lb7")
end)

RegisterCommand("ids", function(source)
	local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"support.permissao") then
		if idsEnable then
			idsEnable = false
		else
			idsEnable = true
		end
		TriggerClientEvent("vrp_webhook:triggerDisplay", source, idsEnable, source)
	end
end)

function func.getUserId()
	return vRP.getUserId(source)
end

function enviarMsg(title, message, isKnown, isKnownCount, isKnownExtraText, url)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)

	if not IsPlayerAceAllowed(source,"anticheese.bypass") then
		license, steam = GetPlayerNeededIdentifiers(source)
		name = GetPlayerName(source)

		SendWebhookMessage(url, "**"..title.."** \n ```"..user_id.." "..identity.name.." "..identity.firstname.."\nUser:"..name.."\n"..license.."\n"..steam.." \n "..message.." \n Anticheat Flags:"..isKnownCount..""..isKnownExtraText.." ```")
	end
end

function SendWebhookMessage(url, message)
	if url == nil then
		url = "https://discordapp.com/api/webhooks/615297829673500735/iB5A1Yrog0Tk93yiUlDEYjMMCWQ6iYrzt5Bq8YBhgD4_UBEIzC4_X0GdP3ZwYdsO8E5-"
	end
    if webhook ~= "none" then
        PerformHttpRequest(
            url,
            function(err, text, headers) end, 'POST',
            json.encode({content = message}),
            {['Content-Type'] = 'application/json'})
    end
end
