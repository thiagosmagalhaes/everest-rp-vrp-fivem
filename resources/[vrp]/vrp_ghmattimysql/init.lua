local Proxy = module("vrp", "lib/Proxy")
local vRP = Proxy.getInterface("vRP")

local API = MySQL

local function on_init(cfg) return API ~= nil end

local queries = {}

local function on_prepare(name, query) queries[name] = query end

local function on_query(name, params, mode)
    local query = queries[name]
    local _params = {}
    _params._ = true

    for k, v in pairs(params) do _params["@" .. k] = v end

    local r = async()
    if mode == "execute" then
        local metodo = string.find(query, 'UPDATE')
        if metodo or string.find(query, 'INSERT') or string.find(query, 'REPLACE') or string.find(query, 'DELETE') then
            local affected = MySQL.Sync.insert(query, _params)
            r(affected or 0)
        else
            MySQL.Sync.execute(query, _params,
                               function(affected) r(affected or 0) end)
        end

    elseif mode == "scalar" then
        MySQL.Sync.fetchScalar(query, _params, function(scalar) r(scalar) end)
    else
        local result = MySQL.Sync.fetchAll(query, _params)
        r(result, #result)
    end
    return r:wait()
end

Citizen.CreateThread(function()
    MySQL.ready(function()
        MySQL.Sync.fetchAll("SELECT 1", {})
        vRP.registerDBDriver("ghmattimysql", on_init, on_prepare, on_query)
    end)
    -- MySQL.Sync.fetchAll("SELECT 1", {})
    -- vRP.registerDBDriver("ghmattimysql",on_init,on_prepare,on_query)
end)
