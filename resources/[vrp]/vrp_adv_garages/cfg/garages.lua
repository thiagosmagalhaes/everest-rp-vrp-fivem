local cfg = {}

cfg.garage_types = {
	["Garagem"] = {
		_config = { gtype={"personal"} }
	},
	["Mafia"] = {
		_config = { gtype={"personal"},permissions={"mafia.permissao"}  }
	},
	["Motoclub"] = {
		_config = { gtype={"personal"},permissions={"motoclub.permissao"}  }
	},
	["Bloods"] = {
		_config = { gtype={"personal"},permissions={"bloods.permissao"}  }
	},


	
	["Bulbasaur"]  = {
		_config = { gtype={"personal"},ghome="Bulbasaur" }
	},
	["Ivysaur"]  = {
		_config = { gtype={"personal"},ghome="Ivysaur" }
	},
	["Venusaur"]  = {
		_config = { gtype={"personal"},ghome="Venusaur" }
	},
	["Squirtle"]  = {
		_config = { gtype={"personal"},ghome="Squirtle" }
	},
	["Blastoise"]  = {
		_config = { gtype={"personal"},ghome="Blastoise" }
	},
	["Metapod"]  = {
		_config = { gtype={"personal"},ghome="Metapod" }
	},
	["Clefairy"]  = {
		_config = { gtype={"personal"},ghome="Clefairy" }
	},
	["Clefable"]  = {
		_config = { gtype={"personal"},ghome="Clefable" }
	},
	["Vulpix"]  = {
		_config = { gtype={"personal"},ghome="Vulpix" }
	},
	["Ninetales"]  = {
		_config = { gtype={"personal"},ghome="Ninetales" }
	},
	["Jigglypuff"]  = {
		_config = { gtype={"personal"},ghome="Jigglypuff" }
	},
	["Wigglytuff"]  = {
		_config = { gtype={"personal"},ghome="Wigglytuff" }
	},
	["Zubat"]  = {
		_config = { gtype={"personal"},ghome="Zubat" }
	},
	["Golbat"]  = {
		_config = { gtype={"personal"},ghome="Golbat" }
	},
	["Oddish"]  = {
		_config = { gtype={"personal"},ghome="Oddish" }
	},
	["Gloom"]  = {
		_config = { gtype={"personal"},ghome="Gloom" }
	},
	["Vileplume"]  = {
		_config = { gtype={"personal"},ghome="Vileplume" }
	},
	["Machoke"]  = {
		_config = { gtype={"personal"},ghome="Machoke" }
	},
	["Machamp"]  = {
		_config = { gtype={"personal"},ghome="Machamp" }
	},
	["Bellsprout"]  = {
		_config = { gtype={"personal"},ghome="Bellsprout" }
	},
	["Weepinbell"]  = {
		_config = { gtype={"personal"},ghome="Weepinbell" }
	},
	["Victreebel"]  = {
		_config = { gtype={"personal"},ghome="Victreebel" }
	},
	["Tentacool"]  = {
		_config = { gtype={"personal"},ghome="Tentacool" }
	},
	["Tentacruel"]  = {
		_config = { gtype={"personal"},ghome="Tentacruel" }
	},
	["Geodude"]  = {
		_config = { gtype={"personal"},ghome="Geodude" }
	},
	["Graveler"]  = {
		_config = { gtype={"personal"},ghome="Graveler" }
	},
	["Golem"]  = {
		_config = { gtype={"personal"},ghome="Golem" }
	},
	["Ponyta"]  = {
		_config = { gtype={"personal"},ghome="Ponyta" }
	},
	["Rapidash"]  = {
		_config = { gtype={"personal"},ghome="Rapidash" }
	},
	["Slowpoke"]  = {
		_config = { gtype={"personal"},ghome="Slowpoke" }
	},
	["Slowbro"]  = {
		_config = { gtype={"personal"},ghome="Slowbro" }
	},
	["Magnemite"]  = {
		_config = { gtype={"personal"},ghome="Magnemite" }
	},
	["Magneton"]  = {
		_config = { gtype={"personal"},ghome="Magneton" }
	},
	["Doduo"]  = {
		_config = { gtype={"personal"},ghome="Doduo" }
	},
	
	["Importados"] = {
		_config = { gtype={"store"}, permissions={"importados.permissao"} },
		["feltzer3"] = { "feltzer 3",300000, 30, 5 },
		["infernus2"] = { "infernus 2",450000, 30, 5 },
		["kamacho"] = { "kamacho",350000, 50, 5 },
		--["fordmustang"] = { "ford mustang",1000000,40,6 },
		--["nissangtr"] = { "nissan gtr",1150000,40,3 },
		
		-- ["teslaprior"] = { "tesla prior", 500000,50,10 },
		--["nissanskyliner34"] = { "skyline r34",1100000,60,6 },
		
		--["bmwm3f80"] = { "bmw m3 f80",900000,50,3 },
		-- ["bmwm4gts"] = { "bmw m4 gts", 950000,50,10 },
		--["rmodmi8"] = { "bmw i8",950000,50,3 },
		--["evoque"] = { "Evoque",400000,70,5 },
		--["mst"] = { "Mustang Shelby",900000,50,5 },
		--["slsamg"] = { "Sls Amg",600000,50,5 },
		--["718caymans"] = { "Porsche Cayman",1200000,50,5 },
		
		--["toyotasupra"] = { "toyota supra",1050000,35,6 }, -- proximos
		--["nissan370z"] = { "nissan 370z",750000,30,6 },
		--["lamborghinihuracan"] = { "lamborghini huracan",1300000,40,3 },
		-- ["dodgechargersrt"] = { "dodge charger srt",1400000,60,5 },
		-- ["mazdarx7"] = { "mazda rx7", 1000000,40,5 },
		-- ["bati"] = { "yamaha xj6", 450000,15,5 },
	},
			
	["Motorista"] = {
		_config = { gtype={"rent"} },
		["bus"] = { "bus",0,0,-1 }
	},
	["Policia"] = {
		_config = { gtype={"rent"},permissions={"policia.permissao"} },
		["police"] = { "Police Cruiser", 0, 0, -1 },
		["police2"] = { "Buffalo Supercharged", 0, 0, -1 },
		["police3"] = { "Police Vapid", 0, 0, -1 },
		["policeb"] = { "Police Motocicle", 0, 0, -1 },
		["polmav"] = { "Police Helicóptero", 0, 0, -1 },
		["policet"] = { "Police Transporter", 0, 0, -1 },
		-- ["policiacharger2018"] = { "Dodge Charger 2018",0,0,-1 },
		-- ["policiasilverado"] = { "Chevrolet Silverado",0,0,-1 },
		-- ["policiatahoe"] = { "Chevrolet Tahoe", 0, 0, -1 },
		-- ["policiataurus"] = { "Ford Taurus",0,0,-1 },
		-- ["2015polstang"] = { "Mustang",0,0,-1 },
		-- ["policiavictoria"] = { "Crown Victoria",0,0,-1 },
		-- ["policeb"] = { "BMW R1200",0,0,-1 },
		-- ["polmav"] = { "Helicóptero",0,0,-1 },
		-- ["pbus"] = { "Ônibus",0,0,-1 },
		-- ["hwaycar3"] = { "Ford Hway",0,0,-1 },
		-- 
	},
	["PoliciaNorte"] = {
		_config = { gtype={"rent"},permissions={"policia.permissao"} },
		["sheriff"] = { "Sheriff", 0, 0,-1 },
		["sheriff2"] = { "Sheriff2", 0, 0,-1 },
		["policeb"] = { "Police Motocicle", 0, 0, -1 },
		["polmav"] = { "Police Helicóptero", 0, 0, -1 },
		["policet"] = { "Police Transporter", 0, 0, -1 },
		-- ["policeb"] = { "Police Motocicle",0,0,-1 },
		-- ["polmav"] = { "Helicóptero",0,0,-1 },
		-- ["pbus"] = { "Ônibus",0,0,-1 },
		-- ["policet"] = { "Police Transporter",0,0,-1 },
		-- ["policiasilverado"] = { "Chevrolet Silverado",0,0,-1 },	
		-- ["policiatahoe"] = { "Chevrolet Tahoe", 0, 0, -1 },	
	},
	-- ["FBI"] = {
	-- 	_config = { gtype={"rent"},permissions={"policia.permissao"} },
	-- 	["fbi"] = { "Buffalo", 0, 0,-1 },
	-- 	["fbi2"] = { "Granger", 0, 0,-1 },
	-- 	["riot"] = { "riot", 0, 0,-1 },
	-- },
	-- ["FBIHeli"] = {
	-- 	_config = { gtype={"rent"},permissions={"policia.permissao"} },
	-- 	["frogger2"] = { "frogger 2", 0, 0,-1 },
	-- 	["cargobob4"] = { "cargobob 4", 0, 0,-1 },
	-- },
	["EMS"] = {
		_config = { gtype={"rent"},permissions={"paramedico.permissao"} },
		["ambulance"] = { "Ambulância",0,0,-1 },
		-- ["paramedicocharger2014"] = { "Dodge Charger 2014",0,0,-1 },
		["polmav"] = { "Helicóptero",0,0,-1 }
	},
	["Mecanico"] = {
		_config = { gtype={"rent"},permissions={"mecanico.permissao"} },
		["flatbed"] = { "Reboque",0,0,-1 },
		["sadler"] = { "Sadler", 0,0,-1 }
	},
	["Garagem Bennys"] = {
		_config = { gtype={"rent"},permissions={"bennys.permissao"} },
		["flatbed"] = { "Reboque",0,0,-1 },
		["sadler"] = { "Sadler", 0,0,-1 }
	},
	["Taxista"] = {
		_config = { gtype={"rent"},permissions={"taxista.permissao"} },
		["taxi"] = { "Taxi",0,0,-1 }
	},
	["Entregador"] = {
		_config = { gtype={"rent"} },
		["mule"] = { "Caminhão",0,0,-1 },
	},
	["Reporter"] = {
		_config = { gtype={"rent"},permissions={"reporter.permissao"} },
		["rumpo"] = { "Van",0,0,-1 },
		["buzzard2"] = {"Helicóptero", 0,0,-1}
	},
	["Lixeiro"] = {
		_config = { gtype={"rent"} },
		["trash"] = { "Caminhão 01",0,0,-1 },
		["trash2"] = { "Caminhão 02",0,0,-1 }
	},
	["Caminhao"] = {
		_config = { gtype={"rent"} },
		["phantom"] = { "caminhão 01",0,0,-1 },
		["packer"] = { "caminhão 02",0,0,-1 }
	},
	["Minerador"] = {
		_config = { gtype={"rent"} },
		["rubble"] = { "Caminhão 01",0,0,-1 }
	},
	["Bicicletario"] = {
		_config = { gtype={"rent"} },
		["scorcher"] = { "Scorcher",0,0,-1 },
		["tribike"] = { "Tribike Verde",0,0,-1 },
		["tribike2"] = { "Tribike Vermelha",0,0,-1 },
		["fixter"] = { "Fixter",0,0,-1 },
		["cruiser"] = { "Cruiser",0,0,-1 },
		["bmx"] = { "Bmx",0,0,-1 }
	},
	["Embarcacoes"] = {
		_config = { gtype={"rent"} },
		["dinghy"] = { "dinghy",0,0,-1 },
		["jetmax"] = { "jetmax",0,0,-1 },
		["marquis"] = { "marquis",0,0,-1 },
		["seashark3"] = { "seashark3",0,0,-1 },
		["speeder"] = { "speeder",0,0,-1 },
		["speeder2"] = { "speeder2",0,0,-1 },
		["squalo"] = { "squalo",0,0,-1 },
		["suntrap"] = { "suntrap",0,0,-1 },
		["toro"] = { "toro",0,0,-1 },
		["toro2"] = { "toro2",0,0,-1 },
		["tropic"] = { "tropic",0,0,-1 },
		["tropic2"] = { "tropic2",0,0,-1 }
	},
	["Bennys"] = {
		_config = { gtype={"shop"},permissions={"bennys.permissao"} },
		_shop = {
			[0] = { "Aerofolio",1500,"" },
			[1] = { "Saia Frontal",1500,"" },
			[2] = { "Saia Traseira",1500,"" },
			[3] = { "Saia",1500,"" },
			[4] = { "Escapamento",1500,"" },
			[5] = { "Interior",1500,"" },
			[6] = { "Grades",1500,"" },
			[7] = { "Capo",1500,"" },
			[8] = { "Parachoque Direito",1500,"" },
			[9] = { "Parachoque Esquerdo",1500,"" },
			[10] = { "Tetos",1500,"" },
			[11] = { "Motor",25000,"" },
			[12] = { "Freios",20000,"" },
			[13] = { "Transmissao",20000,"" },
			[14] = { "Buzina",1500,"" },
			[15] = { "Suspensao",15000,"" },
			[16] = { "Blindagem",50000,"" },
			[18] = { "Turbo",7500,"" },
			[20] = { "Fumaca",1500,"" },
			[22] = { "Farois",1500,"" },
			[23] = { "Rodas",3750,"" },
			[24] = { "Rodas Traseiras",1500,"" },
			[25] = { "Suporte de Placa",1500,"" },
			[27] = { "Trims",1500,"" },
			[28] = { "Enfeites",1500,"" },
			[29] = { "Painel",1500,"" },
			[30] = { "Lanterna",1500,"" },
			[31] = { "Macaneta",1500,"" },
			[32] = { "Bancos",1500,"" },
			[33] = { "Volante",1500,"" },
			[34] = { "H Shift",1500,"" },
			[35] = { "Placas",1500,"" },
			[36] = { "Caixa de Som",1500,"" },
			[37] = { "Porta-Malas",1500,"" },
			[38] = { "Hidraulica",3250,"" },
			[39] = { "Placa de Motor",3000,"" },
			[40] = { "Filtro de Ar",1500,"" },
			[41] = { "Struts",1500,"" },
			[42] = { "Capas",1500,"" },
			[43] = { "Antenas",1500,"" },
			[44] = { "Extra Trims",1500,"" },
			[45] = { "Tanque",1500,"" },
			[46] = { "Vidros",1500,"" },
			[48] = { "Livery",1500,"" },
			[49] = { "Tiras",0,"" }
		}
	}
}

