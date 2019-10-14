local cfg = {}

cfg.list = {
	[1] = { text = true, hash = 631614199, x = 461.86, y = -993.68, z = 24.91, lock = true, perm = "policia.permissao" },
	[2] = { text = true, hash = 631614199, x = 461.84, y = -998.37, z = 24.91, lock = true, perm = "policia.permissao" },
	[3] = { text = true, hash = 631614199, x = 461.83, y = -1002.08, z = 24.91, lock = true, perm = "policia.permissao" },
	[36] = { text = true, hash = 631614199, x=1848.55, y=3681.15, z=34.29, lock = true, perm = "policia.permissao" },
	[37] = { text = true, hash = 631614199, x=1845.98, y=3685.14, z=34.29, lock = true, perm = "policia.permissao" },
	[4] = { text = true, hash = 2271212864, x = 468.29, y = -1014.15, z = 26.38, lock = true, perm = "policia.permissao", other = 5 },
	[5] = { text = true, hash = 2271212864, x = 468.96, y = -1014.09, z = 26.38, lock = true, perm = "policia.permissao", other = 4 },
	[6] = { text = true, hash = 749848321, x = 452.71, y = -982.58, z = 30.68, lock = false, perm = "policia.permissao" },
	[7] = { text = false, hash = 520341586, x = -14.12, y = -1441.47, z = 31.10, lock = true, perm = "admin.permissao" },
	[8] = { text = true, hash = 4147641866, x = 37.95, y = -1403.29, z = 29.44, lock = true, perm = "mafia.permissao" },
	[9] = { text = false, hash = 486670049, x = -106.93, y = -8.45, z = 70.52, lock = true, perm = "admin.permissao" },
	[10] = { text = false, hash = 308207762, x = 8.22, y = 539.46, z = 176.02, lock = true, perm = "admin.permissao" },
	[11] = { text = false, hash = -26664553, x=2332.22, y=2575.53, z=46.68, lock = true, perm = "admin.permissao", other = 12 },
	[12] = { text = false, hash = 914592203, x=2330.52, y=2576.17, z=46.68, lock = true, perm = "admin.permissao", other = 11 },
	
	[13] = { text = false, hash = 132154435, x = 1973.54, y = 3815.41, z = 33.42, lock = true, perm = "admin.permissao" },
	[14] = { text = true, hash = 185711165, x = 445.37, y = -989.77, z = 30.68, lock = true, perm = "policia.permissao", other = 15 },
	[15] = { text = true, hash = 185711165, x = 444.07, y = -989.77, z = 30.68, lock = true, perm = "policia.permissao", other = 14 },
	[16] = { text = true, hash = 190770132, x = 981.90, y = -103.00, z = 74.84, lock = true, perm = "motoclub.permissao" },
	[17] = { text = true, hash = 4147641866, x = -1096.60, y = 4949.51, z = 218.48, lock = true, perm = "roxo.permissao" },
	[18] = { text = true, hash = 4147641866, x = 97.39, y = 6327.53, z = 31.37, lock = true, perm = "verde.permissao" },
	[19] = { text = true, hash = 4147641866, x = 1483.60, y = 6392.15, z = 23.33, lock = true, perm = "amarelo.permissao" },
	[21] = { text = true, hash = 3584148813, x = 887.89, y = -2107.53, z = 30.80, lock = true, perm = "motoclub.permissao" },
	[22] = { text = true, hash = 3584148813, x = 900.99, y = -2105.30, z = 30.76, lock = true, perm = "motoclub.permissao" },
	[23] = { text = false, hash = 3687927243, x = -1150.05, y = -1521.69, z = 10.62, lock = true, perm = "admin.permissao" }, -- ESSA PORTA É DE UMA CASA QUE POR PADRAO A PORTA FICA ABERTA, POR ISSO A PERMISSAO SÓ PRA ADM ABRIR A PORTA
	
	[24] = { text = true, hash = -770740285, x=330.14688110352, y=-585.74420166016, z=43.332565307617, lock = false, perm = "paramedico.permissao", other = 25 },
	[25] = { text = true, hash = -770740285, x=329.27380371094, y=-585.482421875, z=43.332576751709, lock = false, perm = "paramedico.permissao", other = 24 },
	[26] = { text = true, hash = 1901183774, x=-2667.6459960938, y=1326.2053222656, z=147.44497680664, lock = true, perm = "mafia.permissao"},
	[27] = { text = true, hash = -147325430, x=-2667.158203125, y=1330.0040283203, z=147.44598388672, lock = true, perm = "mafia.permissao"},
	[28] = { text = false, hash = -2030220382, x=-1002.49, y=-477.65, z=50.03, lock = true, perm = "null.permissao"},
	[29] = { text = false, hash = -2051651622, x=127.24, y=-760.43, z=45.75, lock = true, perm = "null.permissao"},

	[30] = { text = true, hash = -292728657, x=-949.19, y=-1475.31, z=6.79, lock = true, perm = "bloods.permissao", other = 31 },
	[31] = { text = true, hash = -1653461382, x=-948.26, y=-1476.86, z=6.79, lock = true, perm = "bloods.permissao", other = 30 },

	[32] = { text = false, hash = -1032171637, x=1058.41, y=-674.86, z=57.3, lock = false, perm = "admin.permissao"},
	[33] = { text = false, hash = -1032171637, x=1071.77, y=-666.11, z=57.49, lock = false, perm = "admin.permissao"},
	[34] = { text = false, hash = -1032171637, x=1082.5, y=-666.55, z=57.4, lock = false, perm = "admin.permissao"},
	[35] = { text = false, hash = -1032171637, x=1093.41, y=-671.79, z=57.1, lock = false, perm = "admin.permissao"},

	
	-- [28] = { text = true, hash = -822900180, x=1174.73, y=2645.36, z=37.76, lock = true, perm = "desmanche.permissao"},
	-- [29] = { text = true, hash = 1335311341, x=1187.87, y=2645.07, z=38.4, lock = true, perm = "desmanche.permissao"},
	-- [23] = { text = false, hash = 746855201, x=261.95, y=221.72, z=106.28, lock = true, perm = "admin.permissao" }, -- PORTA BANCO CENTRAL
}

return cfg


