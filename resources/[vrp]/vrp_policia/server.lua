local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

func = Tunnel.getInterface("vrp_policia")


local idgens = Tools.newIDGenerator()


-----------------------------------------------------------------------------------------------------------------------------------------
-- PLACA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('placa',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"policia.permissao") then
		if args[1] then
			local user_id = vRP.getUserByRegistration(args[1])
			if user_id then
				local identity = vRP.getUserIdentity(user_id)
				if identity then
					vRPclient.playSound(source,"Event_Message_Purple","GTAO_FM_Events_Soundset")
					TriggerClientEvent('chatMessage',source,"911",{64,64,255},"^1Passaporte: ^0"..identity.user_id.."   ^2|   ^1Placa: ^0"..identity.registration.."   ^2|   ^1Proprietário: ^0"..identity.name.." "..identity.firstname.."   ^2|   ^1Idade: ^0"..identity.age.." anos   ^2|   ^1Telefone: ^0"..identity.phone)
				end
			else
				TriggerClientEvent("Notify",source,"importante","Placa inválida ou veículo de americano.")
			end
		else
			local mPlaca,mName,mNet,mPrice,mBanido,mLock,mModel,mStreet = vRPclient.ModelName(source,7)
			local placa_user = vRP.getUserByRegistration(mPlaca)
			if mPlaca then
				if placa_user then
					local identity = vRP.getUserIdentity(placa_user)
					if identity then
						vRPclient.playSound(source,"Event_Message_Purple","GTAO_FM_Events_Soundset")
						TriggerClientEvent('chatMessage',source,"911",{64,64,255},"^1Passaporte: ^0"..identity.user_id.."   ^2|   ^1Placa: ^0"..identity.registration.."   ^2|   ^1Proprietário: ^0"..identity.name.." "..identity.firstname.."   ^2|   ^1Idade: ^0"..identity.age.." anos   ^2|   ^1Telefone: ^0"..identity.phone)
					end
				else
					TriggerClientEvent("Notify",source,"importante","Placa inválida ou veículo de americano.")
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYTOW
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('paytow',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"policia.permissao") then
		local nplayer = vRPclient.getNearestPlayer(source,2)
		if nplayer then
			local nuser_id = vRP.getUserId(nplayer)
			if nuser_id then
				vRP.giveMoney(nuser_id,200)
				vRPclient._playAnim(source,true,{{"mp_common","givetake1_a"}},false)
				TriggerClientEvent("Notify",source,"sucesso","Efetuou o pagamento pelo serviço do mecânico.")
				TriggerClientEvent("Notify",nplayer,"sucesso","Recebeu <b>$200 dólares</b> pelo serviço de mecânico.")
			end
		end
	end
end)


AddEventHandler("vRP:playerSpawn",function(user_id,source,first_spawn)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"policia.permissao") then
		TriggerEvent('eblips:remove',source)
		vRP.addUserGroup(user_id,"PaisanaPolicia")
		vRPclient.giveWeapons(source,{},false)
		TriggerClientEvent("Notify",source,"aviso","Você saiu de serviço.")
	
	elseif vRP.hasPermission(user_id,"paramedico.permissao") then
		TriggerEvent('eblips:remove',source)
		vRP.addUserGroup(user_id,"PaisanaEnfermeiro")
		vRPclient.giveWeapons(source,{},false)
		TriggerClientEvent("Notify",source,"aviso","Você saiu de serviço.")
	
	elseif vRP.hasPermission(user_id,"mecanico.permissao") then
		vRP.addUserGroup(user_id,"PaisanaMecanico")
		TriggerClientEvent("Notify",source,"aviso","Você saiu de serviço.")
	
	elseif vRP.hasPermission(user_id,"taxista.permissao") then
		vRP.addUserGroup(user_id,"PaisanaTaxista")
		TriggerClientEvent("Notify",source,"aviso","Você saiu de serviço.")
	
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TOOGLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('toogle',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"policia.permissao") then
		TriggerEvent('eblips:remove',source)
		vRP.addUserGroup(user_id,"PaisanaPolicia")
		vRPclient.giveWeapons(source,{},false)
		TriggerClientEvent("Notify",source,"aviso","Você saiu de serviço.")
	elseif vRP.hasPermission(user_id,"paisanapolicia.permissao") then
		TriggerEvent('eblips:add',{ name = "Policial", src = source, color = 53 })
		vRP.addUserGroup(user_id,"Policia")
		TriggerClientEvent("Notify",source,"sucesso","Você entrou em serviço.")
	elseif vRP.hasPermission(user_id,"paramedico.permissao") then
		TriggerEvent('eblips:remove',source)
		vRP.addUserGroup(user_id,"PaisanaEnfermeiro")
		vRPclient.giveWeapons(source,{},false)
		TriggerClientEvent("Notify",source,"aviso","Você saiu de serviço.")
	elseif vRP.hasPermission(user_id,"paisanaparamedico.permissao") then
		TriggerEvent('eblips:add',{ name = "EMS", src = source, color = 41 })
		vRP.addUserGroup(user_id,"Enfermeiro")
		TriggerClientEvent("Notify",source,"sucesso","Você entrou em serviço.")
	elseif vRP.hasPermission(user_id,"mecanico.permissao") then
		vRP.addUserGroup(user_id,"PaisanaMecanico")
		TriggerClientEvent("Notify",source,"aviso","Você saiu de serviço.")
	elseif vRP.hasPermission(user_id,"paisanamecanico.permissao") then
		vRP.addUserGroup(user_id,"Mecanico")
		TriggerClientEvent("Notify",source,"sucesso","Você entrou em serviço.")
	elseif vRP.hasPermission(user_id,"taxista.permissao") then
		vRP.addUserGroup(user_id,"PaisanaTaxista")
		TriggerClientEvent("Notify",source,"aviso","Você saiu de serviço.")
	elseif vRP.hasPermission(user_id,"paisanataxista.permissao") then
		vRP.addUserGroup(user_id,"Taxista")
		TriggerClientEvent("Notify",source,"sucesso","Você entrou em serviço.")
	end
	
	TriggerClientEvent("global:loadJob", source)
