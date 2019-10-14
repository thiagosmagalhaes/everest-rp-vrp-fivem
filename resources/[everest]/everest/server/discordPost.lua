local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
local Tools = module("vrp", "lib/Tools")

local vRP = Proxy.getInterface("vRP")

local timezone = -0
local Time = {}

function attHora()
    Time.hora = tonumber(os.date("%H", os.time() + timezone * 60 * 60))
    if Time.hora >= 0 and Time.hora <= 9 then Time.hora = "0" .. Time.hora end

    Time.min = tonumber(os.date("%M"))
    if Time.min >= 0 and Time.min <= 9 then Time.min = "0" .. Time.min end

    Time.seg = tonumber(os.date("%S"))
    if Time.seg >= 0 and Time.seg <= 9 then Time.seg = "0" .. Time.seg end

    Time.ano = tonumber(os.date("%Y"))
    Time.mes = tonumber(os.date("%m"))
    if Time.mes >= 0 and Time.mes <= 9 then Time.mes = "0" .. Time.mes end
    Time.dia = tonumber(os.date("%d"))
    if Time.dia >= 0 and Time.dia <= 9 then Time.dia = "0" .. Time.dia end
end

function SendWebhookMessage(webhook, message)
    if webhook ~= nil and webhook ~= "" then
        PerformHttpRequest(webhook, function(err, text, headers) end, 'POST',
                           json.encode({content = message}),
                           {['Content-Type'] = 'application/json'})
    end
end

RegisterServerEvent("everest:postarDiscord")
AddEventHandler("everest:postarDiscord", function(source, url, message)
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)

    local dados = "\n[ID]: " .. user_id .. " " .. identity.name .. " " ..
                      identity.firstname .. "\n[DATA]: " .. Time.dia .. "/" ..
                      Time.mes .. " [HORA]: " .. Time.hora .. ":" .. Time.min ..
                      " \r```"

    SendWebhookMessage(url, "```\n" .. message .. dados)
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        attHora()
    end
end)