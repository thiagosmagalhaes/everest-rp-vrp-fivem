local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPNserver = Tunnel.getInterface("vrp_identidade")
-----------------------------------------------------------------------------------------------------------------------------------------
-- IDENTIDADE
-----------------------------------------------------------------------------------------------------------------------------------------
local css = [[
	@import url('https://fonts.googleapis.com/css?family=Muli:300,400,700');

	.clear {
		clear: both;
	}

	#DocumentSection {
		background-color: #e3e3e3;
		width: 300px;
		min-height: 300px;
		border-radius: 5px;
		box-shadow: 0px 0px 3px rgba(0, 0, 0, 0.08);
		text-align: center;
		position: absolute;
		right: 5%;
		bottom: 8%;
		font-family: 'Muli';
		color: #3c3c3c;
		padding-bottom: 15px;
		z-index: 1;
		overflow: hidden;
	}

	#DocumentSection:before,
	#DocumentSection:after {
		content: ' ';
		position: absolute;
		width: 200%;
		height: 200%;
	}

	#DocumentSection:before {
		background-color: #1A237E;
		top: -193%;
		left: -100%;
		transform: rotate(-5deg);
		z-index: 1;
	}

	#DocumentSection:after {
		background-color: #1565C0;
		top: -191%;
		left: -100%;
		transform: rotate(-6deg);
		z-index: 0;
	}

	#DocumentSection .avatar-img {
		width: 100px;
		height:100px;
		margin: 50px auto 0 auto;
		overflow:hidden;
		border-radius: 50px;
	}

	#DocumentSection .avatar-img img {
		width: 100%;
	}

	#DocumentSection .each-info {
		display: block;
		margin: 0;
		width: 70%;
		margin: 0 auto;
	}

	#DocumentSection .each-info.person-name {
		font-size: 20px;
	}

	#DocumentSection .each-info.person-age {
		font-size: 15px;
	}

	#DocumentSection .each-info.person-job {
		border-top: 1px solid rgba(0, 0, 0, 0.1);
		border-bottom: 1px solid rgba(0, 0, 0, 0.1);
		margin: 25px auto;
		padding: 10px 0;
		color: #1565C0;
		font-size: 18px;
	}

	#DocumentSection .secondary-info {
		margin-top: 15px;
	}

	#DocumentSection .secondary-info .clear {
		margin-bottom: 3px;
		display: block;
	}

	#DocumentSection .secondary-info .each-info strong {
		float: left;
		font-weight: 300;
	}

	#DocumentSection .secondary-info .each-info span {
		float: right;
		font-weight: bold;
		color: #1565C0;
	}
]]



local identity = false
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if IsControlJustPressed(0,344) then
			
			if identity then
				vRP._removeDiv("rg")
				identity = false
			else
				local foto, name, firstname,user_id,registration,age,phone,multas,paypal,groupname = vRPNserver.Identidade()
				if foto == nil or foto == "" then
					foto  = "https://www.moxtra.com/service/themes/images/default/avatar-single-360.png"
				end
				local html = string.format("<div id='DocumentSection'><div class='avatar-img'><img src='%s'></div> <div class='infos'><div class='main-info'>"..
					"<h1 class='each-info person-name'>%s %s</h1>"..
					"<h2 class='each-info person-age'>%s anos</h2>"..
					"<h2 class='each-info person-job'>%s</h2>"..
					"</div>"..
					"<div class='secondary-info'>"..
					"<div class='each-info'><strong>Passaporte:</strong><span class='person-id'>%s</span></div>"..
					"<div class='clear'></div>"..
					"<div class='each-info'><strong>Registro: </strong><span class='person-passport'>%s</span></div>"..
					"<div class='clear'></div>"..
					"<div class='each-info'><strong>Telefone:</strong><span class='person-phone'>%s</span></div>"..
					"<div class='clear'></div>"..
					"<div class='each-info'><strong>Multas:</strong><span class='person-phone'>$%s</span></div>"..
					"<div class='clear'></div>"..
					"<div class='each-info'><strong>Paypal:</strong><span class='person-phone'>$%s</span></div>"..
					"<div class='clear'></div>"..
					"</div>"..
					"</div>"..
					"</div>", foto, name, firstname, age, groupname, user_id, registration, phone, multas, paypal)
				
				vRP._setDiv("rg", css, html)
				identity = true
			end
		end
	end
end)