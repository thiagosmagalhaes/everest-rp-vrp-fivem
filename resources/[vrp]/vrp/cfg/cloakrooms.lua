local cfg = {}

local surgery_male = { model = "mp_m_freemode_01" }
local surgery_female = { model = "mp_f_freemode_01" }
local personagem = { model = "mp_f_freemode_01" }

for i=0,19 do
	surgery_female[i] = { 0,0 }
	surgery_male[i] = { 0,0 }
end

cfg.cloakroom_types = {
	["Personagem"] = {
		_config = {},
		["Personagem"] = personagem
	}
}

cfg.cloakrooms = {
	{ "Personagem",344.19,-1644.22,92.70 },
}

return cfg