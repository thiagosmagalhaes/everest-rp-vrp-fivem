local Proxy = module("lib/Proxy")
local Tunnel = module("lib/Tunnel")

vRP2 = Proxy.getInterface("vRP")

local config = module("cfg/base")

vRP = {}
Proxy.addInterface("vRP",vRP)

tvRP = {}
Tunnel.bindInterface("vRP",tvRP)
vRPclient = Tunnel.getInterface("vRP")

vRP.users = {}
vRP.rusers = {}
vRP.user_tables = {}
vRP.user_nocautes = {}
vRP.user_tmp_tables = {}
vRP.user_sources = {}

local db_drivers = {}
local db_driver
local cached_prepares = {}
local cached_queries = {}
local prepared_queries = {}
local db_initialized = false

function vRP.registerDBDriver(name,on_init,on_prepare,on_query)
	if not db_drivers[name] then
		db_drivers[name] = { on_init,on_prepare,on_query }

		if name == config.db.driver then
			db_driver = db_drivers[name]

			local ok = on_init(config.db)
			if ok then
				db_initialized = true
				for _,prepare in pairs(cached_prepares) do
					on_prepare(table.unpack(prepare,1,table.maxn(prepare)))
				end

				for _,query in pairs(cached_queries) do
					query[2](on_query(table.unpack(query[1],1,table.maxn(query[1]))))
				end

				cached_prepares = nil
				cached_queries = nil
			end
		end
	end
end

function vRP.format(n)
	local left,num,right = string.match(n,'^([^%d]*%d)(%d*)(.-)$')
	return left..(num:reverse():gsub('(%d%d%d)','%1.'):reverse())..right
end

--[[function vRP.logs(archive,text)
	archive = io.open(archive,"a")
	if archive then
		archive:write(text.."\n")
	end
	archive:close()
end]]

function vRP.prepare(name,query)
	prepared_queries[name] = true

	if db_initialized then
		db_driver[2](name,query)
	else
		table.insert(cached_prepares,{ name,query })
	end
end

function vRP.query(name,params,mode)
	if not mode then mode = "query" end

	if db_initialized then
		return db_driver[3](name,params or {},mode)
	else
		local r = async()
		table.insert(cached_queries,{{ name,params or {},mode },r })
		return r:wait()
	end
end

function vRP.execute(name,params)
	return vRP.query(name,params,"execute")
end

