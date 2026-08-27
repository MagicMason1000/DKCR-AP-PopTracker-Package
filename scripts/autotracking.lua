-- Configuration --------------------------------------
AUTOTRACKER_ENABLE_ITEM_TRACKING = true
AUTOTRACKER_ENABLE_LOCATION_TRACKING = true and not IS_ITEMS_ONLY
ENABLE_WORLDCHECK_LOG  = ENABLE_DEBUG_LOG and false
ENABLE_LETTERCHECK_LOG = ENABLE_DEBUG_LOG and false
ENABLE_BOSSCHECK_LOG   = ENABLE_DEBUG_LOG and false
ENABLE_SHARDCHECK_LOG  = ENABLE_DEBUG_LOG and false
ENABLE_ORBCHECK_LOG    = ENABLE_DEBUG_LOG and false
ENABLE_SMOGCHECK_LOG   = ENABLE_DEBUG_LOG and false
ENABLE_BUTTONCHECK_LOG = ENABLE_DEBUG_LOG and false
ENABLE_LOLCHECK_LOG    = ENABLE_DEBUG_LOG and false
-------------------------------------------------------
print("")
print("Active Auto-Tracker Configuration")
print("---------------------------------------------------------------------")
print(string.format("Enable Item Tracking:\t\t%s", AUTOTRACKER_ENABLE_ITEM_TRACKING))
print(string.format("Enable Location Tracking:\t%s", AUTOTRACKER_ENABLE_LOCATION_TRACKING))
if ENABLE_DEBUG_LOG then
    print("\nDEBUG LOGGING ENABLED")
    print(string.format("Enable WorldCheck Logging:\t%s", ENABLE_WORLDCHECK_LOG))
    print(string.format("Enable LetterCheck Logging:\t%s", ENABLE_LETTERCHECK_LOG))
    print(string.format("Enable BossCheck Logging:\t%s", ENABLE_BOSSCHECK_LOG))
    print(string.format("Enable ShardCheck Logging:\t%s", ENABLE_SHARDCHECK_LOG))
    print(string.format("Enable OrbCheck Logging:\t%s", ENABLE_ORBCHECK_LOG))
    print(string.format("Enable SmogCheck Logging:\t%s", ENABLE_SMOGCHECK_LOG))
    print(string.format("Enable ButtonCheck Logging:\t%s", ENABLE_BUTTONCHECK_LOG))
    print(string.format("Enable LolCheck Logging:\t%s", ENABLE_LOLCHECK_LOG))
end
print("---------------------------------------------------------------------")
print("")

-- uncomment this to use `Tracker.AllowDeferredLogicUpdate` to defer logic updates, which might be needed if you touch A LOT of items/locations at once.
-- if Tracker.AllowDeferredLogicUpdate == false then Tracker.AllowDeferredLogicUpdate = true end

-- loads the AP autotracking code
ScriptHost:LoadScript("scripts/autotracking/archipelago.lua")
ScriptHost:LoadScript("scripts/autotracking/logic.lua")
ScriptHost:LoadScript("scripts/autotracking/watch.lua")

-- Runs all of the functions from watch.lua once when the pack loads. Otherwise they wont run until something updates, which can be confusing for the user.
SetLetterStatus("kReq1", "letters_1")
SetLetterStatus("kReq2", "letters_2")
SetLetterStatus("kReq3", "letters_3")
SetLetterStatus("kReq4", "letters_4")
SetLetterStatus("kReq5", "letters_5")
SetLetterStatus("kReq6", "letters_6")
SetLetterStatus("kReq7", "letters_7")
SetLetterStatus("kReq8", "letters_8")
SetPuzzleStatus()
SetItemStatus("Button")
SetItemStatus("Shard")

-- Sets global values used by logic.lua.
WORLDS = { "Jungle", "Beach", "Ruins", "Cave", "Forest", "Cliff", "Factory", "Volcano", "Golden Temple" }

