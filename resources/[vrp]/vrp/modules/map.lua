local client_areas = {}
AddEventHandler("vRP:playerLeave",function(user_id,source)
	local areas = client_areas[source]
	if areas then
		for k,area in pairs(areas) do
			if area.inside and area.leave then
				area.leave(source,k)
			end
		end
	end
	client_areas[source] = nil
end)

function vRP.setArea(source,name,x,y,z,radius,height,cb_enter,cb_leave)
	local areas = client_areas[source] or {}
	client_areas[source] = areas
	areas[name] = { enter = cb_enter, leave = cb_leave }
	vRPclient._setArea(source,name,x,y,z,radius,height)
end

function vRP.removeArea(source,name)
	vRPclient._removeArea(source,name)
	local areas = client_areas[source]
	if areas then
		local area = areas[name] 
		if area then
			if area.inside and area.leave then
				area.leave(source,name)
			end
			areas[name] = nil
		end
	end
end

function tvRP.enterArea(name)
	local areas = client_areas[source]
	if areas then
		local area = areas[name] 
		if area and not area.inside then
			area.inside = true
			if area.enter then
				area.enter(source,name)
			end
		end
	end
end

function tvRP.leaveArea(name)
	local areas = client_areas[source]
	if areas then
		local area = areas[name] 
		if area and area.inside then
			area.inside = false
			if area.leave then
				area.leave(source,name)
			end
		end
	end
end

local cfg = module("cfg/blips_markers")
AddEventHandler("vRP:playerSpawn",function(user_id,source,first_spawn)
	if first_spawn then
		for k,v in pairs(cfg.blips) do
			vRPclient._addBlip(source,v[1],v[2],v[3],v[4],v[5],v[6],v[7],v[8])
		end
	end
end)