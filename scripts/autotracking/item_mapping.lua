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
	
	[26] = { { "balloons" } },
	[27] = { { "balloons", nil, 3 } },
	[28] = { { "balloons", nil, 7 } },
}