end)

RegisterServerEvent("vrp_policia:remove_service")
AddEventHandler("vrp_policia:remove_service",function()

	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"policia.permissao") then
		TriggerEvent('eblips:remove',source)
		vRP.addUserGroup(user_id,"PaisanaPolicia")
		vRPclient.giveWeapons(source,{},false)
		TriggerClientEvent("Notify",source,"aviso","Você saiu de serviço.")
	elseif vRP.hasPermission(user_id,"paramedico.permissao") then
		TriggerEvent('eblips:remove',source)
		vRP.addUserGroup(user_id,"PaisanaEnfermeiro")
		vRPclient.giveWeapons(source,{},false)
		TriggerClientEvent("Notify",source,"aviso","Você saiu de serviço.")
	elseif vRP.hasPermission(user_id,"mecanico.permissao") then
		vRP.addUserGroup(user_id,"PaisanaMecanico")
		TriggerClientEvent("Notify",source,"aviso","Você saiu de serviço.")
	elseif vRP.hasPermission(user_id,"taxista.permissao") then
		vRP.addUserGroup(user_id,"PaisanaTaxista")
		TriggerClientEvent("Notify",source,"aviso","Você saiu de serviço.")
	end
	
	TriggerClientEvent("global:loadJob", source)
end)


-----------------------------------------------------------------------------------------------------------------------------------------
-- REANIMAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('reanimar',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"polpar.permissao") then
		TriggerClientEvent('reanimar',source)
	end
end)

RegisterServerEvent("reanimar:pagamento")
AddEventHandler("reanimar:pagamento",function()
	local user_id = vRP.getUserId(source)
	if user_id then
		pagamento = math.random(50,80)
		vRP.giveMoney(user_id,pagamento)
		TriggerClientEvent("Notify",source,"sucesso","Recebeu <b>$"..pagamento.." dólares</b> de gorjeta do americano.")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DETIDO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('detido',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"policia.permissao") then
		local placa,vname,vnet = vRPclient.ModelName(source,7)
		local placa_user = vRP.getUserByRegistration(placa)
		if placa_user then
			if vname then
				local rows = vRP.query("vRP/get_vehicle",{ user_id = placa_user, vehicle = vname })
				if #rows > 0 then
					if rows[1].detido == 1 then
						TriggerClientEvent("Notify",source,"importante","Este veículo já se encontra detido.")
					else
						vRP.execute("vRP/set_detido",{ user_id = placa_user, vehicle = vname, detido = 1, time = parseInt(os.time()) })
						TriggerClientEvent("Notify",source,"sucesso","Veículo detido com sucesso.")
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ID
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('id',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	-- if vRP.hasPermission(user_id,"polpar.permissao") or vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"policia.permissao") then
	if args[1] then
		if vRP.hasPermission(user_id,"polpar.permissao") or vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"policia.permissao") then
			local nplayer = vRP.getUserSource(parseInt(args[1]))
			if nplayer == nil then
				TriggerClientEvent("Notify",source,"aviso","Passaporte <b>"..vRP.format(args[1]).."</b> indisponível no momento.")
				return
			end

			local nuser_id = vRP.getUserId(nplayer)

			local ok = true
			if vRPclient.getHealth(nplayer) > 100 and not (vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"support.permissao")) then
				TriggerClientEvent("Notify",source,"importante","Foi solicitado o RG, aguarde o mesmo te mostrar!")
				ok = vRP.request(nplayer,"Entregar registro de identidade?",15)
			end
			if ok then
				if nuser_id then
					local value = vRP.getUData(nuser_id,"vRP:multas")
					local valormultas = json.decode(value) or 0
					local identity = vRP.getUserIdentity(nuser_id)
					-- local carteira = vRP.getMoney(nuser_id)
					-- local banco = vRP.getBankMoney(nuser_id)
					-- vRPclient.setDiv(source,"completerg",".div_completerg { background-color: rgba(0,0,0,0.60); font-size: 13px; font-family: arial; color: #fff; width: 420px; padding: 20px 20px 5px; bottom: 8%; right: 2.5%; position: absolute; border: 1px solid rgba(255,255,255,0.2); letter-spacing: 0.5px; } .local { width: 220px; padding-bottom: 15px; float: left; } .local2 { width: 200px; padding-bottom: 15px; float: left; } .local b, .local2 b { color: #d1257d; }","<div class=\"local\"><b>Nome:</b> "..identity.name.." "..identity.firstname.." ( "..vRP.format(identity.user_id).." )</div><div class=\"local2\"><b>Identidade:</b> "..identity.registration.."</div><div class=\"local\"><b>Idade:</b> "..identity.age.." Anos</div><div class=\"local2\"><b>Telefone:</b> "..identity.phone.."</div><div class=\"local\"><b>Multas pendentes:</b> "..vRP.format(parseInt(valormultas)).."</div><div class=\"local2\"><b>Carteira:</b> "..vRP.format(parseInt(carteira)).."</div>")
					vRPclient.setDiv(source,"completerg",".div_completerg { background-color: rgba(0,0,0,0.60); font-size: 13px; font-family: arial; color: #fff; width: 420px; padding: 20px 20px 5px; bottom: 8%; right: 2.5%; position: absolute; border: 1px solid rgba(255,255,255,0.2); letter-spacing: 0.5px; } .local { width: 220px; padding-bottom: 15px; float: left; } .local2 { width: 200px; padding-bottom: 15px; float: left; } .local b, .local2 b { color: #d1257d; }","<div class=\"local\"><b>Nome:</b> "..identity.name.." "..identity.firstname.." ( "..vRP.format(identity.user_id).." )</div><div class=\"local2\"><b>Identidade:</b> "..identity.registration.."</div><div class=\"local\"><b>Idade:</b> "..identity.age.." Anos</div><div class=\"local2\"><b>Telefone:</b> "..identity.phone.."</div><div class=\"local\"><b>Multas pendentes:</b> "..vRP.format(parseInt(valormultas)).."</div>")
					vRP.request(source,"Você deseja fechar o registro geral?",1000)
					vRPclient.removeDiv(source,"completerg")
				end
			else
				TriggerClientEvent("Notify",source,"negado","O cidadão não quis mostrar o RG!")
			end
		end
	else
		local nplayer = vRPclient.getNearestPlayer(source,2)
		local nuser_id = vRP.getUserId(nplayer)
		
		local ok = true
		if vRPclient.getHealth(nplayer) > 100 and not (vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"support.permissao")) then
			TriggerClientEvent("Notify",source,"importante","Foi solicitado o RG, aguarde o mesmo te mostrar!")
			ok = vRP.request(nplayer,"Entregar registro de identidade?",15)
		end
		if ok then
			if nuser_id then
				local value = vRP.getUData(nuser_id,"vRP:multas")
				local valormultas = json.decode(value) or 0
				local identity = vRP.getUserIdentity(nuser_id)
				-- local carteira = vRP.getMoney(nuser_id)
				-- local banco = vRP.getBankMoney(nuser_id)
				vRPclient.setDiv(source,"completerg",".div_completerg { background-color: rgba(0,0,0,0.60); font-size: 13px; font-family: arial; color: #fff; width: 420px; padding: 20px 20px 5px; bottom: 8%; right: 2.5%; position: absolute; border: 1px solid rgba(255,255,255,0.2); letter-spacing: 0.5px; } .local { width: 220px; padding-bottom: 15px; float: left; } .local2 { width: 200px; padding-bottom: 15px; float: left; } .local b, .local2 b { color: #d1257d; }","<div class=\"local\"><b>Nome:</b> "..identity.name.." "..identity.firstname.." ( "..vRP.format(identity.user_id).." )</div><div class=\"local2\"><b>Identidade:</b> "..identity.registration.."</div><div class=\"local\"><b>Idade:</b> "..identity.age.." Anos</div><div class=\"local2\"><b>Telefone:</b> "..identity.phone.."</div><div class=\"local\"><b>Multas pendentes:</b> "..vRP.format(parseInt(valormultas)).."</div>")
				vRP.request(source,"Você deseja fechar o registro geral?",1000)
				vRPclient.removeDiv(source,"completerg")
			end
		else
			TriggerClientEvent("Notify",source,"negado","O cidadão não quis mostrar o RG!")
		end
	end
	-- end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ALGEMAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("vrp_policia:algemar")
