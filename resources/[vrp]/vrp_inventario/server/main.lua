local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

local idgens = Tools.newIDGenerator()

func = {}
Tunnel.bindInterface("vrp_inventario",func)

funcClient = Tunnel.getInterface("vrp_inventario")


local webhookgarmas = "https://discordapp.com/api/webhooks/601534655996362787/e8TcpUFdIL9157GqFytTVaoltKgEYdDFbXMtUY54hwzGE2cyU_86YjvWNTDqvPNaUosL"
local webhookequipar = "https://discordapp.com/api/webhooks/601534749990977537/f2JO6rdmVGBEYmaiVOQWnTvoBXUbdaPP5pxLTGDX2yQ9m1S7uRoNaLmToSp096cbZJb8" 
local webhookenviaritem = "https://discordapp.com/api/webhooks/600809493965832192/P9agnByurFcBog_aOwNmXl5QbXMKfCwC4IXavKGB9XP4x3Rhcl1UJuWVIW-Vipas7W4n"
local webhookenviardinheiro = "https://discordapp.com/api/webhooks/618453784217124864/iWxCHo7yMYPwpdhaAt1C6sknqX-lYZ8T-XVpnToVEkieh1hxsELWZL8NDxeasGCNLXEs"
local webhookdropar = "https://discordapp.com/api/webhooks/600808827167834116/ebKgs6EUeVIzoMft6hKNVEx_X9gniUJfcCC9elyFekoUZwhsn4WXtmmzZ_tKe8K4oxms"
local webhookpaypal = "https://discordapp.com/api/webhooks/618453784217124864/iWxCHo7yMYPwpdhaAt1C6sknqX-lYZ8T-XVpnToVEkieh1hxsELWZL8NDxeasGCNLXEs"
local webhookhelp = "https://discordapp.com/api/webhooks/607226083720429569/BMLrxaWiXoriViyPsrA6aV2Sj--mm4NA0AcXhn2zCX_cg_drpB0-aaNAG-UOxXdAcc0S"


-- RegisterServerEvent('getPlayerInventory')
-- AddEventHandler('getPlayerInventory',function(cb)
	
-- end)
function func.getPlayerInventory() 
	local source = source
	local user_id = vRP.getUserId(source)

	-- local identity = vRP.getUserIdentity(user_id)
	local data = vRP.getUserDataTable(user_id)
	if data ~= nil then
		 return data, vRP.getMoney(user_id)
	else
		return nil
	end
end

function func.droparItem(tipo, nome, quantidade)

	if tipo == "money" then
		TriggerClientEvent("Notify", source, "negado", "Você só pode enviar o dinheiro")
		return
	end

	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if user_id and nome then
		local px,py,pz = vRPclient.getPosition(source)
		for k,v in pairs(itemlist) do
			if nome == v.index then
				if quantidade and parseInt(quantidade) > 0 then
					if vRP.tryGetInventoryItem(user_id,k,parseInt(quantidade)) then
						TriggerEvent("DropSystem:create",k,parseInt(quantidade),px,py,pz)
						vRPclient._playAnim(source,true,{{"pickup_object","pickup_low"}},false)
						TriggerEvent("everest:postarDiscord", source, webhookdropar, "[DROPOU]: "..parseInt(quantidade).." "..v.nome)
					end
				else
					local data = vRP.getUserDataTable(user_id)
					for i,o in pairs(data.inventory) do
						if itemlist[i].index == nome then
							if vRP.tryGetInventoryItem(user_id,k,parseInt(o.amount)) then
								TriggerEvent("DropSystem:create",k,parseInt(o.amount),px,py,pz)
								vRPclient._playAnim(source,true,{{"pickup_object","pickup_low"}},false)
								TriggerEvent("everest:postarDiscord", source,  webhookdropar, "[DROPOU]: "..parseInt(quantidade).." "..v.nome)
							end
						end
					end
				end
			end
		end
	end
end