cfg.garages = {
	{ "Bennys",-223.01,-1330.35,30.89,nil,nil,nil,nil,50,false },   --- BENNYS  -222.74,-1329.76,30.71 
	-- { "Carros",-29.99,-1104.89,26.42,nil,nil,nil,nil,50,false }, ---29.99,-1104.89,26.42
	-- { "Motos",-31.92,-1114.31,26.42,nil,nil,nil,nil,50,false }, --
	{ "Importados",-813.86,-193.90,42.66,nil,nil,nil,nil,50,false },
	{ "Garagem",55.43,-876.19,30.66,44.20,-870.47,30.46,160.0,0,true },
	{ "Garagem",317.25,2623.14,44.46,334.52,2623.09,44.49,20.0,0,true },
	{ "Garagem",-773.34,5598.15,33.60,-772.82,5578.48,33.48,89.0,0,true },
	{ "Garagem",275.23,-345.54,45.17,285.05,-339.29,44.91,249.0,0,true },
	{ "Garagem",596.40,90.65,93.12,608.21,104.11,92.81,70.0,0,true },
	{ "Garagem",1960.91,3754.20,32.25,1960.07,3764.09,32.19,95.0,0,true },     -- 1960.07,3764.09,32.19
	{ "Garagem",-2030.01,-465.97,11.60,-2024.27,-471.93,11.40,140.0,0,true },
	{ "Garagem",-1184.92,-1510.00,4.64,-1186.70,-1490.54,4.37,125.0,0,true },
	{ "Garagem",-73.44,-2004.99,18.27,-84.96,-2004.22,18.01,352.0,0,true },
	{ "Garagem",214.02,-808.44,31.01,227.62,-789.23,30.68,247.0,0,true },
	{ "Garagem",-348.88,-874.02,31.31,-334.58,-891.73,31.07,345.0,0,true },
	{ "Garagem",67.81,12.41,69.21,63.79,15.93,69.11,344.89,0,true },
	{ "Mafia",-2663.95,1301.07,147.44,  -2661.75,1305.77,147.11, 94.0, 50,true },
	{ "Motoclub",901.23089599609,-2097.9943847656,30.761924743652,  906.26293945313,-2100.9001464844,30.776767730713, 89.514976501465, 50,true },
	{ "Motoclub", 963.40515136719,-112.8459777832,74.43928527832,  965.25018310547,-108.21510314941,73.870597839355, 221.47100830078, 50,true },
	{ "Bloods", -963.54,-1488.4,5.01, -963.79,-1484.58,5.01, 105.88, 50,true },
	{ "Policia",458.67,-1008.08,28.27,447.20,-1021.32,28.45,90.0,50,true },
	{ "PoliciaNorte", 1859.28, 3681.35, 33.79, 1873.68,3686.05,33.58,210.0,50,true },
	{ "PoliciaNorte",-452.07,6005.75,31.84,-463.50,6009.80,31.34,90.0,50,true },
	{ "FBI",111.89,-733.24,33.13,  107.96,-731.9,33.13, 336.63,true },
	{ "FBIHeli",-69.62,-814.91,326.18, -74.97,-818.8,326.18, 336.63,true },
	{ "EMS",295.12,-600.61,43.30,291.96,-608.69,43.36,70.0,50,true },
	-- { "EMS",1815.96,3678.71,34.27,1805.27,3680.97,34.22,120.0,50,true },
	-- { "EMS",-248.14,6332.97,32.42,352.08,-588.14,74.16,90.0,50,true },
	{ "Mecanico",-347.41,-133.23,39.00,-360.84,-112.93,38.69,156.38,50,false },
	{ "Garagem Bennys",-191.97,-1284.47,31.23,-189.63,-1289.97,31.3, 97.48,50,false },
	{ "Taxista",895.36,-179.28,74.70,910.51,-177.95,74.26,240.0,50,false },
	{ "Entregador",46.35,-1749.46,29.63,29.47,-1743.63,29.30,50.0,50,false }, 
	{ "Reporter",-537.13,-886.54,25.20,-528.47,-899.59,23.90,60.0,50,false },  
	{ "Lixeiro",-341.58,-1567.46,25.22,-342.17,-1560.10,25.23,100.0,50,false },
	{ "Motorista",453.89,-600.57,28.58,462.22,-605.06,28.49,220.0,50,false },
	{ "Bicicletario",-1177.82,-1564.45,4.47,-1189.17,-1571.31,4.32,125.0,50,false },
	{ "Bicicletario",-896.17,-781.21,15.91,-897.22,-778.68,15.91,80.0,50,false },
	{ "Bicicletario",-250.727,-1529.59,31.58,-247.68,-1527.71,31.59,230.0,50,false },
	{ "Bicicletario",118.04273986816,-1950.8385009766,20.747224807739,113.35559844971,-1946.5416259766,20.663171768188,49.90,50,false },
	{ "Bicicletario",340.53161621094,-2037.1586914063,21.480211257935,337.21893310547,-2040.1044921875,21.198081970215,53.87,50,false },
	{ "Bicicletario",-1038.21,-2721.08,13.65,-1040.06,-2719.6,13.67,53.87,50,false },
	{ "Embarcacoes",-1605.19,-1164.37,1.28,-1619.61,-1175.78,-0.08,130.0,50,false },
	{ "Embarcacoes",-1522.68,1494.92,111.58,-1526.63,1499.64,109.08,350.0,50,false },
	{ "Embarcacoes",1337.36,4269.71,31.50,1343.24,4269.59,30.11,190.0,50,false },
	{ "Embarcacoes",-192.32,791.54,198.10,-195.95,788.35,195.93,230.0,50,false },
	{ "Bulbasaur",-789.45,307.83,85.70,-795.85,303.96,85.70,179.0,50,false },
	{ "Ivysaur",164.55,-575.40,43.86, 153.20593261719,-576.66546630859,43.88680267334, 28.93,50,false },
	{ "Venusaur",-1299.98,-410.16,35.75,-1299.24,-405.64,35.91,297.0,50,false },
	{ "Squirtle",-1437.50,-545.39,34.74,-1417.43,-523.60,31.90,213.0,50,false },
	{ "Blastoise",-927.69,-393.46,38.96,-922.50,-408.35,37.56,115.0,50,false },
	{ "Metapod",-337.06,207.71,88.57,-331.29,216.83,87.54,358.0,50,false },
	{ "Clefairy",1401.35,1114.99,114.83,1406.73,1118.89,114.83,87.0,50,false },
	{ "Clefable",-1149.42,-1535.88,4.35,-1155.71,-1549.34,4.27,301.0,50,false },
	{ "Vulpix",-809.62,189.91,72.47,-820.07,184.30,72.13,130.0,50,false },
	{ "Ninetales",-188.88,500.52,134.64,-189.37,505.09,134.50,290.0,50,false },
	{ "Jigglypuff",350.45,438.48,147.47,355.79,438.24,146.00,290.0,50,false },
	{ "Wigglytuff",391.12,428.44,144.10,391.29,434.54,143.24,260.0,50,false },
	{ "Zubat",-682.91,601.79,143.66,-687.15,605.04,143.71,320.0,50,false },
	{ "Golbat",-755.32,627.34,142.76,-749.56,628.13,142.45,190.0,50,false },
	{ "Oddish",-865.31,696.79,149.00,-862.28,704.71,149.12,270.0,50,false },
	{ "Gloom",131.63,565.70,183.87,131.06,571.19,183.43,270.0,50,false },
	{ "Vileplume",-1323.06,445.33,99.80,-1323.20,450.40,99.72,1.0,50,false },
	{ "Machoke",-1492.95,421.42,111.24,-1507.75,429.52,111.07,50.0,50,false },
	{ "Machamp",-1405.56,540.03,122.92,-1412.13,538.28,122.53,100.0,50,false },
	{ "Bellsprout",-1365.74,603.67,133.87,-1356.17,605.95,134.02,10.0,50,false },
	{ "Weepinbell",-963.26,761.97,175.46,-969.55,766.17,175.20,40.0,50,false },
	{ "Victreebel",-440.65,684.42,153.06,-442.65,677.18,152.24,120.0,50,false },
	{ "Tentacool",1290.13,-585.26,71.74,1295.45,-567.97,71.23,350.0,50,false },
	{ "Tentacruel",1311.15,-592.49,72.92,1318.95,-575.41,72.98,340.0,50,false },
	{ "Geodude",1344.92,-609.22,74.35,1351.63,-595.03,74.33,320.0,50,false },
	{ "Graveler",1359.97,-620.09,74.33,1360.12,-600.839,74.33,360.0,50,false },
	{ "Golem",1392.43,-607.50,74.33,1377.72,-596.03,74.33,50.0,50,false },
	{ "Ponyta",1404.30,-570.85,74.34,1387.43,-577.91,74.33,110.0,50,false },
	{ "Rapidash",1366.80,-544.94,74.33,1363.47,-552.22,74.33,160.0,50,false },
	{ "Slowpoke",1360.39,-537.19,73.77,1353.13,-554.18,74.10,160.0,50,false },
	{ "Slowbro",1321.85,-525.14,72.12,1317.99,-534.88,72.05,160.0,50,false },
	{ "Magnemite",1314.76,-516.79,71.39,1308.05,-535.15,71.29,160.0,50,false },
	{ "Magneton",-23.59,-1427.51,30.65,-24.14,-1438.26,30.65,180.0,50,false },
	{ "Doduo",24.41,541.41,176.02,13.31,547.29,176.03,92.0,50,false },
	{ "Minerador", 1054.74, -1952.76, 32.09, 1069.87, -1961.82, 31.01, 73, true },
	{ "Caminhao", 1196.63, -3253.71, 7.1, 1189.02,-3242.79, 7.02, 50, false }
}

return cfg