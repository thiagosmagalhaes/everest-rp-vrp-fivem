local cfg = {}

cfg.slot_types = {
	["bulbasaur"] = {{
		{ "entry",-786.96,315.73,217.63 },
		{ "chest",-795.06,326.30,217.03,_config = { weight = 250, name = 1 }},
		{ "wardrobe",-797.86,327.60,220.43 }
	}},
	["ivysaur"] = {{
		{ "entry",-773.96,341.95,196.68 },
		{ "chest",-765.93,331.44,196.08,_config = { weight = 250, name = 2 }},
		{ "wardrobe",-763.09,329.44,199.48 }
	}},
	["venusaur"] = {{
		{ "entry",-787.01,315.78,187.91 },
		{ "chest",-795.16,326.39,187.31,_config = { weight = 250, name = 3 }},
		{ "wardrobe",-797.87,328.16,190.71 }
	}},
	["charmander"] = {{
		{ "entry",266.03,-1007.26,-101.00 },
		{ "chest",265.89,-999.46,-99.00,_config = { weight = 50, name = 4 }},
		{ "wardrobe",259.71,-1003.95,-99.00 }
	}},
	["charmeleon"] = {{
		{ "entry",-31.52,-594.95,80.03 },
		{ "chest",-12.370526313782,-596.90124511719,79.430221557617,_config = { weight = 200, name = 5 }},
		{ "wardrobe",-38.28,-589.65,78.83 }
	}},
	["charizard"] = {{
		{ "entry",-18.13,-590.89,90.11 },
		{ "chest",-25.9,-588.11,90.12, _config = { weight = 150, name = 6 }},
		{ "wardrobe",-37.78,-583.58,83.91 }
	}},
	["squirtle"] = {{
		{ "entry",-1452.25,-540.67,74.04 },
		{ "chest",-1457.91,-550.34,72.87,_config = { weight = 350, name = 7 }},
		{ "wardrobe",-1449.80,-549.14,72.84 }
	}},
	["wartortle"] = {{
		{ "entry",-1451.32,-524.13,56.92 },
		{ "chest",-1457.18,-529.80,56.93,_config = { weight = 225, name = 8 }},
		{ "wardrobe",-1467.49,-537.18,50.73 }
	}},
	["blastoise"] = {{
		{ "entry",-912.61,-365.16,114.27 },
		{ "chest",-903.64,-371.98,113.10,_config = { weight = 250, name = 9 }},
		{ "wardrobe",-903.54,-363.99,113.07 }
	}},
	["caterpie"] = {{
		{ "entry",-602.95,58.89,98.20 },
		{ "chest",-598.30,48.72,97.03,_config = { weight = 175, name = 10 }},
		{ "wardrobe",-594.61,56.17,96.99 }
	}},
	["metapod"] = {{
		{ "entry",-785.15,323.64,211.99 },
		{ "chest",-789.78,333.89,210.83,_config = { weight = 300, name = 11 }},
		{ "wardrobe",-793.57,326.54,210.79 }
	}},
	["butterfree"] = {{
		{ "entry",103.03,-1927.67,10.99 },
		{ "chest",100.19,-1936.61,10.99,_config = { weight = 150, name = 12 }},
		{ "wardrobe",105.04,-1931.96,10.99 }
	}},
	["weedle"] = {{
		{ "entry",83.66,-1911.75,10.99 },
		{ "chest",80.74,-1920.74,10.99,_config = { weight = 150, name = 13 }},
		{ "wardrobe",85.59,-1916.01,10.99 }
	}},
	["kakuna"] = {{
		{ "entry",64.35,-1895.98,10.99 },
		{ "chest",61.41,-1904.87,10.99,_config = { weight = 150, name = 14 }},
		{ "wardrobe",66.27,-1900.27,10.99 }
	}},
	["beedrill"] = {{
		{ "entry",44.00,-1879.34,10.99 },
		{ "chest",41.06,-1888.25,10.99,_config = { weight = 150, name = 15 }},
		{ "wardrobe",45.96,-1883.64,10.99 }
	}},
	["pidgey"] = {{
		{ "entry",24.27,-1863.22,10.99 },
		{ "chest",21.41,-1872.17,10.99,_config = { weight = 150, name = 16 }},
		{ "wardrobe",26.26,-1867.51,10.99 }
	}},
	["pidgeotto"] = {{
		{ "entry",4.46,-1847.01,10.99 },
		{ "chest",1.63,-1855.97,10.99,_config = { weight = 150, name = 17 }},
		{ "wardrobe",6.43,-1851.37,10.99 }
	}},
	["pidgeot"] = {{
		{ "entry",-14.87,-1831.24,10.99 },
		{ "chest",-17.82,-1840.17,10.99,_config = { weight = 150, name = 18 }},
		{ "wardrobe",-12.88,-1835.49,10.99 }
	}},
	["rattata"] = {{
		{ "entry",-34.06,-1815.57,10.99 },
		{ "chest",-36.92,-1824.50,10.99,_config = { weight = 150, name = 19 }},
		{ "wardrobe",-32.05,-1819.83,10.99 }
	}},
	["raticate"] = {{
		{ "entry",-53.85,-1799.33,10.99 },
		{ "chest",-56.70,-1808.32,10.99,_config = { weight = 150, name = 20 }},
		{ "wardrobe",-51.84,-1803.63,10.99 }
	}},
	["spearow"] = {{
		{ "entry",-73.58,-1783.29,10.99 },
		{ "chest",-76.46,-1792.20,10.99,_config = { weight = 150, name = 21 }},
		{ "wardrobe",-71.53,-1787.48,10.99 }
	}},
	["fearow"] = {{
		{ "entry",-93.25,-1767.12,10.99 },
		{ "chest",-96.15,-1776.10,10.99,_config = { weight = 150, name = 22 }},
		{ "wardrobe",-91.29,-1771.44,10.99 }
	}},
	["ekans"] = {{
		{ "entry",103.03,-1927.67,1.99 },
		{ "chest",100.19,-1936.61,1.99,_config = { weight = 150, name = 23 }},
		{ "wardrobe",105.04,-1931.96,1.99 }
	}},
	["arbok"] = {{
		{ "entry",83.66,-1911.75,1.99 },
		{ "chest",80.74,-1920.74,1.99,_config = { weight = 150, name = 24 }},
		{ "wardrobe",85.59,-1916.01,1.99 }
	}},
	["pikachu"] = {{
		{ "entry",64.35,-1895.98,1.99 },
		{ "chest",61.41,-1904.87,1.99,_config = { weight = 150, name = 25 }},
		{ "wardrobe",66.27,-1900.27,1.99 }
	}},
	["raichu"] = {{
		{ "entry",44.00,-1879.34,1.99 },
		{ "chest",41.06,-1888.25,1.99,_config = { weight = 150, name = 26 }},
		{ "wardrobe",45.96,-1883.64,1.99 }
	}},
	["sandshrew"] = {{
		{ "entry",24.27,-1863.22,1.99 },
		{ "chest",21.41,-1872.17,1.99,_config = { weight = 150, name = 27 }},
		{ "wardrobe",26.26,-1867.51,1.99 }
	}},
	["sandslash"] = {{
		{ "entry",4.46,-1847.01,1.99 },
		{ "chest",1.63,-1855.97,1.99,_config = { weight = 150, name = 28 }},
		{ "wardrobe",6.43,-1851.37,1.99 }
	}},
	["nidoran"] = {{
		{ "entry",-14.87,-1831.24,1.99 },
		{ "chest",-17.82,-1840.17,1.99,_config = { weight = 150, name = 29 }},
		{ "wardrobe",-12.88,-1835.49,1.99 }
	}},
	["nidorina"] = {{
		{ "entry",-34.06,-1815.57,1.99 },
		{ "chest",-36.92,-1824.50,1.99,_config = { weight = 150, name = 30 }},
		{ "wardrobe",-32.05,-1819.83,1.99 }
	}},
	["nidoqueen"] = {{
		{ "entry",-53.85,-1799.33,1.99 },
		{ "chest",-56.70,-1808.32,1.99,_config = { weight = 150, name = 31 }},
		{ "wardrobe",-51.84,-1803.63,1.99 }
	}},
	["nidorino"] = {{
		{ "entry",-73.58,-1783.29,1.99 },
		{ "chest",-76.46,-1792.20,1.99,_config = { weight = 150, name = 32 }},
		{ "wardrobe",-71.53,-1787.48,1.99 }
	}},
	["nidoking"] = {{
		{ "entry",-93.25,-1767.12,1.99 },
		{ "chest",-96.15,-1776.10,1.99,_config = { weight = 150, name = 33 }},
		{ "wardrobe",-91.29,-1771.44,1.99 }
	}},
	["clefairy"] = {{
		{ "entry",1396.71,1141.81,114.33 },
		{ "chest",1404.01,1150.06,114.33,_config = { weight = 500, name = 34 }},
		{ "wardrobe",1399.85,1139.65,114.33 }
	}},
	["vulpix"] = {{
		{ "entry",-815.75,178.62,72.15 },
		{ "chest",-808.46,175.21,76.74,_config = { weight = 1500, name = 36 }},
		{ "wardrobe",-811.63,175.09,76.74 }
	}},
	["ninetales"] = {{
		{ "entry",-174.16,497.61,137.66 },
		{ "chest",-174.47,493.61,130.04,_config = { weight = 500, name = 37 }},
		{ "wardrobe",-167.38,487.78,133.84 }
	}},
	["jigglypuff"] = {{
		{ "entry",342.02,437.68,149.39 },
		{ "chest",338.12,436.87,141.77,_config = { weight = 500, name = 38 }},
		{ "wardrobe",334.22,428.44,145.57 }
	}},
	["wigglytuff"] = {{
		{ "entry",373.69,423.48,145.90 },
		{ "chest",377.02,429.11,138.30,_config = { weight = 500, name = 39 }},
		{ "wardrobe",374.48,411.57,142.10 }
	}},
	["zubat"] = {{
		{ "entry",-682.25,592.51,145.39 },
		{ "chest",-680.61,589.02,137.76,_config = { weight = 500, name = 40 }},
		{ "wardrobe",-671.41,587.25,141.56 }
	}},
	["golbat"] = {{
		{ "entry",-758.46,618.90,144.15 },
		{ "chest",-762.36,618.66,136.53,_config = { weight = 500, name = 41 }},
		{ "wardrobe",-767.38,610.83,140.33 }
	}},
	["oddish"] = {{
		{ "entry",-859.87,691.23,152.86 },
		{ "chest",-858.41,697.45,145.25,_config = { weight = 500, name = 42 }},
		{ "wardrobe",-855.35,679.94,149.05 }
	}},
	["gloom"] = {{
		{ "entry",117.30,559.73,184.30 },
		{ "chest",118.50,566.17,176.69,_config = { weight = 500, name = 43 }},
		{ "wardrobe",122.13,548.71,180.49 }
	}},
	["vileplume"] = {{
		{ "entry",-1289.69,449.66,97.90 },
		{ "chest",-1287.86,455.73,90.29,_config = { weight = 500, name = 44 }},
		{ "wardrobe",-1286.07,437.98,94.09 }
	}},
	["paras"] = {{
		{ "entry",-87.95,6361.65,16.00 },
		{ "chest",-91.40,6364.98,16.00,_config = { weight = 25, name = 45 }},
		{ "wardrobe",-92.37,6366.54,16.00 }
	}},
	["parasect"] = {{
		{ "entry",-87.91,6361.59,11.00 },
		{ "chest",-91.45,6364.99,11.00,_config = { weight = 25, name = 46 }},
		{ "wardrobe",-92.33,6366.54,11.00 }
	}},
	["venonat"] = {{
		{ "entry",-94.73,6354.60,16.00 },
		{ "chest",-98.29,6357.90,16.00,_config = { weight = 25, name = 47 }},
		{ "wardrobe",-99.24,6359.47,16.00 }
	}},
	["venomoth"] = {{
		{ "entry",-94.69,6354.51,11.00 },
		{ "chest",-98.22,6357.90,11.00,_config = { weight = 25, name = 48 }},
		{ "wardrobe",-99.27,6359.50,11.00 }
	}},
	["diglett"] = {{
		{ "entry",-101.76,6347.31,16.00 },
		{ "chest",-105.35,6350.72,16.00,_config = { weight = 25, name = 49 }},
		{ "wardrobe",-106.27,6352.25,16.00 }
	}},
	["dugtrio"] = {{
		{ "entry",-101.76,6347.28,11.00 },
		{ "chest",-105.35,6350.70,11.00,_config = { weight = 25, name = 50 }},
		{ "wardrobe",-106.31,6352.28,11.00 }
	}},
	["meowth"] = {{
		{ "entry",-107.99,6340.91,16.00 },
		{ "chest",-111.53,6344.37,16.00,_config = { weight = 25, name = 51 }},
		{ "wardrobe",-112.46,6345.86,16.00 }
	}},
	["persian"] = {{
		{ "entry",-107.99,6340.91,11.00 },
		{ "chest",-111.53,6344.37,11.00,_config = { weight = 25, name = 52 }},
		{ "wardrobe",-112.46,6345.86,11.00 }
	}},
	["psyduck"] = {{
		{ "entry",-114.15,6334.62,16.00 },
		{ "chest",-117.73,6338.02,16.00,_config = { weight = 25, name = 53 }},
		{ "wardrobe",-118.67,6339.58,16.00 }
	}},
	["golduck"] = {{
		{ "entry",-114.15,6334.62,11.00 },
		{ "chest",-117.73,6338.02,11.00,_config = { weight = 25, name = 54 }},
		{ "wardrobe",-118.67,6339.58,11.00 }
	}},
	["mankey"] = {{
		{ "entry",-120.62,6328.02,16.00 },
		{ "chest",-124.23,6331.42,16.00,_config = { weight = 25, name = 55 }},
		{ "wardrobe",-125.15,6332.97,16.00 }
	}},
	["primeape"] = {{
		{ "entry",-120.62,6328.02,11.00 },
		{ "chest",-124.23,6331.42,11.00,_config = { weight = 25, name = 56 }},
		{ "wardrobe",-125.15,6332.97,11.00 }
	}},
	["growlithe"] = {{
		{ "entry",-126.64,6321.85,16.00 },
		{ "chest",-130.21,6325.28,16.00,_config = { weight = 25, name = 57 }},
		{ "wardrobe",-131.19,6326.85,16.00 }
	}},
	["arcanine"] = {{
		{ "entry",-126.64,6321.85,11.00 },
		{ "chest",-130.21,6325.28,11.00,_config = { weight = 25, name = 58 }},
		{ "wardrobe",-131.19,6326.85,11.00 }
	}},
	["poliwag"] = {{
		{ "entry",-132.75,6315.61,16.00 },
		{ "chest",-136.34,6319.01,16.00,_config = { weight = 25, name = 59 }},
		{ "wardrobe",-137.23,6320.54,16.00 }
	}},
	["poliwhirl"] = {{
		{ "entry",-132.75,6315.61,11.00 },
		{ "chest",-136.34,6319.01,11.00,_config = { weight = 25, name = 60 }},
		{ "wardrobe",-137.23,6320.54,11.00 }
	}},
	["poliwrath"] = {{
		{ "entry",-138.95,6309.41,16.00 },
		{ "chest",-142.52,6312.75,16.00,_config = { weight = 25, name = 61 }},
		{ "wardrobe",-143.43,6314.30,16.00 }
	}},
	["abra"] = {{
		{ "entry",-138.95,6309.41,11.00 },
		{ "chest",-142.52,6312.75,11.00,_config = { weight = 25, name = 62 }},
		{ "wardrobe",-143.43,6314.30,11.00 }
	}},
	["kadabra"] = {{
		{ "entry",-144.92,6303.16,16.00 },
		{ "chest",-148.51,6306.57,16.00,_config = { weight = 25, name = 63 }},
		{ "wardrobe",-149.44,6308.17,16.00 }
	}},
	["alakazam"] = {{
		{ "entry",-144.92,6303.16,11.00 },
		{ "chest",-148.51,6306.57,11.00,_config = { weight = 25, name = 64 }},
		{ "wardrobe",-149.44,6308.17,11.00 }
	}},
	["machop"] = {{
		{ "entry",-151.18,6296.80,16.00 },
		{ "chest",-154.77,6300.20,16.00,_config = { weight = 25, name = 65 }},
		{ "wardrobe",-155.67,6301.72,16.00 }
	}},
	["machoke"] = {{
		{ "entry",-1507.75,450.26,100.80 },
		{ "chest",-1501.74,436.26,100.80,_config = { weight = 500, name = 66 }},
		{ "wardrobe",-1497.54,432.94,100.80 }
	}},
	["machamp"] = {{
		{ "entry",-1407.78,529.24,100.80 },
		{ "chest",-1393.60,523.38,100.80,_config = { weight = 500, name = 67 }},
		{ "wardrobe",-1388.25,523.92,100.80 }
	}},
	["bellsprout"] = {{
		{ "entry",-1362.79,612.81,100.80 },
		{ "chest",-1377.95,615.54,100.80,_config = { weight = 500, name = 68 }},
		{ "wardrobe",-1383.06,613.89,100.80 }
	}},
	["weepinbell"] = {{
		{ "entry",-970.45,755.67,135.32 },
		{ "chest",-963.83,741.71,135.32,_config = { weight = 500, name = 69 }},
		{ "wardrobe",-959.57,738.53,135.32 }
	}},
	["victreebel"] = {{
		{ "entry",-447.07,684.94,121.58 },
		{ "chest",-448.59,700.26,121.58,_config = { weight = 500, name = 70 }},
		{ "wardrobe",-451.59,704.72,121.58 }
	}},
	["tentacool"] = {{
		{ "entry",1375.87,-571.70,50.80 },
		{ "chest",1364.30,-581.76,50.80,_config = { weight = 250, name = 71 }},
		{ "wardrobe",1362.41,-586.64,50.80 }
	}},
	["tentacruel"] = {{
		{ "entry",1350.90,-558.02,50.80 },
		{ "chest",1339.25,-568.10,50.80,_config = { weight = 250, name = 72 }},
		{ "wardrobe",1337.34,-573.11,50.80 }
	}},
	["geodude"] = {{
		{ "entry",1326.22,-544.62,50.80 },
		{ "chest",1314.59,-554.66,50.80,_config = { weight = 250, name = 73 }},
		{ "wardrobe",1312.64,-559.70,50.80 }
	}},
	["graveler"] = {{
		{ "entry",1302.17,-531.59,50.80 },
		{ "chest",1290.47,-541.63,50.80,_config = { weight = 250, name = 74 }},
		{ "wardrobe",1288.54,-546.62,50.80 }
	}},
	["golem"] = {{
		{ "entry",1277.94,-518.41,50.80 },
		{ "chest",1266.26,-528.45,50.80,_config = { weight = 250, name = 75 }},
		{ "wardrobe",1264.32,-533.41,50.80 }
	}},
	["ponyta"] = {{
		{ "entry",1375.87,-571.70,35.80 },
		{ "chest",1364.30,-581.76,35.80,_config = { weight = 250, name = 76 }},
		{ "wardrobe",1362.41,-586.64,35.80 }
	}},
	["rapidash"] = {{
		{ "entry",1350.90,-558.02,35.80 },
		{ "chest",1339.25,-568.10,35.80,_config = { weight = 250, name = 77 }},
		{ "wardrobe",1337.34,-573.11,35.80 }
	}},
	["slowpoke"] = {{
		{ "entry",1326.22,-544.62,35.80 },
		{ "chest",1314.59,-554.66,35.80,_config = { weight = 250, name = 78 }},
		{ "wardrobe",1312.64,-559.70,35.80 }
	}},
	["slowbro"] = {{
		{ "entry",1302.17,-531.59,35.80 },
		{ "chest",1290.47,-541.63,35.80,_config = { weight = 250, name = 79 }},
		{ "wardrobe",1288.54,-546.62,35.80 }
	}},
	["magnemite"] = {{
		{ "entry",1277.94,-518.41,35.80 },
		{ "chest",1266.26,-528.45,35.80,_config = { weight = 250, name = 80 }},
		{ "wardrobe",1264.32,-533.41,35.80 }
	}},
	["magneton"] = {{
		{ "entry",-14.30,-1440.74,31.10 },
		{ "chest",-17.73,-1432.10,31.10,_config = { weight = 400, name = 81 }},
		{ "wardrobe",-18.53,-1438.78,31.10 }
	}},
	["farfetch"] = {{
		{ "entry",-107.76,-8.26,70.51 },
		{ "chest",-108.96,-9.91,70.51,_config = { weight = 200, name = 82 }},
		{ "wardrobe",-110.60,-14.61,70.51 }
	}},
	["doduo"] = {{
		{ "entry",7.95,538.72,176.02 },
		{ "chest",-6.94,530.56,174.99,_config = { weight = 750, name = 83 }},
		{ "wardrobe",8.60,528.60,170.63 }
	}},
	["dodrio"] = {{
		{ "entry",407.57,-2005.91,1.80 },
		{ "chest",395.97,-2015.63,1.80,_config = { weight = 150, name = 84 }},
		{ "wardrobe",394.02,-2020.60,1.80 }
	}},
	["seel"] = {{
		{ "entry",384.53,-1993.27,1.80 },
		{ "chest",372.95,-2003.14,1.80,_config = { weight = 150, name = 85 }},
		{ "wardrobe",370.97,-2008.09,1.80 }
	}},
	["dewgong"] = {{
		{ "entry",361.04,-1980.58,1.80 },
		{ "chest",349.41,-1990.32,1.80,_config = { weight = 150, name = 86 }},
		{ "wardrobe",347.46,-1995.35,1.80 }
	}},
	["grimer"] = {{
		{ "entry",338.05,-1968.12,1.80 },
		{ "chest",326.45,-1977.86,1.80,_config = { weight = 150, name = 87 }},
		{ "wardrobe",324.51,-1982.80,1.80 }
	}},
	["muk"] = {{
		{ "entry",389.62,-2038.86,1.80 },
		{ "chest",378.02,-2048.78,1.80,_config = { weight = 150, name = 88 }},
		{ "wardrobe",376.08,-2053.72,1.80 }
	}},
	["shellder"] = {{
		{ "entry",366.10,-2026.15,1.80 },
		{ "chest",354.52,-2036.02,1.80,_config = { weight = 150, name = 89 }},
		{ "wardrobe",352.56,-2040.87,1.80 }
	}},
	["cloyster"] = {{
		{ "entry",342.06,-2013.13,1.80 },
		{ "chest",330.43,-2022.90,1.80,_config = { weight = 150, name = 90 }},
		{ "wardrobe",328.48,-2027.85,1.80 }
	}},
	["gastly"] = {{
		{ "entry",317.16,-1999.60,1.80 },
		{ "chest",305.57,-2009.40,1.80,_config = { weight = 150, name = 91 }},
		{ "wardrobe",303.60,-2014.26,1.80 }
	}},
	["haunter"] = {{
		{ "entry",375.86,-2065.37,1.80 },
		{ "chest",364.39,-2075.11,1.80,_config = { weight = 150, name = 92 }},
		{ "wardrobe",362.38,-2080.03,1.80 }
	}},
	["gengar"] = {{
		{ "entry",352.24,-2052.55,1.80 },
		{ "chest",340.68,-2062.17,1.80,_config = { weight = 150, name = 93 }},
		{ "wardrobe",338.72,-2067.10,1.80 }
	}},
	["onix"] = {{
		{ "entry",328.33,-2039.42,1.80 },
		{ "chest",316.73,-2049.22,1.80,_config = { weight = 150, name = 94 }},
		{ "wardrobe",314.73,-2054.15,1.80 }
	}},
	["drowzee"] = {{
		{ "entry",304.12,-2026.30,1.80 },
		{ "chest",292.57,-2036.05,1.80,_config = { weight = 150, name = 95 }},
		{ "wardrobe",290.60,-2041.05,1.80 }
	}},
	["hypno"] = {{
		{ "entry",360.10,-2094.44,1.80 },
		{ "chest",348.53,-2104.30,1.80,_config = { weight = 150, name = 96 }},
		{ "wardrobe",346.53,-2109.25,1.80 }
	}},
	["krabby"] = {{
		{ "entry",335.87,-2081.38,1.80 },
		{ "chest",324.29,-2091.09,1.80,_config = { weight = 150, name = 97 }},
		{ "wardrobe",322.32,-2096.10,1.80 }
	}},
	["kingler"] = {{
		{ "entry",313.21,-2068.98,1.80 },
		{ "chest",301.59,-2078.80,1.80,_config = { weight = 150, name = 98 }},
		{ "wardrobe",299.68,-2083.68,1.80 }
	}},
	["voltorb"] = {{
		{ "entry",289.76,-2056.31,1.80 },
		{ "chest",278.19,-2066.06,1.80,_config = { weight = 150, name = 99 }},
		{ "wardrobe",276.26,-2070.98,1.80 }
	}},
	["electrode"] = {{
		{ "entry",407.57,-2005.91,-4.80 },
		{ "chest",395.97,-2015.63,-4.80,_config = { weight = 150, name = 100 }},
		{ "wardrobe",394.02,-2020.60,-4.80 }
	}},
	["exeggcute"] = {{
		{ "entry",384.53,-1993.27,-4.80 },
		{ "chest",372.95,-2003.14,-4.80,_config = { weight = 150, name = 101 }},
		{ "wardrobe",370.97,-2008.09,-4.80 }
	}},
	["exeggutor"] = {{
		{ "entry",361.04,-1980.58,-4.80 },
		{ "chest",349.41,-1990.32,-4.80,_config = { weight = 150, name = 102 }},
		{ "wardrobe",347.46,-1995.35,-4.80 }
	}},
	["cubone"] = {{
		{ "entry",338.05,-1968.12,-4.80 },
		{ "chest",326.45,-1977.86,-4.80,_config = { weight = 150, name = 103 }},
		{ "wardrobe",324.51,-1982.80,-4.80 }
	}},
	["marowak"] = {{
		{ "entry",389.62,-2038.86,-4.80 },
		{ "chest",378.02,-2048.78,-4.80,_config = { weight = 150, name = 104 }},
		{ "wardrobe",376.08,-2053.72,-4.80 }
	}},
	["hitmonlee"] = {{
		{ "entry",366.10,-2026.15,-4.80 },
		{ "chest",354.52,-2036.02,-4.80,_config = { weight = 150, name = 105 }},
		{ "wardrobe",352.56,-2040.87,-4.80 }
	}},
	["hitmonchan"] = {{
		{ "entry",342.06,-2013.13,-4.80 },
		{ "chest",330.431,-2022.90,-4.80,_config = { weight = 150, name = 106 }},
		{ "wardrobe",328.48,-2027.85,-4.80 }
	}},
	["lickitung"] = {{
		{ "entry",317.16,-1999.60,-4.80 },
		{ "chest",305.57,-2009.40,-4.80,_config = { weight = 150, name = 107 }},
		{ "wardrobe",303.60,-2014.26,-4.80 }
	}},
	["koffing"] = {{
		{ "entry",375.86,-2065.37,-4.80 },
		{ "chest",364.39,-2075.11,-4.80,_config = { weight = 150, name = 108 }},
		{ "wardrobe",362.38,-2080.03,-4.80 }
	}},
	["weezing"] = {{
		{ "entry",352.24,-2052.55,-4.80 },
		{ "chest",340.68,-2062.17,-4.80,_config = { weight = 150, name = 109 }},
		{ "wardrobe",338.72,-2067.10,-4.80 }
	}},
	["rhyhorn"] = {{
		{ "entry",328.33,-2039.42,-4.80 },
		{ "chest",316.73,-2049.22,-4.80,_config = { weight = 150, name = 110 }},
		{ "wardrobe",314.73,-2054.15,-4.80 }
	}},
	["rhydon"] = {{
		{ "entry",304.12,-2026.30,-4.80 },
		{ "chest",292.57,-2036.05,-4.80,_config = { weight = 150, name = 111 }},
		{ "wardrobe",290.60,-2041.05,-4.80 }
	}},
	["chansey"] = {{
		{ "entry",360.10,-2094.44,-4.80 },
		{ "chest",348.53,-2104.30,-4.80,_config = { weight = 150, name = 112 }},
		{ "wardrobe",346.53,-2109.25,-4.80 }
	}},
	["tangela"] = {{
		{ "entry",335.87,-2081.38,-4.80 },
		{ "chest",324.29,-2091.09,-4.80,_config = { weight = 150, name = 113 }},
		{ "wardrobe",322.32,-2096.10,-4.80 }
	}},
	["kangaskhan"] = {{
		{ "entry",313.21,-2068.98,-4.80 },
		{ "chest",301.59,-2078.80,-4.80,_config = { weight = 150, name = 114 }},
		{ "wardrobe",299.68,-2083.68,-4.80 }
	}},
	["horsea"] = {{
		{ "entry",289.76,-2056.31,-4.80 },
		{ "chest",278.19,-2066.06,-4.80,_config = { weight = 150, name = 115 }},
		{ "wardrobe",276.26,-2070.98,-4.80 }
	}},

	["seadra"] = {{
		{ "entry",308.09,-182.68,31.00 },
		{ "chest",312.52,-184.31,31.00,_config = { weight = 25, name = 116 }},
		{ "wardrobe",314.11,-185.49,31.00 }
	}},
	["goldeen"] = {{
		{ "entry",304.23,-192.74,31.00 },
		{ "chest",308.75,-194.50,31.00,_config = { weight = 25, name = 117 }},
		{ "wardrobe",310.14,-195.45,31.00 }
	}},
	["seaking"] = {{
		{ "entry",300.37,-203.08,31.00 },
		{ "chest",304.85,-204.83,31.00,_config = { weight = 25, name = 118 }},
		{ "wardrobe",306.34,-205.77,31.00 }
	}},
	["staryu"] = {{
		{ "entry",296.62,-213.20,31.00 },
		{ "chest",300.99,-214.96,31.00,_config = { weight = 25, name = 119 }},
		{ "wardrobe",302.45,-215.88,31.00 }
	}},
	["starmie"] = {{
		{ "entry",318.24,-186.52,31.00 },
		{ "chest",322.66,-188.28,31.00,_config = { weight = 25, name = 120 }},
		{ "wardrobe",324.21,-189.26,31.00 }
	}},
	["mrmime"] = {{
		{ "entry",314.27,-197.37,31.00 },
		{ "chest",318.58,-199.15,31.00,_config = { weight = 25, name = 121 }},
		{ "wardrobe",320.15,-200.13,31.00 }
	}},
	["scyther"] = {{
		{ "entry",310.38,-207.66,31.00 },
		{ "chest",314.74,-209.42,31.00,_config = { weight = 25, name = 122 }},
		{ "wardrobe",316.27,-210.42,31.00 }
	}},
	["jynx"] = {{
		{ "entry",306.37,-218.41,31.00 },
		{ "chest",310.68,-220.08,31.00,_config = { weight = 25, name = 123 }},
		{ "wardrobe",312.23,-221.13,31.00 }
	}},
	["electabuzz"] = {{
		{ "entry",324.37,-200.58,31.00 },
		{ "chest",328.87,-202.31,31.00,_config = { weight = 25, name = 124 }},
		{ "wardrobe",330.30,-203.32,31.00 }
	}},
	["magmar"] = {{
		{ "entry",320.58,-210.81,31.00 },
		{ "chest",324.97,-212.49,31.00,_config = { weight = 25, name = 125 }},
		{ "wardrobe",326.51,-213.48,31.00 }
	}},
	["pinsir"] = {{
		{ "entry",316.88,-220.81,31.00 },
		{ "chest",321.21,-222.61,31.00,_config = { weight = 25, name = 126 }},
		{ "wardrobe",322.77,-223.55,31.00 }
	}},
	["taurus"] = {{
		{ "entry",334.10,-204.02,31.00 },
		{ "chest",338.58,-205.71,31.00,_config = { weight = 25, name = 127 }},
		{ "wardrobe",340.01,-206.74,31.00 }
	}},
	["magikarp"] = {{
		{ "entry",330.48,-213.85,31.00 },
		{ "chest",334.86,-215.61,31.00,_config = { weight = 25, name = 128 }},
		{ "wardrobe",336.38,-216.59,31.00 }
	}},
	["gyarados"] = {{
		{ "entry",326.40,-224.67,31.00 },
		{ "chest",330.86,-226.31,31.00,_config = { weight = 25, name = 129 }},
		{ "wardrobe",332.29,-227.41,31.00 }
	}},
	["lapras"] = {{
		{ "entry",348.25,-197.77,31.00 },
		{ "chest",352.58,-199.54,31.00,_config = { weight = 25, name = 130 }},
		{ "wardrobe",354.11,-200.51,31.00 }
	}},
	["ditto"] = {{
		{ "entry",344.32,-208.30,31.00 },
		{ "chest",348.68,-209.98,31.00,_config = { weight = 25, name = 131 }},
		{ "wardrobe",350.19,-210.95,31.00 }
	}},
	["eevee"] = {{
		{ "entry",340.45,-218.61,31.00 },
		{ "chest",344.78,-220.32,31.00,_config = { weight = 25, name = 132 }},
		{ "wardrobe",346.27,-221.33,31.00 }
	}},
	["vaporeon"] = {{
		{ "entry",336.54,-228.78,31.00 },
		{ "chest",340.93,-230.52,31.00,_config = { weight = 25, name = 133 }},
		{ "wardrobe",342.47,-231.47,31.00 }
	}},
	["jolteon"] = {{
		{ "entry",308.09,-182.68,21.00 },
		{ "chest",312.52,-184.31,21.00,_config = { weight = 25, name = 134 }},
		{ "wardrobe",314.11,-185.49,21.00 }
	}},
	["flareon"] = {{
		{ "entry",304.23,-192.74,21.00 },
		{ "chest",308.75,-194.50,21.00,_config = { weight = 25, name = 135 }},
		{ "wardrobe",310.14,-195.45,21.00 }
	}},
	["porygon"] = {{
		{ "entry",300.37,-203.08,21.00 },
		{ "chest",304.85,-204.83,21.00,_config = { weight = 25, name = 136 }},
		{ "wardrobe",306.34,-205.77,21.00 }
	}},
	["omanyte"] = {{
		{ "entry",296.62,-213.20,21.00 },
		{ "chest",300.99,-214.96,21.00,_config = { weight = 25, name = 137 }},
		{ "wardrobe",302.45,-215.88,21.00 }
	}},
	["omastar"] = {{
		{ "entry",318.24,-186.52,21.00 },
		{ "chest",322.66,-188.28,21.00,_config = { weight = 25, name = 138 }},
		{ "wardrobe",324.21,-189.26,21.00 }
	}},
	["kabuto"] = {{
		{ "entry",314.27,-197.37,21.00 },
		{ "chest",318.58,-199.15,21.00,_config = { weight = 25, name = 139 }},
		{ "wardrobe",320.15,-200.13,21.00 }
	}},
	["kabutops"] = {{
		{ "entry",310.38,-207.66,21.00 },
		{ "chest",314.74,-209.42,21.00,_config = { weight = 25, name = 140 }},
		{ "wardrobe",316.27,-210.42,21.00 }
	}},
	["aerodactyl"] = {{
		{ "entry",306.37,-218.41,21.00 },
		{ "chest",310.68,-220.08,21.00,_config = { weight = 25, name = 141 }},
		{ "wardrobe",312.23,-221.13,21.00 }
	}},
	["snorlax"] = {{
		{ "entry",324.37,-200.58,21.00 },
		{ "chest",328.87,-202.31,21.00,_config = { weight = 25, name = 142 }},
		{ "wardrobe",330.30,-203.32,21.00 }
	}},
	["articuno"] = {{
		{ "entry",320.58,-210.81,21.00 },
		{ "chest",324.97,-212.49,21.00,_config = { weight = 25, name = 143 }},
		{ "wardrobe",326.51,-213.48,21.00 }
	}},
	["zapdos"] = {{
		{ "entry",316.88,-220.81,21.00 },
		{ "chest",321.21,-222.61,21.00,_config = { weight = 25, name = 144 }},
		{ "wardrobe",322.77,-223.55,21.00 }
	}},
	["moltres"] = {{
		{ "entry",334.10,-204.02,21.00 },
		{ "chest",338.58,-205.71,21.00,_config = { weight = 25, name = 145 }},
		{ "wardrobe",340.01,-206.74,21.00 }
	}},
	["dratini"] = {{
		{ "entry",330.48,-213.85,21.00 },
		{ "chest",334.86,-215.61,21.00,_config = { weight = 25, name = 146 }},
		{ "wardrobe",336.38,-216.59,21.00 }
	}},
	["dragonair"] = {{
		{ "entry",326.40,-224.67,21.00 },
		{ "chest",330.86,-226.31,21.00,_config = { weight = 25, name = 147 }},
		{ "wardrobe",332.29,-227.41,21.00 }
	}},
	["dragonite"] = {{
		{ "entry",348.25,-197.77,21.00 },
		{ "chest",352.58,-199.54,21.00,_config = { weight = 25, name = 148 }},
		{ "wardrobe",354.11,-200.51,21.00 }
	}},
	["mewtwo"] = {{
		{ "entry",344.32,-208.30,21.00 },
		{ "chest",348.68,-209.98,21.00,_config = { weight = 25, name = 149 }},
		{ "wardrobe",350.19,-210.95,21.00 }
	}},
	["mew"] = {{
		{ "entry",340.45,-218.61,21.00 },
		{ "chest",344.78,-220.32,21.00,_config = { weight = 25, name = 150 }},
		{ "wardrobe",346.27,-221.33,21.00 }
	}},
	["chikorita"] = {{
		{ "entry",336.54,-228.78,21.00 },
		{ "chest",340.93,-230.52,21.00,_config = { weight = 25, name = 151 }},
		{ "wardrobe",342.47,-231.47,21.00 }
	}},
	["bayleef"] = {{
		{ "entry",308.09,-182.68,11.00 },
		{ "chest",312.52,-184.31,11.00,_config = { weight = 25, name = 152 }},
		{ "wardrobe",314.11,-185.49,11.00 }
	}},
	["meganium"] = {{
		{ "entry",304.23,-192.74,11.00 },
		{ "chest",308.75,-194.50,11.00,_config = { weight = 25, name = 153 }},
		{ "wardrobe",310.14,-195.45,11.00 }
	}},
	["cyndaquil"] = {{
		{ "entry",300.37,-203.08,11.00 },
		{ "chest",304.85,-204.83,11.00,_config = { weight = 25, name = 154 }},
		{ "wardrobe",306.34,-205.77,11.00 }
	}},
	["praiana"] = {{
		{ "entry",-1150.9696044922,-1520.5335693359,10.632717132568 },
		{ "chest",-1152.2790527344,-1519.0157470703,10.632717132568,_config = { weight = 25, name = 155 }},
		{ "wardrobe",-1145.2879638672,-1514.3701171875, 10.632729530334 }
	}}
}