function func.enviarItem(tipo, item, quantidade)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)

	-- local nplayer = vRP.getUserSource(parseInt(id_player))
    local nplayer = vRPclient.getNearestPlayer(source, 2)
	local nuser_id = vRP.getUserId(nplayer)
	local identity2 = vRP.getUserIdentity(nuser_id)

	
	if nplayer then
		local qtd = parseInt(quantidade)
		if nuser_id and item ~= "money" and qtd > 0 then
			for k,v in pairs(itemlist) do
				if item == v.index then
					if vRP.getInventoryWeight(user_id)+vRP.getItemWeight(k)*qtd <= vRP.getInventoryMaxWeight(nuser_id) then
						if vRP.tryGetInventoryItem(user_id,k,qtd) then
							vRP.giveInventoryItem(nuser_id,k,qtd)
							vRPclient._playAnim(source,true,{{"mp_common","givetake1_a"}},false)
							TriggerClientEvent("Notify",source,"sucesso","Enviou <b>"..qtd.."x "..v.nome.."</b>.")
							TriggerClientEvent("Notify",nplayer,"sucesso","Recebeu <b>"..qtd.."x "..v.nome.."</b>.")
							-- vRP.logs("savedata/enviar.txt","[ID]: "..user_id.." / [NID]: "..nuser_id.." / [ITEM]: "..k)
							TriggerEvent("everest:postarDiscord", source, webhookenviaritem, "[ENVIOU PARA]: "..nuser_id.." "..identity2.name.." "..identity2.firstname.." \n[ENVIOU]: "..qtd.."x "..v.nome)
						end
					end
				end
			end
		elseif nuser_id and qtd > 0 then
			if vRP.tryPayment(user_id,qtd) then
				vRP.giveMoney(nuser_id,qtd)
				vRPclient._playAnim(source,true,{{"mp_common","givetake1_a"}},false)
				TriggerClientEvent("Notify",source,"sucesso","Enviou <b>$"..vRP.format(qtd).." dólares</b>.")
				TriggerClientEvent("Notify",nplayer,"sucesso","Recebeu <b>$"..vRP.format(qtd).." dólares</b>.")
				-- vRP.logs("savedata/enviar.txt","[ID]: "..user_id.." / [NID]: "..nuser_id.." / [VALOR]: "..qtd)
				TriggerEvent("everest:postarDiscord",source,  webhookenviardinheiro, "[ENVIOU PARA]: "..nuser_id.." "..identity2.name.." "..identity2.firstname.." \n[ENVIOU]: "..vRP.format(qtd).."x dolares")

			else
				TriggerClientEvent("Notify",source,"negado","Não tem a quantia que deseja enviar.")
			end
		end
	else
		TriggerClientEvent("Notify",source,"negado","Não há ninguém perto de você!")
	end
end


