local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
vRPgarage = Tunnel.getInterface("vrp_adv_garages")

vRP._prepare("vRP/move_vehicle","UPDATE vrp_user_vehicles SET user_id = @tuser_id WHERE user_id = @user_id AND vehicle = @vehicle")
vRP._prepare("vRP/add_vehicle","INSERT IGNORE INTO vrp_user_vehicles(user_id,vehicle) VALUES(@user_id,@vehicle)")
vRP._prepare("vRP/remove_vehicle","DELETE FROM vrp_user_vehicles WHERE user_id = @user_id AND vehicle = @vehicle")
vRP._prepare("vRP/get_vehicles","SELECT vehicle FROM vrp_user_vehicles WHERE user_id = @user_id")
vRP._prepare("vRP/get_vehicle","SELECT vehicle FROM vrp_user_vehicles WHERE user_id = @user_id AND vehicle = @vehicle")
vRP._prepare("vRP/get_detido","SELECT * FROM vrp_user_vehicles WHERE user_id = @user_id AND vehicle = @vehicle")
vRP._prepare("vRP/set_detido","UPDATE vrp_user_vehicles SET detido = @detido, time = @time WHERE user_id = @user_id AND vehicle = @vehicle")
vRP._prepare("vRP/get_maxcars","SELECT COUNT(vehicle) as quantidade FROM vrp_user_vehicles WHERE user_id = @user_id")
vRP._prepare("vRP/set_vehstatus","UPDATE vrp_user_vehicles SET engine = @engine, body = @body, fuel = @fuel WHERE user_id = @user_id AND vehicle = @vehicle")
vRP._prepare("vRP/count_vehicle","SELECT COUNT(*) as qtd FROM vrp_user_vehicles WHERE vehicle = @vehicle")

local cfg = module("vrp_adv_garages","cfg/garages")
local cfg_inventory = module("vrp","cfg/inventory")


local totalgaragem = 3



local idveh = {}
RegisterServerEvent("vrp_adv_garages_id")
AddEventHandler("vrp_adv_garages_id",function(netid,enginehealth,bodyhealth,fuel)
	if idveh[netid] and netid ~= 0 then
		local user_id = idveh[netid][1]
		local carname = idveh[netid][2]
		local player = vRP.getUserSource(user_id)
		if player then
			vRPgarage.despawnNameVehicle(player,carname)
		end
		vRP.execute("vRP/set_vehstatus",{ user_id = user_id, vehicle = carname, engine = parseInt(enginehealth), body = parseInt(bodyhealth), fuel = parseInt(fuel) })
	end
end)

