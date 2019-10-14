--[[
ALTER TABLE `vrp_user_homes`
	CHANGE COLUMN `home` `home` VARCHAR(255) NOT NULL AFTER `user_id`,
	DROP INDEX `home`,
	DROP PRIMARY KEY,
	ADD PRIMARY KEY (`user_id`,`home`);]]

local cfg = module("cfg/homes")

vRP.prepare("vRP/get_myaddress","SELECT * FROM vrp_user_homes WHERE user_id = @user_id and dono=1")
vRP.prepare("vRP/get_address","SELECT * FROM vrp_user_homes WHERE user_id = @user_id")
vRP.prepare("vRP/get_address2","SELECT * FROM vrp_user_homes WHERE home=@home AND user_id = @user_id")
vRP.prepare("vRP/get_home_owner","SELECT * FROM vrp_user_homes WHERE home = @home AND number = @number")
vRP.prepare("vRP/get_home","SELECT vuh.user_id, vuh.home, vuh.number, vuh.dono FROM vrp_user_homes vuh WHERE vuh.home = @home AND vuh.number = @number and vuh.user_id=@user_id")
vRP.prepare("vRP/get_moradores","SELECT vui.name, vui.firstname, vuh.user_id, vuh.home, vuh.number, vuh.dono FROM vrp_user_homes vuh INNER JOIN vrp_user_identities vui ON vui.user_id = vuh.user_id WHERE vuh.home = @home AND vuh.number = @number AND vuh.dono = 0")
vRP.prepare("vRP/rm_address","DELETE FROM vrp_user_homes WHERE user_id = @user_id AND home = @home")
vRP.prepare("vRP/rm_address_chest","DELETE FROM vrp_srv_data WHERE dkey = @dkey")
vRP.prepare("vRP/set_address","REPLACE INTO vrp_user_homes(user_id,home,number,dono) VALUES(@user_id,@home,@number,@dono)")

local components = {}

function vRP.getUserMyAddress(user_id)
	local rows = vRP.query("vRP/get_myaddress",{ user_id = user_id })
	return rows
end

function vRP.getUserAddress(user_id)
	local rows = vRP.query("vRP/get_address",{ user_id = user_id })
	return rows
end

function vRP.getUserAddress2(user_id, home)
	local rows = vRP.query("vRP/get_address2",{ user_id = user_id, home = home })
	return rows[1]
end



function vRP.setUserAddress(user_id,home,number,dono)
	vRP.execute("vRP/set_address",{ user_id = user_id, home = home, number = number, dono=dono })
end

function vRP.removeUserAddress(user_id,home,chestid)
	vRP.execute("vRP/rm_address",{ user_id = user_id, home = home })
	vRP.execute("vRP/rm_address_chest",{ dkey = "chest:u"..user_id.."-"..chestid.."home" })
end

function vRP.getUserByAddress(home,number, user)
	local rows = vRP.query("vRP/get_home_owner",{ home = home, number = number })

	for i, morador in pairs(rows) do
		if user and morador.user_id == user then
			return morador
		end

		if not user and morador.dono == 1 then
			return morador
		end
	end
	
	return false
end

function vRP.getInfoAndress(user_id, home, number)
	local rows = vRP.query("vRP/get_home",{ home = home, number = number, user_id=user_id })
	if #rows > 0 then
		return rows[1]
	end
	return false
end

function vRP.getMoradores(home, number)
	local rows = vRP.query("vRP/get_moradores",{ home = home, number = number })
	
	return rows or false
end

function vRP.findFreeNumber(user_id, home,max)
	local i = 1
	while i <= max do
		if not vRP.getUserByAddress(home,i) then
			return i
		end
		i = i+1
	end
end

function vRP.defHomeComponent(name,oncreate,ondestroy)
	components[name] = { oncreate,ondestroy }
end

local uslots = {}
for k,v in pairs(cfg.slot_types) do
	uslots[k] = {}
	for l,w in pairs(v) do
		uslots[k][l] = { used = false }
	end
end

local function allocateSlot(stype)
	local slots = cfg.slot_types[stype]
	if slots then
		local _uslots = uslots[stype]
		for k,v in pairs(slots) do
			if _uslots[k] and not _uslots[k].used then
				_uslots[k].used = true
				return k
			end
		end
	end
	return nil
end

local function freeSlot(stype, id)
	local slots = cfg.slot_types[stype]
	if slots then
		uslots[stype][id] = { used = false }
	end
end

local function getAddressSlot(home_name,number)
	for k,v in pairs(uslots) do
		for l,w in pairs(v) do
			if w.home_name == home_name and tostring(w.home_number) == tostring(number) then
				return k,l
			end
		end
	end
	return nil,nil
end

local function is_empty(table)
	for k,v in pairs(table) do
		return false
	end
	return true
end