local bandagem = {}
function func.userItem(tipo, item, quantidade)
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)

	if tipo == "arma" then
		for k,v in pairs(itemlist) do
			if item == v.index then
				if not funcClient.temArma(source,string.gsub(k,"wbody|","")) then
					if vRP.tryGetInventoryItem(user_id,k,parseInt(quantidade)) then
						local weapons = {}
						weapons[string.gsub(k,"wbody|","")] = { ammo = 0 }
						if string.gsub(k,"wbody|","") == "WEAPON_MOLOTOV" or string.gsub(k,"wbody|","") == "WEAPON_BZGAS" then
							weapons[string.gsub(k,"wbody|","")] = { ammo = parseInt(quantidade) }
						end
						vRPclient._giveWeapons(source,weapons)
						TriggerEvent("everest:postarDiscord", source, webhookequipar, "[EQUIPOU]: "..v.nome)
					else
						TriggerClientEvent("Notify",source,"negado","Armamento não encontrado.")
					end
				else
					TriggerClientEvent("Notify",source,"negado","Já está equipado!")
				end
			end
		end
	elseif tipo == "municao" then
		for k,v in pairs(itemlist) do
			if item == v.index then
				local uweapons = vRPclient.getWeapons(source)
				local weaponuse = string.gsub(k,"wammo|","")
				if uweapons[weaponuse] then
					if vRP.tryGetInventoryItem(user_id,"wammo|"..weaponuse,parseInt(quantidade)) then
						local weapons = {}
						weapons[weaponuse] = { ammo = parseInt(quantidade) }
						vRPclient._giveWeapons(source,weapons,false)
						TriggerEvent("everest:postarDiscord", source, webhookequipar, "[EQUIPOU]: "..v.nome.." \n[MUNICAO]: "..parseInt(quantidade))
					else
						TriggerClientEvent("Notify",source,"negado","Munição não encontrada.")
					end
				else
					TriggerClientEvent("Notify",source,"importante","Equipe o armamento antes.")
				end
			end
		end
	else

		if item == "bandagem" then
			vida = vRPclient.getHealth(source)
			if vida > 100 and vida < 400 then
				if not bandagem[user_id] then
					if vRP.tryGetInventoryItem(user_id,"bandagem",1) then
						bandagem[user_id] = true
						TriggerClientEvent('bandagem',source)
						TriggerClientEvent("Notify",source,"sucesso","Bandagem utilizada com sucesso.")
						SetTimeout(60000, function()
							bandagem[user_id] = false
						end)
					else
						TriggerClientEvent("Notify",source,"negado","Bandagem não encontrada na mochila.")
					end
				else
					TriggerClientEvent("Notify",source,"importante","Você precisa aguardar <b>"..bandagem[user_id].." segundos</b> para utilizar outra Bandagem.")
				end
			else
				TriggerClientEvent("Notify",source,"aviso","Você não pode utilizar de vida cheia ou nocauteado.")
			end
		elseif item == "mochila" then
			if vRP.tryGetInventoryItem(user_id,"mochila",1) then
				vRP.varyExp(user_id,"physical","strength",650)
				TriggerClientEvent("Notify",source,"sucesso","Mochila utilizada com sucesso.")
			else
				TriggerClientEvent("Notify",source,"negado","Mochila não encontrada na mochila.")
			end
		elseif item == "cerveja" then
			if vRP.tryGetInventoryItem(user_id,"cerveja",1) then
				TriggerClientEvent('cancelando',source,true)
				vRPclient._CarregarObjeto(source, true,"amb@world_human_drinking@beer@male@idle_a","idle_a","prop_amb_beer_bottle",49,28422)
				SetTimeout(10000,function()
					vRPclient.playScreenEffect(source,"RaceTurbo",180)
					vRPclient.playScreenEffect(source,"DrugsTrevorClownsFight",180)
					TriggerClientEvent('cancelando',source,false)
					vRPclient._DeletarObjeto(source)
					TriggerClientEvent("Notify",source,"sucesso","Cerveja utilizada com sucesso.")
				end)
			else
				TriggerClientEvent("Notify",source,"negado","Cerveja não encontrada na mochila.")
			end
		elseif item == "tequila" then
			if vRP.tryGetInventoryItem(user_id,"tequila",1) then
				TriggerClientEvent('cancelando',source,true)
				vRPclient._CarregarObjeto(source, true,"amb@world_human_drinking@beer@male@idle_a","idle_a","prop_amb_beer_bottle",49,28422)
				SetTimeout(10000,function()
					vRPclient.playScreenEffect(source,"RaceTurbo",180)
					vRPclient.playScreenEffect(source,"DrugsTrevorClownsFight",180)
					TriggerClientEvent('cancelando',source,false)
					vRPclient._DeletarObjeto(source)
					TriggerClientEvent("Notify",source,"sucesso","Tequila utilizada com sucesso.")
				end)
			else
				TriggerClientEvent("Notify",source,"negado","Tequila não encontrada na mochila.")
			end
		elseif item == "vodka" then
			if vRP.tryGetInventoryItem(user_id,"vodka",1) then
				TriggerClientEvent('cancelando',source,true)
				vRPclient._CarregarObjeto(source, true,"amb@world_human_drinking@beer@male@idle_a","idle_a","prop_amb_beer_bottle",49,28422)
				SetTimeout(10000,function()
					vRPclient.playScreenEffect(source,"RaceTurbo",180)
					vRPclient.playScreenEffect(source,"DrugsTrevorClownsFight",180)
					TriggerClientEvent('cancelando',source,false)
					vRPclient._DeletarObjeto(source)
					TriggerClientEvent("Notify",source,"sucesso","Vodka utilizada com sucesso.")
				end)
			else
				TriggerClientEvent("Notify",source,"negado","Vodka não encontrada na mochila.")
			end
		elseif item == "whisky" then
			if vRP.tryGetInventoryItem(user_id,"whisky",1) then
				TriggerClientEvent('cancelando',source,true)
				vRPclient._CarregarObjeto(source, true,"amb@world_human_drinking@beer@male@idle_a","idle_a","p_whiskey_notop",49,28422)
				SetTimeout(10000,function()
					vRPclient.playScreenEffect(source,"RaceTurbo",180)
					vRPclient.playScreenEffect(source,"DrugsTrevorClownsFight",180)
					TriggerClientEvent('cancelando',source,false)
					vRPclient._DeletarObjeto(source)
					TriggerClientEvent("Notify",source,"sucesso","Whisky utilizado com sucesso.")
				end)
			else
				TriggerClientEvent("Notify",source,"negado","Whisky não encontrado na mochila.")
			end
		elseif item == "conhaque" then
			if vRP.tryGetInventoryItem(user_id,"conhaque",1) then
				TriggerClientEvent('cancelando',source,true)
				vRPclient._CarregarObjeto(source, true,"amb@world_human_drinking@beer@male@idle_a","idle_a","prop_amb_beer_bottle",49,28422)
				SetTimeout(10000,function()
					vRPclient.playScreenEffect(source,"RaceTurbo",180)
					vRPclient.playScreenEffect(source,"DrugsTrevorClownsFight",180)
					TriggerClientEvent('cancelando',source,false)
					vRPclient._DeletarObjeto(source)
					TriggerClientEvent("Notify",source,"sucesso","Conhaque utilizado com sucesso.")
				end)
			else
				TriggerClientEvent("Notify",source,"negado","Conhaque não encontrado na mochila.")
			end
		elseif item == "absinto" then
			if vRP.tryGetInventoryItem(user_id,"absinto",1) then
				TriggerClientEvent('cancelando',source,true)
				vRPclient._CarregarObjeto(source, true,"amb@world_human_drinking@beer@male@idle_a","idle_a","prop_amb_beer_bottle",49,28422)
				SetTimeout(10000,function()
					vRPclient.playScreenEffect(source,"RaceTurbo",180)
					vRPclient.playScreenEffect(source,"DrugsTrevorClownsFight",180)
					TriggerClientEvent('cancelando',source,false)
					vRPclient._DeletarObjeto(source)
					TriggerClientEvent("Notify",source,"sucesso","Absinto utilizado com sucesso.")
				end)
			else
				TriggerClientEvent("Notify",source,"negado","Absinto não encontrada na mochila.")
			end
		elseif item == "maconha" then
			if vRP.tryGetInventoryItem(user_id,"maconha",1) then
				vRPclient._playAnim(source,true,{{"mp_player_int_uppersmoke","mp_player_int_smoke"}},true)
				SetTimeout(10000,function()
					vRPclient._stopAnim(source,false)
					vRPclient.playScreenEffect(source,"RaceTurbo",180)
					vRPclient.playScreenEffect(source,"DrugsTrevorClownsFight",180)
					TriggerClientEvent("Notify",source,"sucesso","Maconha utilizada com sucesso.")
				end)
			else
				TriggerClientEvent("Notify",source,"negado","Maconha não encontrada na mochila.")
			end
		elseif item == "cocaina" then
			if vRP.tryGetInventoryItem(user_id,"cocaina",1) then
				vRPclient._playAnim(source,true,{{"mp_player_int_uppersmoke","mp_player_int_smoke"}},true)
				SetTimeout(10000,function()
					vRPclient._stopAnim(source,false)
					vRPclient.playScreenEffect(source,"RaceTurbo",180)
					vRPclient.playScreenEffect(source,"DrugsTrevorClownsFight",180)
					TriggerClientEvent("Notify",source,"sucesso","Cocaina utilizada com sucesso.")
				end)
			else
				TriggerClientEvent("Notify",source,"negado","Cocaina não encontrada na mochila.")
			end
		elseif item == "metanfetamina" then
			if vRP.tryGetInventoryItem(user_id,"metanfetamina",1) then
				vRPclient._playAnim(source,true,{{"mp_player_int_uppersmoke","mp_player_int_smoke"}},true)
				SetTimeout(10000,function()
					vRPclient._stopAnim(source,false)
					vRPclient.playScreenEffect(source,"RaceTurbo",180)
					vRPclient.playScreenEffect(source,"DrugsTrevorClownsFight",180)
					TriggerClientEvent("Notify",source,"sucesso","Metanfetamina utilizada com sucesso.")
				end)
			else
				TriggerClientEvent("Notify",source,"negado","Metanfetamina não encontrada na mochila.")
			end
		elseif item == "capuz" then
			if vRP.getInventoryItemAmount(user_id,"capuz") >= 1 then
				local nplayer = vRPclient.getNearestPlayer(source,2)
				if nplayer then
					vRPclient.setCapuz(nplayer)
					vRP.closeMenu(nplayer)
					TriggerClientEvent("Notify",source,"sucesso","Capuz utilizado com sucesso.")
				end
			else
				TriggerClientEvent("Notify",source,"negado","Capuz não encontrado na mochila.")
			end
		elseif item == "energetico" then
			if vRP.tryGetInventoryItem(user_id,"energetico",1) then
				TriggerClientEvent('cancelando',source,true)
				vRPclient._CarregarObjeto(source, true,"amb@world_human_drinking@beer@male@idle_a","idle_a","prop_energy_drink",49,28422)
				SetTimeout(10000,function()
					TriggerClientEvent('energeticos',source,true)
					TriggerClientEvent('cancelando',source,false)
					vRPclient._DeletarObjeto(source)
					TriggerClientEvent("Notify",source,"sucesso","Energético utilizado com sucesso.")
				end)
				SetTimeout(60000,function()
					TriggerClientEvent('energeticos',source,false)
					TriggerClientEvent("Notify",source,"aviso","O efeito do energético passou e o coração voltou a bater normalmente.")
				end)
			else
				TriggerClientEvent("Notify",source,"negado","Energético não encontrado na mochila.")
			end
		elseif item == "lockpick" then
			
			local tempoDesbloqueio = 5000
			local totalPoliciais = vRP.getUsersByPermission("policia.permissao")

			local mPlaca,mName,mNet,mPrice,mBanido,mLock,mModel,mStreet = vRPclient.ModelName(source,7)
			local mPlacaUser = vRP.getUserByRegistration(mPlaca)

			local donoVeiculo = vRP.getUserSource(mPlacaUser)
			
			if vRP.getInventoryItemAmount(user_id, "lockpick") > 0 and mName then
				if #totalPoliciais > 0 then
					TriggerClientEvent('cancelando',source,true)
					TriggerClientEvent("progress",source,tempoDesbloqueio,"ABRINDO VEÍCULO")
					vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)

					SetTimeout(tempoDesbloqueio,function()
						TriggerClientEvent('cancelando',source,false)
						vRPclient._stopAnim(source,false)

						local random = math.random(10)
						
						if random < 9 then
							vRP.tryGetInventoryItem(user_id,"lockpick", 1)
							TriggerClientEvent("syncLock",-1,mNet)
							TriggerClientEvent("vrp_sound:source",source,'lock',0.1)
							-- TriggerClientEvent('vrp_rastreador:add_rastreador', donoVeiculo, mNet, mModel)
							TriggerEvent('emp_desmanche:VeiculoRoubado', mModel, mPlaca, true)

							SetTimeout(10*60*1000, function()
								TriggerEvent('emp_desmanche:VeiculoRoubado', mModel, mPlaca, false)
							end)
							
							local policia = vRP.getUsersByPermission("policia.permissao")
							local x,y,z = vRPclient.getPosition(source)
							local pick = {}
							for k,v in pairs(policia) do
								local player = vRP.getUserSource(parseInt(v))
								if player then
									async(function()
										local id = idgens:gen()
										pick[id] = vRPclient.addRadiusBlip(player, x, y, z, 1, 150.0, 60)	
										vRPclient._playSound(player,"CONFIRM_BEEP","HUD_MINI_GAME_SOUNDSET")
										TriggerClientEvent('chatMessage',player,"911",{65,130,255},"Roubo na ^1"..mStreet.."^0 do veículo ^1"..mModel.."^0 de placa ^1"..mPlaca.."^0 verifique o ocorrido.")
										SetTimeout(15000,function() 
											-- vRPclient.removeBlip(player,blips[id]) 
											vRPclient.removeBlip(player,pick[id]) 
											idgens:free(id) 
										end)

										if donoVeiculo then
											vRPclient._playSound(donoVeiculo,"CONFIRM_BEEP","HUD_MINI_GAME_SOUNDSET")
											TriggerClientEvent('chatMessage',donoVeiculo,"911",{65,130,255},"O alarme do seu veículo "..mModel.." disparou! Chame as autoridades!")
										end
									end)
								end
							end
						else
							vRPclient._playSound(source,"CONFIRM_BEEP","HUD_MINI_GAME_SOUNDSET")
							TriggerClientEvent('chatMessage',source,"",{65,130,255},"Ops, faltou treino na hora de abrir o veículo, tente novamente!")
						end
					end)
				else
					TriggerClientEvent("Notify",source,"aviso","Número insuficiente de policiais no momento.",8000)
				end
			else
				TriggerClientEvent("Notify",source,"negado","Precisa de uma <b>Lockpick</b> para iniciar o roubo do veículo.")
			end
		elseif item == "masterpick" then
			local mPlaca,mName,mNet,mPrice,mBanido,mLock,mModel,mStreet = vRPclient.ModelName(source,7)
			local mPlacaUser = vRP.getUserByRegistration(mPlaca)
			if vRP.getInventoryItemAmount(user_id,"masterpick") >= 1 and mName then

				if vRP.hasPermission(user_id,"policia.permissao") then
					TriggerClientEvent("syncLock",-1,mNet)
					return
				end

				TriggerClientEvent('cancelando',source,true)
				vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)

				SetTimeout(60000,function()
					TriggerClientEvent("vrp_sound:source",source,'lock',0.1)
					TriggerClientEvent('cancelando',source,false)
					TriggerClientEvent("syncLock",-1,mNet)
					-- TriggerClientEvent('vrp_rastreador:add_rastreador', donoVeiculo, mNet, mModel)
					vRPclient._stopAnim(source,false)

					local policia = vRP.getUsersByPermission("policia.permissao")
					local x,y,z = vRPclient.getPosition(source)
					local pick = {}
					for k,v in pairs(policia) do
						local player = vRP.getUserSource(parseInt(v))
						if player then
							async(function()
								local id = idgens:gen()
								pick[id] = vRPclient.addRadiusBlip(player, x, y, z, 1, 150.0, 60)	
								vRPclient._playSound(player,"CONFIRM_BEEP","HUD_MINI_GAME_SOUNDSET")
								TriggerClientEvent('chatMessage',player,"911",{65,130,255},"Roubo na ^1"..mStreet.."^0 do veículo ^1"..mModel.."^0 de placa ^1"..mPlaca.."^0 verifique o ocorrido.")
								SetTimeout(15000,function() 
									-- vRPclient.removeBlip(player,blips[id]) 
									vRPclient.removeBlip(player,pick[id]) 
									idgens:free(id) 
								end)

								if donoVeiculo then
									vRPclient._playSound(donoVeiculo,"CONFIRM_BEEP","HUD_MINI_GAME_SOUNDSET")
									TriggerClientEvent('chatMessage',donoVeiculo,"911",{65,130,255},"O alarme do seu veículo "..mModel.." disparou! Chame as autoridades!")
								end
							end)
						end
					end
				end)
			else
				TriggerClientEvent("Notify",source,"negado","Precisa de uma <b>Masterpick</b> para iniciar o roubo do veículo.")
			end
		end

	end
