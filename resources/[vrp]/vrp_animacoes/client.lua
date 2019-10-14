local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- 60309 MAO ESQUERDA
-- 28422 MAO DIREITA
-- 50 NÃO REPETE
-- 49 REPETE
-----------------------------------------------------------------------------------------------------------------------------------------
local fov_min = 5.0
local fov_max = 70.0
local binoculos = false
local fov = (fov_max+fov_min)*0.5
-----------------------------------------------------------------------------------------------------------------------------------------
local animacoes = {
	{ nome = "radio2" , prop = "prop_boombox_01" , flag = 49 , mao = 57005 , pos1 = 0.30, pos2 = -0.05 , pos3 = -0.07, xa = -55.0, ya = -20.0, za = 50.0, del=false},
	{ nome = "bolsa", prop = "prop_ld_case_01" , flag = 49 , mao = 57005 , pos1 = 0.16, pos2 = 0 , pos3 = 0, xa = -55.0, ya = -20.0, za = 50.0},
	{ nome = "bolsa2" , prop = "prop_ld_case_01_s" , flag = 49 , mao = 57005, pos1 = 0.15, pos2 = 0.005, pos3 = -0.03, xa = -55.0, ya = -20.0, za = 50.0 },
	{ nome = "bolsa3" , prop = "prop_security_case_01" , flag = 49 , mao = 57005 , pos1 = 0.16 , pos2 = -0.01 , pos3 = -0.03, xa = -55.0, ya = -25.0, za = 60.0 },
	{ nome = "bolsa4" , prop = "w_am_case" , flag = 49 , mao = 57005 , pos1 = 0.08 , pos2 = 0 , pos3 = 0, xa = -55.0, ya = -20.0, za = 50.0 },
	{ nome = "caixa" , dict = "anim@heists@box_carry@" , anim = "idle" , prop = "hei_prop_heist_box" , flag = 49 , mao = 28422, del = false },
	{ nome = "caixa2", prop = "prop_tool_box_04" , flag = 49 , mao = 57005 , pos1 = 0.35 , pos2 = -0.15 , pos3 = -0.10, xa = -55.0, ya = -20.0, za = 50.0, del = false },
	{ nome = "lixo" , prop = "prop_cs_rub_binbag_01" , flag = 49 , mao = 57005 , pos1 = 0.16, pos2 = 0 , pos3 = 0, xa = -55.0, ya = -20.0, za = 50.0, del=false },
	{ nome = "prebeber" , dict = "amb@code_human_wander_drinking@beer@male@base" , anim = "static" , prop = "prop_fib_coffee" , flag = 49 , mao = 28422 },
	{ nome = "prebeber2" , dict = "amb@code_human_wander_drinking@beer@male@base" , anim = "static" , prop = "prop_ld_flow_bottle" , flag = 49 , mao = 28422 },
	{ nome = "prebeber3" , dict = "amb@code_human_wander_drinking@beer@male@base" , anim = "static" , prop = "prop_cs_bs_cup" , flag = 49 , mao = 28422 },
	{ nome = "verificar" , dict = "amb@medic@standing@tendtodead@idle_a" , anim = "idle_a" , andar = false , loop = true },
	{ nome = "mexer" , dict = "amb@prop_human_parking_meter@female@idle_a" , anim = "idle_a_female" , andar = true , loop = true },
	{ nome = "cuidar" , dict = "mini@cpr@char_a@cpr_str" , anim = "cpr_pumpchest" , andar = true , loop = true },
	{ nome = "cuidar2" , dict = "mini@cpr@char_a@cpr_str" , anim = "cpr_kol" , andar = true , loop = true },
	{ nome = "cuidar3" , dict = "mini@cpr@char_a@cpr_str" , anim = "cpr_kol_idle" , andar = true , loop = true },
	{ nome = "cansado" , dict = "rcmbarry" , anim = "idle_d" , andar = false , loop = true },
	{ nome = "alongar2" , dict = "mini@triathlon" , anim = "idle_e" , andar = false , loop = true },
	{ nome = "meleca" , dict = "anim@mp_player_intuppernose_pick" , anim = "idle_a" , andar = true , loop = true },
	{ nome = "bora" , dict = "missfam4" , anim = "say_hurry_up_a_trevor" , andar = true , loop = false },
	{ nome = "limpar" , dict = "missfbi3_camcrew" , anim = "final_loop_guy" , andar = true , loop = false },
	{ nome = "galinha" , dict = "random@peyote@chicken" , anim = "wakeup" , andar = true , loop = true },
	{ nome = "amem" , dict = "rcmepsilonism8" , anim = "worship_base" , andar = true , loop = true },
	{ nome = "nervoso" , dict = "rcmme_tracey1" , anim = "nervous_loop" , andar = true , loop = true },
	{ nome = "morrer" , dict = "misslamar1dead_body" , anim = "dead_idle" , andar = false , loop = true },
	{ nome = "ajoelhar" , dict = "amb@medic@standing@kneel@idle_a" , anim = "idle_a" , andar = false , loop = true },
	{ nome = "sinalizar" , dict = "amb@world_human_car_park_attendant@male@base" , anim = "base" , prop = "prop_parking_wand_01" , flag = 49 , mao = 28422 },
	{ nome = "placa" , dict = "amb@world_human_bum_freeway@male@base" , anim = "base" , prop = "prop_beggers_sign_01" , flag = 49 , mao = 28422 },
	{ nome = "placa2" , dict = "amb@world_human_bum_freeway@male@base" , anim = "base" , prop = "prop_beggers_sign_03" , flag = 49 , mao = 28422 },
	{ nome = "placa3" , dict = "amb@world_human_bum_freeway@male@base" , anim = "base" , prop = "prop_beggers_sign_04" , flag = 49 , mao = 28422 },
	{ nome = "abanar" , dict = "timetable@amanda@facemask@base" , anim = "base" , andar = true , loop = true },
	{ nome = "cocada" , dict = "mp_player_int_upperarse_pick" , anim = "mp_player_int_arse_pick" , andar = true , loop = true },
	{ nome = "cocada2" , dict = "mp_player_int_uppergrab_crotch" , anim = "mp_player_int_grab_crotch" , andar = true , loop = true },
	{ nome = "lero" , dict = "anim@mp_player_intselfiejazz_hands" , anim = "idle_a" , andar = true , loop = false },
	{ nome = "dj2" , dict = "anim@mp_player_intupperair_synth" , anim = "idle_a_fp" , andar = false , loop = true },
	{ nome = "beijo" , dict = "anim@mp_player_intselfieblow_kiss" , anim = "exit" , andar = true , loop = false },
	{ nome = "malicia" , dict = "anim@mp_player_intupperdock" , anim = "idle_a" , andar = true , loop = false },
	{ nome = "ligar" , dict = "cellphone@" , anim = "cellphone_call_in" , prop = "prop_amb_phone" , flag = 50 , mao = 28422 },
	{ nome = "radio" , dict = "cellphone@" , anim = "cellphone_call_in" , prop = "prop_cs_hand_radio" , flag = 50 , mao = 28422 },
	{ nome = "cafe" , dict = "amb@world_human_aa_coffee@base" , anim = "base" , prop = "prop_fib_coffee" , flag = 50 , mao = 28422 },
	{ nome = "cafe2" , dict = "amb@world_human_aa_coffee@idle_a" , anim = "idle_a" , prop = "prop_fib_coffee" , flag = 49 , mao = 28422 },
	{ nome = "chuva" , dict = "amb@world_human_drinking@coffee@male@base" , anim = "base" , prop = "p_amb_brolly_01" , flag = 49 , mao = 57005, pos1 = 0.15, pos2 = 0.005, pos3 = -0.02, xa = 80.0, ya = -20.0, za = 175.0 },
	{ nome = "chuva2" , dict = "amb@world_human_drinking@coffee@male@base" , anim = "base" , prop = "p_amb_brolly_01_s" , flag = 49 , mao = 57005, pos1 = 0.15, pos2 = 0.005, pos3 = -0.02, xa = 80.0, ya = -20.0, za  = 175.0 },
	{ nome = "comer" , dict = "amb@code_human_wander_eating_donut@male@idle_a" , anim = "idle_c" , prop = "prop_cs_burger_01" , flag = 49 , mao = 28422 },
	{ nome = "comer2" , dict = "amb@code_human_wander_eating_donut@male@idle_a" , anim = "idle_c" , prop = "prop_cs_hotdog_01" , flag = 49 , mao = 28422 },
	{ nome = "comer3" , dict = "amb@code_human_wander_eating_donut@male@idle_a" , anim = "idle_c" , prop = "prop_amb_donut" , flag = 49 , mao = 28422 },
	{ nome = "beber" , dict = "amb@world_human_drinking@beer@male@idle_a" , anim = "idle_a" , prop = "p_cs_bottle_01" , flag = 49 , mao = 28422, del=false },
	{ nome = "beber2" , dict = "amb@world_human_drinking@beer@male@idle_a" , anim = "idle_a" , prop = "prop_energy_drink" , flag = 49 , mao = 28422, del=false },
	{ nome = "beber3" , dict = "amb@world_human_drinking@beer@male@idle_a" , anim = "idle_a" , prop = "prop_amb_beer_bottle" , flag = 49 , mao = 28422, del=false },
	{ nome = "beber4" , dict = "amb@world_human_drinking@beer@male@idle_a" , anim = "idle_a" , prop = "p_whiskey_notop" , flag = 49 , mao = 28422, del=false },
	{ nome = "beber5" , dict = "amb@world_human_drinking@beer@male@idle_a" , anim = "idle_a" , prop = "prop_beer_logopen" , flag = 49 , mao = 28422, del=false },
	{ nome = "beber6" , dict = "amb@world_human_drinking@beer@male@idle_a" , anim = "idle_a" , prop = "prop_beer_blr" , flag = 49 , mao = 28422, del=false },
	{ nome = "beber7" , dict = "amb@world_human_drinking@beer@male@idle_a" , anim = "idle_a" , prop = "prop_ld_flow_bottle" , flag = 49 , mao = 28422, del=false },
	{ nome = "digitar" , dict = "anim@heists@prison_heistig1_p1_guard_checks_bus" , anim = "loop" , andar = false , loop = true },
	{ nome = "continencia" , dict = "mp_player_int_uppersalute" , anim = "mp_player_int_salute" , andar = true , loop = true },
	{ nome = "atm" , dict = "amb@prop_human_atm@male@idle_a" , anim = "idle_a" , andar = false , loop = false },
	{ nome = "no" , dict = "mp_player_int_upper_nod" , anim = "mp_player_int_nod_no" , andar = true , loop = true },
	{ nome = "palmas" , dict = "anim@mp_player_intcelebrationfemale@slow_clap" , anim = "slow_clap" , andar = true , loop = false },
	{ nome = "palmas2" , dict = "amb@world_human_cheering@male_b" , anim = "base" , andar = true , loop = true },
	{ nome = "palmas3" , dict = "amb@world_human_cheering@male_d" , anim = "base" , andar = true , loop = true },
	{ nome = "palmas4" , dict = "amb@world_human_cheering@male_e" , anim = "base" , andar = true , loop = true },
	{ nome = "postura" , dict = "anim@heists@prison_heiststation@cop_reactions" , anim = "cop_a_idle" , andar = true , loop = true },
	{ nome = "postura2" , dict = "amb@world_human_cop_idles@female@base" , anim = "base" , andar = true , loop = true },
	{ nome = "varrer" , dict = "amb@world_human_janitor@male@idle_a" , anim = "idle_a" , prop = "prop_tool_broom" , flag = 49 , mao = 28422, extra = function()
			local x, y, z = table.unpack(GetEntityCoords(PlayerPedId()))
			SetTimeout(5000,function()
				TriggerServerEvent("varrer",-1,x,y,z, 5.0)
			end)
		end
	},
	{ nome = "musica" , dict = "amb@world_human_musician@guitar@male@base" , anim = "base" , prop = "prop_el_guitar_01" , flag = 49 , mao = 60309 },
	{ nome = "musica2" , dict = "amb@world_human_musician@guitar@male@base" , anim = "base" , prop = "prop_el_guitar_02" , flag = 49 , mao = 60309 },
	{ nome = "musica3" , dict = "amb@world_human_musician@guitar@male@base" , anim = "base" , prop = "prop_el_guitar_03" , flag = 49 , mao = 60309 },
	{ nome = "musica4" , dict = "amb@world_human_musician@guitar@male@base" , anim = "base" , prop = "prop_acc_guitar_01" , flag = 49 , mao = 60309 },
	{ nome = "camera" , dict = "amb@world_human_paparazzi@male@base" , anim = "base" , prop = "prop_pap_camera_01" , flag = 49 , mao = 28422 },
	{ nome = "camera2" , dict = "missfinale_c2mcs_1" , anim = "fin_c2_mcs_1_camman" , prop = "prop_v_cam_01" , flag = 49 , mao = 28422 },
	{ nome = "prancheta" , dict = "amb@world_human_clipboard@male@base" , anim = "base" , prop = "p_amb_clipboard_01" , flag = 50 , mao = 60309 },
	{ nome = "mapa" , dict = "amb@world_human_clipboard@male@base" , anim = "base" , prop = "prop_tourist_map_01" , flag = 50 , mao = 60309 },
	-- { nome = "anotar" , dict = "amb@medic@standing@timeofdeath@base" , anim = "base" , prop = "prop_notepad_01" , flag = 49 , mao = 60309 },
	{ nome = "anotar" , dict = "amb@medic@standing@timeofdeath@base" , anim = "base" , prop = "prop_notepad_01", proptwo = "prop_pencil_01", flag = 49 , mao = 60309, pos1 = 0.00, pos2 = 0.00, pos3 = 0.00, xa = 0.0, ya = -0.40, za = -0.40},
	{ nome = "peace" , dict = "mp_player_int_upperpeace_sign" , anim = "mp_player_int_peace_sign" , andar = true , loop = true },
	{ nome = "deitar" , dict = "amb@world_human_sunbathe@female@back@idle_a" , anim = "idle_a" , andar = false , loop = true },
	{ nome = "deitar2" , dict = "amb@world_human_sunbathe@female@front@idle_a" , anim = "idle_a" , andar = false , loop = true },
	{ nome = "deitar3" , dict = "amb@world_human_sunbathe@male@back@idle_a" , anim = "idle_a" , andar = false , loop = true },
	{ nome = "deitar4" , dict = "amb@world_human_sunbathe@male@front@idle_a" , anim = "idle_a" , andar = false , loop = true },
	{ nome = "deitar5" , dict = "mini@cpr@char_b@cpr_str" , anim = "cpr_kol_idle" , andar = false , loop = true },
	{ nome = "debrucar" , dict = "amb@prop_human_bum_shopping_cart@male@base" , anim = "base" , andar = false , loop = true },
	{ nome = "dancar" , dict = "rcmnigel1bnmt_1b" , anim = "dance_loop_tyler" , andar = false , loop = true },
	{ nome = "dancar2" , dict = "mp_safehouse" , anim = "lap_dance_girl" , andar = false , loop = true },
	{ nome = "dancar3" , dict = "misschinese2_crystalmazemcs1_cs" , anim = "dance_loop_tao" , andar = false , loop = true },
	{ nome = "dancar4" , dict = "mini@strip_club@private_dance@part1" , anim = "priv_dance_p1" , andar = false , loop = true },
	{ nome = "dancar5" , dict = "mini@strip_club@private_dance@part2" , anim = "priv_dance_p2" , andar = false , loop = true },
	{ nome = "dancar6" , dict = "mini@strip_club@private_dance@part3" , anim = "priv_dance_p3" , andar = false , loop = true },
	{ nome = "dancar7" , dict = "special_ped@mountain_dancer@monologue_2@monologue_2a" , anim = "mnt_dnc_angel" , andar = false , loop = true },
	{ nome = "dancar8" , dict = "special_ped@mountain_dancer@monologue_3@monologue_3a" , anim = "mnt_dnc_buttwag" , andar = false , loop = true },
	{ nome = "dancar9" , dict = "missfbi3_sniping" , anim = "dance_m_default" , andar = false , loop = true },
	{ nome = "dancar10" , dict = "anim@amb@nightclub@dancers@black_madonna_entourage@" , anim = "hi_dance_facedj_09_v2_male^5" , andar = false , loop = true },
	{ nome = "dancar11" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_09_v1_female^1" , andar = false , loop = true },
	{ nome = "dancar12" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_09_v1_female^2" , andar = false , loop = true },
	{ nome = "dancar13" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_09_v1_female^3" , andar = false , loop = true },
	{ nome = "dancar14" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_09_v1_female^4" , andar = false , loop = true },
	{ nome = "dancar15" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_09_v1_female^5" , andar = false , loop = true },
	{ nome = "dancar16" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_09_v1_female^6" , andar = false , loop = true },
	{ nome = "dancar17" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_09_v1_male^1" , andar = false , loop = true },
	{ nome = "dancar18" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_09_v1_male^2" , andar = false , loop = true },
	{ nome = "dancar19" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_09_v1_male^3" , andar = false , loop = true },
	{ nome = "dancar20" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_09_v1_male^4" , andar = false , loop = true },
	{ nome = "dancar21" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_09_v1_male^5" , andar = false , loop = true },
	{ nome = "dancar22" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_09_v1_male^6" , andar = false , loop = true },
	{ nome = "dancar23" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_09_v2_female^1" , andar = false , loop = true },
	{ nome = "dancar24" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_09_v2_female^2" , andar = false , loop = true },
	{ nome = "dancar25" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_09_v2_female^3" , andar = false , loop = true },
	{ nome = "dancar26" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_09_v2_female^4" , andar = false , loop = true },
	{ nome = "dancar27" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_09_v2_female^5" , andar = false , loop = true },
	{ nome = "dancar28" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_09_v2_female^6" , andar = false , loop = true },
	{ nome = "dancar29" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_09_v2_male^1" , andar = false , loop = true },
	{ nome = "dancar30" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_09_v2_male^2" , andar = false , loop = true },
	{ nome = "dancar31" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_09_v2_male^3" , andar = false , loop = true },
	{ nome = "dancar32" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_09_v2_male^4" , andar = false , loop = true },
	{ nome = "dancar33" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_09_v2_male^5" , andar = false , loop = true },
	{ nome = "dancar34" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_09_v2_male^6" , andar = false , loop = true },

	{ nome = "dancar35" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_11_v1_female^1" , andar = false , loop = true },
	{ nome = "dancar36" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_11_v1_female^2" , andar = false , loop = true },
	{ nome = "dancar37" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_11_v1_female^3" , andar = false , loop = true },
	{ nome = "dancar38" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_11_v1_female^4" , andar = false , loop = true },
	{ nome = "dancar39" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_11_v1_female^5" , andar = false , loop = true },
	{ nome = "dancar40" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_11_v1_female^6" , andar = false , loop = true },
	{ nome = "dancar41" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_11_v1_male^1" , andar = false , loop = true },
	{ nome = "dancar42" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_11_v1_male^2" , andar = false , loop = true },
	{ nome = "dancar43" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_11_v1_male^3" , andar = false , loop = true },
	{ nome = "dancar44" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_11_v1_male^4" , andar = false , loop = true },
	{ nome = "dancar45" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_11_v1_male^5" , andar = false , loop = true },
	{ nome = "dancar46" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_11_v1_male^6" , andar = false , loop = true },
	{ nome = "dancar47" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_11_v2_female^1" , andar = false , loop = true },
	{ nome = "dancar48" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_11_v2_female^2" , andar = false , loop = true },
	{ nome = "dancar49" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_11_v2_female^3" , andar = false , loop = true },
	{ nome = "dancar50" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_11_v2_female^4" , andar = false , loop = true },
	{ nome = "dancar51" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_11_v2_female^5" , andar = false , loop = true },
	{ nome = "dancar52" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_11_v2_female^6" , andar = false , loop = true },
	{ nome = "dancar53" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_11_v2_male^1" , andar = false , loop = true },
	{ nome = "dancar54" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_11_v2_male^2" , andar = false , loop = true },
	{ nome = "dancar55" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_11_v2_male^3" , andar = false , loop = true },
	{ nome = "dancar56" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_11_v2_male^4" , andar = false , loop = true },
	{ nome = "dancar57" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_11_v2_male^5" , andar = false , loop = true },
	{ nome = "dancar58" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_11_v2_male^6" , andar = false , loop = true },
	{ nome = "dancar59" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_13_v1_female^1" , andar = false , loop = true },
	{ nome = "dancar60" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_13_v1_female^2" , andar = false , loop = true },
	{ nome = "dancar61" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_13_v1_female^3" , andar = false , loop = true },
	{ nome = "dancar62" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_13_v1_female^4" , andar = false , loop = true },
	{ nome = "dancar63" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_13_v1_female^5" , andar = false , loop = true },
	{ nome = "dancar64" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_13_v1_female^6" , andar = false , loop = true },
	{ nome = "dancar65" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_13_v1_male^1" , andar = false , loop = true },
	{ nome = "dancar66" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_13_v1_male^2" , andar = false , loop = true },
	{ nome = "dancar67" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_13_v1_male^3" , andar = false , loop = true },
	{ nome = "dancar68" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_13_v1_male^4" , andar = false , loop = true },
	{ nome = "dancar69" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_13_v1_male^5" , andar = false , loop = true },
	{ nome = "dancar70" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_13_v1_male^6" , andar = false , loop = true },
	{ nome = "dancar71" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_13_v2_female^1" , andar = false , loop = true },
	{ nome = "dancar72" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_13_v2_female^2" , andar = false , loop = true },
	{ nome = "dancar73" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_13_v2_female^3" , andar = false , loop = true },
	{ nome = "dancar74" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_13_v2_female^4" , andar = false , loop = true },
	{ nome = "dancar75" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_13_v2_female^5" , andar = false , loop = true },
	{ nome = "dancar76" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_13_v2_female^6" , andar = false , loop = true },
	{ nome = "dancar77" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_13_v2_male^1" , andar = false , loop = true },
	{ nome = "dancar78" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_13_v2_male^2" , andar = false , loop = true },
	{ nome = "dancar79" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_13_v2_male^3" , andar = false , loop = true },
	{ nome = "dancar80" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_13_v2_male^4" , andar = false , loop = true },
	{ nome = "dancar81" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_13_v2_male^5" , andar = false , loop = true },
	{ nome = "dancar82" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_13_v2_male^6" , andar = false , loop = true },
	{ nome = "dancar83" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_15_v1_female^1" , andar = false , loop = true },
	{ nome = "dancar84" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_15_v1_female^2" , andar = false , loop = true },
	{ nome = "dancar85" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_15_v1_female^3" , andar = false , loop = true },
	{ nome = "dancar86" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_15_v1_female^4" , andar = false , loop = true },
	{ nome = "dancar87" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_15_v1_female^5" , andar = false , loop = true },
	{ nome = "dancar88" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_15_v1_female^6" , andar = false , loop = true },
	{ nome = "dancar89" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_15_v1_male^1" , andar = false , loop = true },
	{ nome = "dancar90" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_15_v1_male^2" , andar = false , loop = true },
	{ nome = "dancar91" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_15_v1_male^3" , andar = false , loop = true },
	{ nome = "dancar92" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_15_v1_male^4" , andar = false , loop = true },
	{ nome = "dancar93" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_15_v1_male^5" , andar = false , loop = true },
	{ nome = "dancar94" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_15_v1_male^6" , andar = false , loop = true },
	{ nome = "dancar95" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_15_v2_female^1" , andar = false , loop = true },
	{ nome = "dancar96" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_15_v2_female^2" , andar = false , loop = true },
	{ nome = "dancar97" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_15_v2_female^3" , andar = false , loop = true },
	{ nome = "dancar98" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_15_v2_female^4" , andar = false , loop = true },
	{ nome = "dancar99" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_15_v2_female^5" , andar = false , loop = true },
	{ nome = "dancar100" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_15_v2_female^6" , andar = false , loop = true },
	{ nome = "dancar101" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_15_v2_male^1" , andar = false , loop = true },
	{ nome = "dancar102" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_15_v2_male^2" , andar = false , loop = true },
	{ nome = "dancar103" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_15_v2_male^3" , andar = false , loop = true },
	{ nome = "dancar104" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_15_v2_male^4" , andar = false , loop = true },
	{ nome = "dancar105" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_15_v2_male^5" , andar = false , loop = true },
	{ nome = "dancar106" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_15_v2_male^6" , andar = false , loop = true },
	{ nome = "dancar107" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_17_v1_female^1" , andar = false , loop = true },
	{ nome = "dancar108" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_17_v1_female^2" , andar = false , loop = true },
	{ nome = "dancar109" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_17_v1_female^3" , andar = false , loop = true },
	{ nome = "dancar110" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_17_v1_female^4" , andar = false , loop = true },
	{ nome = "dancar111" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_17_v1_female^5" , andar = false , loop = true },
	{ nome = "dancar112" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_17_v1_female^6" , andar = false , loop = true },
	{ nome = "dancar113" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_17_v1_male^1" , andar = false , loop = true },
	{ nome = "dancar114" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_17_v1_male^2" , andar = false , loop = true },
	{ nome = "dancar115" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_17_v1_male^3" , andar = false , loop = true },
	{ nome = "dancar116" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_17_v1_male^4" , andar = false , loop = true },
	{ nome = "dancar117" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_17_v1_male^5" , andar = false , loop = true },
	{ nome = "dancar118" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_17_v1_male^6" , andar = false , loop = true },
	{ nome = "dancar119" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_17_v2_female^1" , andar = false , loop = true },
	{ nome = "dancar120" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_17_v2_female^2" , andar = false , loop = true },
	{ nome = "dancar121" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_17_v2_female^3" , andar = false , loop = true },
	{ nome = "dancar122" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_17_v2_female^4" , andar = false , loop = true },
	{ nome = "dancar123" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_17_v2_female^5" , andar = false , loop = true },
	{ nome = "dancar124" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_17_v2_female^6" , andar = false , loop = true },
	{ nome = "dancar125" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_17_v2_male^1" , andar = false , loop = true },
	{ nome = "dancar126" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_17_v2_male^2" , andar = false , loop = true },
	{ nome = "dancar127" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_17_v2_male^3" , andar = false , loop = true },
	{ nome = "dancar128" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_17_v2_male^4" , andar = false , loop = true },
	{ nome = "dancar129" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_17_v2_male^5" , andar = false , loop = true },
	{ nome = "dancar130" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_17_v2_male^6" , andar = false , loop = true },
	{ nome = "dancar131" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_09_v1_female^1" , andar = false , loop = true },
	{ nome = "dancar132" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_09_v1_female^2" , andar = false , loop = true },
	{ nome = "dancar133" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_09_v1_female^3" , andar = false , loop = true },
	{ nome = "dancar134" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_09_v1_female^4" , andar = false , loop = true },
	{ nome = "dancar135" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_09_v1_female^5" , andar = false , loop = true },
	{ nome = "dancar136" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_09_v1_female^6" , andar = false , loop = true },
	{ nome = "dancar137" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_09_v1_male^1" , andar = false , loop = true },
	{ nome = "dancar138" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_09_v1_male^2" , andar = false , loop = true },
	{ nome = "dancar139" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_09_v1_male^3" , andar = false , loop = true },
	{ nome = "dancar140" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_09_v1_male^4" , andar = false , loop = true },
	{ nome = "dancar141" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_09_v1_male^5" , andar = false , loop = true },
	{ nome = "dancar142" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_09_v1_male^6" , andar = false , loop = true },
	{ nome = "dancar143" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_09_v2_female^1" , andar = false , loop = true },
	{ nome = "dancar144" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_09_v2_female^2" , andar = false , loop = true },
	{ nome = "dancar145" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_09_v2_female^3" , andar = false , loop = true },
	{ nome = "dancar146" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_09_v2_female^4" , andar = false , loop = true },
	{ nome = "dancar147" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_09_v2_female^5" , andar = false , loop = true },
	{ nome = "dancar148" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_09_v2_female^6" , andar = false , loop = true },
	{ nome = "dancar149" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_09_v2_male^1" , andar = false , loop = true },
	{ nome = "dancar150" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_09_v2_male^2" , andar = false , loop = true },
	{ nome = "dancar151" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_09_v2_male^3" , andar = false , loop = true },
	{ nome = "dancar152" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_09_v2_male^4" , andar = false , loop = true },
	{ nome = "dancar153" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_09_v2_male^5" , andar = false , loop = true },
	{ nome = "dancar154" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_09_v2_male^6" , andar = false , loop = true },
	{ nome = "dancar155" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_11_v1_female^1" , andar = false , loop = true },
	{ nome = "dancar156" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_11_v1_female^2" , andar = false , loop = true },
	{ nome = "dancar157" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_11_v1_female^3" , andar = false , loop = true },
	{ nome = "dancar158" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_11_v1_female^4" , andar = false , loop = true },
	{ nome = "dancar159" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_11_v1_female^5" , andar = false , loop = true },
	{ nome = "dancar160" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_11_v1_female^6" , andar = false , loop = true },
	{ nome = "dancar161" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_11_v1_male^1" , andar = false , loop = true },
	{ nome = "dancar162" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_11_v1_male^2" , andar = false , loop = true },
	{ nome = "dancar163" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_11_v1_male^3" , andar = false , loop = true },
	{ nome = "dancar164" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_11_v1_male^4" , andar = false , loop = true },
	{ nome = "dancar165" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_11_v1_male^5" , andar = false , loop = true },
	{ nome = "dancar166" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_11_v1_male^6" , andar = false , loop = true },
	{ nome = "dancar167" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_13_v2_female^1" , andar = false , loop = true },
	{ nome = "dancar168" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_13_v2_female^2" , andar = false , loop = true },
	{ nome = "dancar169" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_13_v2_female^3" , andar = false , loop = true },
	{ nome = "dancar170" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_13_v2_female^4" , andar = false , loop = true },
	{ nome = "dancar171" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_13_v2_female^5" , andar = false , loop = true },
	{ nome = "dancar172" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_13_v2_female^6" , andar = false , loop = true },
	{ nome = "dancar173" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_13_v2_male^1" , andar = false , loop = true },
	{ nome = "dancar174" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_13_v2_male^2" , andar = false , loop = true },
	{ nome = "dancar175" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_13_v2_male^3" , andar = false , loop = true },
	{ nome = "dancar176" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_13_v2_male^4" , andar = false , loop = true },
	{ nome = "dancar177" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_13_v2_male^5" , andar = false , loop = true },
	{ nome = "dancar178" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_13_v2_male^6" , andar = false , loop = true },
	{ nome = "dancar179" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_15_v1_female^1" , andar = false , loop = true },
	{ nome = "dancar180" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_15_v1_female^2" , andar = false , loop = true },
	{ nome = "dancar181" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_15_v1_female^3" , andar = false , loop = true },
	{ nome = "dancar182" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_15_v1_female^4" , andar = false , loop = true },
	{ nome = "dancar183" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_15_v1_female^5" , andar = false , loop = true },
	{ nome = "dancar184" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_15_v1_female^6" , andar = false , loop = true },
	{ nome = "dancar185" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_15_v1_male^1" , andar = false , loop = true },
	{ nome = "dancar186" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_15_v1_male^2" , andar = false , loop = true },
	{ nome = "dancar187" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_15_v1_male^3" , andar = false , loop = true },
	{ nome = "dancar188" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_15_v1_male^4" , andar = false , loop = true },
	{ nome = "dancar189" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_15_v1_male^5" , andar = false , loop = true },
	{ nome = "dancar190" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_15_v1_male^6" , andar = false , loop = true },
	{ nome = "dancar191" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_15_v2_female^1" , andar = false , loop = true },
	{ nome = "dancar192" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_15_v2_female^2" , andar = false , loop = true },
	{ nome = "dancar193" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_15_v2_female^3" , andar = false , loop = true },
	{ nome = "dancar194" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_15_v2_female^4" , andar = false , loop = true },
	{ nome = "dancar195" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_15_v2_female^5" , andar = false , loop = true },
	{ nome = "dancar196" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_15_v2_female^6" , andar = false , loop = true },
	{ nome = "dancar197" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_15_v2_male^1" , andar = false , loop = true },
	{ nome = "dancar198" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_15_v2_male^2" , andar = false , loop = true },
	{ nome = "dancar199" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_15_v2_male^3" , andar = false , loop = true },
	{ nome = "dancar200" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_15_v2_male^4" , andar = false , loop = true },
	{ nome = "dancar201" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_15_v2_male^5" , andar = false , loop = true },
	{ nome = "dancar202" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_15_v2_male^6" , andar = false , loop = true },
	{ nome = "dancar203" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_17_v1_female^1" , andar = false , loop = true },
	{ nome = "dancar204" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_17_v1_female^2" , andar = false , loop = true },
	{ nome = "dancar205" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_17_v1_female^3" , andar = false , loop = true },
	{ nome = "dancar206" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_17_v1_female^4" , andar = false , loop = true },
	{ nome = "dancar207" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_17_v1_female^5" , andar = false , loop = true },
	{ nome = "dancar208" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_17_v1_female^6" , andar = false , loop = true },
	{ nome = "dancar209" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_17_v1_male^1" , andar = false , loop = true },
	{ nome = "dancar210" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_17_v1_male^2" , andar = false , loop = true },
	{ nome = "dancar211" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_17_v1_male^3" , andar = false , loop = true },
	{ nome = "dancar212" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_17_v1_male^4" , andar = false , loop = true },
	{ nome = "dancar213" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_17_v1_male^5" , andar = false , loop = true },
	{ nome = "dancar214" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_17_v1_male^6" , andar = false , loop = true },
	{ nome = "dancar215" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_17_v2_female^1" , andar = false , loop = true },
	{ nome = "dancar216" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_17_v2_female^2" , andar = false , loop = true },
	{ nome = "dancar217" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_17_v2_female^3" , andar = false , loop = true },
	{ nome = "dancar218" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_17_v2_female^4" , andar = false , loop = true },
	{ nome = "dancar219" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_17_v2_female^5" , andar = false , loop = true },
	{ nome = "dancar220" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_17_v2_female^6" , andar = false , loop = true },
	{ nome = "dancar221" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_17_v2_male^1" , andar = false , loop = true },
	{ nome = "dancar222" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_17_v2_male^2" , andar = false , loop = true },
	{ nome = "dancar223" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_17_v2_male^3" , andar = false , loop = true },
	{ nome = "dancar224" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_17_v2_male^4" , andar = false , loop = true },
	{ nome = "dancar225" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_17_v2_male^5" , andar = false , loop = true },
	{ nome = "dancar226" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_17_v2_male^6" , andar = false , loop = true },
	{ nome = "sexo" , dict = "rcmpaparazzo_2" , anim = "shag_loop_poppy" , andar = false , loop = true },
	{ nome = "sexo2" , dict = "rcmpaparazzo_2" , anim = "shag_loop_a" , andar = false , loop = true },
	{ nome = "sexo3" , dict = "anim@mp_player_intcelebrationfemale@air_shagging" , anim = "air_shagging" , andar = false , loop = true },
	{ nome = "sexo4" , dict = "oddjobs@towing" , anim = "m_blow_job_loop" , andar = false , loop = true , carros = true },
	{ nome = "sexo5" , dict = "oddjobs@towing" , anim = "f_blow_job_loop" , andar = false , loop = true , carros = true },
	{ nome = "sexo6" , dict = "mini@prostitutes@sexlow_veh" , anim = "low_car_sex_loop_female" , andar = false , loop = true , carros = true },
	{ nome = "sentar" , anim = "PROP_HUMAN_SEAT_CHAIR_MP_PLAYER" },
	{ nome = "sentar2" , dict = "amb@world_human_picnic@male@base" , anim = "base" , andar = false , loop = true },
	{ nome = "sentar3" , dict = "anim@heists@fleeca_bank@ig_7_jetski_owner" , anim = "owner_idle" , andar = false , loop = true },
	{ nome = "sentar4" , dict = "amb@world_human_stupor@male@base" , anim = "base" , andar = false , loop = true },
	{ nome = "sentar5" , dict = "amb@world_human_picnic@female@base" , anim = "base" , andar = false , loop = true },
	{ nome = "sentar6" , dict = "anim@amb@nightclub@lazlow@lo_alone@" , anim = "lowalone_base_laz" , andar = false , loop = true },
	{ nome = "beijar" , dict = "mp_ped_interaction" , anim = "kisses_guy_a" , andar = false , loop = false },
	{ nome = "striper" , dict = "mini@strip_club@idles@stripper" , anim = "stripper_idle_02" , andar = false , loop = true },
	{ nome = "escutar" , dict = "mini@safe_cracking" , anim = "idle_base" , andar = false , loop = true },
	{ nome = "alongar" , dict = "anim@deathmatch_intros@unarmed" , anim = "intro_male_unarmed_e" , andar = false , loop = true },
	{ nome = "dj" , dict = "anim@mp_player_intupperdj" , anim = "idle_a", andar = true , loop = true },
	{ nome = "rock" , dict = "anim@mp_player_intcelebrationmale@air_guitar" , anim = "air_guitar" , andar = false , loop = true },
	{ nome = "rock2" , dict = "mp_player_introck" , anim = "mp_player_int_rock" , andar = false , loop = false },
	{ nome = "abracar" , dict = "mp_ped_interaction" , anim = "hugs_guy_a" , andar = false , loop = false },
	{ nome = "abracar2" , dict = "mp_ped_interaction" , anim = "kisses_guy_b" , andar = false , loop = false },
	{ nome = "peitos" , dict = "mini@strip_club@backroom@" , anim = "stripper_b_backroom_idle_b" , andar = false , loop = false },
	{ nome = "espernear" , dict = "missfam4leadinoutmcs2" , anim = "tracy_loop" , andar = false , loop = true },
	{ nome = "arrumar" , dict = "anim@amb@business@coc@coc_packing_hi@" , anim = "full_cycle_v1_pressoperator" , andar = false , loop = true },
	{ nome = "bebado" , dict = "missfam5_blackout" , anim = "pass_out" , andar = false , loop = false },
	{ nome = "bebado2" , dict = "missheist_agency3astumble_getup" , anim = "stumble_getup" , andar = false , loop = false },
	{ nome = "bebado3" , dict = "missfam5_blackout" , anim = "vomit" , andar = false , loop = false },
	{ nome = "yoga" , dict = "missfam5_yoga" , anim = "f_yogapose_a" , andar = false , loop = true },
	{ nome = "yoga2" , dict = "amb@world_human_yoga@male@base" , anim = "base_a" , andar = false , loop = true },
	{ nome = "abdominal" , dict = "amb@world_human_sit_ups@male@base" , anim = "base" , andar = false , loop = true },
	{ nome = "bixa" , anim = "WORLD_HUMAN_PROSTITUTE_LOW_CLASS" },
	{ nome = "britadeira" , dict = "amb@world_human_const_drill@male@drill@base" , anim = "base" , prop = "prop_tool_jackham" , flag = 15 , mao = 28422 },
	{ nome = "cerveja" , anim = "WORLD_HUMAN_PARTYING" },
	{ nome = "churrasco" , anim = "PROP_HUMAN_BBQ" },
	{ nome = "consertar" , anim = "WORLD_HUMAN_WELDING" },
	{ nome = "dormir" , dict = "anim@heists@ornate_bank@hostages@hit" , anim = "hit_react_die_loop_ped_a" , andar = false , loop = true },
	{ nome = "dormir2" , dict = "anim@heists@ornate_bank@hostages@hit" , anim = "hit_react_die_loop_ped_e" , andar = false , loop = true },
	{ nome = "dormir3" , dict = "anim@heists@ornate_bank@hostages@hit" , anim = "hit_react_die_loop_ped_h" , andar = false , loop = true },
	{ nome = "encostar" , dict = "amb@lo_res_idles@" , anim = "world_human_lean_male_foot_up_lo_res_base" , andar = false , loop = true },
	{ nome = "estatua" , dict = "amb@world_human_statue@base" , anim = "base" , andar = false , loop = true },
	{ nome = "flexao" , dict = "amb@world_human_push_ups@male@base" , anim = "base" , andar = false , loop = true },
	{ nome = "fumar" , anim = "WORLD_HUMAN_SMOKING" },
	{ nome = "fumar2" , anim = "WORLD_HUMAN_PROSTITUTE_HIGH_CLASS" },
	{ nome = "fumar3" , anim = "WORLD_HUMAN_AA_SMOKE" },
	{ nome = "fumar4" , anim = "WORLD_HUMAN_SMOKING_POT" },
	{ nome = "malhar" , dict = "amb@world_human_muscle_free_weights@male@barbell@base" , anim = "base" , prop = "prop_curl_bar_01" , flag = 49 , mao = 28422 },
	{ nome = "malhar2" , dict = "amb@prop_human_muscle_chin_ups@male@base" , anim = "base" , andar = false , loop = true },
	{ nome = "martelo" , dict = "amb@world_human_hammering@male@base" , anim = "base" , prop = "prop_tool_hammer" , flag = 49 , mao = 28422 },
	{ nome = "pescar" , dict = "amb@world_human_stand_fishing@base" , anim = "base" , prop = "prop_fishing_rod_01" , flag = 49 , mao = 60309 },
	{ nome = "pescar2" , dict = "amb@world_human_stand_fishing@idle_a" , anim = "idle_c" , prop = "prop_fishing_rod_01" , flag = 49 , mao = 60309 },
	{ nome = "plantar" , dict = "amb@world_human_gardener_plant@female@base" , anim = "base_female" , andar = false , loop = true },
	{ nome = "plantar2" , dict = "amb@world_human_gardener_plant@female@idle_a" , anim = "idle_a_female" , andar = false , loop = true },
	{ nome = "procurar" , dict = "amb@world_human_bum_wash@male@high@base" , anim = "base" , andar = false , loop = true },
	{ nome = "soprador" , dict = "amb@code_human_wander_gardener_leaf_blower@base" , anim = "static" , prop = "prop_leaf_blower_01" , flag = 49 , mao = 28422 },
	{ nome = "soprador2" , dict = "amb@code_human_wander_gardener_leaf_blower@idle_a" , anim = "idle_a" , prop = "prop_leaf_blower_01" , flag = 49 , mao = 28422 },
	{ nome = "soprador3" , dict = "amb@code_human_wander_gardener_leaf_blower@idle_a" , anim = "idle_b" , prop = "prop_leaf_blower_01" , flag = 49 , mao = 28422 },
	{ nome = "tragar" , anim = "WORLD_HUMAN_DRUG_DEALER" },
	{ nome = "trotar" , dict = "amb@world_human_jog_standing@male@fitidle_a" , anim = "idle_a" , andar = false , loop = true },
	{ nome = "esquentar" , anim = "WORLD_HUMAN_STAND_FIRE" },
	{ nome = "selfie" , dict = "cellphone@self" , anim = "selfie_in_from_text" , prop = "prop_amb_phone" , flag = 50 , mao = 28422 },
	{ nome = "selfie2" , dict = "cellphone@" , anim = "cellphone_text_read_base_cover_low" , prop = "prop_amb_phone" , flag = 50 , mao = 28422 },
	{ nome = "mecanico" , dict = "amb@world_human_vehicle_mechanic@male@idle_a" , anim = "idle_a" , andar = false , loop = true },
	{ nome = "mecanico2" , dict = "mini@repair" , anim = "fixing_a_player" , andar = false , loop = true },
	{ nome = "mecanico3" , dict = "mini@repair" , anim = "fixing_a_ped" , andar = false , loop = true },
	{ nome = "binoculos" , dict = "amb@world_human_binoculars@male@enter" , anim = "enter" , prop = "prop_binoc_01" , flag = 50 , mao = 28422 , extra = function()
		SetTimeout(900, function()
			binoculos = true
		end)
	end },
	{ nome = "pano2" , dict = "timetable@maid@cleaning_surface@base" , anim = "base" , prop = "prop_rag_01" , flag = 49 , mao = 28422 , extra = function()
		local vehicle = vRP.getNearestVehicle(7)
		if IsEntityAVehicle(vehicle) then
			SetTimeout(15000,function()
				TriggerServerEvent("tryclean",VehToNet(vehicle))
			end)
		end
	end },
	{ nome = "pano" , dict = "timetable@maid@cleaning_window@base" , anim = "base" , prop = "prop_rag_01" , flag = 49 , mao = 28422 , extra = function()
		local vehicle = vRP.getNearestVehicle(7)
		if IsEntityAVehicle(vehicle) then
			SetTimeout(15000,function()
				TriggerServerEvent("tryclean",VehToNet(vehicle))
			end)
		end
	end }
}

local playerCurrentlyHasProp = false
local surrendered = false
local playerCurrentlyAnimated = false
local LastAD = false
local objAux = nil

RegisterNetEvent('emotes')
AddEventHandler('emotes',function(nome)
	local ped = PlayerPedId()
	if GetEntityHealth(ped) > 100 then
		
		for _,emote in pairs(animacoes) do
			if not IsPedInAnyVehicle(ped) and not emote.carros then
				if nome == emote.nome then
					GiveWeaponToPed(ped, 0xA2719263, 1, false, true)
					
					playerCurrentlyAnimated = true
					local del = emote.del
					if emote.extra then emote.extra() end
					
					if emote.prop then
						playerCurrentlyHasProp = true
						-- vRP.CarregarObjeto(del,emote.dict,emote.anim,emote.prop,emote.flag,emote.mao, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
						-- if objAux == emote.prop then
						-- 	local obj = vRP.getObjeto()
						-- 	DetachEntity(obj,false,false)
						-- 	TriggerServerEvent("trydeleteobj",ObjToNet(obj))
						-- end
						vRP.DeletarObjeto()
						objAux = emote.prop
						vRP.CarregarObjeto(del,emote.dict,emote.anim,emote.prop,emote.flag,emote.mao,emote.pos1,emote.pos2,emote.pos3, emote.xa, emote.ya, emote.za)
					elseif emote.dict then
						vRP._playAnim(emote.andar,{{emote.dict,emote.anim}},emote.loop)
					else
						vRP._playAnim(false,{task=emote.anim},false)
					end
				end
			else
				if IsPedInAnyVehicle(ped) and emote.carros then
					local vehicle = GetVehiclePedIsIn(ped,false)
					if nome == emote.nome then
						if (GetPedInVehicleSeat(vehicle,-1) == ped or GetPedInVehicleSeat(vehicle,1) == ped) and emote.nome == "sexo4" then
							vRP._playAnim(emote.andar,{{emote.dict,emote.anim}},emote.loop)
						elseif (GetPedInVehicleSeat(vehicle,0) == ped or GetPedInVehicleSeat(vehicle,2) == ped) and (emote.nome == "sexo5" or emote.nome == "sexo6") then
							vRP._playAnim(emote.andar,{{emote.dict,emote.anim}},emote.loop)
						end
					end
				end
			end
		end
	end
end)



RegisterNetEvent('d_emotes')
AddEventHandler('d_emotes',function(nome)
	local ped = PlayerPedId()
	if GetEntityHealth(ped) > 100 then
		for _,emote in pairs(animacoes) do
			if not IsPedInAnyVehicle(ped) and not emote.carros then
				if nome == emote.nome then
					if emote.prop then
						local coord = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 1.5, -0.94)
						if DoesObjectOfTypeExistAtCoords(coord.x, coord.y, coord.z, 1.5, GetHashKey(emote.prop), true) then
							local objeto = GetClosestObjectOfType(coord.x, coord.y, coord.z, 0.9,GetHashKey(emote.prop), false, false,false)
							TriggerServerEvent("trydeleteobj", ObjToNet(objeto))
						end
						return 
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BINOCULOS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	SetTimeout(1000, function()
		while true do
			Citizen.Wait(1)
			if binoculos then
				local scaleform = RequestScaleformMovie("BINOCULARS")
				while not HasScaleformMovieLoaded(scaleform) do
					Citizen.Wait(10)
				end
	
				local cam = CreateCam("DEFAULT_SCRIPTED_FLY_CAMERA",true)
				AttachCamToEntity(cam,PlayerPedId(),0.0,0.0,1.0,true)
				SetCamRot(cam,0.0,0.0,GetEntityHeading(PlayerPedId()))
				SetCamFov(cam,fov)
				RenderScriptCams(true,false,0,1,0)
	
				while binoculos and true do
					Citizen.Wait(1)
					BlockWeaponWheelThisFrame()
					local zoomvalue = (1.0/(fov_max-fov_min))*(fov-fov_min)
					CheckInputRotation(cam,zoomvalue)
					HandleZoom(cam)
					DrawScaleformMovieFullscreen(scaleform,255,255,255,255)
				end
	
				fov = (fov_max+fov_min)*0.5
				RenderScriptCams(false,false,0,1,0)
				SetScaleformMovieAsNoLongerNeeded(scaleform)
				DestroyCam(cam,false)
				SetNightvision(false)
				SetSeethrough(false)
			end
		end
	end)
end)

RegisterNetEvent('binoculos')
AddEventHandler('binoculos',function()
	if IsEntityPlayingAnim(PlayerPedId(),"amb@world_human_binoculars@male@enter","enter",3) then
		binoculos = true
	else
		binoculos = false
	end
end)


function CheckInputRotation(cam,zoomvalue)
	local rightAxisX = GetDisabledControlNormal(0,220)
	local rightAxisY = GetDisabledControlNormal(0,221)
	local rotation = GetCamRot(cam,2)
	if rightAxisX ~= 0.0 or rightAxisY ~= 0.0 then
		new_z = rotation.z+rightAxisX*-1.0*(8.0)*(zoomvalue+0.1)
		new_x = math.max(math.min(20.0,rotation.x+rightAxisY*-1.0*(8.0)*(zoomvalue+0.1)),-89.5)
		SetCamRot(cam,new_x,0.0,new_z,2)
	end
end

function HandleZoom(cam)
	if IsControlJustPressed(0,241) then
		fov = math.max(fov-10.0,fov_min)
	end

	if IsControlJustPressed(0,242) then
		fov = math.min(fov+10.0,fov_max)
	end

	local current_fov = GetCamFov(cam)
	if math.abs(fov-current_fov) < 0.1 then
		fov = current_fov
	end
	SetCamFov(cam,current_fov+(fov-current_fov)*0.05)
end