AddEventHandler("vrp_policia:algemar",function()
	local source = source
	local user_id = vRP.getUserId(source)
	local nplayer = vRPclient.getNearestPlayer(source,2)
	if nplayer then
		if vRPclient.getHealth(nplayer) > 100 then
			if vRP.getInventoryItemAmount(user_id,"algemas") >= 1 then
				if vRPclient.isHandcuffed(nplayer) then
					vRPclient.toggleHandcuff(nplayer)
					TriggerClientEvent("vrp_sound:source",source,'uncuff',0.1)
					TriggerClientEvent("vrp_sound:source",nplayer,'uncuff',0.1)
				else
					TriggerClientEvent('cancelando',source,true)
					TriggerClientEvent('cancelando',nplayer,true)
					TriggerClientEvent('carregar',nplayer,source)
					vRPclient._playAnim(source,false,{{"mp_arrest_paired","cop_p2_back_left"}},false)
					vRPclient._playAnim(nplayer,false,{{"mp_arrest_paired","crook_p2_back_left"}},false)
					SetTimeout(3500,function()
						vRPclient._stopAnim(source,false)
						vRPclient.toggleHandcuff(nplayer)
						TriggerClientEvent('carregar',nplayer,source)
						TriggerClientEvent('cancelando',source,false)
						TriggerClientEvent('cancelando',nplayer,false)
						TriggerClientEvent("vrp_sound:source",source,'cuff',0.1)
						TriggerClientEvent("vrp_sound:source",nplayer,'cuff',0.1)
					end)
				end
			else
				if vRP.hasPermission(user_id,"policia.permissao") then
					if vRPclient.isHandcuffed(nplayer) then
						vRPclient.toggleHandcuff(nplayer)
						TriggerClientEvent("vrp_sound:source",source,'uncuff',0.1)
						TriggerClientEvent("vrp_sound:source",nplayer,'uncuff',0.1)
					else
						TriggerClientEvent('cancelando',source,true)
						TriggerClientEvent('cancelando',nplayer,true)
						TriggerClientEvent('carregar',nplayer,source)
						vRPclient._playAnim(source,false,{{"mp_arrest_paired","cop_p2_back_left"}},false)
						vRPclient._playAnim(nplayer,false,{{"mp_arrest_paired","crook_p2_back_left"}},false)
						SetTimeout(3500,function()
							vRPclient._stopAnim(source,false)
							vRPclient.toggleHandcuff(nplayer)
							TriggerClientEvent('carregar',nplayer,source)
							TriggerClientEvent('cancelando',source,false)
							TriggerClientEvent('cancelando',nplayer,false)
							TriggerClientEvent("vrp_sound:source",source,'cuff',0.1)
							TriggerClientEvent("vrp_sound:source",nplayer,'cuff',0.1)
						end)
					end
				end
			end
		end
	end
end)

function func.getNearestPlayer()
	local source = source
 	return vRPclient.getNearestPlayer(source,2)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CARREGAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("vrp_policia:carregar")
