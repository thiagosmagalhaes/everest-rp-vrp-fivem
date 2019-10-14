RegisterNetEvent("Notify")
AddEventHandler("Notify",function(css,mensagem)
	SendNUIMessage({ css = css, mensagem = mensagem })
end)