local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

local idgens = Tools.newIDGenerator()

local variavel = 0

local atms = {
	{ atms = 1 , nome = "Caixa Eletrônico", policia = 2 , recompensa = math.random(5000,12000) },
	{ atms = 2 , nome = "Caixa Eletrônico", policia = 2 , recompensa = math.random(5000,12000) },
	{ atms = 3 , nome = "Caixa Eletrônico", policia = 2 , recompensa = math.random(5000,12000) },
	{ atms = 4 , nome = "Caixa Eletrônico", policia = 2 , recompensa = math.random(5000,12000) },
	{ atms = 5 , nome = "Caixa Eletrônico", policia = 2 , recompensa = math.random(5000,12000) },
	{ atms = 6 , nome = "Caixa Eletrônico", policia = 2 , recompensa = math.random(5000,12000) },
	{ atms = 7 , nome = "Caixa Eletrônico", policia = 2 , recompensa = math.random(5000,12000) },
	{ atms = 8 , nome = "Caixa Eletrônico", policia = 2 , recompensa = math.random(5000,12000) },
	{ atms = 9 , nome = "Caixa Eletrônico", policia = 2 , recompensa = math.random(5000,12000) },
	{ atms = 10 , nome = "Caixa Eletrônico", policia = 2 , recompensa = math.random(5000,12000) },
    { atms = 11 , nome = "Caixa Eletrônico", policia = 2 , recompensa = math.random(5000,12000) },
    { atms = 12 , nome = "Banco", policia = 4 , recompensa = math.random(15000,50000) }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------

RegisterServerEvent('crz_celetronico:iniciandoInvasao')
AddEventHandler('crz_celetronico:iniciandoInvasao',function(id)
	local src = source
	local user_id = vRP.getUserId(src)
	local soldado = vRP.getUsersByPermission("policia.permissao")
    for _,rb in pairs(atms) do
        if rb.atms == id then
            if #soldado < rb.policia then
				TriggerClientEvent('chatMessage',src,"ALERTA",{255,70,50},"Número insuficiente de policiais no momento para iniciar um roubo.")
            elseif (os.time()-variavel) <= 1800 then
				TriggerClientEvent('chatMessage',src,"ALERTA",{255,70,50},"Os cofres estão vazios, aguarde ^1"..vRP.format(parseInt((1800-(os.time()-variavel)))).." segundos ^0até que os seguranças retornem com o dinheiro.")
            else
                vRPclient.setStandBY(source,parseInt(700))
                TriggerClientEvent('crz_celetronico:abrirPainel', src, id)
            end
        end
    end
end)


local radiusBlips = {}
RegisterServerEvent('crz_celetronico:chamarPolicia')
AddEventHandler('crz_celetronico:chamarPolicia',function(atm,x,y,z)
	local source = source
    local user_id = vRP.getUserId(source)
	local soldado = vRP.getUsersByPermission("policia.permissao")
    for _,rb in pairs(atms) do
        if rb.atms == atm then
            for l,w in pairs(soldado) do
                local player = vRP.getUserSource(parseInt(w))
                if player then
					variavel = os.time()
                    async(function()

                        local id = idgens:gen()
                        radiusBlips[id] = vRPclient.addRadiusBlip(player, x, y, z, 1, 150.0, 60)	
                        
                        vRPclient.playSound(player,"HUD_MINI_GAME_SOUNDSET","CHECKPOINT_AHEAD")
                        TriggerClientEvent('chatMessage',player,"911",{65,130,255},"O roubo começou no(a) ^1"..rb.nome.."^0, dirija-se até o local e intercepte os assaltantes.")
                        SetTimeout(30000,function() 
                            vRPclient.removeBlip(player,radiusBlips[id]) 
                            idgens:free(id) 
                        end)
                    end)
                end
            end
        end
    end
end)

RegisterServerEvent('crz_celetronico:finalizouRoubo')
AddEventHandler('crz_celetronico:finalizouRoubo',function(atm,x,y,z)
	local source = source
    local user_id = vRP.getUserId(source)
	local soldado = vRP.getUsersByPermission("policia.permissao")
    for _,rb in pairs(atms) do
        if rb.atms == atm then
            vRP.giveInventoryItem(user_id,"dinheirosujo",rb.recompensa,false)
            TriggerClientEvent('removerblip',-1)
            for l,w in pairs(soldado) do
                local player = vRP.getUserSource(parseInt(w))
                if player then
                    variavel = os.time()
                    async(function()
                        local id = idgens:gen()
                        radiusBlips[id] = vRPclient.addRadiusBlip(player, x, y, z, 1, 150.0, 60)	
                        
                        vRPclient.playSound(player,"HUD_MINI_GAME_SOUNDSET","CHECKPOINT_AHEAD")
                        TriggerClientEvent('chatMessage',player,"911",{65,130,255},"O roubo finalizou no(a) ^1"..rb.nome.."^0, dirija-se até o local e intercepte os assaltantes.")
                        SetTimeout(30000,function() 
                            vRPclient.removeBlip(player,radiusBlips[id]) 
                            idgens:free(id) 
                        end)
                    end)
                end
            end
        end
    end
end)

RegisterServerEvent('crz_celetronico:perdeuRoubo')
AddEventHandler('crz_celetronico:perdeuRoubo',function(atm,x,y,z)
	local source = source
    local user_id = vRP.getUserId(source)
	local soldado = vRP.getUsersByPermission("policia.permissao")
    for _,rb in pairs(atms) do
        if rb.atms == atm then
            TriggerClientEvent('removerblip',-1)
            for l,w in pairs(soldado) do
                local player = vRP.getUserSource(parseInt(w))
                if player then
                    async(function()
                        local id = idgens:gen()
                        radiusBlips[id] = vRPclient.addRadiusBlip(player, x, y, z, 1, 150.0, 60)	
                        
                        vRPclient.playSound(player,"HUD_MINI_GAME_SOUNDSET","CHECKPOINT_AHEAD")
                        TriggerClientEvent('chatMessage',player,"911",{65,130,255},"O assaltante não conseguiu decifrar o código do ^1"..rb.nome.."^0.")
                        SetTimeout(30000,function() 
                            vRPclient.removeBlip(player,radiusBlips[id]) 
                            idgens:free(id) 
                        end)
                    end)
                end
            end
        end
    end
end)