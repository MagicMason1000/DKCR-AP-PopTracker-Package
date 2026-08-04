WORLD_OFFEST = 0x1000
ITEM_OFFSET = 0x2000
ITEM_MAPPING = {
	[ITEM_OFFSET + 0x01] = { { "puzzle_piece" } },
	[WORLD_OFFEST + 0x00] = { { "letters_beach" } },
	[WORLD_OFFEST + 0x01] = { { "letters_cave" } },
	[WORLD_OFFEST + 0x02] = { { "letters_cliff" } },
	[WORLD_OFFEST + 0x03] = { { "letters_factory" } },
	[WORLD_OFFEST + 0x04] = { { "letters_forest" } },
	[WORLD_OFFEST + 0x05] = { { "letters_jungle" } },
	[WORLD_OFFEST + 0x06] = { { "letters_ruins" } },
	[WORLD_OFFEST + 0x07] = { { "letters_volcano" } },
	
	--[[

	[WORLD_OFFEST + 0x??] = { { "key_2" } },
	[WORLD_OFFEST + 0x??] = { { "key_4" } },
	[WORLD_OFFEST + 0x??] = { { "key_6" } },
	[WORLD_OFFEST + 0x??] = { { "key_7" } },
	[WORLD_OFFEST + 0x??] = { { "key_5" } },
	[WORLD_OFFEST + 0x??] = { { "key_1" } },
	[WORLD_OFFEST + 0x??] = { { "key_3" } },
	[WORLD_OFFEST + 0x??] = { { "key_8" } },
	
	[WORLD_OFFEST + 0x??] = { { "rare_orb_1" } },
	[WORLD_OFFEST + 0x??] = { { "rare_orb_2" } },
	[WORLD_OFFEST + 0x??] = { { "rare_orb_3" } },
	[WORLD_OFFEST + 0x??] = { { "rare_orb_4" } },
	[WORLD_OFFEST + 0x??] = { { "rare_orb_5" } },
	[WORLD_OFFEST + 0x??] = { { "rare_orb_6" } },
	[WORLD_OFFEST + 0x??] = { { "rare_orb_7" } },
	[WORLD_OFFEST + 0x??] = { { "rare_orb_8" } },
	
	[26] = { { "balloon" } },
	[27] = { { "balloon", nil, 3 } },
	[28] = { { "balloon", nil, 7 } },

	[] = { { "banana" } },
	[] = { { "banana", nil, 10 } },
	[] = { { "banana", nil, 25 } },
	[] = { { "coin" } }
	
	]]
}