end

RegisterCommand('revistar',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local nplayer = vRPclient.getNearestPlayer(source,2)
	local nuser_id = vRP.getUserId(nplayer)

	local ok = true
	if vRPclient.getHealth(nplayer) > 100 then
		TriggerClientEvent("Notify",source,"importante","O cidadão precisa aceitar a revista! Aguarde...")
		ok = vRP.request(nplayer,"Deseja aceitar a revista?",15)
	end
	if ok then
		if nuser_id then
			local identity = vRP.getUserIdentity(user_id)
			local weapons = vRPclient.getWeapons(nplayer)
			local money = vRP.getMoney(nuser_id)
			local data = vRP.getUserDataTable(nuser_id)
			TriggerClientEvent('chatMessage',source,"",{},"^4- -  ^5M O C H I L A^4  - - - - - - - - - - - - - - - - - - - - - - - - - - -  [  ^3"..string.format("%.2f",vRP.getInventoryWeight(nuser_id)).."kg^4  /  ^3"..string.format("%.2f",vRP.getInventoryMaxWeight(nuser_id)).."kg^4  ]  - -")
			if data and data.inventory then
				for k,v in pairs(data.inventory) do
					TriggerClientEvent('chatMessage',source,"",{},"     "..vRP.format(parseInt(v.amount)).."x "..itemlist[k].nome)
				end
			end
			TriggerClientEvent('chatMessage',source,"",{},"^4- -  ^5E Q U I P A D O^4  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -")
			for k,v in pairs(weapons) do
				if v.ammo < 1 then
					TriggerClientEvent('chatMessage',source,"",{},"     1x "..itemlist["wbody|"..k].nome)
				else
					TriggerClientEvent('chatMessage',source,"",{},"     1x "..itemlist["wbody|"..k].nome.." | "..vRP.format(parseInt(v.ammo)).."x Munições")
				end
			end
			TriggerClientEvent('chatMessage',source,"",{},"     $"..vRP.format(parseInt(money)).." Dólares")
			TriggerClientEvent("Notify",nplayer,"aviso","Revistado por <b>"..identity.name.." "..identity.firstname.."</b>.")
		end
	else
		TriggerClientEvent("Notify",source,"negado","Revista negada!")
	end
end)