function openGarage(source,gid,pos,head,payprice)
	local source = source
	local user_id = vRP.getUserId(source)
	local vehicles = cfg.garage_types[gid]
	local gtypes = vehicles._config.gtype
	local mods = vehicles._shop
	local menu = { name = gid }

	for _,gtype in pairs(gtypes) do
		if gtype == "personal" then
			menu["Possuídos"] = { function(player,choice)
				local user_id = vRP.getUserId(source)
				if user_id then
					local kitems = {}
					local submenu = { name = "Possuídos" }
					submenu.onclose = function()
						vRP.openMenu(source,menu)
					end

					local choose = function(player,choice)
						local vname = kitems[choice]
						if vname then
							local rows = vRP.query("vRP/get_detido",{ user_id = user_id, vehicle = vname })
							local data = vRP.getSData("custom:u"..user_id.."veh_"..vname)
							local custom = json.decode(data)
							if not payprice then
								vRP.closeMenu(source)
								local cond,netid,carname = vRPgarage.spawnGarageVehicle(source,vname,pos,head,custom,parseInt(rows[1].engine),parseInt(rows[1].body),parseInt(rows[1].fuel))
								if cond then
									idveh[netid] = { user_id,carname }
								else
									TriggerClientEvent("Notify",source,"aviso","Já tem um veículo deste modelo fora da garagem.")
								end
							else
								local valorCobrar = 0.005
								local ok = true
								local isVip = vRP.hasPermission(user_id,"diamante.permissao")
								local carros = getVeiculo(vname)
								if not isVip then
									ok = vRP.request(source,"Deseja acionar o seguro pagando <b>$"..vRP.format(parseInt(carros.preco*valorCobrar)).."</b> dólares?",30)
								end
								if ok then
									if (not isVip and (vRP.getBankMoney(user_id)+vRP.getMoney(user_id)) >= parseInt(carros.preco*valorCobrar)) or isVip then
										vRP.closeMenu(source)
										local cond,netid,carname = vRPgarage.spawnGarageVehicle(source,vname,pos,head,custom,parseInt(rows[1].engine),parseInt(rows[1].body),parseInt(rows[1].fuel))
										if isVip or (cond and vRP.tryFullPayment(user_id,parseInt(carros.preco*valorCobrar))) then
											idveh[netid] = { user_id,carname }
										else
											TriggerClientEvent("Notify",source,"aviso","Já tem um veículo deste modelo fora da garagem.")
										end
									else
										TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.")
									end
								end
							end
						end
					end

					local choosedetido = function(player,choice)
						local vname = kitems[choice]
						if vname then
							local carros = getVeiculo(vname)
							local ok = vRP.request(source,"Veículo na detenção ou roubado, deseja acionar o seguro pagando <b>$"..vRP.format(parseInt(carros.preco*0.05)).."</b> dólares?",60)
							if ok then
								if vRP.tryFullPayment(user_id,parseInt(carros.preco*0.05)) then
									vRP.closeMenu(source)
									TriggerClientEvent("Notify",source,"sucesso","Seguradora foi acionada, aguarde a notificação da liberação.")
									SetTimeout(15000,function()
										vRP.execute("vRP/set_detido",{ user_id = user_id, vehicle = vname, detido = 0, time = 0 })
										TriggerClientEvent("Notify",source,"sucesso","Veículo liberado.")
									end)

									-- vRP.closeMenu(source)
									-- vRP.execute("vRP/set_detido",{ user_id = user_id, vehicle = vname, detido = 0, time = 0 })
									-- TriggerClientEvent("Notify",source,"sucesso","Veículo liberado.")
								else
									TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.")
								end
							else
								TriggerClientEvent("Notify",source,"negado","Pedido recusado.")
							end
						end
					end

					local choosedetidotime = function(source,choice)
						local vname = kitems[choice]
						if vname then
							local carros = getVeiculo(vname)
							local ok = vRP.request(source,"Veículo na detenção ou roubado, deseja acionar o seguro pagando <b>$"..vRP.format(parseInt(carros.preco*0.1)).."</b> dólares?",60)
							if ok then
								if vRP.tryFullPayment(user_id,parseInt(carros.preco*0.1)) then
									vRP.closeMenu(source)
									TriggerClientEvent("Notify",source,"sucesso","Seguradora foi acionada, aguarde a notificação da liberação.")
									SetTimeout(15000,function()
										vRP.execute("vRP/set_detido",{ user_id = user_id, vehicle = vname, detido = 0, time = 0 })
										TriggerClientEvent("Notify",source,"sucesso","Veículo liberado.")
									end)
								else
									TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.")
								end
							else
								TriggerClientEvent("Notify",source,"negado","Pedido recusado.")
							end
						end
					end

					local pvehicles = vRP.query("vRP/get_vehicles",{ user_id = user_id })
					for k,v in pairs(pvehicles) do
						local vehicle = getVeiculos()[v.vehicle]

						if vehicle then
	
							local rows = vRP.query("vRP/get_detido",{ user_id = user_id, vehicle = v.vehicle })
							if parseInt(rows[1].detido) == 0 then
								submenu[vehicle.title] = { choose,"<text01>Lataria</text01>: <text02>"..vRP.format(parseInt(rows[1].body*0.1)).."%</text02><text01>Motor:</text01> <text02>"..vRP.format(parseInt(rows[1].engine*0.1)).."%</text02><text01>Gasolina:</text01> <text02>"..vRP.format(parseInt(rows[1].fuel)).."%</text02>" }
							else
								if os.time() <= parseInt(rows[1].time+24*60*60) then
									submenu[vehicle.title] = { choosedetidotime,"<text01>Lataria</text01>: <text02>"..vRP.format(parseInt(rows[1].body*0.1)).."%</text02><text01>Motor:</text01> <text02>"..vRP.format(parseInt(rows[1].engine*0.1)).."%</text02><text01>Gasolina:</text01> <text02>"..vRP.format(parseInt(rows[1].fuel)).."%</text02>" }
								else
									submenu[vehicle.title] = { choosedetido,"<text01>Lataria</text01>: <text02>"..vRP.format(parseInt(rows[1].body*0.1)).."%</text02><text01>Motor:</text01> <text02>"..vRP.format(parseInt(rows[1].engine*0.1)).."%</text02><text01>Gasolina:</text01> <text02>"..vRP.format(parseInt(rows[1].fuel)).."%<t/ext02>" }
								end
							end
							kitems[vehicle.title] = v.vehicle
						end
					end
					vRP.openMenu(source,submenu)
				end
			end }

			menu["Guardar"] = { function(player,choice)
				local ok,name,netid = vRPgarage.getNearestOwnedVehicle(source,30)
				if ok then
					vRPgarage.despawnGarageVehicle(source,name,netid)
				else
					TriggerClientEvent('deletarveiculo',source,30)
				end
			end }
		elseif gtype == "rent" then
			menu["Aluguel"] = { function(player,choice)
				local user_id = vRP.getUserId(source)
				if user_id then
					local kitems = {}
					local submenu = { name = "Aluguel" }
					submenu.onclose = function()
						vRP.openMenu(source,menu)
					end

					local choose = function(player,choice)
						local vname = kitems[choice]
						if vname then
							local data = vRP.getSData("custom:u"..user_id.."veh_"..vname)
							local custom = json.decode(data) or false
							local cond,netid,carname = vRPgarage.spawnGarageVehicle(source,vname,pos,head,custom,1000,1000,100)
							if cond then
								idveh[netid] = { user_id,carname }
							else
								TriggerClientEvent("Notify",source,"aviso","Já tem um veículo deste modelo fora da garagem.")
							end
							vRP.closeMenu(source)
						end
					end

					local _pvehicles = vRP.query("vRP/get_vehicles",{ user_id = user_id })
					local pvehicles = {}
					for k,v in pairs(_pvehicles) do
						pvehicles[string.lower(v.vehicle)] = true
					end

					for k,v in pairs(vehicles) do
						if k ~= "_config" and k ~= "_shop" and pvehicles[string.lower(k)] == nil then
							submenu[v[1]] = { choose }
							kitems[v[1]] = k
						end
					end
					vRP.openMenu(source,submenu)
				end
			end }

			menu["Guardar"] = { function(player,choice)
				local ok,name,netid = vRPgarage.getNearestOwnedVehicle(source,30)
				if ok then
					vRPgarage.despawnGarageVehicle(source,name,netid)
				else
					TriggerClientEvent('deletarveiculo',source,30)
				end
			end }
		
		
		
		
		
		
		
		
		
		
		
		elseif gtype == "store" then
			menu["Comprar"] = { function(player,choice)
				local user_id = vRP.getUserId(source)
				if user_id then
					local kitems = {}
					local submenu = { name = "Comprar" }
					submenu.onclose = function()
						vRP.openMenu(source,menu)
					end

					local choose = function(player,choice)
						local vname = kitems[choice]
						if vname then
							local vehicle = vehicles[vname]
							if vehicle then
								local rows = vRP.query("vRP/count_vehicle",{ vehicle = vname })
								if vehicle[4] ~= -1 and parseInt(rows[1].qtd) >= vehicle[4] then
									TriggerClientEvent("Notify",source,"importante","Estoque indisponivel.")
								else
									local totalv = vRP.query("vRP/get_maxcars",{ user_id = user_id })
									if vRP.hasPermission(user_id,"prata.permissao") then
										if parseInt(totalv[1].quantidade) >= totalgaragem + 3 then
											TriggerClientEvent("Notify",source,"importante","Atingiu o número máximo de veículos em sua garagem.")
											return
										end
									elseif vRP.hasPermission(user_id,"ouro.permissao") then
										if parseInt(totalv[1].quantidade) >= totalgaragem + 3 then
											TriggerClientEvent("Notify",source,"importante","Atingiu o número máximo de veículos em sua garagem.")
											return
										end
									elseif vRP.hasPermission(user_id,"platina.permissao") then
										if parseInt(totalv[1].quantidade) >= totalgaragem + 5 then
											TriggerClientEvent("Notify",source,"importante","Atingiu o número máximo de veículos em sua garagem.")
											return
										end
									else
										if parseInt(totalv[1].quantidade) >= totalgaragem then
											TriggerClientEvent("Notify",source,"importante","Atingiu o número máximo de veículos em sua garagem.")
											return
										end
									end
									local ok = vRP.request(source,"Tem certeza que deseja <b>comprar</b> este veículo?",30)
									if ok then
										if vRP.tryFullPayment(user_id,vehicle[2]) then
											vRP.execute("vRP/add_vehicle",{ user_id = user_id, vehicle = vname })
											if vehicle[2] > 0 then
												TriggerClientEvent("Notify",source,"sucesso","Pagou <b>$"..vRP.format(parseInt(vehicle[2])).." dólares</b>.")
											end
											vRP.closeMenu(source)
										else
											TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.")
										end
									else
										TriggerClientEvent("Notify",source,"negado","Pedido recusado.")
									end
								end
							end
						end
					end

					local _pvehicles = vRP.query("vRP/get_vehicles",{ user_id = user_id })
					local pvehicles = {}
					for k,v in pairs(_pvehicles) do
						pvehicles[string.lower(v.vehicle)] = true
					end

					for k,v in pairs(vehicles) do
						if k ~= "_config" and k ~= "_shop" and pvehicles[string.lower(k)] == nil then
							if v[2] > 0 then
								if v[4] == -1 then
									submenu[v[1]] = { choose,"<text01>Valor:</text01> <text02>$"..v[2].."</text02><text01>P-Malas:</text01> <text02>"..v[3].."</text02><text01>Estoque:</text01> <text02>Ilimitado</text02>" }
								else
									submenu[v[1]] = { choose,"<text01>Valor:</text01> <text02>$"..v[2].."</text02><text01>P-Malas:</text01> <text02>"..v[3].."</text02><text01>Estoque:</text01> <text02>"..v[4].."</text02>" }
								end
							else
								submenu[v[1]] = { choose }
							end
							kitems[v[1]] = k
						end
					end
					vRP.openMenu(source,submenu)
				end
			end }
			menu["Vender"] = { function(player,choice)
				local user_id = vRP.getUserId(source)
				if user_id then
					local kitems = {}
					local submenu = { name = "Vender" }
					submenu.onclose = function()
						vRP.openMenu(source,menu)
					end

					    local choose = function(player,choice)
                        local vname = kitems[choice]
                        if vname then
                            local vehicle = vehicles[vname]
                            if vehicle then
                                local ok = vRP.request(source,"Tem certeza que deseja <b>vender</b> este veículo?",30)
                                if ok then
                                    local price = math.ceil(vehicle[2]*0.7)
                                    local rows = vRP.query("vRP/get_vehicle",{ user_id = user_id, vehicle = vname })
                                    if #rows <= 0 then
                                        TriggerClientEvent("Notify",source,"aviso","Não encontrado.")
                                        return
                                    end
                                    if parseInt(rows[1].detido) >= 1 then
                                        TriggerClientEvent("Notify",source,"aviso","Acione a seguradora antes de vender.")
                                        return
                                    end
                                    vRP.execute("vRP/remove_vehicle",{ user_id = user_id, vehicle = vname })
									
									async(function()
										vRP.setSData("custom:u"..user_id.."veh_"..vname,json.encode())
										Citizen.Wait(1000)
										vRP.setSData("custom:u"..user_id.."veh_"..vname,json.encode())
									end)

                                    vRP.giveMoney(user_id,parseInt(price))
                                    if parseInt(price) > 0 then
                                        TriggerClientEvent("Notify",source,"sucesso","Recebeu <b>$"..vRP.format(parseInt(price)).." dólares</b>.")
                                    end
                                    vRP.closeMenu(source)
                                end
                            end
                        end
                    end

					local _pvehicles = vRP.query("vRP/get_vehicles",{ user_id = user_id })
					local pvehicles = {}
					for k,v in pairs(_pvehicles) do
						pvehicles[string.lower(v.vehicle)] = true
					end

					for k,v in pairs(pvehicles) do
						local vehicle = vehicles[k]
						if vehicle then
							if vehicle[2] > 0 then
								submenu[vehicle[1]] = { choose,"<text01>Valor:</text01> <text02>$"..parseInt(math.ceil(vehicle[2]*0.7)).."</text02>" }
							else
								submenu[vehicle[1]] = { choose }
							end
							kitems[vehicle[1]] = k
						end
					end
					vRP.openMenu(source,submenu)
				end
			end }








			
		elseif gtype == "shop" then
			menu["Loja"] = { function(player,choice)
				local user_id = vRP.getUserId(source)
				local tosub = false
				if user_id then
					local submenu = { name = "Loja" }
					submenu.onclose = function()
						if not tosub then
							vRP.openMenu(source,menu)
						end
					end

					local ch_color = function(player,choice)
						local old_vname,old_custom = vRPgarage.getVehicleMods(source)
						local subsubmenu = { name = "Cores" }
						subsubmenu.onclose = function()
							tosub = false
							local vname,custom = vRPgarage.getVehicleMods(source)
							if custom then
								if vRP.tryFullPayment(user_id,1500) then
									if vname then
										local mPlaca = vRPclient.ModelName(player,7)
										local mPlacaUser = vRP.getUserByRegistration(mPlaca)
										if mPlacaUser then
											vRP.setSData("custom:u"..mPlacaUser.."veh_"..vname,json.encode(custom))
										end
										TriggerClientEvent("Notify",player,"sucesso","Pagou <b>$3.000 dólares</b>.")
									end
								else
									vRPgarage.setVehicleMods(source,old_custom)
									TriggerClientEvent("Notify",player,"negado","Dinheiro insuficiente.")
								end
							end
						vRP.openMenu(source,submenu)
					end

					local ch_pri = function(player,choice,mod)
						vRPgarage.scrollVehiclePrimaryColour(source,mod)
					end

					local ch_sec = function(player,choice,mod)
						vRPgarage.scrollVehicleSecondaryColour(source,mod)
					end

					local ch_primaria = function(player,choice)
						local rgb = vRP.prompt(source,"RGB Color(255 255 255):","")
						rgb = sanitizeString(rgb,"\"[]{}+=?!_()#@%/\\|,.",false)
						local r,g,b = table.unpack(splitString(rgb," "))
						vRPgarage.setCustomPrimaryColour(source,tonumber(r),tonumber(g),tonumber(b))
					end

					local ch_secundaria = function(player,choice)
						local rgb = vRP.prompt(source,"RGB Color(255 255 255):","")
						rgb = sanitizeString(rgb,"\"[]{}+=?!_()#@%/\\|,.",false)
						local r,g,b = table.unpack(splitString(rgb," "))
						vRPgarage.setCustomSecondaryColour(source,tonumber(r),tonumber(g),tonumber(b))
					end

					local ch_perolada = function(player,choice,mod)
						vRPgarage.scrollVehiclePearlescentColour(source,mod)
					end

					local ch_rodas = function(player,choice,mod)
						vRPgarage.scrollVehicleWheelColour(source,mod)
					end

					local ch_fumaca = function(player,choice)
						local rgb = vRP.prompt(source,"RGB Color(255 255 255):","")
						rgb = sanitizeString(rgb,"\"[]{}+=?!_()#@%/\\|,.",false)
						local r,g,b = table.unpack(splitString(rgb," "))
						vRPgarage.setSmokeColour(source,tonumber(r),tonumber(g),tonumber(b))
					end

					subsubmenu["Primária"] = { ch_pri }
					subsubmenu["Secundária"] = { ch_sec }
					subsubmenu["Primária RGB"] = { ch_primaria }
					subsubmenu["Secundária RGB"] = { ch_secundaria }
					subsubmenu["Perolada"] = { ch_perolada }
					subsubmenu["Rodas"] = { ch_rodas }
					subsubmenu["Fumaça"] = { ch_fumaca }
					tosub = true
					vRP.openMenu(source,subsubmenu)
				end

				submenu["Cores"] = { ch_color,"<b>Valor:</b> $1.500" }

				local ch_neon = function(player,choice)
					local old_vname,old_custom = vRPgarage.getVehicleMods(source)
					local subsubmenu = { name = "Neon" }
					subsubmenu.onclose = function()
						tosub = false
						local vname,custom = vRPgarage.getVehicleMods(source)
						if custom then
							if vRP.tryFullPayment(user_id,1500) then
								if vname then
									local mPlaca = vRPclient.ModelName(player,7)
									local mPlacaUser = vRP.getUserByRegistration(mPlaca)
									if mPlacaUser then
										vRP.setSData("custom:u"..mPlacaUser.."veh_"..vname,json.encode(custom))
									end
									TriggerClientEvent("Notify",player,"sucesso","Pagou <b>$1.500 dólares</b>.")
								end
							else
								vRPgarage.setVehicleMods(source,old_custom)
								TriggerClientEvent("Notify",player,"negado","Dinheiro insuficiente.")
							end
						end
						vRP.openMenu(source,submenu)
					end

					local ch_nleft = function(player,choice)
						vRPgarage.toggleNeon(source,0)
					end

					local ch_nright = function(player,choice)
						vRPgarage.toggleNeon(source,1)
					end

					local ch_nfront = function(player,choice)
						vRPgarage.toggleNeon(source,2)
					end

					local ch_nback = function(player,choice)
						vRPgarage.toggleNeon(source,3)
					end

					local ch_ncolor = function(player,choice)
						local rgb = vRP.prompt(source,"RGB Color(255 255 255):","")
						rgb = sanitizeString(rgb,"\"[]{}+=?!_()#@%/\\|,.",false)
						local r,g,b = table.unpack(splitString(rgb," "))
						vRPgarage.setNeonColour(source,tonumber(r),tonumber(g),tonumber(b))
					end

					subsubmenu["Traseiro"] = { ch_nback }
					subsubmenu["Dianteiro"] = { ch_nfront }
					subsubmenu["Esquerdo"] = { ch_nleft }
					subsubmenu["Direito"] = { ch_nright }
					subsubmenu["Cor"] = { ch_ncolor }
					tosub = true
					vRP.openMenu(source,subsubmenu)
				end

				submenu["Neon"] = { ch_neon,"<b>Valor:</b> $1.500" }

				local ch_mods = function(player,choice)
					local kitems = {}
					local old_vname,old_custom = vRPgarage.getVehicleMods(source)
					local subsubmenu = { name = "Modificações" }
					subsubmenu.onclose = function()
						tosub = false
						local vname,custom = vRPgarage.getVehicleMods(source)
						local price = 0
						local items = {}
						if custom then
							for k,v in pairs(custom.mods) do
								local old = old_custom.mods[k]
								local mod = mods[k]
								if mod then
									if old ~= v then
										if mod[4] then
											items[k] = { mod[4],mod[2] }
										else
											price = price + mod[2]
										end
									end
								end
							end
							if vRP.tryFullPayment(user_id,price) then
								if vname then
									local mPlaca = vRPclient.ModelName(player,7)
									local mPlacaUser = vRP.getUserByRegistration(mPlaca)
									if mPlacaUser then
										vRP.setSData("custom:u"..mPlacaUser.."veh_"..vname,json.encode(custom))
									end
									if price > 0 then
										TriggerClientEvent("Notify",source,"sucesso","Pagou <b>$"..vRP.format(parseInt(price)).." dólares</b>.")
									end
								end
							else
								vRPgarage.setVehicleMods(source,old_custom)
								TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.")
							end
						end
						vRP.openMenu(source,submenu)
					end

					local ch_mod = function(player,choice,mod)
						vRPgarage.scrollVehicleMods(source,kitems[choice],mod)
					end

					for k,v in pairs(mods) do
						if v[2] > 0 then
							subsubmenu[v[1]] = { ch_mod,"<b>Valor:</b> $"..parseInt(math.max(v[2],0)) }
						else
							subsubmenu[v[1]] = { ch_mod }
						end
						kitems[v[1]] = k
					end
					tosub = true
					vRP.openMenu(source,subsubmenu)
				end

				submenu["Modificações"] = { ch_mods }
				vRP.openMenu(source,submenu)
				end
			end }
		end
	end
	vRP.openMenu(source,menu)
