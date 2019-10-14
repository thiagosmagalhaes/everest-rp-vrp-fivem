local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
emP = {}
Tunnel.bindInterface("emp_cacador", emP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
function emP.checkPayment(item, quantidade)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        if vRP.getInventoryWeight(user_id) + vRP.getItemWeight(item) *
            quantidade <= vRP.getInventoryMaxWeight(user_id) then
            vRP.giveInventoryItem(user_id, item, quantidade)
            random = math.random(100)
            if random >= 98 then
                vRP.giveInventoryItem(user_id, "etiqueta", 1)
            end
            return true
        else
            return false
        end
    end
end

function emP.cancelarAnimal(npc) TriggerClientEvent("cancelarAnimal", -1, npc) end

-----------------------------------------------------------------------------------------------------------------------------------------
-- NUI FUNCTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
local valores = {
    {item = "carnedecormorao", venda = 350},
    {item = "carnedecorvo", venda = 350}, {item = "carnedeaguia", venda = 350},
    {item = "carnedecervo", venda = 250}, {item = "carnedecoelho", venda = 250},
    {item = "carnedecoyote", venda = 250}, {item = "carnedelobo", venda = 350},
    {item = "carnedepuma", venda = 350}, {item = "carnedejavali", venda = 350},
    {item = "etiqueta", venda = 500}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- VENDER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("cacador-vender")
AddEventHandler("cacador-vender", function(item)
    local source = source
    local user_id = vRP.getUserId(source)
    local quantidade = 0
    local data = vRP.getUserDataTable(user_id)
    if data and data.inventory then
        for k, v in pairs(valores) do
            if item == v.item then
                for i, o in pairs(data.inventory) do
                    if i == item then quantidade = o.amount end
                end
                if parseInt(quantidade) > 0 then
                    if vRP.tryGetInventoryItem(user_id, v.item, quantidade) then
                        vRP.giveMoney(user_id, parseInt(v.venda * quantidade))
                        TriggerClientEvent("Notify", source, "sucesso",
                                           "Vendeu <b>" .. quantidade .. "x " ..
                                               vRP.getItemName(v.item) ..
                                               "</b> por <b>$" ..
                                               vRP.format(
                                                   parseInt(v.venda * quantidade)) ..
                                               " dólares</b>.")
                    end
                else
                    TriggerClientEvent("Notify", source, "negado",
                                       "Não possui <b>" ..
                                           vRP.getItemName(v.item) ..
                                           "s</b> em sua mochila.")
                end
            end
        end
    end
end)
