local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
local idgens = Tools.newIDGenerator()
-----------------------------------------------------------------------------------------------------------------------------------------
-- DV
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('dv',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"concessionaria.permissao") or vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"support.permissao") or vRP.hasPermission(user_id,"mecanico.permissao") then
		if vRP.hasPermission(user_id,"concessionaria.permissao") then
			TriggerClientEvent('vrp_concessionaria:deletarveiculo',source, 7)
		else
			TriggerClientEvent('deletarveiculo',source, 7)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRYDELETEENTITY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("trydeleteentity")
AddEventHandler("trydeleteentity",function(entid)
	TriggerClientEvent("syncdeleteentity",-1,entid)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRYDELETEVEH
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("trydeleteveh")
AddEventHandler("trydeleteveh",function(index)
	TriggerClientEvent("syncdeleteveh",-1,index)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRYDELETEPED
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("trydeleteped")
AddEventHandler("trydeleteped",function(index)
	TriggerClientEvent("syncdeleteped",-1,index)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRYDELETEOBJ
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("trydeleteobj")
AddEventHandler("trydeleteobj",function(index)
	TriggerClientEvent("syncdeleteobj",-1, index)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FIX
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('fix',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local vehicle = vRPclient.getNearestVehicle(source,7)
	if vehicle then
		if vRP.hasPermission(user_id,"admin.permissao") then
			TriggerClientEvent('reparar',source)
		end
	end
end)

RegisterCommand('ipl',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") then
		TriggerClientEvent('loadIPL',source, args[1])
	end
end)

RegisterCommand('ripl',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") then
		TriggerClientEvent('unloadIPL',source, args[1])
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRUNK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("tryblips")
AddEventHandler("tryblips",function(vehid)
	TriggerClientEvent("syncblips",-1,vehid)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRYAREA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('limparea',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local x,y,z = vRPclient.getPosition(source)
	if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"support.permissao") then
		TriggerClientEvent("syncarea",-1,x,y,z,500.0)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LIFE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('life',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"support.permissao") then
		local vida = 400
		if args[2] then
			vida = parseInt(args[2])
		end
		if args[1] then
			local nplayer = vRP.getUserSource(parseInt(args[1]))
			if nplayer then
				vRPclient.killGod(nplayer, false)
				vRPclient.setHealth(nplayer,vida)
			end
		else
			vRPclient.killGod(source, false)
			vRPclient.setHealth(source,vida)
			TriggerClientEvent("Notify", source, "sucesso","Vida:"..vRPclient.getHealth(source).."<br>Colete:"..vRPclient.getArmour(source))		
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- GOD
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('god',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") then
		if args[1] then
			local nplayer = vRP.getUserSource(parseInt(args[1]))
			if nplayer then
				vRPclient.killGod(nplayer, false)
				vRPclient.setHealth(nplayer,400)
				vRPclient.setArmour(nplayer,100)
			end
		else
			vRPclient.killGod(source, false)
			vRPclient.setHealth(source,400)
			vRPclient.setArmour(source,100)
		end
	end
end)

RegisterCommand('clear',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") then
		vRP.clearInventory(user_id)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HASH
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('hash',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"support.permissao") then
		TriggerClientEvent('vehash',source)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- WL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('wl',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"support.permissao") then
		if args[1] then
			vRP.setWhitelisted(parseInt(args[1]),true)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UNWL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('unwl',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"support.permissao") then
		if args[1] then
			vRP.setWhitelisted(parseInt(args[1]),false)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- KICK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('kick',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"support.permissao") then
		if args[1] then
			local id = vRP.getUserSource(parseInt(args[1]))
			if id then
				vRP.kick(id,"Você foi expulso da cidade.")
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BAN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('ban',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"support.permissao") then
		if args[1] then
			vRP.setBanned(parseInt(args[1]),true)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UNBAN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('unban',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"support.permissao") then
		if args[1] then
			vRP.setBanned(parseInt(args[1]),false)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MONEY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('money',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") then
		if args[1] then
			vRP.giveMoney(user_id,parseInt(args[1]))
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('item',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") then
		if args[1] and args[2] then
			vRP.giveInventoryItem(user_id,args[1],parseInt(args[2]))
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- NC
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('nc',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"support.permissao") then
		vRPclient.toggleNoclip(source)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TPCDS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('tpcds',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"support.permissao") then
		local fcoords = vRP.prompt(source,"Cordenadas:","")
		if fcoords == "" then
			return
		end
		local coords = {}
		for coord in string.gmatch(fcoords or "0,0,0","[^,]+") do
			table.insert(coords,parseInt(coord))
		end
		vRPclient.teleport(source,coords[1] or 0,coords[2] or 0,coords[3] or 0)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CDS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('cds',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"support.permissao") then
		local x,y,z = vRPclient.getPosition(source)
		local head = vRPclient.getHeader(source)
		x = round(x,2)
		y = round(y,2)
		z = round(z,2)
		head = round(head,2)
		vRP.prompt(source,"Cordenadas:",x..","..y..","..z.."\nx="..x..", y="..y..", z="..z..", h="..head)
	end
end)

function round(num, numDecimalPlaces)
    local mult = 10 ^ (numDecimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
end

RegisterCommand('skin',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") then
		TriggerClientEvent("changeSkin", source, args[1])
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GROUP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('g',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"support.permissao") then
		if args[1] and args[2] then
			if not vRP.hasPermission(user_id,"admin.permissao") and (args[2] == "admin" or args[2] == "support") then
				return
			end
			vRP.addUserGroup(parseInt(args[1]),args[2])

			if args[2] == "Diretor" or args[2] == "Medico" then
				vRP.addUserGroup(parseInt(args[1]),"Enfermeiro")
			end
			if args[2] == "Comando" or args[2] == "SubComando" then
				vRP.addUserGroup(parseInt(args[1]),"Policia")
			end
			if args[2] == "DMecanico" then
				vRP.addUserGroup(parseInt(args[1]),"Mecanico")
			end
			TriggerClientEvent("global:loadJob", source)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UNGROUP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('ug',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"support.permissao") then
		if args[1] and args[2] then
			if not vRP.hasPermission(user_id,"admin.permissao") and (args[2] == "admin" or args[2] == "support") then
				return
			end
			
			vRP.removeUserGroup(parseInt(args[1]),args[2])
			if args[2] == "Enfermeiro" then
				vRP.removeUserGroup(parseInt(args[1]),"Diretor")
				vRP.removeUserGroup(parseInt(args[1]),"Medico")
			end
			if args[2] == "Policia" then
				vRP.removeUserGroup(parseInt(args[1]),"Comando")
				vRP.removeUserGroup(parseInt(args[1]),"SubComando")
			end
			if args[2] == "Mecanico" then
				vRP.removeUserGroup(parseInt(args[1]),"DMecanico")
			end
			vRP.removeUserGroup(parseInt(args[1]),"Paisana"..args[2])
			TriggerClientEvent("global:loadJob", source)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TPTOME
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('tptome',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"support.permissao") then
		if args[1] then
			local tplayer = vRP.getUserSource(parseInt(args[1]))
			local x,y,z = vRPclient.getPosition(source)
			if tplayer then
				vRPclient.teleport(tplayer,x,y,z)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TPTO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('tpto',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"support.permissao") then
		if args[1] then
			local tplayer = vRP.getUserSource(parseInt(args[1]))
			if tplayer then
				if vRP.hasPermission(parseInt(args[1]),"admin.permissao") and not vRP.hasPermission(user_id,"admin.permissao") then
					TriggerClientEvent("Notify", source, "negado", "Você não tem permissão de dar tp em um ADM!")
					return
				end
				vRPclient.teleport(source,vRPclient.getPosition(tplayer))
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TPWAY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('tpway',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"support.permissao") then
		TriggerClientEvent('tptoway',source)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('car',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"support.permissao") then
		if args[1] then
			TriggerClientEvent('spawnarveiculo',source,args[1])
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DELNPCS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('delnpcs',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"support.permissao") then
		TriggerClientEvent('delnpcs',source)
	end
end)

RegisterCommand('algema',function(source,args,rawCommand)
	vRPclient.toggleHandcuff(source)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('adm',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"support.permissao") then
		local mensagem = vRP.prompt(source,"Mensagem:","")
		if mensagem == "" then
			return
		end
		vRPclient.setDiv(-1,"anuncio",".div_anuncio { background: rgba(255,50,50,0.8); font-size: 11px; font-family: arial; color: #fff; padding: 20px; bottom: 10%; right: 5%; max-width: 500px; position: absolute; -webkit-border-radius: 5px; } bold { font-size: 16px; }","<bold>"..mensagem.."</bold><br><br>Mensagem enviada por: Administrador")
		SetTimeout(60000,function()
			vRPclient.removeDiv(-1,"anuncio")
		end)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERSON
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('pon',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"support.permissao") then
        local users = vRP.getUsers()
		local players = ""
		local count = 0
        for k,v in pairs(users) do
            if k ~= #users then
				players = players..","
				count = count+1
            end
            players = players..k
        end
        TriggerClientEvent('chatMessage',source,"ONLINE",{255,160,0},players.." | TOTAL:"..count)
    end
end)

RegisterCommand('rename',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasGroup(user_id, "admin") or vRP.hasGroup(user_id, "owner") or vRP.hasPermission(user_id,"support.permissao")  then
		local idjogador = vRP.prompt(source, "Qual id do jogador?", "")
		local nome = vRP.prompt(source, "Novo nome", "")
		local firstname = vRP.prompt(source, "Novo sobrenome", "")
		local idade = vRP.prompt(source, "Nova idade", "")

		if idjogador and nome and firstname and idade then
			TriggerEvent('creative-character:updateName', idjogador, nome, firstname, idade)
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- TUNAR CARRO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('tuning',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") then
		local vehicle = vRPclient.getNearestVehicle(source,7)
		if vehicle then
			TriggerClientEvent('vehtuning',source,vehicle)
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- MARCA UMA AREA DETERMINADA
-----------------------------------------------------------------------------------------------------------------------------------------
local blips = {}
RegisterCommand('area',function(source,args,rawCommand)
	local source = source
	local user_id = vRP.getUserId(source)
	
	if vRP.hasPermission(user_id,"admin.permissao") then
		local x,y,z = vRPclient.getPosition(source)
		async(function()
			local ids = idgens:gen()
			blips[ids] = vRPclient.addRadiusBlip(source, x, y, z, 1, tonumber(args[1]), 60)	
			SetTimeout(30000,function() vRPclient.removeBlip(source,blips[ids]) idgens:free(ids) end)
		end)
	end
end)

RegisterCommand('object',function(source,args,rawCommand)
	local source = source
	local user_id = vRP.getUserId(source)
	
	if vRP.hasPermission(user_id,"admin.permissao") then
		TriggerClientEvent("cobject", source, args[1])
	end
end)