local function leave_slot(user_id,player,stype,sid)
	local slot = uslots[stype][sid]
	local home = cfg.homes[slot.home_name]
	if home then
		local tmp = vRP.getUserTmpTable(user_id)
		if tmp then
			tmp.home_stype = nil
			tmp.home_sid = nil
		end

		if player and home and home.entry_point then
			vRPclient._teleport(player,table.unpack(home.entry_point))
			slot.players[user_id] = nil
		end

		for k,v in pairs(cfg.slot_types[stype][sid]) do
			local name,x,y,z = table.unpack(v)

			if name == "entry" then
				local nid = "vRP:home:slot"..stype..sid
				vRPclient._removeNamedMarker(player,nid)
				vRP.removeArea(player,nid)
			else
				local component = components[v[1]]
				if component then
					local data = slot.components[k]
					if not data then
						data = {}
						slot.components[k] = data
					end

					component[2](slot.bau_id, slot.owner_id, stype, sid, k, v._config or {}, data, x, y, z, player)
				end
			end
		end

		if is_empty(slot.players) then
			freeSlot(stype,sid)
		end
	end
end

local function enter_slot(user_id,player,stype,sid)
	local slot = uslots[stype][sid]
	local home = cfg.homes[slot.home_name]
	local tmp = vRP.getUserTmpTable(user_id)

	if tmp then
		tmp.home_stype = stype
		tmp.home_sid = sid
	end

	slot.players[user_id] = player

	local menu = { name = slot.home_name }
	menu["Sair"] = { function(player,choice)
		leave_slot(user_id,player,stype,sid)
	end }


	local endereco = vRP.getInfoAndress(user_id, slot.home_name,slot.home_number)
	if endereco and endereco.dono == 1 then
		local moradores = vRP.getMoradores(slot.home_name,slot.home_number)
		local vagas_restantes = home.max_people-#moradores
		if vagas_restantes > 0 then
			menu["Compartilhar"] = { function(player,choice)

				

				local addMorador = function(player,choice)
					local idjogador = vRP.prompt(source, "Informe o passaporte!", "")
					local possuiCasa = vRP.getUserAddress2(parseInt(idjogador), slot.home_name)
					if not possuiCasa then
						if parseInt(idjogador) > 0 and parseInt(idjogador) ~= user_id then
							vRP.setUserAddress(parseInt(idjogador), slot.home_name, slot.home_number, 0)
							TriggerClientEvent("Notify",player,"sucesso","Morador incluído com sucesso!")
							vRP.closeMenu(player)
						end
					else
						TriggerClientEvent("Notify",player,"negado","Jogador já mora no predio!")
					end
				end

				local removeMorador = function(player,choice)
					ok = vRP.request(source,"Deseja remover este morador?",30)

					if ok then
						for i, morador in pairs(moradores) do
							if morador.name.." "..morador.firstname == choice then
								vRP.execute("vRP/rm_address",{ user_id = morador.user_id, home = slot.home_name })
								TriggerClientEvent("Notify",player,"sucesso","Morador removido com sucesso!")
								vRP.closeMenu(player)
								return
							end
						end
					end
				end

				local submenu = { name = "Compartilhar" }
				submenu.onclose = function()
					vRP.openMenu(source,menu)
				end

				if vagas_restantes > 0 then
					submenu["Adicionar Morador"] = { addMorador,"<text01>Vagas</text01>: <text02>"..vagas_restantes.."</text02>" }
				end

				
				for i, morador in pairs(moradores) do
					submenu[morador.name.." "..morador.firstname] = { removeMorador }
				end

				vRP.openMenu(source,submenu)
			end }
		end
	end

	local function entry_enter(player,area)
		vRP.openMenu(player,menu)
	end

	local function entry_leave(player,area)
		vRP.closeMenu(player)
	end

	for k,v in pairs(cfg.slot_types[stype][sid]) do
		local name,x,y,z = table.unpack(v)

		if name == "entry" then
			vRPclient._teleport(player, x,y,z)
			local nid = "vRP:home:slot"..stype..sid
			vRP.setArea(player,nid,x,y,z,1,1,entry_enter,entry_leave)
		else
			local component = components[v[1]]
			if component then
				local data = slot.components[k]
				if not data then
					data = {}
					slot.components[k] = data
				end
				component[1](slot.bau_id, slot.owner_id, stype, sid, k, v._config or {},data,x,y,z,player)
			end
		end
	end
end

function vRP.accessHome(user_id,home,number)
	local _home = cfg.homes[home]
	local stype,slotid = getAddressSlot(home,number)
	local player = vRP.getUserSource(user_id)
	local owner_id = vRP.getUserByAddress(home, number, parseInt(user_id))
	if not owner_id then
		owner_id = vRP.getUserByAddress(home,number)
	end

	if _home ~= nil and player ~= nil then
		if stype == nil then
			stype = _home.slot
			slotid = allocateSlot(_home.slot)

			if slotid ~= nil then
				local slot = uslots[stype][slotid]
				slot.home_name = home
				slot.home_number = number
				slot.owner_id = owner_id.user_id
				slot.bau_id = vRP.getUserByAddress(home,number).user_id
				slot.players = {}
				slot.components = {}
			end
		end

		if slotid ~= nil then
			enter_slot(user_id,player,stype,slotid)
			return true
		end
	end
end