AddEventHandler("vrp_policia:carregar",function()
	local source = source
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"polpar.permissao") or vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"support.permissao") then
		local nplayer = vRPclient.getNearestPlayer(source,10)
		if nplayer then
			TriggerClientEvent('carregar',nplayer,source)
			if not vRP.hasPermission(user_id,"polpar.permissao") and (vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"support.permissao")) then
				local user_id2 = vRP.getUserId(nplayer)
				TriggerClientEvent("Notify", source, "importante", "Passaporte: "..user_id2)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RMASCARA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('rmascara',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"polpar.permissao") then
		local nplayer = vRPclient.getNearestPlayer(source,2)
		if nplayer then
			TriggerClientEvent('rmascara',nplayer)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RCHAPEU
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('rchapeu',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"polpar.permissao") then
		local nplayer = vRPclient.getNearestPlayer(source,2)
		if nplayer then
			TriggerClientEvent('rchapeu',nplayer)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RCAPUZ
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('rcapuz',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"polpar.permissao") then
		local nplayer = vRPclient.getNearestPlayer(source,2)
		if nplayer then
			if vRPclient.isCapuz(nplayer) then
				vRPclient.setCapuz(nplayer)
				TriggerClientEvent("Notify",source,"sucesso","Capuz removido com sucesso.")
			else
				TriggerClientEvent("Notify",source,"importante","A pessoa não está com o capuz na cabeça.")
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('re',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"polpar.permissao") then
		local nplayer = vRPclient.getNearestPlayer(source,2)
		if nplayer then
			if vRPclient.isInComa(nplayer) then
				TriggerClientEvent('cancelando',source,true)
				vRPclient._playAnim(source,false,{{"amb@medic@standing@tendtodead@base","base"},{"mini@cpr@char_a@cpr_str","cpr_pumpchest"}},true)
				TriggerClientEvent("progress",source,30000,"reanimando")
				SetTimeout(30000,function()
					vRPclient.killGod(nplayer, true)
					vRPclient.setHealth(nplayer,150)
					vRPclient._stopAnim(source, false)
					vRP.giveMoney(user_id,300)
					TriggerClientEvent('cancelando',source,false)
				end)
			else
				TriggerClientEvent("Notify",source,"importante","A pessoa precisa estar em coma para prosseguir.")
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CV
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('cv',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"polpar.permissao") then
		local nplayer = vRPclient.getNearestPlayer(source,10)
		if nplayer then
			vRPclient.putInNearestVehicleAsPassenger(nplayer,7)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RV
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('rv',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"polpar.permissao") then
		local nplayer = vRPclient.getNearestPlayer(source,10)
		if nplayer then
			vRPclient.ejectVehicle(nplayer)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- APREENDER
-----------------------------------------------------------------------------------------------------------------------------------------
local itemlist = {
	"celular",
	"dinheirosujo",
	"algemas",
	"capuz",
	"lockpick",
	"masterpick",
	"maconha",
	"orgao",
	"etiqueta",
	"pendrive16",
	"pendrive32",
	"pendrive64",
	"relogioroubado",
	"pulseiraroubada",
	"anelroubado",
	"colarroubado",
	"brincoroubado",
	"carregadorroubado",
	"carteiraroubada",
	"tabletroubado",
	"sapatosroubado", 
	"maquiagemroubada",
	"vibradorroubado",
	"perfumeroubado",
	--"pecadearma",
	--"armacaodearma",
	"metanfetamina",
	--"anfetamina",
	--"acidobateria",
	--"folhadecoca",
	--"pastadecoca",
	"cocaina",
	--"logsinvasao",
	--"acessodeepweb",
	--"keysinvasao",
	--"pendriveinformacoes",
	"wbody|WEAPON_DAGGER",
	"wbody|WEAPON_BAT",
	"wbody|WEAPON_BOTTLE",
	"wbody|WEAPON_CROWBAR",
	"wbody|WEAPON_FLASHLIGHT",
	"wbody|WEAPON_GOLFCLUB",
	"wbody|WEAPON_HAMMER",
	"wbody|WEAPON_HATCHET",
	"wbody|WEAPON_KNUCKLE",
	"wbody|WEAPON_KNIFE",
	"wbody|WEAPON_MACHETE",
	"wbody|WEAPON_SWITCHBLADE",
	"wbody|WEAPON_NIGHTSTICK",
	"wbody|WEAPON_WRENCH",
	"wbody|WEAPON_BATTLEAXE",
	"wbody|WEAPON_POOLCUE",
	"wbody|WEAPON_STONE_HATCHET",
	"wbody|WEAPON_PISTOL",
	"wbody|WEAPON_COMBATPISTOL",
	"wbody|WEAPON_MOLOTOV",
	"wbody|WEAPON_BZGAS",
	"wbody|WEAPON_CARBINERIFLE",
	"wbody|WEAPON_SMG",
	"wbody|WEAPON_PUMPSHOTGUN_MK2",
	"wbody|WEAPON_STUNGUN",
	"wbody|WEAPON_NIGHTSTICK",
	"wbody|WEAPON_SNSPISTOL",
	"wbody|WEAPON_MICROSMG",
	"wbody|WEAPON_ASSAULTRIFLE",
	"wbody|WEAPON_FIREEXTINGUISHER",
	"wbody|WEAPON_FLARE",
	"wbody|WEAPON_REVOLVER",
	"wbody|WEAPON_PISTOL_MK2",
	"wbody|WEAPON_VINTAGEPISTOL",
	"wbody|WEAPON_MUSKET",
	"wbody|WEAPON_GUSENBERG",
	"wbody|WEAPON_ASSAULTSMG",
	"wbody|WEAPON_COMPACTRIFLE",
	"wbody|WEAPON_COMBATPDW",
	"wbody|WEAPON_REVOLVER_MK2",
	"wammo|WEAPON_DAGGER",
	"wammo|WEAPON_BAT",
	"wammo|WEAPON_BOTTLE",
	"wammo|WEAPON_CROWBAR",
	"wammo|WEAPON_FLASHLIGHT",
	"wammo|WEAPON_GOLFCLUB",
	"wammo|WEAPON_HAMMER",
	"wammo|WEAPON_HATCHET",
	"wammo|WEAPON_KNUCKLE",
	"wammo|WEAPON_KNIFE",
	"wammo|WEAPON_MACHETE",
	"wammo|WEAPON_SWITCHBLADE",
	"wammo|WEAPON_NIGHTSTICK",
	"wammo|WEAPON_WRENCH",
	"wammo|WEAPON_BATTLEAXE",
	"wammo|WEAPON_POOLCUE",
	"wammo|WEAPON_STONE_HATCHET",
	"wammo|WEAPON_PISTOL",
	"wammo|WEAPON_COMBATPISTOL",
	"wammo|WEAPON_CARBINERIFLE",
	"wammo|WEAPON_SMG",
	"wammo|WEAPON_PUMPSHOTGUN_MK2",
	"wammo|WEAPON_STUNGUN",
	"wammo|WEAPON_NIGHTSTICK",
	"wammo|WEAPON_SNSPISTOL",
	"wammo|WEAPON_MICROSMG",
	"wammo|WEAPON_ASSAULTRIFLE",
	"wammo|WEAPON_FIREEXTINGUISHER",
	"wammo|WEAPON_FLARE",
	"wammo|WEAPON_FLAREGUN",
	"wammo|WEAPON_REVOLVER",
	"wammo|WEAPON_PISTOL_MK2",
	"wammo|WEAPON_VINTAGEPISTOL",
	"wammo|WEAPON_MUSKET",
	"wammo|WEAPON_GUSENBERG",
	"wammo|WEAPON_ASSAULTSMG",
	"wammo|WEAPON_COMPACTRIFLE",
	"wammo|WEAPON_COMBATPDW",
	"wammo|WEAPON_REVOLVER_MK2",
}

