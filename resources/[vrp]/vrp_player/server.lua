local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
local idgens = Tools.newIDGenerator()

func = {}
Tunnel.bindInterface("vrp_player",func)

funcCLIENTE = Tunnel.getInterface("vrp_player")

-----------------------------------------------------------------------------------------------------------------------------------------
-- SALÁRIO
-----------------------------------------------------------------------------------------------------------------------------------------
local salarios = {
	[1] = { permissao = "prata.permissao", ['nome'] = "PRATA", ['payment'] = 500 },
	[2] = { permissao = "ouro.permissao", ['nome'] = "OURO", ['payment'] = 750 },
	[3] = { permissao = "platina.permissao", ['nome'] = "PLATINA", ['payment'] = 1250 },
	[4] = { permissao = "diamante.permissao", ['nome'] = "DIAMANTE", ['payment'] = 2500 },

	[5] = { permissao = "comando.permissao", ['nome'] = "COMANDANTE", ['payment'] = 1000, require=7},
	[6] = { permissao = "subcomando.permissao", ['nome'] = "SUB COMANDO", ['payment'] = 500, require=7 },
	[7] = { permissao = "policia.permissao", ['nome'] = "POLICIAL", ['payment'] = 4500 },

	[8] = { permissao = "reporter.permissao", ['nome'] = "REPORTER", ['payment'] = 2000 },
	[9] = { permissao = "advogado.permissao", ['nome'] = "ADVOGADO", ['payment'] = 2000 },
	[10] = { permissao =  "mecanico.permissao", ['nome'] = "MECÂNICO", ['payment'] = 2000 },
	[11] = { permissao =  "taxista.permissao", ['nome'] = "TAXISTA", ['payment'] = 1000 },

	[12] = { permissao =  "diretor.permissao", ['nome'] = "DIRETO(A) EMS", ['payment'] = 1000, require=14 },
	[13] = { permissao =  "enfermeiro.permissao", ['nome'] = "MÉDICO", ['payment'] = 500, require=14 },
	[14] = { permissao =  "paramedico.permissao", ['nome'] = "PARAMEDICO", ['payment'] = 4500 },
	
	[15] = { permissao =  "bennys.permissao", ['nome'] = "BENNY'S", ['payment'] = 2000 },
	
	[16] = { permissao =  "juiz.permissao", ['nome'] = "Juíz", ['payment'] = 6500 },

}