cfg.homes = {
	["Bulbasaur"] = {
		slot = "bulbasaur",
		entry_point = { -772.72,312.78,85.69 },
		buy_price = 500000, max_people = 5,
		sell_price = 350000,
		max = 99
	},
	["Ivysaur"] = {
		slot = "ivysaur",
		entry_point = { 169.90,-567.56,43.87 },
		buy_price = 500000, max_people = 5,
		sell_price = 350000,
		max = 99
	},
	["Venusaur"] = {
		slot = "venusaur",
		entry_point = { -1288.22,-430.35,35.16 },
		buy_price = 500000, max_people = 5,
		sell_price = 350000,
		max = 99
	},
	["Charmander"] = {
		slot = "charmander",
		entry_point = { 255.20,-1013.37,29.26 },
		buy_price = 100000, max_people = 1,
		sell_price = 70000,
		max = 99
	},
	["Charmeleon"] = {
		slot = "charmeleon",
		entry_point = { -47.32,-585.99,37.95 },
		buy_price = 400000, max_people = 4,
		sell_price = 280000,
		max = 99
	},
	["Charizard"] = {
		slot = "charizard",
		entry_point = { -470.74,-679.52,32.71 },
		buy_price = 300000, max_people = 3,
		sell_price = 210000,
		max = 99
	},
	["Squirtle"] = {
		slot = "squirtle",
		entry_point = { -1447.56,-537.48,34.74 },
		buy_price = 700000, max_people = 7,
		sell_price = 490000,
		max = 99
	},
	["Wartortle"] = {
		slot = "wartortle",
		entry_point = { -1038.76,-756.51,19.83 },
		buy_price = 450000, max_people = 4,
		sell_price = 315000,
		max = 99
	},
	["Blastoise"] = {
		slot = "blastoise",
		entry_point = { -935.87,-378.89,38.96 },
		buy_price = 500000, max_people = 5,
		sell_price = 350000,
		max = 99
	},
	["Caterpie"] = {
		slot = "caterpie",
		entry_point = { -614.61,46.56,43.59 },
		buy_price = 350000, max_people = 3,
		sell_price = 245000,
		max = 99
	},
	["Metapod"] = {
		slot = "metapod",
		entry_point = { -310.14,221.56,87.92 },
		buy_price = 600000, max_people = 6,
		sell_price = 420000,
		max = 99
	},
	["Butterfree"] = {
		slot = "butterfree",
		entry_point = { -34.20,-1847.02,26.19 },
		buy_price = 300000, max_people = 3,
		sell_price = 210000,
		max = 1
	},
	["Weedle"] = {
		slot = "weedle",
		entry_point = { -20.62,-1858.82,25.40 },
		buy_price = 300000, max_people = 3,
		sell_price = 210000,
		max = 1
	},
	["Kakuna"] = {
		slot = "kakuna",
		entry_point = { -4.95,-1872.08,24.15 },
		buy_price = 300000, max_people = 3,
		sell_price = 210000,
		max = 1
	},
	["Beedrill"] = {
		slot = "beedrill",
		entry_point = { 23.18,-1896.54,22.96 },
		buy_price = 300000, max_people = 3,
		sell_price = 210000,
		max = 1
	},
	["Pidgey"] = {
		slot = "pidgey",
		entry_point = { 39.24,-1911.63,21.95 },
		buy_price = 300000, max_people = 3,
		sell_price = 210000,
		max = 1
	},
	["Pidgeotto"] = {
		slot = "pidgeotto",
		entry_point = { 56.64,-1922.50,21.91 },
		buy_price = 300000, max_people = 3,
		sell_price = 210000,
		max = 1
	},
	["Pidgeot"] = {
		slot = "pidgeot",
		entry_point = { 72.11,-1939.04,21.36 },
		buy_price = 300000, max_people = 3,
		sell_price = 210000,
		max = 1
	},
	["Rattata"] = {
		slot = "rattata",
		entry_point = { 76.53,-1948.19,21.17 },
		buy_price = 300000, max_people = 3,
		sell_price = 210000,
		max = 1
	},
	["Raticate"] = {
		slot = "raticate",
		entry_point = { 85.59,-1959.67,21.12 },
		buy_price = 300000, max_people = 3,
		sell_price = 210000,
		max = 1
	},
	["Spearow"] = {
		slot = "spearow",
		entry_point = { 114.21,-1961.01,21.33 },
		buy_price = 300000, max_people = 3,
		sell_price = 210000,
		max = 1
	},
	["Fearow"] = {
		slot = "fearow",
		entry_point = { 144.24,-1969.04,18.85 },
		buy_price = 300000, max_people = 3,
		sell_price = 210000,
		max = 1
	},
	["Ekans"] = {
		slot = "ekans",
		entry_point = { 148.85,-1960.51,19.45 },
		buy_price = 300000, max_people = 3,
		sell_price = 210000,
		max = 1
	},
	["Arbok"] = {
		slot = "arbok",
		entry_point = { 165.28,-1944.99,20.23 },
		buy_price = 300000, max_people = 3,
		sell_price = 210000,
		max = 1
	},
	["Pikachu"] = {
		slot = "pikachu",
		entry_point = { 179.17,-1924.14,21.37 },
		buy_price = 300000, max_people = 3,
		sell_price = 210000,
		max = 1
	},
	["Raichu"] = {
		slot = "raichu",
		entry_point = { 148.72,-1904.33,23.53 },
		buy_price = 300000, max_people = 3,
		sell_price = 210000,
		max = 1
	},
	["Sandshrew"] = {
		slot = "sandshrew",
		entry_point = { 126.58,-1929.87,21.38 },
		buy_price = 300000, max_people = 3,
		sell_price = 210000,
		max = 1
	},
	["Sandslash"] = {
		slot = "sandslash",
		entry_point = { 118.16,-1920.95,21.32 },
		buy_price = 300000, max_people = 3,
		sell_price = 210000,
		max = 1
	},
	["Nidoran"] = {
		slot = "nidoran",
		entry_point = { 101.06,-1912.26,21.40 },
		buy_price = 300000, max_people = 3,
		sell_price = 210000,
		max = 1
	},
	["Nidorina"] = {
		slot = "nidorina",
		entry_point = { 115.14,-1887.88,23.92 },
		buy_price = 300000, max_people = 3,
		sell_price = 210000,
		max = 1
	},
	["Nidoqueen"] = {
		slot = "nidoqueen",
		entry_point = { 104.11,-1885.18,24.31 },
		buy_price = 300000, max_people = 3,
		sell_price = 210000,
		max = 1
	},
	["Nidorino"] = {
		slot = "nidorino",
		entry_point = { 128.18,-1897.06,23.67 },
		buy_price = 300000, max_people = 3,
		sell_price = 210000,
		max = 1
	},
	["Nidoking"] = {
		slot = "nidoking",
		entry_point = { 5.26,-1884.31,23.69 },
		buy_price = 300000, max_people = 3,
		sell_price = 210000,
		max = 1
	},
	["Vulpix"] = {
		slot = "vulpix",
		entry_point = { -817.01,178.06,72.22 },
		buy_price = 8500000, max_people = 15,
		sell_price = 7500000,
		max = 1
	},
	["Clefairy"] = {
		slot = "clefairy",
		entry_point = { 1394.9603271484,1141.6575927734,114.62497711182 },
		buy_price = 1000000, max_people = 10,
		sell_price = 700000,
		max = 5
	},
	["Ninetales"] = {
		slot = "ninetales",
		entry_point = { -174.79,502.36,137.41 },
		buy_price = 1000000, max_people = 10,
		sell_price = 700000,
		max = 1
	},
	["Jigglypuff"] = {
		slot = "jigglypuff",
		entry_point = { 346.48,440.65,147.70 },
		buy_price = 1000000, max_people = 10,
		sell_price = 700000,
		max = 1
	},
	["Wigglytuff"] = {
		slot = "wigglytuff",
		entry_point = { 373.95,427.84,145.68 },
		buy_price = 1000000, max_people = 10,
		sell_price = 700000,
		max = 1
	},
	["Zubat"] = {
		slot = "zubat",
		entry_point = { -686.18,596.33,143.64 },
		buy_price = 1000000, max_people = 10,
		sell_price = 700000,
		max = 1
	},
	["Golbat"] = {
		slot = "golbat",
		entry_point = { -753.14,620.52,142.71 },
		buy_price = 1000000, max_people = 10,
		sell_price = 700000,
		max = 1
	},
	["Oddish"] = {
		slot = "oddish",
		entry_point = { -853.02,695.46,148.78 },
		buy_price = 1000000, max_people = 10,
		sell_price = 700000,
		max = 1
	},
	["Gloom"] = {
		slot = "gloom",
		entry_point = { 119.35,564.17,183.95 },
		buy_price = 1000000, max_people = 10,
		sell_price = 700000,
		max = 1
	},
	["Vileplume"] = {
		slot = "vileplume",
		entry_point = { -1308.17,448.89,100.96 },
		buy_price = 1000000, max_people = 10,
		sell_price = 700000,
		max = 1
	},

	["Paras"] = {
		slot = "paras",
		entry_point = { -84.83,6362.56,31.57 },
		buy_price = 50000, max_people = 0,
		sell_price = 35000,
		max = 1
	},
	["Parasect"] = {
		slot = "parasect",
		entry_point = { -90.26,6357.22,31.57 },
		buy_price = 50000, max_people = 0,
		sell_price = 35000,
		max = 1
	},
	["Venonat"] = {
		slot = "venonat",
		entry_point = { -93.54,6353.90,31.57 },
		buy_price = 50000, max_people = 0,
		sell_price = 35000,
		max = 1
	},
	["Venomoth"] = {
		slot = "venomoth",
		entry_point = { -98.96,6348.53,31.57 },
		buy_price = 50000, max_people = 0,
		sell_price = 35000,
		max = 1
	},
	["Diglett"] = {
		slot = "diglett",
		entry_point = { -107.61,6339.86,31.57 },
		buy_price = 50000, max_people = 0,
		sell_price = 35000,
		max = 1
	},
	["Dugtrio"] = {
		slot = "dugtrio",
		entry_point = { -106.70,6333.93,31.57 },
		buy_price = 50000, max_people = 0,
		sell_price = 35000,
		max = 1
	},
	["Meowth"] = {
		slot = "meowth",
		entry_point = { -103.43,6330.66,31.57 },
		buy_price = 50000, max_people = 0,
		sell_price = 35000,
		max = 1
	},
	["Persian"] = {
		slot = "persian",
		entry_point = { -103.39,6330.68,35.50 },
		buy_price = 50000, max_people = 0,
		sell_price = 35000,
		max = 1
	},
	["Psyduck"] = {
		slot = "psyduck",
		entry_point = { -106.65,6333.97,35.50 },
		buy_price = 50000, max_people = 0,
		sell_price = 35000,
		max = 1
	},
	["Golduck"] = {
		slot = "golduck",
		entry_point = { -107.63,6339.85,35.50 },
		buy_price = 50000, max_people = 0,
		sell_price = 35000,
		max = 1
	},
	["Mankey"] = {
		slot = "mankey",
		entry_point = { -102.21,6345.27,35.50 },
		buy_price = 50000, max_people = 0,
		sell_price = 35000,
		max = 1
	},
	["Primeape"] = {
		slot = "primeape",
		entry_point = { -98.94,6348.54,35.50 },
		buy_price = 50000, max_people = 0,
		sell_price = 35000,
		max = 1
	},
	["Growlithe"] = {
		slot = "growlithe",
		entry_point = { -93.52,6353.94,35.50 },
		buy_price = 50000, max_people = 0,
		sell_price = 35000,
		max = 1
	},
	["Arcanine"] = {
		slot = "arcanine",
		entry_point = { -90.25,6357.18,35.50 },
		buy_price = 50000, max_people = 0,
		sell_price = 35000,
		max = 1
	},
	["Poliwag"] = {
		slot = "poliwag",
		entry_point = { -84.88,6362.61,35.50 },
		buy_price = 50000, max_people = 0,
		sell_price = 35000,
		max = 1
	},
	["Poliwhirl"] = {
		slot = "poliwhirl",
		entry_point = { -111.15,6322.90,31.57 },
		buy_price = 50000, max_people = 0,
		sell_price = 35000,
		max = 1
	},
	["Poliwrath"] = {
		slot = "poliwrath",
		entry_point = { -114.31,6326.05,31.57 },
		buy_price = 50000, max_people = 0,
		sell_price = 35000,
		max = 1
	},
	["Abra"] = {
		slot = "abra",
		entry_point = { -120.24,6327.25,31.57 },
		buy_price = 50000, max_people = 0,
		sell_price = 35000,
		max = 1
	},
	["Kadabra"] = {
		slot = "kadabra",
		entry_point = { -120.26,6327.23,35.50 },
		buy_price = 50000, max_people = 0,
		sell_price = 35000,
		max = 1
	},
	["Alakazam"] = {
		slot = "alakazam",
		entry_point = { -114.30,6326.04,35.50 },
		buy_price = 50000, max_people = 0,
		sell_price = 35000,
		max = 1
	},
	["Machop"] = {
		slot = "machop",
		entry_point = { -111.11,6322.87,35.50 },
		buy_price = 50000, max_people = 0,
		sell_price = 35000,
		max = 1
	},
	["Machoke"] = {
		slot = "machoke",
		entry_point = { -1495.87,436.99,112.49 },
		buy_price = 1000000, max_people = 10,
		sell_price = 700000,
		max = 1
	},
	["Machamp"] = {
		slot = "machamp",
		entry_point = { -1405.36,526.83,123.83 },
		buy_price = 1000000, max_people = 10,
		sell_price = 700000,
		max = 1
	},
	["Bellsprout"] = {
		slot = "bellsprout",
		entry_point = { -1367.38,610.73,133.88 },
		buy_price = 1000000, max_people = 10,
		sell_price = 700000,
		max = 1
	},
	["Weepinbell"] = {
		slot = "weepinbell",
		entry_point = { -972.19,752.15,176.38 },
		buy_price = 1000000, max_people = 10,
		sell_price = 700000,
		max = 1
	},
	["Victreebel"] = {
		slot = "victreebel",
		entry_point = { -446.08,686.36,153.11 },
		buy_price = 1000000, max_people = 10,
		sell_price = 700000,
		max = 1
	},
	["Tentacool"] = {
		slot = "tentacool",
		entry_point = { 1300.99,-574.21,71.73 },
		buy_price = 500000, max_people = 5,
		sell_price = 350000,
		max = 1
	},
	["Tentacruel"] = {
		slot = "tentacruel",
		entry_point = { 1323.37,-583.15,73.24 },
		buy_price = 500000, max_people = 5,
		sell_price = 350000,
		max = 1
	},
	["Geodude"] = {
		slot = "geodude",
		entry_point = { 1341.30,-597.26,74.70 },
		buy_price = 500000, max_people = 5,
		sell_price = 350000,
		max = 1
	},
	["Graveler"] = {
		slot = "graveler",
		entry_point = { 1367.23,-606.68,74.71 },
		buy_price = 500000, max_people = 5,
		sell_price = 350000,
		max = 1
	},
	["Golem"] = {
		slot = "golem",
		entry_point = { 1386.29,-593.54,74.48 },
		buy_price = 500000, max_people = 5,
		sell_price = 350000,
		max = 1
	},
	["Ponyta"] = {
		slot = "ponyta",
		entry_point = { 1389.09,-569.46,74.49 },
		buy_price = 500000, max_people = 5,
		sell_price = 350000,
		max = 1
	},
	["Rapidash"] = {
		slot = "rapidash",
		entry_point = { 1373.29,-555.81,74.68 },
		buy_price = 500000, max_people = 5,
		sell_price = 350000,
		max = 1
	},
	["Slowpoke"] = {
		slot = "slowpoke",
		entry_point = { 1348.44,-546.72,73.89 },
		buy_price = 500000, max_people = 5,
		sell_price = 350000,
		max = 1
	},
	["Slowbro"] = {
		slot = "slowbro",
		entry_point = { 1328.64,-536.04,72.44 },
		buy_price = 500000, max_people = 5,
		sell_price = 350000,
		max = 1
	},
	["Magnemite"] = {
		slot = "magnemite",
		entry_point = { 1303.25,-527.36,71.46 },
		buy_price = 500000, max_people = 5,
		sell_price = 350000,
		max = 1
	},
	["Magneton"] = {
		slot = "magneton",
		entry_point = { -14.16,-1441.45,31.10 },
		buy_price = 800000, max_people = 8,
		sell_price = 540000,
		max = 1
	},
	["Farfetch"] = {
		slot = "farfetch",
		entry_point = { -106.93,-8.46,70.52 },
		buy_price = 400000, max_people = 4,
		sell_price = 280000,
		max = 1
	},
	["Doduo"] = {
		slot = "doduo",
		entry_point = { 8.27,539.62,176.02 },
		buy_price = 1500000, max_people = 15,
		sell_price = 1050000,
		max = 1
	},
	["Dodrio"] = {
		slot = "dodrio",
		entry_point = { 313.36,-2040.47,20.93 },
		buy_price = 300000, max_people = 3,
		sell_price = 210000,
		max = 1
	},
	["Seel"] = {
		slot = "seel",
		entry_point = { 317.12,-2043.53,20.93 },
		buy_price = 300000, max_people = 3,
		sell_price = 210000,
		max = 1
	},
	["Dewgong"] = {
		slot = "dewgong",
		entry_point = { 324.37,-2049.63,20.93 },
		buy_price = 300000, max_people = 3,
		sell_price = 210000,
		max = 1
	},
	["Grimer"] = {
		slot = "grimer",
		entry_point = { 325.70,-2050.96,20.93 },
		buy_price = 300000, max_people = 3,
		sell_price = 210000,
		max = 1
	},
	["Muk"] = {
		slot = "muk",
		entry_point = { 333.07,-2056.97,20.93 },
		buy_price = 300000, max_people = 3,
		sell_price = 210000,
		max = 1
	},
	["Shellder"] = {
		slot = "shellder",
		entry_point = { 334.46,-2058.15,20.93 },
		buy_price = 300000, max_people = 3,
		sell_price = 210000,
		max = 1
	},
	["Cloyster"] = {
		slot = "cloyster",
		entry_point = { 341.76,-2064.37,20.93 },
		buy_price = 300000, max_people = 3,
		sell_price = 210000,
		max = 1
	},
	["Gastly"] = {
		slot = "gastly",
		entry_point = { 345.46,-2067.50,20.93 },
		buy_price = 300000, max_people = 3,
		sell_price = 210000,
		max = 1
	},
	["Haunter"] = {
		slot = "haunter",
		entry_point = { 356.74,-2074.75,21.74 },
		buy_price = 300000, max_people = 3,
		sell_price = 210000,
		max = 1
	},
	["Gengar"] = {
		slot = "gengar",
		entry_point = { 357.78,-2073.33,21.74 },
		buy_price = 300000, max_people = 3,
		sell_price = 210000,
		max = 1
	},
	["Onix"] = {
		slot = "onix",
		entry_point = { 365.07,-2064.74,21.74 },
		buy_price = 300000, max_people = 3,
		sell_price = 210000,
		max = 1
	},
	["Drowzee"] = {
		slot = "drowzee",
		entry_point = { 371.21,-2057.33,21.74 },
		buy_price = 300000, max_people = 3,
		sell_price = 210000,
		max = 1
	},
	["Hypno"] = {
		slot = "hypno",
		entry_point = { 372.42,-2056.05,21.74 },
		buy_price = 300000, max_people = 3,
		sell_price = 210000,
		max = 1
	},
	["Krabby"] = {
		slot = "krabby",
		entry_point = { 364.54,-2045.55,22.35 },
		buy_price = 300000, max_people = 3,
		sell_price = 210000,
		max = 1
	},
	["Kingler"] = {
		slot = "kingler",
		entry_point = { 360.80,-2042.48,22.35 },
		buy_price = 300000, max_people = 3,
		sell_price = 210000,
		max = 1
	},
	["Voltorb"] = {
		slot = "voltorb",
		entry_point = { 353.54,-2036.29,22.35 },
		buy_price = 300000, max_people = 3,
		sell_price = 210000,
		max = 1
	},
	["Electrode"] = {
		slot = "electrode",
		entry_point = { 352.17,-2035.19,22.35 },
		buy_price = 300000, max_people = 3,
		sell_price = 210000,
		max = 1
	},
	["Exeggcute"] = {
		slot = "exeggcute",
		entry_point = { 344.77,-2029.02,22.35 },
		buy_price = 300000, max_people = 3,
		sell_price = 210000,
		max = 1
	},
	["Exeggutor"] = {
		slot = "exeggutor",
		entry_point = { 343.40,-2027.82,22.35 },
		buy_price = 300000, max_people = 3,
		sell_price = 210000,
		max = 1
	},
	["Cubone"] = {
		slot = "cubone",
		entry_point = { 336.07,-2021.78,22.35 },
		buy_price = 300000, max_people = 3,
		sell_price = 210000,
		max = 1
	},
	["Marowak"] = {
		slot = "marowak",
		entry_point = { 332.36,-2018.66,22.35 },
		buy_price = 300000, max_people = 3,
		sell_price = 210000,
		max = 1
	},
	["Hitmonlee"] = {
		slot = "hitmonlee",
		entry_point = { 297.87,-2034.54,19.83 },
		buy_price = 300000, max_people = 3,
		sell_price = 210000,
		max = 1
	},
	["Hitmonchan"] = {
		slot = "hitmonchan",
		entry_point = { 293.37,-2044.23,19.64 },
		buy_price = 300000, max_people = 3,
		sell_price = 210000,
		max = 1
	},
	["Lickitung"] = {
		slot = "lickitung",
		entry_point = { 295.08,-2067.54,17.64 },
		buy_price = 300000, max_people = 3,
		sell_price = 210000,
		max = 1
	},
	["Koffing"] = {
		slot = "koffing",
		entry_point = { 286.26,-2052.54,19.64 },
		buy_price = 300000, max_people = 3,
		sell_price = 210000,
		max = 1
	},
	["Weezing"] = {
		slot = "weezing",
		entry_point = { 290.88,-2047.32,19.64 },
		buy_price = 300000, max_people = 3,
		sell_price = 210000,
		max = 1
	},
	["Rhyhorn"] = {
		slot = "rhyhorn",
		entry_point = { 330.66,-1999.91,24.04 },
		buy_price = 300000, max_people = 3,
		sell_price = 210000,
		max = 1
	},
	["Rhydon"] = {
		slot = "rhydon",
		entry_point = { 335.17,-1994.75,24.04 },
		buy_price = 300000, max_people = 3,
		sell_price = 210000,
		max = 1
	},
	["Chansey"] = {
		slot = "chansey",
		entry_point = { 337.72,-1991.66,24.04 },
		buy_price = 300000, max_people = 3,
		sell_price = 210000,
		max = 1
	},
	["Tangela"] = {
		slot = "tangela",
		entry_point = { 356.86,-1996.79,24.24 },
		buy_price = 300000, max_people = 3,
		sell_price = 210000,
		max = 1
	},
	["Kangaskhan"] = {
		slot = "kangaskhan",
		entry_point = { 345.41,-2015.36,22.39 },
		buy_price = 300000, max_people = 3,
		sell_price = 210000,
		max = 1
	},
	["Horsea"] = {
		slot = "horsea",
		entry_point = { 367.19,-2000.38,24.24 },
		buy_price = 300000, max_people = 3,
		sell_price = 210000,
		max = 1
	},
	["Seadra"] = {
		slot = "seadra",
		entry_point = { 329.38,-225.10,54.22 },
		buy_price = 50000, max_people = 0,
		sell_price = 35000,
		max = 3
	},
	["Goldeen"] = {
		slot = "goldeen",
		entry_point = { 331.32,-225.97,54.22 },
		buy_price = 50000, max_people = 0,
		sell_price = 35000,
		max = 3
	},
	["Seaking"] = {
		slot = "seaking",
		entry_point = { 334.96,-227.27,54.22 },
		buy_price = 50000, max_people = 0,
		sell_price = 35000,
		max = 3
	},
	["Staryu"] = {
		slot = "staryu",
		entry_point = { 337.13,-224.78,54.22 },
		buy_price = 50000, max_people = 0,
		sell_price = 35000,
		max = 3
	},
	["Starmie"] = {
		slot = "starmie",
		entry_point = { 339.12,-219.49,54.22 },
		buy_price = 50000, max_people = 0,
		sell_price = 35000,
		max = 3
	},
	["MrMime"] = {
		slot = "mrmime",
		entry_point = { 340.94,-214.93,54.22 },
		buy_price = 50000, max_people = 0,
		sell_price = 35000,
		max = 3
	},
	["Scyther"] = {
		slot = "scyther",
		entry_point = { 343.00,-209.63,54.22 },
		buy_price = 50000, max_people = 0,
		sell_price = 35000,
		max = 3
	},
	["Jynx"] = {
		slot = "jynx",
		entry_point = { 344.70,-205.03,54.22 },
		buy_price = 50000, max_people = 0,
		sell_price = 35000,
		max = 3
	},
	["Electabuzz"] = {
		slot = "electabuzz",
		entry_point = { 346.73,-199.71,54.22 },
		buy_price = 50000, max_people = 0,
		sell_price = 35000,
		max = 3
	},
	["Magmar"] = {
		slot = "magmar",
		entry_point = { 312.81,-218.84,54.22 },
		buy_price = 50000, max_people = 0,
		sell_price = 35000,
		max = 3
	},
	["Pinsir"] = {
		slot = "pinsir",
		entry_point = { 310.80,-218.06,54.22 },
		buy_price = 50000, max_people = 0,
		sell_price = 35000,
		max = 3
	},
	["Taurus"] = {
		slot = "taurus",
		entry_point = { 307.22,-216.68,54.22 },
		buy_price = 50000, max_people = 0,
		sell_price = 35000,
		max = 3
	},
	["Magikarp"] = {
		slot = "magikarp",
		entry_point = { 307.55,-213.29,54.22 },
		buy_price = 50000, max_people = 0,
		sell_price = 35000,
		max = 3
	},
	["Gyarados"] = {
		slot = "gyarados",
		entry_point = { 309.57,-207.96,54.22 },
		buy_price = 50000, max_people = 0,
		sell_price = 35000,
		max = 3
	},
	["Lapras"] = {
		slot = "lapras",
		entry_point = { 311.41,-203.41,54.22 },
		buy_price = 50000, max_people = 0,
		sell_price = 35000,
		max = 3
	},
	["Ditto"] = {
		slot = "ditto",
		entry_point = { 313.38,-198.11,54.22 },
		buy_price = 50000, max_people = 0,
		sell_price = 35000,
		max = 3
	},
	["Eevee"] = {
		slot = "eevee",
		entry_point = { 315.80,-194.89,54.22 },
		buy_price = 50000, max_people = 0,
		sell_price = 35000,
		max = 3
	},
	["Vaporeon"] = {
		slot = "vaporeon",
		entry_point = { 319.42,-196.20,54.22 },
		buy_price = 50000, max_people = 0,
		sell_price = 35000,
		max = 3
	},
	["Jolteon"] = {
		slot = "jolteon",
		entry_point = { 321.39,-196.99,54.22 },
		buy_price = 50000, max_people = 0,
		sell_price = 35000,
		max = 3
	},
	["Flareon"] = {
		slot = "flareon",
		entry_point = { 329.35,-225.11,58.01 },
		buy_price = 50000, max_people = 0,
		sell_price = 35000,
		max = 3
	},
	["Porygon"] = {
		slot = "porygon",
		entry_point = { 331.34,-225.91,58.01 },
		buy_price = 50000, max_people = 0,
		sell_price = 35000,
		max = 3
	},
	["Omanyte"] = {
		slot = "omanyte",
		entry_point = { 334.92,-227.31,58.01 },
		buy_price = 50000, max_people = 0,
		sell_price = 35000,
		max = 3
	},
	["Omastar"] = {
		slot = "omastar",
		entry_point = { 337.10,-224.80,58.01 },
		buy_price = 50000, max_people = 0,
		sell_price = 35000,
		max = 3
	},
	["Kabuto"] = {
		slot = "kabuto",
		entry_point = { 339.20,-219.50,58.01 },
		buy_price = 50000, max_people = 0,
		sell_price = 35000,
		max = 3
	},
	["Kabutops"] = {
		slot = "kabutops",
		entry_point = { 340.97,-214.92,58.01 },
		buy_price = 50000, max_people = 0,
		sell_price = 35000,
		max = 3
	},
	["Aerodactyl"] = {
		slot = "aerodactyl",
		entry_point = { 342.90,-209.60,58.01 },
		buy_price = 50000, max_people = 0,
		sell_price = 35000,
		max = 3
	},
	["Snorlax"] = {
		slot = "snorlax",
		entry_point = { 344.77,-205.03,58.01 },
		buy_price = 50000, max_people = 0,
		sell_price = 35000,
		max = 3
	},
	["Articuno"] = {
		slot = "articuno",
		entry_point = { 346.73,-199.75,58.01 },
		buy_price = 50000, max_people = 0,
		sell_price = 35000,
		max = 3
	},
	["Zapdos"] = {
		slot = "zapdos",
		entry_point = { 325.09,-229.57,54.22 },
		buy_price = 50000, max_people = 0,
		sell_price = 35000,
		max = 3
	},
	["Moltres"] = {
		slot = "moltres",
		entry_point = { 312.80,-218.76,58.01 },
		buy_price = 50000, max_people = 0,
		sell_price = 35000,
		max = 3
	},
	["Dratini"] = {
		slot = "dratini",
		entry_point = { 310.82,-218.08,58.01 },
		buy_price = 50000, max_people = 0,
		sell_price = 35000,
		max = 3
	},
	["Dragonair"] = {
		slot = "dragonair",
		entry_point = { 307.25,-216.64,58.01 },
		buy_price = 50000, max_people = 0,
		sell_price = 35000,
		max = 3
	},
	["Dragonite"] = {
		slot = "dragonite",
		entry_point = { 307.59,-213.31,58.01 },
		buy_price = 50000, max_people = 0,
		sell_price = 35000,
		max = 3
	},
	["Mewtwo"] = {
		slot = "mewtwo",
		entry_point = { 309.59,-207.96,58.01 },
		buy_price = 50000, max_people = 0,
		sell_price = 35000,
		max = 3
	},
	["Mew"] = {
		slot = "mew",
		entry_point = { 311.32,-203.40,58.01 },
		buy_price = 50000, max_people = 0,
		sell_price = 35000,
		max = 3
	},
	["Chikorita"] = {
		slot = "chikorita",
		entry_point = { 313.29,-198.06,58.01 },
		buy_price = 50000, max_people = 0,
		sell_price = 35000,
		max = 3
	},
	["Bayleef"] = {
		slot = "bayleef",
		entry_point = { 315.81,-194.83,58.01 },
		buy_price = 50000, max_people = 0,
		sell_price = 35000,
		max = 3
	},
	["Meganium"] = {
		slot = "meganium",
		entry_point = { 319.35,-196.22,58.01 },
		buy_price = 50000, max_people = 0,
		sell_price = 35000,
		max = 3
	},
	["Cyndaquil"] = {
		slot = "cyndaquil",
		entry_point = { 321.32,-197.11,58.01 },
		buy_price = 50000, max_people = 0,
		sell_price = 35000,
		max = 3
	},
	["Praiana"] = {
		slot = "praiana",
		entry_point = { -1149.9858398438,-1521.7456054688,10.628058433533 },
		buy_price = 150000, max_people = 1,
		sell_price = 135000,
		max = 5
	}
}

return cfg