end

local function build_garages(source)
	local source = source
	local user_id = vRP.getUserId(source)
	local address = vRP.getUserAddress(user_id) or false
	if user_id then
		if #address > 0 then
			for k,v in pairs(cfg.garages) do
				local i,x,y,z,x2,y2,z2,h,opac,pay = table.unpack(v)
				local g = cfg.garage_types[i]

				if g then
					for kk,vv in pairs(address) do
						local cfg = g._config
						if not cfg.ghome or cfg.ghome == vv.home then
							local garage_enter = function(player,area)
								if user_id and vRP.hasPermissions(user_id,cfg.permissions or {}) then
									openGarage(source,i,{x2,y2,z2},h,pay)
								end
							end

							local garage_leave = function(player,area)
								vRP.closeMenu(source)
							end

							vRPclient._addMarker(source,23,x,y,z-0.95,1,1,0.5,0,95,140,opac,100)
							vRP.setArea(source,"vRP:garage"..k,x,y,z,1.0,1.0,garage_enter,garage_leave)
						end
					end
				end
			end
		else
			for k,v in pairs(cfg.garages) do
				local i,x,y,z,x2,y2,z2,h,opac,pay = table.unpack(v)
				local g = cfg.garage_types[i]

				if g then
					local cfg = g._config
						if not cfg.ghome then
							local garage_enter = function(player,area)
							if user_id and vRP.hasPermissions(user_id,cfg.permissions or {}) then
								openGarage(source,i,{x2,y2,z2},h,pay)
							end
						end

						local garage_leave = function(player,area)
							vRP.closeMenu(source)
						end

						vRPclient._addMarker(source,23,x,y,z-0.95,1,1,0.5,0,95,140,opac,100)
						vRP.setArea(source,"vRP:garage"..k,x,y,z,1.0,1.0,garage_enter,garage_leave)
					end
				end
			end
		end
	end
