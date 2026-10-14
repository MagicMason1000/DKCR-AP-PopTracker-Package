local jungle <const>, beach <const>, ruins <const>, cave <const>, forest <const>, cliff <const>, factory <const>, volcano <const>, temple <const> = 0x100, 0x200, 0x300, 0x400, 0x500, 0x600, 0x700, 0x800, 0x900
local collectables <const>, key <const>, orb <const>, ability <const>, unlock <const>, shop <const>, filler <const> = 0x1000, 0x2000, 0x3000, 0x4000, 0x5000, 0x6000, 0x10000

ITEM_MAPPING = {
	[collectables + 0x1] = { { "puzzle_piece" } },
	[collectables + jungle + 0x2]  = { { "letters_1" } },
	[collectables + beach + 0x2]   = { { "letters_2" } },
	[collectables + ruins + 0x2]   = { { "letters_3" } },
	[collectables + cave + 0x2]    = { { "letters_4" } },
	[collectables + forest + 0x2]  = { { "letters_5" } },
	[collectables + cliff + 0x2]   = { { "letters_6" } },
	[collectables + factory + 0x2] = { { "letters_7" } },
	[collectables + volcano + 0x2] = { { "letters_8" } },

	[key + jungle]  = { { "key_1" } },
	[key + beach]   = { { "key_2" } },
	[key + ruins]   = { { "key_3" } },
	[key + cave]    = { { "key_4" } },
	[key + forest]  = { { "key_5" } },
	[key + cliff]   = { { "key_6" } },
	[key + factory] = { { "key_7" } },
	[key + volcano] = { { "key_8" } },
	
	[orb] = { { "rare_orb" } },
	
	-- Abilities and vehicles here
	
	[unlock + 0x1] = { { "mirror_shard" } },
	[unlock + 0x2] = { { "mirror_mode_unlock" } },
	[unlock + 0x3] = { { "factory_button" } },
	[unlock + 0x4] = { { "progressive_boss_unlock" } },
	
	[shop + 0x1] = { { "squawks" } },

	[filler + 0x1] = { { "balloon" } },
	[filler + 0x2] = { { "balloon", nil, 3 } },
	[filler + 0x3] = { { "balloon", nil, 7 } },
	[filler + 0x4] = { { "banana" } },
	[filler + 0x5] = { { "banana", nil, 10 } },
	[filler + 0x6] = { { "banana", nil, 25 } },
	[filler + 0x7] = { { "coin" } },
	[filler + 0x8] = { { "heart" } },
}