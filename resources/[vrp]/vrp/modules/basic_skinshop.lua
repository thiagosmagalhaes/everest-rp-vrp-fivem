local cfg = module("cfg/skinshops")
local skinshops = cfg.skinshops
local procurado = {}
local tempoProcura = 60*10 -- 10 minutos

function vRP.check_procurado(source, user_id)
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

local function parse_part(key)
	if type(key) == "string" and string.sub(key, 1, 1) == "p" then
		return true,tonumber(string.sub(key,2))
	else
		return false,tonumber(key)
	end
end

function vRP.openSkinshop(source,parts)
	local user_id = vRP.getUserId(source)
	if vRP.check_procurado(source, user_id) then
		TriggerClientEvent("Notify",source,"negado","Você está sendo procurado! Tente novamente mais tarde!")
	else
		if user_id then
			local data = vRP.getUserDataTable(user_id)
			local old_custom = vRPclient.getCustomization(source)
			old_custom.modelhash = nil

			local menudata = { name = "Loja de Roupas" }

			local drawables = {}
			local textures = {}
			local ontexture = function(player,choice)
				local texture = textures[choice]
				texture[1] = texture[1]+1
				if texture[1] >= texture[2] then
					texture[1] = 0
				end

				local custom = {}
				custom[parts[choice]] = { drawables[choice][1],texture[1] }
				vRPclient._setCustomization(source,custom)
			end

			local ondrawable = function(player, choice, mod)
				if mod == 0 then
					ontexture(player,choice)
				else
					local isprop, index = parse_part(parts[choice])
					local drawable = drawables[choice]
					drawable[1] = drawable[1]+mod

					if isprop then
						if drawable[1] >= drawable[2] then
							drawable[1] = -1
							elseif drawable[1] < -1 then
								drawable[1] = drawable[2]-1
							end 
						else
							if drawable[1] >= drawable[2] then
								drawable[1] = 0
							elseif drawable[1] < 0 then
								drawable[1] = drawable[2]
							end 
						end

						local custom = {}
						custom[parts[choice]] = { drawable[1],textures[choice][1] }
						vRPclient.setCustomization(source,custom)

						local n = vRPclient.getDrawableTextures(source,parts[choice],drawable[1])
						textures[choice][2] = n

						if textures[choice][1] >= n then
							textures[choice][1] = 0
						end
					end
				end

			for k,v in pairs(parts) do
				drawables[k] = { 0,0 }
				textures[k] = { 0,0 }

				local old_part = old_custom[v]
				if old_part then
					drawables[k][1] = old_part[1]
					textures[k][1] = old_part[2]
				end

				async(function()
					drawables[k][2] = vRPclient.getDrawables(source,v)
					textures[k][2] = vRPclient.getDrawableTextures(source,v,drawables[k][1])
				end)
				menudata[k] = { ondrawable }
			end

			menudata.onclose = function(player)
				local custom = vRPclient.getCustomization(source)
				local price = 0
				custom.modelhash = nil
				for k,v in pairs(custom) do
					local old = old_custom[k]
					if v[1] ~= old[1] then
						price = price + 20
					end
					if v[2] ~= old[2] then
						price = price + 5
					end
				end

				if vRP.tryFullPayment(user_id,price) then
					if price > 0 then
						TriggerClientEvent("Notify",source,"sucesso","Comprou <b>$"..vRP.format(parseInt(price)).."</b> em roupas e acessórios.")
					end
				else
					TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.")
					vRPclient._setCustomization(source,old_custom)
				end
			end
			vRP.openMenu(source,menudata)
		end
	end
end

local function build_client_skinshops(source)
	local user_id = vRP.getUserId(source)
	if user_id then
		for k,v in pairs(skinshops) do
			local parts,x,y,z = table.unpack(v)
			local skinshop_enter = function(source)
				local user_id = vRP.getUserId(source)
				if user_id then
					vRP.openSkinshop(source,parts)
				end
			end

			local function skinshop_leave(source)
			vRP.closeMenu(source)
		end
			vRPclient._addMarker(source,23,x,y,z-0.95,1,1,0.5,0,95,140,50,100)
			vRP.setArea(source,"vRP:skinshop"..k,x,y,z,1,1,skinshop_enter,skinshop_leave)
		end
	end
end



AddEventHandler("vRP:playerSpawn", function(user_id,source,first_spawn)
	if first_spawn then
		build_client_skinshops(source)
	end
end)