end

AddEventHandler("vRP:playerSpawn",function(user_id,source,first_spawn)
	if first_spawn then
		build_garages(source)
	end
end)

RegisterServerEvent("vrp_adv_garages:init")
AddEventHandler("vrp_adv_garages:init",function()
	build_garages(source)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VENDER O VEÍCULO PARA OUTRO JOGADOR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('vehs',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		local menu = vRP.buildMenu("vehicle",{ user_id = user_id, player = source, vname = name })
		menu.name = "Veículos"

		local kitems = {}
		local choose = function(source,choice)
			local tosub = false
			local vehicle = choice
			local vname = kitems[vehicle]
			local submenu = { name = vehicle }
			submenu.onclose = function()
				tosub = false
				vRP.openMenu(source,menu)
			end

			local ch_sell = function(source,choice)
				local nplayer = vRPclient.getNearestPlayer(source,3)
				if nplayer then
					local tuser_id = vRP.getUserId(nplayer)
					local totalv = vRP.query("vRP/get_maxcars",{ user_id = tuser_id })
					if vRP.hasPermission(tuser_id,"bronze.permissao") then
						if parseInt(totalv[1].quantidade) >= totalgaragem + 1 then
							TriggerClientEvent("Notify",source,"importante","A pessoa atingiu o número máximo de veículos na garagem.")
							return
						end
					elseif vRP.hasPermission(tuser_id,"prata.permissao") then
						if parseInt(totalv[1].quantidade) >= totalgaragem + 2 then
							TriggerClientEvent("Notify",source,"importante","A pessoa atingiu o número máximo de veículos na garagem.")
							return
						end
					elseif vRP.hasPermission(tuser_id,"ouro.permissao") then
						if parseInt(totalv[1].quantidade) >= totalgaragem + 3 then
							TriggerClientEvent("Notify",source,"importante","A pessoa atingiu o número máximo de veículos na garagem.")
							return
						end
					elseif vRP.hasPermission(tuser_id,"platina.permissao") then
						if parseInt(totalv[1].quantidade) >= totalgaragem + 4 then
							TriggerClientEvent("Notify",source,"importante","A pessoa atingiu o número máximo de veículos na garagem.")
							return
						end
					elseif vRP.hasPermission(tuser_id,"diamante.permissao") then
						if parseInt(totalv[1].quantidade) >= totalgaragem + 5 then
							TriggerClientEvent("Notify",source,"importante","A pessoa atingiu o número máximo de veículos na garagem.")
							return
						end
					else
						if parseInt(totalv[1].quantidade) >= totalgaragem then
							TriggerClientEvent("Notify",source,"importante","A pessoa atingiu o número máximo de veículos na garagem.")
							return
						end
					end
					local owned = vRP.query("vRP/get_vehicle",{ user_id = tuser_id, vehicle = vname })
					if #owned == 0 then
						local price = tonumber(sanitizeString(vRP.prompt(source,"Valor:",""),"\"[]{}+=?!_()#@%/\\|,.",false))
						local ok = vRP.request(nplayer,"Aceita comprar um <b>"..vehicle.."</b> por <b>$"..vRP.format(parseInt(price)).."</b> dólares?",30)
						if ok then
							if parseInt(price) > 0 then
								if vRP.tryFullPayment(tuser_id,parseInt(price)) then
									vRP.execute("vRP/move_vehicle",{ user_id = user_id, tuser_id = tuser_id, vehicle = vname })
									local data = vRP.getSData("custom:u"..user_id.."veh_"..vname)
									local custom = json.decode(data)
									vRP.setSData("custom:u"..tuser_id.."veh_"..vname, json.encode(custom))
									vRP.setSData("custom:u"..user_id.."veh_"..vname, json.encode())
									vRP.giveMoney(user_id,parseInt(price))
									TriggerClientEvent("Notify",nplayer,"sucesso","Pagou <b>$"..vRP.format(parseInt(price)).." dólares</b>.")
									TriggerClientEvent("Notify",source,"sucesso","Recebeu <b>$"..vRP.format(parseInt(price)).." dólares</b>.")
								else
									TriggerClientEvent("Notify",nplayer,"negado","Dinheiro insuficiente.")
									TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.")
								end
							end
						else
							TriggerClientEvent("Notify",source,"negado","Pedido recusado.")
						end
					else
						TriggerClientEvent("Notify",nplayer,"importante","Veículo ja possuído.")
						TriggerClientEvent("Notify",source,"importante","Veículo ja possuído.")
					end
				end
			end
			submenu["Vender"] = { ch_sell }
			tosub = true
			vRP.openMenu(source,submenu)
		end

		local choosedetido = function(source,choice)
			TriggerClientEvent("Notify",source,"importante","Veículo roubado ou detido pela policia, acione a seguradora.")
		end

		local pvehicles = vRP.query("vRP/get_vehicles",{ user_id = user_id })
		for k,v in pairs(pvehicles) do
			local vehicle = getVeiculos()[v.vehicle]

			if vehicle then
				local rows = vRP.query("vRP/get_detido",{ user_id = user_id, vehicle = v.vehicle })
				if parseInt(rows[1].detido) == 0 then
					menu[vehicle.title] = { choose }
				else
					menu[vehicle.title] = { choosedetido }
				end
				kitems[vehicle.title] = v.vehicle
			end
		end

		vRP.openMenu(source,menu)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BOTÃO L PARA TRANCAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("buttonLock")
AddEventHandler("buttonLock",function()
	local source = source
	local user_id = vRP.getUserId(source)
	local mPlaca = vRPclient.ModelName(source,7)
	local mPlacaUser = vRP.getUserByRegistration(mPlaca)
	if user_id == mPlacaUser then
		vRPgarage.toggleLock(source)
		TriggerClientEvent("vrp_sound:source",source,'lock',0.1)
	end
end)

RegisterServerEvent("tryLock")
AddEventHandler("tryLock",function(nveh)
	TriggerClientEvent("syncLock",-1,nveh)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BOTÃO PAGEUP PARA ABRIR PORTA-MALAS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("buttonTrunk")
AddEventHandler("buttonTrunk",function()
	local source = source
	local user_id = vRP.getUserId(source)
	local mPlaca,mName,mNet,mPrice,mBanido,mLock = vRPclient.ModelName(source,7)
	if not mLock then
		if mPlaca then
			if mName then
				if mBanido then
					TriggerClientEvent("Notify",source,"negado","Veículos de serviço ou alugados não podem utilizar o Porta-Malas.")
					return
				end
				local mPlacaUser = vRP.getUserByRegistration(mPlaca)
				if mPlacaUser then
					local chestname = "u"..mPlacaUser.."veh_"..string.lower(mName)
					local max_weight = cfg_inventory.vehicle_chest_weights[string.lower(mName)] or 50

					local cb_out = function(idname,amount)
						if parseInt(amount) > 0 then
							TriggerClientEvent("Notify",source,"sucesso","Retirado <b>"..amount.."x "..vRP.getItemName(idname).."</b>.")
						end
					end

					local cb_in = function(idname,amount)
						if parseInt(amount) > 0 then
							TriggerClientEvent("Notify",source,"sucesso","Colocado <b>"..amount.."x "..vRP.getItemName(idname).."</b>.")
						end
					end

					vRPgarage.toggleTrunk(source)
					vRP.openChest(source,chestname,max_weight,function()
						vRPgarage.toggleTrunk(source)
					end,cb_in,cb_out)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ANCORAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('ancorar',function(source,args,rawCommand)
	local source = source
	local user_id = vRP.getUserId(source)
	local mPlaca = vRPclient.ModelName(source,7)
	local mPlacaUser = vRP.getUserByRegistration(mPlaca)
	if user_id == mPlacaUser then
		vRPgarage.toggleAnchor(source)
	end
end)