vRP.prepare("vRP/base_tables",[[
	CREATE TABLE IF NOT EXISTS `vrp_users` (
		`id` int(11) NOT NULL AUTO_INCREMENT,
		`last_login` varchar(255) NOT NULL,
		`ip` varchar(255) NOT NULL,
		`whitelisted` tinyint(1) DEFAULT NULL,
		`banned` tinyint(1) DEFAULT NULL,
		PRIMARY KEY (`id`)
	  ) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8_bin;

	  ALTER TABLE `vrp`.`vrp_users` 
		CHANGE COLUMN `last_login` `last_login` VARCHAR(255) NULL ,
		CHANGE COLUMN `ip` `ip` VARCHAR(255) NULL ,
		CHANGE COLUMN `whitelisted` `whitelisted` TINYINT(1) NOT NULL DEFAULT 0 ,
		CHANGE COLUMN `banned` `banned` TINYINT(1) NOT NULL DEFAULT 0 ;

	  
		CREATE TABLE IF NOT EXISTS `vrp`.`policia` (
			`id` INT(11) NOT NULL AUTO_INCREMENT,
			`user_id` INT(11) NOT NULL,
			`dkey` VARCHAR(45) NOT NULL,
			`dvalue` TEXT NULL DEFAULT NULL,
			`img` VARCHAR(150) NULL DEFAULT NULL,
			`valor` DECIMAL(10,2) NULL DEFAULT NULL,
			`datahora` DATETIME NULL DEFAULT NULL,
			`id_pai` INT(11) NULL DEFAULT '0',
			PRIMARY KEY (`id`, `dkey`, `user_id`))
		  ENGINE = InnoDB
		  AUTO_INCREMENT = 282
		  DEFAULT CHARACTER SET = utf8
		  COLLATE = utf8_bin;

CREATE TABLE IF NOT EXISTS vrp_user_ids(
  identifier VARCHAR(100),
  user_id INTEGER,
  CONSTRAINT pk_user_ids PRIMARY KEY(identifier),
  CONSTRAINT fk_user_ids_users FOREIGN KEY(user_id) REFERENCES vrp_users(id) ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS vrp_characters(
  id INTEGER AUTO_INCREMENT,
  user_id INTEGER,
  CONSTRAINT pk_characters PRIMARY KEY(id),
  CONSTRAINT fk_characters_users FOREIGN KEY(user_id) REFERENCES vrp_users(id) ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS vrp_user_data(
  user_id INTEGER,
  dkey VARCHAR(100),
  dvalue BLOB,
  CONSTRAINT pk_user_data PRIMARY KEY(user_id,dkey),
  CONSTRAINT fk_user_data_users FOREIGN KEY(user_id) REFERENCES vrp_users(id) ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS vrp_character_data(
  character_id INTEGER,
  dkey VARCHAR(100),
  dvalue BLOB,
  CONSTRAINT pk_character_data PRIMARY KEY(character_id,dkey),
  CONSTRAINT fk_character_data_characters FOREIGN KEY(character_id) REFERENCES vrp_characters(id) ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS vrp_server_data(
  id VARCHAR(100),
  dkey VARCHAR(100),
  dvalue BLOB,
  CONSTRAINT pk_server_data PRIMARY KEY(id, dkey)
);
CREATE TABLE IF NOT EXISTS vrp_global_data(
  dkey VARCHAR(100),
  dvalue BLOB,
  CONSTRAINT pk_global_data PRIMARY KEY(dkey)
);
CREATE TABLE IF NOT EXISTS `vrp_user_homes` (
  `user_id` int(11) NOT NULL,
  `home` varchar(255) NOT NULL,
  `number` int(11) DEFAULT NULL,
  `dono` INT(1) NULL DEFAULT '1',
  PRIMARY KEY (`user_id`,`home`),
  CONSTRAINT `fk_user_homes_users` FOREIGN KEY (`user_id`) REFERENCES `vrp_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8_bin;

CREATE TABLE IF NOT EXISTS `vrp_user_identities` (
  `user_id` int(11) NOT NULL,
  `registration` varchar(20) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `firstname` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  `foto` VARCHAR(200) NULL DEFAULT NULL,
  `foragido` INT(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`user_id`),
  KEY `registration` (`registration`),
  KEY `phone` (`phone`),
  CONSTRAINT `fk_user_identities_users` FOREIGN KEY (`user_id`) REFERENCES `vrp_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8_bin;

CREATE TABLE IF NOT EXISTS `vrp_user_moneys` (
  `user_id` int(11) NOT NULL,
  `wallet` int(11) DEFAULT NULL,
  `bank` int(11) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  CONSTRAINT `fk_user_moneys_users` FOREIGN KEY (`user_id`) REFERENCES `vrp_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8_bin;

CREATE TABLE IF NOT EXISTS `vrp_user_vehicles` (
  `user_id` int(11) NOT NULL,
  `vehicle` varchar(100) NOT NULL,
  `detido` int(1) NOT NULL DEFAULT '0',
  `time` varchar(24) NOT NULL DEFAULT '0',
  `engine` int(4) NOT NULL DEFAULT '1000',
  `body` int(4) NOT NULL DEFAULT '1000',
  `fuel` int(3) NOT NULL DEFAULT '100',
  PRIMARY KEY (`user_id`,`vehicle`),
  CONSTRAINT `fk_user_vehicles_users` FOREIGN KEY (`user_id`) REFERENCES `vrp_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8_bin;

CREATE TABLE IF NOT EXISTS `vrp_srv_data` (
  `dkey` varchar(100) NOT NULL,
  `dvalue` text,
  PRIMARY KEY (`dkey`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8_bin;

]])

vRP.prepare("vRP/create_user","INSERT INTO vrp_users(whitelisted,banned) VALUES(false,false); SELECT LAST_INSERT_ID() AS id")
vRP.prepare("vRP/add_identifier","INSERT INTO vrp_user_ids(identifier,user_id) VALUES(@identifier,@user_id)")
vRP.prepare("vRP/userid_byidentifier","SELECT user_id FROM vrp_user_ids WHERE identifier = @identifier")
vRP.prepare("vRP/set_userdata","REPLACE INTO vrp_user_data(user_id,dkey,dvalue) VALUES(@user_id,@key,@value)")
vRP.prepare("vRP/get_userdata","SELECT dvalue FROM vrp_user_data WHERE user_id = @user_id AND dkey = @key")
vRP.prepare("vRP/set_srvdata","REPLACE INTO vrp_srv_data(dkey,dvalue) VALUES(@key,@value)")
vRP.prepare("vRP/get_srvdata","SELECT dvalue FROM vrp_srv_data WHERE dkey = @key")
vRP.prepare("vRP/get_banned","SELECT banned FROM vrp_users WHERE id = @user_id")
vRP.prepare("vRP/set_banned","UPDATE vrp_users SET banned = @banned WHERE id = @user_id")
vRP.prepare("vRP/get_whitelisted","SELECT whitelisted FROM vrp_users WHERE id = @user_id")
vRP.prepare("vRP/set_whitelisted","UPDATE vrp_users SET whitelisted = @whitelisted WHERE id = @user_id")
vRP.prepare("vRP/set_last_login","UPDATE vrp_users SET last_login = @last_login, ip = @ip WHERE id = @user_id")
vRP.prepare("vRP/set_fichacriminal","INSERT INTO vrp_fichacriminal(user_id,ficha,tempopreso) VALUES (@user_id,@ficha,@tempopreso)")
vRP.prepare("vRP/get_fichacriminal","SELECT * FROM vrp_fichacriminal WHERE user_id = @user_id")
vRP.prepare("vRP/get_prioridade","SELECT vui.identifier, vui.user_id FROM vrp_user_ids vui INNER JOIN vrp_user_data vud ON vud.user_id=vui.user_id where vui.identifier like 'steam:%' AND vud.dvalue like @vip")

vRP.prepare("vRP/set_serverdata","REPLACE INTO vrp_server_data(dkey,dvalue) VALUES(@key,@value)")
vRP.prepare("vRP/get_serverdata","SELECT * FROM vrp_server_data WHERE dkey = @key")

function vRP.getUserIdByIdentifiers(ids)
	if ids and #ids then
		for i=1,#ids do
			if (string.find(ids[i],"ip:") == nil) then
				local rows = vRP.query("vRP/userid_byidentifier",{ identifier = ids[i] })
				if #rows > 0 then
					return rows[1].user_id
				end
			end
		end

		local rows,affected = vRP.query("vRP/create_user",{})

		if #rows > 0 then
			local user_id = rows[1].id
			for l,w in pairs(ids) do
				if (string.find(w,"ip:") == nil) then
					vRP.execute("vRP/add_identifier",{ user_id = user_id, identifier = w })
				end
			end
			return user_id
		end
	end
end

local pioridade = {}
function vRP.getPrioridade()
	pioridade = {}
	filtrarVip("admin", 100)
	filtrarVip("support", 90)
	filtrarVip("Diamante", 80)
	filtrarVip("Platina", 60)
	filtrarVip("Ouro", 40)
	filtrarVip("Prata", 20)

	return pioridade
end

function filtrarVip(vip, porcentagem)
	local prata = vRP.query("vRP/get_prioridade", {vip = "%"..vip.."%"})
	for l,w in pairs(prata) do
		if not pioridade[w.identifier] then
			pioridade[w.identifier] = porcentagem
		end		
	end
end

function vRP.isBanned(user_id)
	local rows = vRP.query("vRP/get_banned",{ user_id = user_id })
	if #rows > 0 then
		return rows[1].banned
	else
		return false
	end
end

function vRP.setBanned(user_id,banned)
	vRP.execute("vRP/set_banned",{ user_id = user_id, banned = banned })
end

function vRP.isWhitelisted(user_id)
	local rows = vRP.query("vRP/get_whitelisted",{ user_id = user_id })
	if #rows > 0 then
		return rows[1].whitelisted
	else
		return false
	end
end

function vRP.setWhitelisted(user_id,whitelisted)
	vRP.execute("vRP/set_whitelisted",{ user_id = user_id, whitelisted = whitelisted })
end

function vRP.setUData(user_id,key,value)
	vRP.execute("vRP/set_userdata",{ user_id = user_id, key = key, value = value })
end

function vRP.getUData(user_id,key)
	local rows = vRP.query("vRP/get_userdata",{ user_id = user_id, key = key })
	if #rows > 0 then
		return rows[1].dvalue
	else
		return ""
	end
end

function vRP.setSData(key,value)
	return vRP.execute("vRP/set_srvdata",{ key = key, value = value })
end

function vRP.getSData(key)
	local rows = vRP.query("vRP/get_srvdata",{ key = key })
	if #rows > 0 then
		return rows[1].dvalue
	else
		return ""
	end
end

function vRP.getUserDataTable(user_id)
	return vRP.user_tables[user_id]
end

function vRP.getUserNocautes(user_id)
	return vRP.user_nocautes[user_id]
end

function vRP.getUserTmpTable(user_id)
	return vRP.user_tmp_tables[user_id]
end

function vRP.getUserId(source)
	if source ~= nil then
		local ids = GetPlayerIdentifiers(source)
		if ids ~= nil and #ids > 0 then
			return vRP.users[ids[1]]
		end
	end
	return nil
end

function vRP.getUsers()
	local users = {}
	for k,v in pairs(vRP.user_sources) do
		users[k] = v
	end
	return users
end

function vRP.getUserSource(user_id)
	return vRP.user_sources[user_id]
end

function vRP.kick(source,reason)
	DropPlayer(source,reason)
end

function vRP.dropPlayer(source)
	local source = source
	local user_id = vRP.getUserId(source)
	vRPclient._removePlayer(-1,source)
	if user_id then
		if user_id and source then
			TriggerEvent("vRP:playerLeave",user_id,source)
		end
		vRP.setUData(user_id,"vRP:datatable",json.encode(vRP.getUserDataTable(user_id)))
		vRP.users[vRP.rusers[user_id]] = nil
		vRP.rusers[user_id] = nil
		vRP.user_tables[user_id] = nil
		vRP.user_tmp_tables[user_id] = nil
		vRP.user_sources[user_id] = nil
	end
end

function vRP.savePlayer(user_id, dados)
	if user_id then
		vRP.setUData(user_id,"vRP:datatable",json.encode(dados))
	end
end

function task_save_datatables()
	SetTimeout(10000,task_save_datatables)
	TriggerEvent("vRP:save")
	for k,v in pairs(vRP.user_tables) do
		vRP.setUData(k,"vRP:datatable",json.encode(v))
	end
end

async(function()
	-- vRP.execute("vRP/base_tables", {})
	task_save_datatables()
end)

AddEventHandler("queue:playerConnecting",function(source,ids,name,setKickReason,deferrals)
	deferrals.defer()
	local source = source
	local ids = ids
	

	if ids ~= nil and #ids > 0 then
		deferrals.update("Carregando identidades.")
		local user_id = vRP.getUserIdByIdentifiers(ids)
		if user_id then
			deferrals.update("Carregando banimentos.")
			if not vRP.isBanned(user_id) then
				deferrals.update("Carregando whitelist.")
				if vRP.isWhitelisted(user_id) then
					if vRP.rusers[user_id] == nil then
						deferrals.update("Carregando banco de dados.")
						local sdata = vRP.getUData(user_id,"vRP:datatable")

						vRP.users[ids[1]] = user_id
						vRP.rusers[user_id] = ids[1]
						vRP.user_tables[user_id] = {}
						vRP.user_tmp_tables[user_id] = {}
						vRP.user_sources[user_id] = source

						if not vRP.user_nocautes[user_id] then
							vRP.user_nocautes[user_id] = {} 
						end

						local data = json.decode(sdata)
						if type(data) == "table" then vRP.user_tables[user_id] = data end

						local tmpdata = vRP.getUserTmpTable(user_id)

						tmpdata.spawns = 0

						vRP.execute("vRP/set_last_login",{ user_id = user_id, last_login = os.date("%Y-%m-%d"), ip = GetPlayerEndpoint(source) })

						TriggerEvent("vRP:playerJoin",user_id,source,name)
						deferrals.done()
					else
						local tmpdata = vRP.getUserTmpTable(user_id)
						tmpdata.spawns = 0

						TriggerEvent("vRP:playerRejoin",user_id,source,name)
						deferrals.done()
					end
				else
					deferrals.done("Entre no discord https://discord.gg/ne7cvAf e envie para a equipe de administração o seu ID: "..user_id)
					TriggerEvent("queue:playerConnectingRemoveQueues",ids)
				end
			else
				deferrals.done("Você foi banido da cidade.")
				TriggerEvent("queue:playerConnectingRemoveQueues",ids)
			end
		else
			deferrals.done("Ocorreu um problema de identificação.")
			TriggerEvent("queue:playerConnectingRemoveQueues",ids)
		end
	else
		deferrals.done("Ocorreu um problema de identidade.")
		TriggerEvent("queue:playerConnectingRemoveQueues",ids)
	end
end)

AddEventHandler("playerDropped",function(reason)
	local source = source
	vRP.dropPlayer(source)
end)

RegisterServerEvent("vRPcli:playerSpawned")
AddEventHandler("vRPcli:playerSpawned",function()
	local user_id = vRP.getUserId(source)
	if user_id then
		vRP.user_sources[user_id] = source
		local tmp = vRP.getUserTmpTable(user_id)
		tmp.spawns = tmp.spawns+1
		local first_spawn = (tmp.spawns == 1)

		if first_spawn then
			for k,v in pairs(vRP.user_sources) do
				vRPclient._addPlayer(source,v)
			end
			vRPclient._addPlayer(-1,source)
			Tunnel.setDestDelay(source,0)
		end
		TriggerEvent("vRP:playerSpawn",user_id,source,first_spawn)
	end
end)