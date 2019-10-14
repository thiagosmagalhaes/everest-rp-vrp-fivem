local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

emP = {}
Tunnel.bindInterface("emp_desmanche",emP)

local listVeiculosProcurados = {}


RegisterServerEvent("emp_desmanche:VeiculoRoubado")
AddEventHandler("emp_desmanche:VeiculoRoubado", function(model, placa, status)
	listVeiculosProcurados[model..placa] = status
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
function emP.isProcurado()
	local source = source
	local user_id = vRP.getUserId(source)
	local mPlaca,mName,mNet,mPrice,mBanido,mLock,mModel,mStreet = vRPclient.ModelName(source,7)
	if mPlaca ~= nil then
		return listVeiculosProcurados[mModel..mPlaca] == true
	else
		return nil
	end
end

function emP.checkPermission()
	local source = source
	local user_id = vRP.getUserId(source)
	return vRP.hasPermission(user_id,"desmanche.permissao")
end

function emP.checkVehicle()
	local source = source
	local user_id = vRP.getUserId(source)
	local mPlaca,mName,mPrice,mBanido = vRPclient.ModelName2(source)
	local placa_user = vRP.getUserByRegistration(mPlaca)
	if placa_user then
		local rows = vRP.query("vRP/get_detido",{ user_id = placa_user, vehicle = mName })
		if #rows <= 0 then
			TriggerClientEvent("Notify",source,"aviso","Veículo não encontrado na lista do proprietário.")
			return
		end
		if mName then
			if parseInt(rows[1].detido) == 1 then
				TriggerClientEvent("Notify",source,"aviso","Veículo encontra-se apreendido na seguradora.")
				return
			end
			if mBanido then
				TriggerClientEvent("Notify",source,"aviso","Veículos de serviço ou alugados não podem ser desmanchados.")
				return
			end
		end
		return true
	end
end

function emP.removeVehicles(mPlaca,mName,mPrice,mNet, integridade)
	local source = source
	local user_id = vRP.getUserId(source)
	local placa_user = vRP.getUserByRegistration(mPlaca)

	local desconto = 0
	if integridade < 200 then 
		desconto = ((200-integridade)/2)/100 -- Verifico a integridade do veiculo
	end

	if placa_user then
		vRP.execute("vRP/set_detido",{ user_id = placa_user, vehicle = mName, detido = 1, time = parseInt(os.time()) })
		local valor = parseInt(mPrice)*0.05
		if desconto > 0 then 
			valor = valor - valor * desconto
		end
		
		vRP.giveInventoryItem(user_id,"dinheirosujo",valor)
		TriggerClientEvent('syncdeleteentity',-1,mNet)
		TriggerClientEvent("Notify", source, "sucesso", "Você recebeu $"..vRP.format(valor).." de dinheiro sujo!")
	end
end