RegisterCommand('apreender',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"policia.permissao") then
		local nplayer = vRPclient.getNearestPlayer(source,2)
		if nplayer then
			local nuser_id = vRP.getUserId(nplayer)
			if nuser_id then
				local weapons = vRPclient.replaceWeapons(nplayer,{})
				for k,v in pairs(weapons) do
					vRP.giveInventoryItem(nuser_id,"wbody|"..k,1)
					if v.ammo > 0 then
						vRP.giveInventoryItem(nuser_id,"wammo|"..k,v.ammo)
					end
				end

				local inv = vRP.getInventory(nuser_id)
				for k,v in pairs(itemlist) do
					local sub_items = { v }
					if string.sub(v,1,1) == "*" then
						local idname = string.sub(v,2)
						sub_items = {}
						for fidname,_ in pairs(inv) do
							if splitString(fidname,"|")[1] == idname then
								table.insert(sub_items,fidname)
							end
						end
					end

					for _,idname in pairs(sub_items) do
						local amount = vRP.getInventoryItemAmount(nuser_id,idname)
						if amount > 0 then
							local item_name,item_weight = vRP.getItemDefinition(idname)
							if item_name then
								if vRP.tryGetInventoryItem(nuser_id,idname,amount,true) then
									vRP.giveInventoryItem(user_id,idname,amount)
								end
							end
						end
					end
				end
				TriggerClientEvent("Notify",nplayer,"importante","Todos os seus pertences foram apreendidos.")
				TriggerClientEvent("Notify",source,"importante","Apreendeu todos os pertences da pessoa.")
			end
		end
	end
end)


RegisterCommand('clear_armas',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") then
		vRP.clearArmas(args[1])

		local nplayer = vRP.getUserSource(parseInt(args[1]))
		if nplayer then
			local nuser_id = vRP.getUserId(nplayer)
			if nuser_id then
				local weapons = vRPclient.replaceWeapons(nplayer,{})
				for k,v in pairs(weapons) do
					vRP.giveInventoryItem(nuser_id,"wbody|"..k,1)
					if v.ammo > 0 then
						vRP.giveInventoryItem(nuser_id,"wammo|"..k,v.ammo)
					end
				end

				local inv = vRP.getInventory(nuser_id)
				for k,v in pairs(itemlist) do
					local sub_items = { v }
					if string.sub(v,1,1) == "*" then
						local idname = string.sub(v,2)
						sub_items = {}
						for fidname,_ in pairs(inv) do
							if splitString(fidname,"|")[1] == idname then
								table.insert(sub_items,fidname)
							end
						end
					end

					for _,idname in pairs(sub_items) do
						local amount = vRP.getInventoryItemAmount(nuser_id,idname)
						if amount > 0 then
							local item_name,item_weight = vRP.getItemDefinition(idname)
							if item_name then
								vRP.tryGetInventoryItem(nuser_id,idname,amount,true)
							end
						end
					end
				end
				TriggerClientEvent("Notify",nplayer,"importante","Todos os seus pertences foram apreendidos.")
				TriggerClientEvent("Notify",source,"importante","Apreendeu todos os pertences da pessoa.")
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ARSENAL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('arsenal',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"policia.permissao") then
		TriggerClientEvent('arsenal',source)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- EXTRAS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('extras',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"policia.permissao") then
		TriggerClientEvent('extras',source)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('cone',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"polpar.permissao") or vRP.hasPermission(user_id,"conce.permissao") or vRP.hasPermission(user_id,"mecanico.permissao") then
		TriggerClientEvent('cone',source,args[1])
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BARREIRA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('barreira',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"polpar.permissao") or vRP.hasPermission(user_id,"conce.permissao") or vRP.hasPermission(user_id,"mecanico.permissao") then
		TriggerClientEvent('barreira',source,args[1])
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SPIKE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('spike',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"policia.permissao") then
		TriggerClientEvent('spike',source,args[1])
	end
end)
--------------------------------------------------------------------------------------------------------------------------------------------------
-- DISPAROS
--------------------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent('atirando')
AddEventHandler('atirando',function(x,y,z)
	local user_id = vRP.getUserId(source)
	if user_id then
		if not vRP.hasPermission(user_id,"policia.permissao") then
			local policiais = vRP.getUsersByPermission("policia.permissao")
			for l,w in pairs(policiais) do
				local player = vRP.getUserSource(w)
				if player then
					TriggerClientEvent('notificacao',player,x,y,z,user_id)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ANUNCIO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('anuncio',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"polpar.permissao") or vRP.hasPermission(user_id,"conce.permissao") then
		local identity = vRP.getUserIdentity(user_id)
		local mensagem = vRP.prompt(source,"Mensagem:","")
		if mensagem == "" then
			return
		end
		vRPclient.setDiv(-1,"anuncio",".div_anuncio { background: rgba(0,128,192,0.8); font-size: 11px; font-family: arial; color: #fff; padding: 20px; bottom: 7%; right: 5%; max-width: 500px; position: absolute; -webkit-border-radius: 5px; } bold { font-size: 15px; }","<bold>"..mensagem.."</bold><br><br>Mensagem enviada por: "..identity.name.." "..identity.firstname)
		SetTimeout(30000,function()
			vRPclient.removeDiv(-1,"anuncio")
		end)
	end
end)
--------------------------------------------------------------------------------------------------------------------------------------------------
-- PRISÃO
--------------------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("vRP:playerSpawn",function(user_id,source,first_spawn)
	local player = vRP.getUserSource(parseInt(user_id))
	if player then
		SetTimeout(30000,function()
			local value = vRP.getUData(parseInt(user_id),"vRP:prisao")
			local tempo = json.decode(value) or -1

			if tempo == -1 then
				return
			end

			if tempo > 0 then
				TriggerClientEvent('prisioneiro',player,true)
				vRPclient.teleport(player,1680.1,2513.0,46.5)
				prison_lock(parseInt(user_id))
			end
		end)
	end
end)

