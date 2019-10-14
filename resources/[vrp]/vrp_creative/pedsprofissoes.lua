local pedlist = {
	{ ['x'] = 426.10, ['y'] = 6463.47, ['z'] = 28.77, ['h'] = 315.75, ['hash'] = 0xFCFA9E1E, ['hash2'] = "A_C_Cow" },
	{ ['x'] = 431.42, ['y'] = 6459.22, ['z'] = 28.75, ['h'] = 318.05, ['hash'] = 0xFCFA9E1E, ['hash2'] = "A_C_Cow" },
	{ ['x'] = 436.70, ['y'] = 6454.85, ['z'] = 28.74, ['h'] = 321.40, ['hash'] = 0xFCFA9E1E, ['hash2'] = "A_C_Cow" },
	{ ['x'] = 428.42, ['y'] = 6477.27, ['z'] = 28.78, ['h'] = 134.37, ['hash'] = 0xFCFA9E1E, ['hash2'] = "A_C_Cow" },
	{ ['x'] = 1151.77, ['y'] = -3248.77, ['z'] = 5.90, ['h'] = 181.03, ['hash'] = 0x6C9B2849, ['hash2'] = "a_m_m_hillbilly_01" },
	{ ['x'] = 1152.27, ['y'] = -3248.77, ['z'] = 5.90, ['h'] = 181.03, ['hash'] = 0x349F33E1, ['hash2'] = "a_c_retriever" },
	{ ['x'] = 1151.26, ['y'] = -3248.77, ['z'] = 5.90, ['h'] = 181.03, ['hash'] = 0x9563221D, ['hash2'] = "a_c_rottweiler" }
}

Citizen.CreateThread(function()
	for k,v in pairs(pedlist) do
		RequestModel(GetHashKey(v.hash2))
		while not HasModelLoaded(GetHashKey(v.hash2)) do
			Citizen.Wait(10)
		end

		local ped = CreatePed(4,v.hash,v.x,v.y,v.z-1,v.h,false,true)
		FreezeEntityPosition(ped,true)
		SetEntityInvincible(ped,true)
	end
end)