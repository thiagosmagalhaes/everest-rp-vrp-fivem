local cfg = {}

cfg.groups = {
	["admin"] = {
		"admin.permissao",
		"support.permissao"
	},
	["support"] = {
		_config = {
			title = "Suporte"
		},
		"support.permissao"
	},


	["Comando"] = {
		_config = {
			title = "Comandante da Policia",
			gtype = "cargo"
		},
		"comando.permissao"
	},
	["SubComando"] = {
		_config = {
			title = "Segundo Escalão da Policia",
			gtype = "cargo"
		},
		"subcomando.permissao"
	},
	["Policia"] = {
		_config = {
			title = "Polícial",
			gtype = "job"
		},
		"policia.permissao",
		"polpar.permissao"
	},

	["Diretor"] = {
		_config = {
			title = "Diretor do EMS",
			gtype = "cargo"
		},
		"diretor.permissao"
	},
	["Medico"] = {
		_config = {
			title = "Medico do EMS",
			gtype = "cargo"
		},
		"enfermeiro.permissao"
	},
	["Enfermeiro"] = {
		_config = {
			title = "Enfermeiro do EMS",
			gtype = "job"
		},
		"paramedico.permissao",
		"polpar.permissao"
	},

	
	
	["Mecanico"] = {
		_config = {
			title = "Mecanico",
			gtype = "job"
		},
		"mecanico.permissao"
	},

	["Bennys"] = {
		_config = {
			title = "Benny's",
			gtype = "job"
		},
		"bennys.permissao"
	},
	
	["Taxista"] = {
		_config = {
			title = "Taxista",
			gtype = "job"
		},
		"taxista.permissao"
	},

	["Motoclub"] = {
        _config = {
            title = "Motoclub",
            gtype = "job"
        },
        "motoclub.permissao",
        
	},

    ["Verde"] = {
        _config = {
            title = "Groove",
            gtype = "job"
        },
        "verde.permissao",
        
    },
    ["Roxo"] = {
        _config = {
            title = "Ballas",
            gtype = "job"
        },
        "roxo.permissao",
        
    },
    ["Amarelo"] = {
        _config = {
            title = "Vagos",
            gtype = "job"
        },
        "amarelo.permissao",
        
    },
    ["Mafia"] = {
        _config = {
            title = "Mafia",
            gtype = "job"
        },
        "mafia.permissao",
        
	},
	["Bloods"] = {
        _config = {
            title = "Bloods",
            gtype = "job"
        },
        "bloods.permissao",
        
	},
	["Desmanche"] = {
		_config = {
			title = "Desmanche",
			gtype = "job"
		},
		"desmanche.permissao",
	},
	
    ["Reporter"] = {
        _config = {
            title = "Reporter",
        },
        "reporter.permissao",
	},
	["Juiz"] = {
        _config = {
			title = "Juiz",
			gtype = "job"
        },
        "juiz.permissao",
    },
   	["Advogado"] = {
        _config = {
			title = "Advogado",
			gtype = "job"
        },
        "advogado.permissao",
    },
    ["Vendedor"] = {
		_config = {
			title = "Vendedor",
			gtype = "job"
		},
		"vendedor.permissao",
	},
	["Concessionaria"] = {
		_config = {
			title = "Concessionária",
			gtype = "cargo"
		},
		"concessionaria.permissao",
	},
	
	["Prata"] = {
		_config = {
			title = "Prata",
			gtype = "vip"
		},
		"prata.permissao",
		"mochila.permissao",
	},
	["Ouro"] = {
		_config = {
			title = "Ouro",
			gtype = "vip"
		},
		"ouro.permissao",
		"mochila.permissao",
		"importados.permissao"
	},
	["Platina"] = {
		_config = {
			title = "Platina",
			gtype = "vip"
		},
		"platina.permissao",
		"mochila.permissao",
		"importados.permissao"
	},
	["Diamante"] = {
		_config = {
			title = "Diamante",
			gtype = "vip"
		},
		"diamante.permissao",
		"mochila.permissao",
		"importados.permissao"
	},
	








	["PaisanaPolicia"] = {
		_config = {
			title = "Policial",
			gtype = "job"
		},
		"paisanapolicia.permissao"
	},
	["PaisanaEnfermeiro"] = {
		_config = {
			title = "Enfermeiro",
			gtype = "job"
		},
		"paisanaparamedico.permissao"
	},
	["PaisanaMecanico"] = {
		_config = {
			title = "Mecanico",
			gtype = "job"
		},
		"paisanamecanico.permissao"
	},
	["PaisanaTaxista"] = {
		_config = {
			title = "Taxista",
			gtype = "job"
		},
		"paisanataxista.permissao"
	},
}

cfg.users = {
	[1] = { "admin" },
	[2] = { "admin" },
	[3] = { "admin" },
}

cfg.selectors = {}

return cfg