local function build_entry_menu(source, user_id,home_name)
	local home = cfg.homes[home_name]
	local shome = cfg.slot_types[home.slot]
	local menu = { name = home_name }

	if not vRP.check_procurado(source, user_id) then 
		menu["Interfone"] = { function(player,choice)
			local number = vRP.prompt(player,"Numero:","")
			number = parseInt(number)
			local huser_id = vRP.getUserByAddress(home_name,number)
			if huser_id then
				if huser_id.user_id == user_id then
					if not vRP.accessHome(user_id,home_name,number) then
						TriggerClientEvent("Notify",player,"importante","Residência ocupada no momento.")
					end
				else
					local isMorador = vRP.getUserByAddress(home_name, number, user_id)
					if isMorador then
						vRP.accessHome(user_id,home_name,number)
					else
						local hplayer = vRP.getUserSource(huser_id.user_id)
						if hplayer ~= nil then
							TriggerClientEvent("Notify",player,"importante","Você tocou o interfone, aguarde...")
							local nuser_id = vRP.getUserId(player)
							local identitys = vRP.getUserIdentity(nuser_id)
							if vRP.request(hplayer,"<b>"..identitys.name.." "..identitys.firstname.."</b> está tocando seu interfone, deseja aceitar?",30) then
								vRP.accessHome(user_id,home_name,number)
							else
								TriggerClientEvent("Notify",player,"negado","Recusaram sua entrada.")
							end
						end
					end
					
					
				end
			else
				TriggerClientEvent("Notify",player,"aviso","Interfone inválido.")
			end
		end }

		menu["Comprar"] = { function(player,choice)
			local addresses = vRP.getUserAddress(user_id)
			local owner = false
			for k,address in pairs(addresses) do
				if address and address.home == home_name then
					owner = true
				end
			end
			if not owner then
				local number = vRP.findFreeNumber(user_id,home_name,home.max)
				if number then
					if vRP.request(player,"Você deseja <b>comprar</b> esta residência?",30) then
						if vRP.tryFullPayment(user_id,home.buy_price) then
							vRP.setUserAddress(user_id,home_name,number,1)
							TriggerClientEvent("Notify",player,"sucesso","Compra concluida.")
						else
							TriggerClientEvent("Notify",player,"negado","Dinheiro insuficiente.")
						end
					end
				else
					TriggerClientEvent("Notify",player,"negado","Já foi comprada!")
				end
			else
				TriggerClientEvent("Notify",player,"negado","Você já comprou está casa!")
			end
		end,"<text01>Valor:</text01><text02>$"..vRP.format(parseInt(home.buy_price)).."</text02>" }

		menu["Vender"] = { function(player,choice)
			local ok = vRP.request(player,"Você deseja <b>vender</b> sua residência?", 30)
			if ok then
				local addresses = vRP.getUserMyAddress(user_id)
				local owner = false
				for k,address in pairs(addresses) do
					if address and address.home == home_name then
						owner = true
					end
				end
				if owner then
					vRP.giveMoney(user_id,home.sell_price)
					vRP.removeUserAddress(user_id,home_name,shome[1][2]._config.name)
					TriggerClientEvent("Notify",player,"sucesso","Venda concluida.")
				else
					TriggerClientEvent("Notify",player,"negado","Residência não encontrada.")
				end
			end
		end,"<text01>Valor:</text01> <text02>$"..vRP.format(parseInt(home.sell_price)).."</text02>" }

		return menu
	else
		TriggerClientEvent("Notify",source,"negado","Você está sendo procurado! Tente mais tarde!")
		return false
	end

	
end

local function build_client_homes(source)
	local user_id = vRP.getUserId(source)
	if user_id then
		for k,v in pairs(cfg.homes) do
			local x,y,z = table.unpack(v.entry_point)
			local function entry_enter(player,area)
				local user_id = vRP.getUserId(player)
				if user_id and vRP.hasPermissions(user_id,v.permissions or {}) then
					if build_entry_menu(source, user_id,k) ~= false then
						vRP.openMenu(source,build_entry_menu(source, user_id,k))
					end
				end
			end

			local function entry_leave(player,area)
				vRP.closeMenu(player)
			end

			local address = vRP.getUserAddress(user_id)
			if #address > 0 then
				for kk,vv in pairs(address) do
					if k == vv.home then
						vRPclient._addBlip(source,x,y,z,411,33,"Minha Residência",0.4,false)
					end
				end
			end

			vRP.setArea(source,"vRP:home"..k,x,y,z,1,1,entry_enter,entry_leave)
		end
	
	end
end

AddEventHandler("vRP:playerSpawn",function(user_id,source,first_spawn)
	if first_spawn then
		build_client_homes(source)
	else
		local tmp = vRP.getUserTmpTable(user_id)
		if tmp and tmp.home_stype then
			leave_slot(user_id,source,tmp.home_stype,tmp.home_sid)
		end
	end
end)

AddEventHandler("vRP:playerLeave",function(user_id,player)
	local tmp = vRP.getUserTmpTable(user_id)
	if tmp and tmp.home_stype then
		leave_slot(user_id,player,tmp.home_stype,tmp.home_sid)
	end
end)