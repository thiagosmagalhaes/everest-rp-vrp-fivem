RegisterNetEvent("global:addMochilaAleatoria")
AddEventHandler("global:addMochilaAleatoria",function()
	local ped = PlayerPedId()
	local bolsas = {
		40, 41, 44, 45
	}
	SetPedComponentVariation(ped,5,bolsas[math.random(1,4)],0,2)
end)

RegisterNetEvent("global:getMochilaRoubo")
AddEventHandler("global:getMochilaRoubo",function()
	local ped = PlayerPedId()
	SetPedComponentVariation(ped,5,45,0,2)
end)

AddEventHandler('onClientMapStart', function()
	exports.spawnmanager:setAutoSpawn(true)
	exports.spawnmanager:forceRespawn()
end)

RegisterNetEvent('Creative:clientPlayerSpawn')
AddEventHandler('Creative:clientPlayerSpawn',function(x,y,z,model)
	exports.spawnmanager:spawnPlayer({ x = x, y = y, z = z, model = GetHashKey(model) })
end)