RegisterServerEvent('salario:pagamento')
AddEventHandler('salario:pagamento',function()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		for k,v in pairs(salarios) do
			if vRP.hasPermission(user_id,v.permissao) and not v.require or (vRP.hasPermission(user_id,v.permissao) and vRP.hasPermission(user_id,salarios[v.require].permissao)) then
				TriggerClientEvent("Notify",source,"importante","Você recebeu um salário de "..v.nome..", $"..parseInt(v.payment).." de recompensa foram depositados")
				vRP.giveBankMoney(user_id,parseInt(v.payment))
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- NOCARJACK
-----------------------------------------------------------------------------------------------------------------------------------------
local veiculos = {}
RegisterServerEvent("TryDoorsEveryone")
AddEventHandler("TryDoorsEveryone",function(veh,doors,placa)
	if not veiculos[placa] then
		TriggerClientEvent("SyncDoorsEveryone",-1,veh,doors)
		veiculos[placa] = true
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- AFKSYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("kickAFK")
AddEventHandler("kickAFK",function()
	local source = source
	local user_id = vRP.getUserId(source)
	if not vRP.hasPermission(user_id,"admin.permissao") 
	and not vRP.hasPermission(user_id,"support.permissao") 
	and not vRP.hasPermission(user_id,"prata.permissao") 
	and not vRP.hasPermission(user_id,"ouro.permissao") 
	and not vRP.hasPermission(user_id,"platina.permissao") 
	and not vRP.hasPermission(user_id,"diamante.permissao") 
	then
		DropPlayer(source,"Voce foi desconectado por ficar ausente.")
	end
	TriggerEvent("vrp_policia:remove_service")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /SEQUESTRO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('sequestro',function(source,args,rawCommand)
	local nplayer = vRPclient.getNearestPlayer(source,5)
	if nplayer then
		if vRPclient.isHandcuffed(nplayer) then
			if not vRPclient.getNoCarro(source) then
				local vehicle = vRPclient.getNearestVehicle(source,7)
				if vehicle then
					if vRPclient.getCarroClass(source,vehicle) then
						vRPclient.setMalas(nplayer)
					end
				end
			elseif vRPclient.isMalas(nplayer) then
				vRPclient.setMalas(nplayer)
			end
		else
			TriggerClientEvent("Notify",source,"aviso","A pessoa precisa estar algemada para colocar ou retirar do Porta-Malas.")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRATAMENTO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('tratamento',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"paramedico.permissao") then
		local nplayer = vRPclient.getNearestPlayer(source,3)
		if nplayer then
			TriggerClientEvent('tratamento',nplayer)
			TriggerClientEvent("Notify",nplayer,"sucesso","Tratamento iniciado, aguarde a liberação do paramédico.")
			TriggerClientEvent("Notify",source,"sucesso","Tratamento no paciente iniciado com sucesso.")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CASAS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('casas',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if args[1] and vRP.hasPermission(user_id,"policia.permissao") then
		local nplayer = vRP.getUserSource(parseInt(args[1]))
		if nplayer == nil then
			return
		end
		user_id = vRP.getUserId(nplayer)
	end
	if user_id then
		local address = vRP.getUserAddress(user_id)
		local casas = ""
		if args[1] then
			if #address > 0 then
				for k,v in pairs(address) do
					casas = casas..v.home.." - Nº"..v.number
					if k ~= #address then
						casas = casas..", "
					end
				end
				TriggerClientEvent("Notify",source,"importante","Residências possuidas pelo passaporte <b>"..vRP.format(parseInt(args[1])).."</b>: "..casas)
			else
				TriggerClientEvent("Notify",source,"negado","Passaporte <b>"..vRP.format(parseInt(args[1])).."</b> não possui residências.")
			end
		else
			if #address > 0 then
				for k,v in pairs(address) do
					casas = casas..v.home.." - Nº"..v.number
					if k ~= #address then
						casas = casas..", "
					end
				end
				TriggerClientEvent("Notify",source,"importante","Residências possuidas: "..casas)
			else
				TriggerClientEvent("Notify",source,"importante","Não possui residências em seu nome.")
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MOTOR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('motor',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local mPlaca = vRPclient.ModelName(source,7)
	local mPlacaUser = vRP.getUserByRegistration(mPlaca)
	if mPlaca then
		if not vRPclient.isInVehicle(source) then
			if vRP.hasPermission(user_id,"mecanico.permissao") then
				if user_id ~= mPlacaUser then
					TriggerClientEvent('cancelando',source,true)
					vRPclient._playAnim(source,false,{{"mini@repair","fixing_a_player"}},true)
					SetTimeout(30000,function()
						TriggerClientEvent('cancelando',source,false)
						TriggerClientEvent('repararmotor',source)
						vRPclient._stopAnim(source,false)
					end)
				else
					TriggerClientEvent("Notify",source,"aviso","Não pode efetuar reparos em seu próprio veículo.")
				end
			else
				if vRP.tryGetInventoryItem(user_id,"militec",1) then
					TriggerClientEvent('cancelando',source,true)
					vRPclient._playAnim(source,false,{{"mini@repair","fixing_a_player"}},true)
					SetTimeout(30000,function()
						TriggerClientEvent('cancelando',source,false)
						TriggerClientEvent('repararmotor',source)
						vRPclient._stopAnim(source,false)
					end)
				else
					TriggerClientEvent("Notify",source,"negado","Precisa de um <b>Militec-1</b> para reparar o motor.")
				end
			end
		else
			TriggerClientEvent("Notify",source,"negado","Precisa estar próximo ou fora do veículo para efetuar os reparos.")
		end
	end
end)

RegisterServerEvent("trymotor")
AddEventHandler("trymotor",function(nveh)
	TriggerClientEvent("syncmotor",-1,nveh)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REPARAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('reparar',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local mPlaca = vRPclient.ModelName(source,7)
	local mPlacaUser = vRP.getUserByRegistration(mPlaca)
	if mPlaca then
		if not vRPclient.isInVehicle(source) then
			local isMotoClub = vRP.hasPermission(user_id,"motoclub.permissao")
			if vRP.hasPermission(user_id,"mecanico.permissao") or isMotoClub then
				if isMotoClub and not funcCLIENTE.podeReparar(source) then 
					TriggerClientEvent("Notify",source,"negado","Você só pode reparar motocicletas!")
					return
				end
				TriggerClientEvent('cancelando',source,true)
				vRPclient._playAnim(source,false,{{"mini@repair","fixing_a_player"}},true)
				TriggerClientEvent("progress",source,30000,"reparando")
				SetTimeout(30000,function()
					TriggerClientEvent('cancelando',source,false)
					TriggerClientEvent('reparar',source)
					vRPclient._stopAnim(source,false)
				end)
			else
				local totalMecanico = vRP.getUsersByPermission("mecanico.permissao")
				if #totalMecanico == 0 and vRP.getInventoryItemAmount(user_id, "repairkit") == 0 then
					local ok = vRP.request(source,"Deseja reparar seu veículo pagando U$ 1.000,00 dólares?",15)
					if ok then
						if vRP.tryPayment(user_id,1000) then
							vRP.giveInventoryItem(user_id,"repairkit",1)
						else
							TriggerClientEvent("Notify",source,"negado","Você não possue dinheiro suficiente!")
						end
					else
						return
					end
				end

				if vRP.tryGetInventoryItem(user_id,"repairkit",1) then
					TriggerClientEvent('cancelando',source,true)
					vRPclient._playAnim(source,false,{{"mini@repair","fixing_a_player"}},true)
					TriggerClientEvent("progress",source,30000,"reparando")
					SetTimeout(30000,function()
						TriggerClientEvent('cancelando',source,false)
						TriggerClientEvent('reparar',source)
						vRPclient._stopAnim(source,false)
					end)
				else
					TriggerClientEvent("Notify",source,"negado","Precisa de um <b>Kit de Reparos</b> para reparar o motor.")
				end
			end
		else
			TriggerClientEvent("Notify",source,"negado","Precisa estar próximo ou fora do veículo para efetuar os reparos.")
			end
		end
	end)

RegisterServerEvent("tryreparar")
AddEventHandler("tryreparar",function(nveh)
	TriggerClientEvent("syncreparar",-1,nveh)
end)


-----------------------------------------------------------------------------------------------------------------------------------------
-- P
-----------------------------------------------------------------------------------------------------------------------------------------
local policia = {}
RegisterCommand('p',function(source,args,rawCommand)
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
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- TRUNK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("trytrunk")
AddEventHandler("trytrunk",function(nveh)
	TriggerClientEvent("synctrunk",-1,nveh)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- WINS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("trywins")
AddEventHandler("trywins",function(nveh)
	TriggerClientEvent("syncwins",-1,nveh)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HOOD
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("tryhood")
AddEventHandler("tryhood",function(nveh)
	TriggerClientEvent("synchood",-1,nveh)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DOORS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("trydoors")
AddEventHandler("trydoors",function(nveh,door)
	TriggerClientEvent("syncdoors",-1,nveh,door)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CALL
-----------------------------------------------------------------------------------------------------------------------------------------
local blips = {}
local tipoChamado = nil
RegisterNetEvent('vrp_player:efeutarchamado')
AddEventHandler('vrp_player:efeutarchamado', function(number, message)

	local source = source
	local answered = false
	local user_id = vRP.getUserId(source)
	local uplayer = vRP.getUserSource(user_id)
	if user_id then
		if message ~= nil and message ~= "" then

			local x,y,z = vRPclient.getPosition(source)
			local players = {}
			tipoChamado = number
			local nomeChamado = ""
			if tipoChamado == "911" then
				nomeChamado = "LSPD - "
				players = vRP.getUsersByPermission("policia.permissao")
			elseif tipoChamado == "112" then
				nomeChamado = "EMS - "
				players = vRP.getUsersByPermission("paramedico.permissao")
			elseif tipoChamado == "mec" then
				nomeChamado = "MECÂNICO - "
				players = vRP.getUsersByPermission("mecanico.permissao")
			elseif tipoChamado == "bennys" then
				nomeChamado = "BENNY'S - "
				players = vRP.getUsersByPermission("bennys.permissao")
			elseif tipoChamado == "taxi" then
				nomeChamado = "TÁXI - "
				players = vRP.getUsersByPermission("taxista.permissao")
			elseif tipoChamado == "reporter" then
				nomeChamado = "RÉPORTER - "
				players = vRP.getUsersByPermission("reporter.permissao")
			elseif tipoChamado == "advogado" then
				nomeChamado = "ADVOGADO - "
				players = vRP.getUsersByPermission("advogado.permissao")
			elseif tipoChamado == "deus" then
				nomeChamado = "ADM - "
				players = vRP.getUsersByPermission("support.permissao")
			elseif tipoChamado == "concessionaria" then 
				nomeChamado = "CONCESSIONÁRIA - "
				players = vRP.getUsersByPermission("concessionaria.permissao")
			end
			local identitys = vRP.getUserIdentity(user_id)
			TriggerClientEvent("Notify",source,"sucesso","Chamado enviado com sucesso.")
			for l,w in pairs(players) do
				local player = vRP.getUserSource(parseInt(w))
				local nuser_id = vRP.getUserId(player)
				if player then
					-- if player and player ~= uplayer then
					async(function()
						
						-- TriggerClientEvent('chatMessage',player,"CHAMADO",{19,197,43},message)
						vRPclient.playSound(player,"Out_Of_Area","DLC_Lowrider_Relay_Race_Sounds")
						local ok = vRP.request(player,"<span style='color:green'><strong>"..nomeChamado..message.."</strong></span> Aceitar o chamado de <b>"..identitys.name.." "..identitys.firstname.." - "..identitys.user_id.."</b>?",120)
						if ok then

							if not answered then
								answered = true
								local identity = vRP.getUserIdentity(nuser_id)

								-- TriggerClientEvent("Notify",source,"importante","Chamado atendido por <b>"..identity.name.." "..identity.firstname.."</b>, aguarde no local.")
								TriggerClientEvent('chatMessage',source,"CHAMADO",{19,197,43},"Chamado atendido por ^1"..identity.name.." "..identity.firstname.."^0, aguarde no local.")
								vRPclient.playSound(source,"Event_Message_Purple","GTAO_FM_Events_Soundset")
								vRPclient._setGPS(player,x,y)

								if tipoChamado == "deus" and vRP.hasPermission(nuser_id,"support.permissao") then
									vRPclient.teleport(player, x, y, z)
								else
									
									if tipoChamado == "mec" or tipoChamado == "bennys" or tipoChamado == "taxi" or tipoChamado == "concessionaria" then
										TriggerClientEvent("sendMsg", source, identity.phone, "Novo chamado: "..message)
										TriggerClientEvent("sendMsg", source, identity.phone, "GPS: "..x..", "..y)
									end
	
									local id = idgens:gen()
									blips[id] = vRPclient.addRadiusBlip(player,x,y,z, 3, 150.0, 60)
									SetTimeout(15000,function() vRPclient.removeBlip(player,blips[id]) idgens:free(id) end)

								end

							else
								TriggerClientEvent("Notify",player,"negado","Chamado ja foi atendido por outra pessoa.")
								vRPclient.playSound(player,"CHECKPOINT_MISSED","HUD_MINI_GAME_SOUNDSET")
							end
						end
					end)
				end
			end
		end
	end
end)

RegisterCommand('online',function(source,args,rawCommand)
	local source = source
	local answered = false
	local user_id = vRP.getUserId(source)

	if user_id then
		if vRP.hasPermission(user_id,"admin.permissao") then
			local players = {}
			players.policia = vRP.getUsersByPermission("policia.permissao")
			players.paramedico = vRP.getUsersByPermission("paramedico.permissao")
			players.mecanico = vRP.getUsersByPermission("mecanico.permissao")
			players.taxista = vRP.getUsersByPermission("taxista.permissao")

			vRPclient.setDiv(source,"online",".div_online { background: rgba(255,50,50,0.8); font-size: 11px; font-family: arial; color: #fff; padding: 20px; bottom: 10%; right: 5%; max-width: 500px; position: absolute; -webkit-border-radius: 5px; } bold { font-size: 13px; position:relative; display:block; width: 250px }","<bold><h3><center>INFORMATIVO EVEREST</center></h3><br><center>Em serviço</center><br>Policiais: "..#players.policia.."<br>Paramedicos: "..#players.paramedico.."<br>Mecanicos: "..#players.mecanico.."<br>Taxistas: "..#players.taxista.."</bold>")
			vRP.request(source,"Fechar janela de informação?",300)
			vRPclient.removeDiv(source,"online")	
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- 911
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('911',function(source,args,rawCommand)
	if args[1] then
		local user_id = vRP.getUserId(source)
		local identity = vRP.getUserIdentity(user_id)
		if user_id then
			if vRP.hasPermission(user_id, "policia.permissao") then
				TriggerClientEvent('chatMessage',-1,"L.S.P.D | "..identity.name.." "..identity.firstname,{65,130,255},rawCommand:sub(4))
			else
				TriggerClientEvent('chatMessage',-1,identity.name.." "..identity.firstname,{65,130,255},rawCommand:sub(4))
			end
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- 112
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('112',function(source,args,rawCommand)
	if args[1] then
		local user_id = vRP.getUserId(source)
		local identity = vRP.getUserIdentity(user_id)
		if user_id then
			if vRP.hasPermission(user_id, "paramedico.permissao") then
				TriggerClientEvent('chatMessage',-1,"EMS | "..identity.name.." "..identity.firstname,{255,70,135},rawCommand:sub(4))
			else
				TriggerClientEvent('chatMessage',-1,identity.name.." "..identity.firstname,{255,70,135},rawCommand:sub(4))
			end
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- mec
-----------------------------------------------------------------------------------------------------------------------------------------
-- RegisterCommand('mec',function(source,args,rawCommand)
-- 	if args[1] then
-- 		local user_id = vRP.getUserId(source)
-- 		local identity = vRP.getUserIdentity(user_id)
-- 		if user_id then
-- 			if vRP.hasPermission(user_id, "mecanico.permissao") then
-- 				TriggerClientEvent('chatMessage',-1,"Mecânico | "..identity.name.." "..identity.firstname,{255, 182, 0},rawCommand:sub(4))
-- 			else
-- 				TriggerClientEvent('chatMessage',-1,identity.name.." "..identity.firstname,{255, 182, 0},rawCommand:sub(4))
-- 			end
-- 		end
-- 	end
-- end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('pr',function(source,args,rawCommand)
	if args[1] then
		local user_id = vRP.getUserId(source)
		local identity = vRP.getUserIdentity(user_id)
		local permission = "policia.permissao"
		if vRP.hasPermission(user_id,permission) then
			local soldado = vRP.getUsersByPermission(permission)
			for l,w in pairs(soldado) do
				local player = vRP.getUserSource(parseInt(w))
				if player then
					async(function()
						TriggerClientEvent('chatMessage',player,identity.name.." "..identity.firstname,{255,175,175},rawCommand:sub(3))
					end)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('hr',function(source,args,rawCommand)
	if args[1] then
		local user_id = vRP.getUserId(source)
		local identity = vRP.getUserIdentity(user_id)
		local permission = "paramedico.permissao"
		if vRP.hasPermission(user_id,permission) then
			local soldado = vRP.getUsersByPermission(permission)
			for l,w in pairs(soldado) do
				local player = vRP.getUserSource(parseInt(w))
				if player then
					async(function()
						TriggerClientEvent('chatMessage',player,identity.name.." "..identity.firstname,{255,175,175},rawCommand:sub(3))
					end)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ME
-----------------------------------------------------------------------------------------------------------------------------------------
-- RegisterCommand('me',function(source,args,rawCommand)
-- 	if args[1] then
-- 		local user_id = vRP.getUserId(source)
-- 		local identity = vRP.getUserIdentity(user_id)
-- 		TriggerClientEvent('chatME',-1,source,identity.name,rawCommand:sub(3))
-- 	end
-- end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CARTAS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('card',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if user_id then
		local cd = math.random(1,13)
		local naipe = math.random(1,4)
		TriggerClientEvent('CartasMe',-1,source,identity.name,cd,naipe)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- USE
-----------------------------------------------------------------------------------------------------------------------------------------
local bandagem = {}
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		for k,v in pairs(bandagem) do
			if v > 0 then
				bandagem[k] = v - 1
			end
		end
	end
end)


-----------------------------------------------------------------------------------------------------------------------------------------
-- ROUPAS
-----------------------------------------------------------------------------------------------------------------------------------------
local roupas = {
	["mergulho"] = {
		[1885233650] = {
			[1] = { 122,0 },
			[5] = { -1,0 },
			[7] = { -1,0 },
			[3] = { 31,0 },
			[4] = { 94,0 },
			[8] = { 123,0 },
			[6] = { 67,0 },
			[11] = { 243,0 },
			[9] = { -1,0 },
			[10] = { -1,0 },
			["p0"] = { -1,0 },
			["p1"] = { 26,0 },
			["p2"] = { -1,0 },
			["p6"] = { -1,0 },
			["p7"] = { -1,0 }
		},
		[-1667301416] = {
			[1] = { 122,0 },
			[5] = { -1,0 },
			[7] = { -1,0 },
			[3] = { 18,0 },
			[4] = { 97,0 },
			[8] = { 153,0 },
			[6] = { 70,0 },
			[11] = { 251,0 },
			[9] = { -1,0 },
			[10] = { -1,0 },
			["p0"] = { -1,0 },
			["p1"] = { 28,0 },
			["p2"] = { -1,0 },
			["p6"] = { -1,0 },
			["p7"] = { -1,0 }
		}
	},
	["paciente"] = {
		[1885233650] = {
			[1] = { -1,0 },
			[5] = { -1,0 },
			[7] = { -1,0 },
			[3] = { 15,0 },
			[4] = { 61,0 },
			[8] = { 15,0 },
			[6] = { 16,0 },
			[11] = { 104,0 },
			[9] = { -1,0 },
			[10] = { -1,0 },
			["p0"] = { 28,1 },
			["p1"] = { 7,0 },
			["p2"] = { -1,0 },
			["p6"] = { -1,0 },
			["p7"] = { -1,0 }
		},
		[-1667301416] = {
			[1] = { -1,0 },
			[5] = { -1,0 },
			[7] = { -1,0 },
			[3] = { 15,0 },
			[4] = { 15,3 },
			[8] = { 7,0 },
			[6] = { 5,0 },
			[11] = { 5,0 },
			[9] = { -1,0 },
			[10] = { -1,0 },
			["p0"] = { 29,1 },
			["p1"] = { 15,0 },
			["p2"] = { -1,0 },
			["p6"] = { -1,0 },
			["p7"] = { -1,0 }
		}
	},
	["preso"] = {
		[1885233650] = {
			[1] = { -1,0 },
			[5] = { -1,0 },
			[7] = { -1,0 },
			[3] = { 0,0 }, -- maos
			[4] = { 5, 7 }, -- calca
			[8] = { -1,0 }, -- blusa
			[6] = { 5,0 }, -- sapatos
			[11] = { 86,0 }, -- jqueta
			[9] = { -1,0 },
			[10] = { -1,0 },
			["p0"] = { -1,0 }, -- chapeu
			["p1"] = { -1,0 }, -- oculos
			["p2"] = { -1,0 }, -- orelhas
			["p6"] = { -1,0 },
			["p7"] = { -1,0 }
		},
		[-1667301416] = {
			[1] = { -1,0 },
			[5] = { -1,0 },
			[7] = { -1,0 },
			[3] = { 15,0 },
			[4] = { 66, 6 },
			[8] = { 7,0 },
			[6] = { 5,0 },
			[11] = { 74,0 },
			[9] = { -1,0 },
			[10] = { -1,0 },
			["p0"] = { -1,0 },
			["p1"] = { -1,0 },
			["p2"] = { -1,0 },
			["p6"] = { -1,0 },
			["p7"] = { -1,0 }
		}
	}
}

RegisterCommand('roupas',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
		if args[1] then
			local custom = roupas[tostring(args[1])]
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
end)




-----------------------------------------------------------------------------------------------------------------------------------------
-- /PROCURADO
-----------------------------------------------------------------------------------------------------------------------------------------
local procurado = {}
local tempoProcura = 60*10 -- 10 minutos

function func.check_procurado(user_id)
	if user_id == nil then 
		user_id = vRP.getUserId(source)
	end
	if procurado[user_id] then
		return os.time()-procurado[user_id] <= tempoProcura
	else 
		return false
	end
end

RegisterServerEvent('vRP:isProcurado')
AddEventHandler('vRP:isProcurado', function(user_id)
	procurado[user_id] = os.time()
end)

RegisterCommand('procurado',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)

	local nplayer = vRPclient.getNearestPlayer(source,2)
	local nuser_id = vRP.getUserId(nplayer)
	
	
	if nuser_id then
		if (vRP.hasPermission(user_id, "policia.permissao") or vRP.hasPermission(user_id, "paramedico.permissao")) then
			if func.check_procurado(nuser_id) then
				TriggerClientEvent("Notify",source,"importante","Individuo ESTÁ sendo procurado!")
			else
				TriggerClientEvent("Notify",source,"importante","Individuo NÃO está sendo procurado!")
			end
		end
	else
		if func.check_procurado(user_id) then
			TriggerClientEvent("Notify",source,"importante","Você ESTÁ sendo procurado!")
		else
			TriggerClientEvent("Notify",source,"importante","Você NÃO está sendo procurado!")
		end
	end
end)