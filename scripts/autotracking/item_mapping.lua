-- This links the addresses of the item on the server side to the item on the poptracker side. These constant tables define the addresses.
local itemType <const> = {
	Collectables = 0x1000,
	Key = 0x2000,
	Orb = 0x3000,
	Ability = 0x4000,
	Unlock = 0x5000,
	Shop = 0x6000,
	Filler = 0x10000
}

local item <const> = {
	PuzzlePiece = 0x1,
	KONGLetter = 0x2,
	MirrorShard = 0x1,
	MirrorModeUnlock = 0x2,
	FactoryButton = 0x3,
	BossUnlock = 0x4,
	Squawks = 0x1,
	Balloonx1 = 0x1,
	Balloonx3 = 0x2,
	Balloonx7 = 0x3,
	Banana = 0x4,
	BananaBunch = 0x5,
	BigBananaBunch = 0x6,
	Coin = 0x7,
	Heart = 0x8,
}

local world <const> = {
	Jungle = 0x100,
	Beach = 0x200,
	Ruins = 0x300,
	Cave = 0x400,
	Forest = 0x500,
	Cliff = 0x600,
	Factory = 0x700,
	Volcano = 0x800,
	GoldenTemple = 0x900
}

-- MARK: Items
ITEM_MAPPING = {
	[itemType.Collectables + item.PuzzlePiece] = { { "puzzle_piece" } },
	[itemType.Collectables + item.KONGLetter + world.Jungle]  = { { "letters_1" } },
	[itemType.Collectables + item.KONGLetter + world.Beach]   = { { "letters_2" } },
	[itemType.Collectables + item.KONGLetter + world.Ruins]   = { { "letters_3" } },
	[itemType.Collectables + item.KONGLetter + world.Cave]    = { { "letters_4" } },
	[itemType.Collectables + item.KONGLetter + world.Forest]  = { { "letters_5" } },
	[itemType.Collectables + item.KONGLetter + world.Cliff]   = { { "letters_6" } },
	[itemType.Collectables + item.KONGLetter + world.Factory] = { { "letters_7" } },
	[itemType.Collectables + item.KONGLetter + world.Volcano] = { { "letters_8" } },

	[itemType.Key + world.Jungle]  = { { "key_1" } },
	[itemType.Key + world.Beach]   = { { "key_2" } },
	[itemType.Key + world.Ruins]   = { { "key_3" } },
	[itemType.Key + world.Cave]    = { { "key_4" } },
	[itemType.Key + world.Forest]  = { { "key_5" } },
	[itemType.Key + world.Cliff]   = { { "key_6" } },
	[itemType.Key + world.Factory] = { { "key_7" } },
	[itemType.Key + world.Volcano] = { { "key_8" } },
	
	[itemType.Orb] = { { "rare_orb" } },
	
	-- Abilities and vehicles here
	
	[itemType.Unlock + item.MirrorShard] = { { "mirror_shard" } },
	[itemType.Unlock + item.MirrorModeUnlock] = { { "mirror_mode_unlock" } },
	[itemType.Unlock + item.FactoryButton] = { { "factory_button" } },
	[itemType.Unlock + item.BossUnlock] = { { "boss_unlock" } },
	
	[itemType.Shop + item.Squawks] = { { "squawks" } },

	[itemType.Filler + item.Balloonx1] = { { "balloon" } },
	[itemType.Filler + item.Balloonx3] = { { "balloon", nil, 3 } },
	[itemType.Filler + item.Balloonx7] = { { "balloon", nil, 7 } },
	[itemType.Filler + item.Banana] = { { "banana" } },
	[itemType.Filler + item.BananaBunch] = { { "banana", nil, 10 } },
	[itemType.Filler + item.BigBananaBunch] = { { "banana", nil, 25 } },
	[itemType.Filler + item.Coin] = { { "coin" } },
	[itemType.Filler + item.Heart] = { { "heart" } },
}