RegisterServerEvent("prison_lock")
AddEventHandler("prison_lock",function(target_id)
	prison_lock(target_id)
end)

function prison_lock(target_id)
	local player = vRP.getUserSource(parseInt(target_id))
	if player then
		SetTimeout(60000,function()
			local value = vRP.getUData(parseInt(target_id),"vRP:prisao")
			local tempo = json.decode(value) or 0
			if parseInt(tempo) >= 1 then
				TriggerClientEvent("Notify",player,"importante","Ainda vai passar <b>"..parseInt(tempo).." meses</b> preso.")
				vRP.setUData(parseInt(target_id),"vRP:prisao",json.encode(parseInt(tempo)-1))
				prison_lock(parseInt(target_id))
			elseif parseInt(tempo) == 0 then
				TriggerClientEvent('prisioneiro',player,false)
				vRPclient.teleport(player,1850.5,2604.0,45.5)
				vRP.setUData(parseInt(target_id),"vRP:prisao",json.encode(-1))
				TriggerClientEvent("Notify",player,"importante","Sua sentença terminou, esperamos não ve-lo novamente.")
			end
			vRPclient.killGod(player, false)
		end)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DIMINUIR PENA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("diminuirpena")
AddEventHandler("diminuirpena",function()
	local source = source
	local user_id = vRP.getUserId(source)
	local value = vRP.getUData(parseInt(user_id),"vRP:prisao")
	local tempo = json.decode(value) or 0
	if tempo >= 20 then
		vRP.setUData(parseInt(user_id),"vRP:prisao",json.encode(parseInt(tempo)-2))
		TriggerClientEvent("Notify",source,"importante","Sua pena foi reduzida em <b>2 meses</b>, continue o trabalho.")
	else
		TriggerClientEvent("Notify",source,"importante","Atingiu o limite da redução de pena, não precisa mais trabalhar.")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PRESET
-----------------------------------------------------------------------------------------------------------------------------------------
local presets = {
	["1"] = {
		[1885233650] = {
			[1] = { 121,0 },
			[5] = { -1,0 },
			[7] = { -1,0 },
			[3] = { 1,0 },
			[4] = { 25,0 },
			[8] = { 58,0 },
			[6] = { 21,0 },
			[11] = { 26,0 },
			[9] = { 13,0 },
			[10] = { -1,0 },
			["p0"] = { 13,0 },
			["p1"] = { 5,5 },
			["p2"] = { -1,0 },
			["p6"] = { -1,0 },
			["p7"] = { -1,0 }
		},
		[-1667301416] = {
			[1] = { 121,0 },
			[5] = { -1,0 },
			[7] = { -1,0 },
			[3] = { 14,0 },
			[4] = { 41,0 },
			[8] = { 35,0 },
			[6] = { 59,1 },
			[11] = { 25,0 },
			[9] = { 14,0 },
			[10] = { -1,0 },
			["p0"] = { 13,0 },
			["p1"] = { 7,1 },
			["p2"] = { -1,0 },
			["p6"] = { -1,0 },
			["p7"] = { -1,0 }
		}
	},
	["2"] = {
		[1885233650] = {
			[1] = { 121,0 },
			[5] = { -1,0 },
			[7] = { -1,0 },
			[3] = { 0,0 },
			[4] = { 25,0 },
			[8] = { 58,0 },
			[6] = { 21,0 },
			[11] = { 118,0 },
			[9] = { 13,0 },
			[10] = { -1,0 },
			["p0"] = { 13,0 },
			["p1"] = { 5,5 },
			["p2"] = { -1,0 },
			["p6"] = { -1,0 },
			["p7"] = { -1,0 }
		}
	},
	["3"] = {
		[1885233650] = {
			[1] = { 121,0 },
			[5] = { -1,0 },
			[7] = { 125,0 },
			[3] = { 0,0 },
			[4] = { 47,0 },
			[8] = { 57,0 },
			[6] = { 15,0 },
			[11] = { 93,0 },
			[9] = { -1,0 },
			[10] = { -1,0 },
			["p0"] = { 96,0 },
			["p1"] = { -1,0 },
			["p2"] = { -1,0 },
			["p6"] = { -1,0 },
			["p7"] = { -1,0 }
		},
		[-1667301416] = {
			[1] = { 121,0 },
			[5] = { -1,0 },
			[7] = { 95,0 },
			[3] = { 14,0 },
			[4] = { 49,0 },
			[8] = { 34,0 },
			[6] = { 57,0 },
			[11] = { 84,0 },
			[9] = { -1,0 },
			[10] = { -1,0 },
			["p0"] = { 95,0 },
			["p1"] = { -1,0 },
			["p2"] = { -1,0 },
			["p6"] = { -1,0 },
			["p7"] = { -1,0 }
		}
	},
	["4"] = {
		[1885233650] = {
			[1] = { 121,0 },
			[5] = { -1,0 },
			[7] = { 126,0 },
			[3] = { 74,0 },
			[4] = { 96,0 },
			[8] = { 57,0 },
			[6] = { 56,1 },
			[11] = { 250,0 },
			[9] = { -1,0 },
			[10] = { 58,0 },
			["p0"] = { 122,0 },
			["p1"] = { -1,0 },
			["p2"] = { -1,0 },
			["p6"] = { -1,0 },
			["p7"] = { -1,0 }
		},
		[-1667301416] = {
			[1] = { 121,0 },
			[5] = { -1,0 },
			[7] = { 96,0 },
			[3] = { 96,0 },
			[4] = { 99,0 },
			[8] = { 34,0 },
			[6] = { 27,0 },
			[11] = { 258,0 },
			[9] = { -1,0 },
			[10] = { 66,0 },
			["p0"] = { 121,0 },
			["p1"] = { -1,0 },
			["p2"] = { -1,0 },
			["p6"] = { -1,0 },
			["p7"] = { -1,0 }
		}
	},
	["5"] = {
		[1885233650] = {
			[1] = { -1,0 },
			[5] = { -1,0 },
			[7] = { 126,0 },
			[3] = { 4,0 },
			[4] = { 25,5 },
			[8] = { 31,4 },
			[6] = { 21,9 },
			[11] = { 31,7 },
			[9] = { -1,0 },
			[10] = { -1,0 },
			["p0"] = { -1,0 },
			["p1"] = { -1,0 },
			["p2"] = { -1,0 },
			["p6"] = { -1,0 },
			["p7"] = { -1,0 }
		},
		[-1667301416] = {
			[1] = { -1,0 },
			[5] = { -1,0 },
			[7] = { 96,0 },
			[3] = { 1,0 },
			[4] = { 37,5 },
			[8] = { 64,2 },
			[6] = { 0,2 },
			[11] = { 57,7 },
			[9] = { -1,0 },
			[10] = { -1,0 },
			["p0"] = { -1,0 },
			["p1"] = { -1,0 },
			["p2"] = { -1,0 },
			["p6"] = { -1,0 },
			["p7"] = { -1,0 }
		}
	},
	["6"] = {
		[1885233650] = {
			[1] = { -1,0 },
			[5] = { -1,0 },
			[7] = { 127,0 },
			[3] = { 74,0 },
			[4] = { 3,3 },
			[8] = { 15,0 },
			[6] = { 9,0 },
			[11] = { 16,1 },
			[9] = { -1,0 },
			[10] = { -1,0 },
			["p0"] = { 28,1 },
			["p1"] = { -1,0 },
			["p2"] = { -1,0 },
			["p6"] = { -1,0 },
			["p7"] = { -1,0 }
		},
		[-1667301416] = {
			[1] = { -1,0 },
			[5] = { -1,0 },
			[7] = { 97,0 },
			[3] = { 96,0 },
			[4] = { 3,13 },
			[8] = { 15,0 },
			[6] = { 10,1 },
			[11] = { 141,1 },
			[9] = { -1,0 },
			[10] = { -1,0 },
			["p0"] = { 29,1 },
			["p1"] = { -1,0 },
			["p2"] = { -1,0 },
			["p6"] = { -1,0 },
			["p7"] = { -1,0 }
		}
	},
	["7"] = {
		[1885233650] = {
			[1] = { 121,0 },
			[5] = { -1,0 },
			[7] = { 126,0 },
			[3] = { 81,0 },
			[4] = { 10,0 },
			[8] = { 57,0 },
			[6] = { 56,1 },
			[11] = { 95,1 },
			[9] = { -1,0 },
			[10] = { 58,0 },
			["p0"] = { -1,0 },
			["p1"] = { -1,0 },
			["p2"] = { -1,0 },
			["p6"] = { -1,0 },
			["p7"] = { -1,0 }
		},
		[-1667301416] = {
			[1] = { 0,0 },
			[5] = { 0,0 },
			[7] = { 96,0 },
			[3] = { 106,1 },
			[4] = { 52,2 },
			[8] = { 34,0 },
			[6] = { 7,0 },
			[11] = { 86,1 },
			[9] = { -1,0 },
			[10] = { 66,0 },
			["p0"] = { -1,0 },
			["p1"] = { -1,0 },
			["p2"] = { -1,0 },
			["p6"] = { -1,0 },
			["p7"] = { -1,0 }
		}
	},
	["8"] = {
		[1885233650] = {
			[1] = { 121,0 },
			[5] = { -1,0 },
			[7] = { 126,0 },
			[3] = { 38,0 },
			[4] = { 96,0 },
			[8] = { 71,3 },
			[6] = { 56,1 },
			[11] = { 249,0 },
			[9] = { -1,0 },
			[10] = { 57,0 },
			["p0"] = { -1,0 },
			["p1"] = { 18,1 },
			["p2"] = { -1,0 },
			["p6"] = { -1,0 },
			["p7"] = { -1,0 }
		},
		[-1667301416] = {
			[1] = { 121,0 },
			[5] = { -1,0 },
			[7] = { 96,0 },
			[3] = { 18,0 },
			[4] = { 99,0 },
			[8] = { 77,3 },
			[6] = { 7,0 },
			[11] = { 257,0 },
			[9] = { -1,0 },
			[10] = { 65,0 },
			["p0"] = { -1,0 },
			["p1"] = { 21,0 },
			["p2"] = { -1,0 },
			["p6"] = { -1,0 },
			["p7"] = { -1,0 }
		}
	}
}

RegisterCommand('preset',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"polpar.permissao") then
		if args[1] then
			local custom = presets[tostring(args[1])]
			if custom then
				local old_custom = vRPclient.getCustomization(source)
				local idle_copy = {}

				idle_copy = vRP.save_idle_custom(source,old_custom)
				idle_copy.modelhash = nil

				for l,w in pairs(custom[old_custom.modelhash]) do
					idle_copy[l] = w
				end
				vRPclient._setCustomization(source,idle_copy)
			end
		else
			vRP.removeCloak(source)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ARSENAL
-----------------------------------------------------------------------------------------------------------------------------------------
-- RegisterCommand('a',function(source,args,rawCommand)
-- 	local user_id = vRP.getUserId(source)
-- 	local identity = vRP.getUserIdentity(user_id)
--     if user_id and vRP.hasPermission(user_id,"polpar.permissao") or vRP.hasPermission(user_id,"admin.permissao") then
-- 		-- if args[1] == "tazer" and vRP.hasPermission(user_id,"polpar.permissao") then
-- 		-- 	vRPclient.giveWeapons(source,{["WEAPON_STUNGUN"] = { ammo = 0 }})
-- 		if args[1] == "rayp" and vRP.hasPermission(user_id,"admin.permissao") then
-- 			vRPclient.giveWeapons(source,{["WEAPON_RAYPISTOL"] = { ammo = 0 }})	
-- 		elseif args[1] == "tompson" and vRP.hasPermission(user_id,"admin.permissao") then
-- 			vRPclient.giveWeapons(source,{["weapon_gusenberg"] = { ammo = 200 }})	
-- 		elseif args[1] == "fire" and vRP.hasPermission(user_id,"admin.permissao") then
-- 			vRPclient.giveWeapons(source,{["WEAPON_FIREWORK"] = { ammo = 10 }})		
-- 		elseif args[1] == "molotov" and vRP.hasPermission(user_id,"admin.permissao") then
-- 			vRPclient.giveWeapons(source,{["weapon_molotov"] = { ammo = 10 }})		
					
-- 		-- elseif args[1] == "cassetete" and vRP.hasPermission(user_id,"polpar.permissao") then
-- 		-- 	vRPclient.giveWeapons(source,{["WEAPON_NIGHTSTICK"] = { ammo = 0 }})
-- 		-- elseif args[1] == "lanterna" and vRP.hasPermission(user_id,"polpar.permissao") then
-- 		-- 	vRPclient.giveWeapons(source,{["WEAPON_FLASHLIGHT"] = { ammo = 0 }})
-- 		-- elseif args[1] == "extintor" and vRP.hasPermission(user_id,"polpar.permissao") then
-- 		-- 	vRPclient.giveWeapons(source,{["WEAPON_FIREEXTINGUISHER"] = { ammo = 0 }})
-- 		-- elseif args[1] == "glock" and vRP.hasPermission(user_id,"policia.permissao") then
-- 		-- 	vRPclient.giveWeapons(source,{["WEAPON_COMBATPISTOL"] = { ammo = 100 }})
-- 		-- elseif args[1] == "mp5" and vRP.hasPermission(user_id,"policia.permissao") then
-- 		-- 	vRPclient.giveWeapons(source,{["WEAPON_SMG"] = { ammo = 200 }})
-- 		-- elseif args[1] == "sigsauer" and vRP.hasPermission(user_id,"policia.permissao") then
-- 		-- 	vRPclient.giveWeapons(source,{["WEAPON_COMBATPDW"] = { ammo = 200 }})
-- 		-- elseif args[1] == "remington" and vRP.hasPermission(user_id,"policia.permissao") then
-- 		-- 	vRPclient.giveWeapons(source,{["WEAPON_PUMPSHOTGUN_MK2"] = { ammo = 30 }})
-- 		-- elseif args[1] == "m4a1" and vRP.hasPermission(user_id,"policia.permissao") then
-- 		-- 	vRPclient.giveWeapons(source,{["WEAPON_CARBINERIFLE"] = { ammo = 200 }})
-- 		-- elseif args[1] == "gas" and vRP.hasPermission(user_id,"policia.permissao") then
-- 		-- 	vRPclient.giveWeapons(source,{["weapon_smokegrenade"] = { ammo = 1 }})	
-- 		-- elseif args[1] == "flare" and vRP.hasPermission(user_id,"policia.permissao") then
-- 		-- 	vRPclient.giveWeapons(source,{["weapon_flare"] = { ammo = 2 }})	
-- 		-- elseif args[1] == "flaregun" and vRP.hasPermission(user_id,"policia.permissao") then
-- 		-- 	vRPclient.giveWeapons(source,{["weapon_flaregun"] = { ammo = 10 }})	
-- 		elseif args[1] == "neve" then
-- 			vRPclient.giveWeapons(source,{["weapon_snowball"] = { ammo = 2 }})	
-- 		-- elseif args[1] == "colete" and vRP.hasPermission(user_id,"polpar.permissao") then
-- 		-- 	vRPclient.setArmour(source,100)
-- 		elseif args[1] == "limpar" and vRP.hasPermission(user_id,"polpar.permissao") then
-- 			vRPclient.giveWeapons(source,{},true)
-- 		else
-- 			if vRP.hasPermission(user_id,"admin.permissao") then
-- 				vRPclient.giveWeapons(source,{[args[1]] = { ammo = 200 }})	
-- 			else
-- 				TriggerClientEvent("Notify",source,"negado","Armamento não encontrado.")
-- 			end
-- 		end
-- 	end
-- end)

local sleepLocation = false
local policia = {}
RegisterServerEvent("vrp_policia:localizacao")
AddEventHandler("vrp_policia:localizacao",function()
	if not sleepLocation then
		sleepLocation = true
		local user_id = vRP.getUserId(source)
		local uplayer = vRP.getUserSource(user_id)
		local identity = vRP.getUserIdentity(user_id)
		local x,y,z = vRPclient.getPosition(source)
		if vRPclient.getHealth(source) > 100 then
			if vRP.hasPermission(user_id,"policia.permissao") then
				TriggerClientEvent("Notify",source,"aviso","Localização enviada.")
				local soldado = vRP.getUsersByPermission("policia.permissao")
				for l,w in pairs(soldado) do
					local player = vRP.getUserSource(parseInt(w))
					if player and player ~= uplayer then
						async(function()
							local id = idgens:gen()
							TriggerClientEvent("Notify",player,"importante","Localização recebida de <b>"..identity.name.." "..identity.firstname.."</b>.")
							vRPclient._playSound(player,"Place_Prop_Fail","DLC_Dmod_Prop_Editor_Sounds")

							policia[id] = vRPclient.addRadiusBlip(player, x, y, z, 3, 150.0, 60)	
							SetTimeout(30000,function() 
								vRPclient.removeBlip(player,policia[id]) 
								idgens:free(id) 
							end)							
						end)
					end
				end
			end
		end
		SetTimeout(10000,function() 
			sleepLocation = false
		end)
	else
		TriggerClientEvent("Notify",source,"negado", "Aguarde para enviar a localização novamente")
	end
end)