LEVELS = {
    { code = "@Jungle/1-1 Jungle Hijinxs", value = 9 },
    { code = "@Jungle/1-2 King of Cling", value = 7 },
    { code = "@Jungle/1-3 Tree Top Bop", value = 5 },
    { code = "@Jungle/1-4 Sunset Shore", value = 5 },
    { code = "@Jungle/1-5 Canopy Cannons", value = 5 },
    { code = "@Jungle/1-6 Crazy Cart", value = 5 },
    { code = "@Jungle/1-K Platform Panic", value = 5 },
    { code = "@Jungle/1-B Mugly's Mound", value = 0 },

    { code = "@Beach/2-1 Poppin' Planks", value = 5 },
    { code = "@Beach/2-2 Sloppy Sands", value = 7 },
    { code = "@Beach/2-3 Peaceful Pier", value = 5 },
    { code = "@Beach/2-4 Cannon Cluster", value = 7 },
    { code = "@Beach/2-5 Stormy Shore", value = 5 },
    { code = "@Beach/2-6 Blowhole Bound", value = 5 },
    { code = "@Beach/2-7 Tidal Terror", value = 5 },
    { code = "@Beach/2-K Tumblin' Temple", value = 5 },
    { code = "@Beach/2-B Pinchin' Pirates", value = 0 },

    { code = "@Ruins/3-1 Wonky Waterway", value = 7 },
    { code = "@Ruins/3-2 Button Bash", value = 7 },
    { code = "@Ruins/3-3 Mast Blast", value = 7 },
    { code = "@Ruins/3-4 Damp Dungeon", value = 9 },
    { code = "@Ruins/3-5 Itty Bitty Biters", value = 7 },
    { code = "@Ruins/3-6 Temple Topple", value = 5 },
    { code = "@Ruins/3-K Shifty Smashers", value = 5 },
    { code = "@Ruins/3-B Ruined Roost", value = 0 },

    { code = "@Cave/4-1 Rickety Rails", value = 5 },
    { code = "@Cave/4-2 Grip & Trip", value = 5 },
    { code = "@Cave/4-3 Bombs Away", value = 5 },
    { code = "@Cave/4-4 Mole Patrol", value = 5 },
    { code = "@Cave/4-5 Crowded Cavern", value = 5 },
    { code = "@Cave/4-K Jagged Jewels", value = 5 },
    { code = "@Cave/4-B The Mole Train", value = 0 },

    { code = "@Forest/5-1 Vine Valley", value = 7 },
    { code = "@Forest/5-2 Clingy Swingy", value = 5 },
    { code = "@Forest/5-3 Flutter Flyaway", value = 7 },
    { code = "@Forest/5-4 Tippin' Totems", value = 7 },
    { code = "@Forest/5-5 Longshot Launch", value = 7 },
    { code = "@Forest/5-6 Springy Spores", value = 7 },
    { code = "@Forest/5-7 Wigglevine Wonders", value = 7 },
    { code = "@Forest/5-8 Muncher Marathon", value = 5 },
    { code = "@Forest/5-K Blast & Bounce", value = 5 },
    { code = "@Forest/5-B Mangoruby Run", value = 0 },

    { code = "@Cliff/6-1 Sticky Situation", value = 9 },
    { code = "@Cliff/6-2 Prehistoric Path", value = 5 },
    { code = "@Cliff/6-3 Weighty Way", value = 5 },
    { code = "@Cliff/6-4 Boulder Roller", value = 7 },
    { code = "@Cliff/6-5 Precarious Plateau", value = 5 },
    { code = "@Cliff/6-6 Crumble Canyon", value = 9 },
    { code = "@Cliff/6-7 Tippy Shippy", value = 5 },
    { code = "@Cliff/6-8 Clifftop Climb", value = 5 },
    { code = "@Cliff/6-K Perilous Passage", value = 5 },
    { code = "@Cliff/6-B Thugly's Highrise", value = 0 },

    { code = "@Factory/7-1 Foggy Fumes", value = 7 },
    { code = "@Factory/7-2 Slammin' Steel", value = 5 },
    { code = "@Factory/7-3 Handy Hazards", value = 7 },
    { code = "@Factory/7-4 Gear Getaway", value = 7 },
    { code = "@Factory/7-5 Cog Jog", value = 9 },
    { code = "@Factory/7-6 Switcheroo", value = 5 },
    { code = "@Factory/7-7 Music Madness", value = 5 },
    { code = "@Factory/7-K Treacherous Track", value = 5 },
    { code = "@Factory/7-B Feather Fiend", value = 0 },

    { code = "@Volcano/8-1 Furious Fire", value = 5 },
    { code = "@Volcano/8-2 Hot Rocket", value = 5 },
    { code = "@Volcano/8-3 Roasting Rails", value = 5 },
    { code = "@Volcano/8-4 Smokey Peak", value = 5 },
    { code = "@Volcano/8-5 Bobbing Basalt", value = 7 },
    { code = "@Volcano/8-6 Moving Melters", value = 5 },
    { code = "@Volcano/8-7 Red Red Rising", value = 5 },
    { code = "@Volcano/8-K Five Monkey Trial", value = 5 },
    { code = "@Volcano/8-B Tiki Tong Terror", value = 0 },

    { code = "@Golden Temple/9-1 Golden Temple", value = 5 }
}

LETTERS = {
    "/KONG Letter K",
    "/KONG Letter O",
    "/KONG Letter N",
    "/KONG Letter G"
}

PUZZLES = {
    "/Puzzle Piece 1",
    "/Puzzle Piece 2",
    "/Puzzle Piece 3",
    "/Puzzle Piece 4",
    "/Puzzle Piece 5",
    "/Puzzle Piece 6",
    "/Puzzle Piece 7",
    "/Puzzle Piece 8",
    "/Puzzle Piece 9",
}

MEDALS = {
    "/Time Attack: Bronze",
    "/Time Attack: Silver",
    "/Time Attack: Gold",
    "/Time Attack: Shiny Gold"
}