------------------------
-- ROUBAR
------------------------
local roubando = false
RegisterCommand('roubar',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	
	local nplayer = vRPclient.getNearestPlayer(source,2)
	if nplayer then
		local nuser_id = vRP.getUserId(nplayer)

		if vRP.request(nplayer,"Você está sendo roubado, deseja passar tudo?",30) then
			roubando = true
			async(function()
				while roubando do
					Wait(500)
					local pessoaPerto = vRPclient.getNearestPlayer(source,2)
					if not pessoaPerto or nuser_id ~= vRP.getUserId(pessoaPerto) then
						roubando = false
						TriggerClientEvent("Notify",source,"negado","Você abandonou o roubo")
					end
				end
			end)

			local weapons = vRPclient.replaceWeapons(nplayer,{})
			for k,v in pairs(weapons) do
				if k == "WEAPON_MOLOTOV" or k == "WEAPON_BZGAS" then
					vRP.giveInventoryItem(nuser_id,"wbody|"..k,v.ammo)
				else
					vRP.giveInventoryItem(nuser_id,"wbody|"..k,1)
				end
				if v.ammo > 0 then
					vRP.giveInventoryItem(nuser_id,"wammo|"..k,v.ammo)
				end
			end

			local vida = vRPclient.getHealth(nplayer)
			if vida <= 100 then
				vRPclient._playAnim(source, false, {{"amb@medic@standing@kneel@idle_a","idle_a"}}, true)
			end
				
			local ndata = vRP.getUserDataTable(nuser_id)
			if ndata ~= nil then
				if ndata.inventory ~= nil then
					TriggerClientEvent("Notify",source,"importante","Iniciando roubo de itens...")
					for k,v in pairs(ndata.inventory) do
						Citizen.Wait(2000)
						if not roubando then return end
						
						if vRP.getInventoryWeight(user_id)+vRP.getItemWeight(k)*v.amount <= vRP.getInventoryMaxWeight(user_id) then
							if vRP.tryGetInventoryItem(nuser_id,k,v.amount) then
								vRP.giveInventoryItem(user_id,k,v.amount)
								TriggerClientEvent("Notify",source,"sucesso","Recebeu <b>"..vRP.format(parseInt(v.amount)).."x "..itemlist[k].nome.."</b>")
							end
						else
							TriggerClientEvent("Notify",source,"negado","Mochila cheia!")
							roubando = false
						end
					end
				end
			end

			local nmoney = vRP.getMoney(nuser_id)
			if vRP.tryPayment(nuser_id,nmoney) then
				vRP.giveMoney(user_id,nmoney)
			end
			
			vRPclient.setStandBY(source,parseInt(600))
			vRPclient._stopAnim(source,false)
			TriggerClientEvent('cancelando',source,false)
			TriggerClientEvent("Notify",source,"importante","Roubo concluido com sucesso.")
			roubando = false

		else
			TriggerClientEvent("Notify",source,"aviso","A pessoa está resistindo ao roubo.")
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- GARMAS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('garmas',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if user_id then
		local weapons = vRPclient.replaceWeapons(source,{})
		for k,v in pairs(weapons) do
			if k == "WEAPON_MOLOTOV" or k == "WEAPON_BZGAS" then
				vRP.giveInventoryItem(user_id,"wbody|"..k,v.ammo)
			else
				vRP.giveInventoryItem(user_id,"wbody|"..k,1)
			end
			if v.ammo > 0 then
				vRP.giveInventoryItem(user_id,"wammo|"..k,v.ammo)
			end
			TriggerEvent("everest:postarDiscord", source, webhookgarmas, "[GUARDOU]: "..k.." "..v.ammo)
		end
		TriggerClientEvent("Notify",source,"sucesso","Guardou seu armamento na mochila.")
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- /PAYPAL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('paypal',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if user_id then
		if args[1] == "sacar" and parseInt(args[2]) > 0 then
			local consulta = vRP.getUData(user_id,"vRP:paypal")
			local resultado = json.decode(consulta) or 0
			if resultado >= parseInt(args[2]) then
				vRP.giveBankMoney(user_id,parseInt(args[2]))
				vRP.setUData(user_id,"vRP:paypal",json.encode(parseInt(resultado-args[2])))
				TriggerClientEvent("Notify",source,"sucesso","Efetuou o saque de <b>$"..vRP.format(parseInt(args[2])).." dólares</b> da sua conta paypal.")
			else
				TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente em sua conta paypal.")
			end
		elseif args[1] == "trans" and parseInt(args[2]) > 0 and parseInt(args[3]) > 0 then
			local consulta = vRP.getUData(parseInt(args[2]),"vRP:paypal")
			local resultado = json.decode(consulta) or 0
			local banco = vRP.getBankMoney(user_id)
			if banco >= parseInt(args[3]) then
				vRP.setBankMoney(user_id,parseInt(banco-args[3]))
				vRP.setUData(parseInt(args[2]),"vRP:paypal",json.encode(parseInt(resultado+args[3])))
				TriggerClientEvent("Notify",source,"sucesso","Enviou <b>$"..vRP.format(parseInt(args[3])).." dólares</b> ao passaporte <b>"..vRP.format(parseInt(args[2])).."</b>.")
				TriggerEvent("everest:postarDiscord", source, webhookpaypal, "[ENVIOU]: $"..vRP.format(parseInt(args[3])).." dólares ao passaporte "..vRP.format(parseInt(args[2])))
				local player = vRP.getUserSource(parseInt(args[2]))
				if player == nil then
					return
				else
					local identity = vRP.getUserIdentity(user_id)
					TriggerClientEvent("Notify",player,"importante","<b>"..identity.name.." "..identity.firstname.."</b> transferiu <b>$"..vRP.format(parseInt(args[3])).." dólares</b> para sua conta do paypal.")
				end
			else
				TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.")
			end
		end
	end
end)

function func.getCapacidade()
	local source = source
	local user_id = vRP.getUserId(source)

	local pesoAtual = vRP.getInventoryWeight(user_id)
	local capacidade = vRP.getInventoryMaxWeight(user_id)

	-- if pesoAtual > capacidade/2 then
	-- 	TriggerClientEvent("global:getMochilaComum", source)
	-- end

	return string.format("%.2f",pesoAtual).."/"..string.format("%.2f",capacidade).. "(Kg)"


end