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
ScriptHost:LoadScript("scripts/autotracking/watch.lua")

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

    { code = "@Golden Temple/9-1 Golden Temple", value = 1 }
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

-- MARK: WorldCheck
-- checkType 1 = KONG Letters
-- checkType 2 = Puzzle Pieces
-- checkType 3 = Level Completions
-- checkType 4 = Mirror Mode Completions
-- checkType 5 = Time Attack Medals

function WorldCheck(world, checkType)
    world = tonumber(world)
    checkType = tonumber(checkType)

    if ENABLE_WORLDCHECK_LOG then
        print()
        print(string.format("WorldCheck: Called with world = %s, checkType = %s", world, checkType))
    end

    if (world == 9 and Tracker:FindObjectForCode("golden_temple_setting").CurrentStage == 0) then
        if ENABLE_WORLDCHECK_LOG then
            print("WorldCheck: Ending early as the Golden Temple is not enabled.")
        end
        return false
    end

    local totalLevelsPerWorld = { 8, 9, 8, 7, 10, 10, 9, 9, 1 }
    local numberedLevelsPerWorld = { 1, 9, 18, 26, 33, 43, 53, 62, 71, 72 } -- Total levels with each index indicating a new world. Used to index LEVELS properly.

    if (checkType == 1) then -- KONG LETTERS
        local access
        local accessibleLetters = false
        local countdown = ((totalLevelsPerWorld[world] - 2) * 4)
        --[[
        accessibleLetters gets set to true when an accessible KONG Letter is found. If it stays false, there are no accessible Letters in the world.
        countdown starts at the total Letters in the world and subtracts one for each completed check. If it equals 0 by the end, then every Letter in the world is collected.
        ]]
        for level = numberedLevelsPerWorld[world], (numberedLevelsPerWorld[world + 1] - 3) do -- Loops through all (minus K and B) levels in the world
            for letter = 1, 4 do
                access = Tracker:FindObjectForCode(LEVELS[level].code .. LETTERS[letter]).AccessibilityLevel
                -- Check if the location is Accessible (6) or Cleared (7)
                if (access == 6) then
                    accessibleLetters = true
                elseif (access == 7) then
                    countdown = countdown - 1
                end
                if ENABLE_WORLDCHECK_LOG and ENABLE_DETAILED_DEBUG_LOG then
                    print(string.format("WorldCheck: %s has access = %s, accessibleLetters = %s, countdown = %s", (LEVELS[level].code .. ":" .. letter), access, accessibleLetters, countdown))
                end
            end
        end

        if (countdown == 0) then
            if ENABLE_WORLDCHECK_LOG then
                print(string.format("WorldCheck [SUCCESS+]: WorldCheck complete. Every KONG Letter in World %s is collected.", world))
            end
            Tracker:FindObjectForCode("@World Progress/Accessible " .. WORLDS[world] .. " Collectibles/KONG Letters Accessible").AvailableChestCount = 0
            return true
        elseif accessibleLetters then
            if ENABLE_WORLDCHECK_LOG then
                print(string.format("WorldCheck [SUCCESS]: WorldCheck complete. KONG Letters are available in World %s.", world))
            end
            Tracker:FindObjectForCode("@World Progress/Accessible " .. WORLDS[world] .. " Collectibles/KONG Letters Accessible").AvailableChestCount = 1
            return true
        else
            if ENABLE_WORLDCHECK_LOG then
                print(string.format("WorldCheck [FAIL]: WorldCheck complete. KONG Letters are NOT available in World %s.", world))
            end
            Tracker:FindObjectForCode("@World Progress/Accessible " .. WORLDS[world] .. " Collectibles/KONG Letters Accessible").AvailableChestCount = 1
            return false
        end
    end

    if (checkType == 2) then -- PUZZLE PIECES
        local totalPP = { 41, 44, 47, 30, 57, 55, 50, 42, 5 }
        local accessiblePP = false
        local countdown = totalPP[world]
        local access

        for level = numberedLevelsPerWorld[world], (numberedLevelsPerWorld[world + 1] - 2) do
            for pp = 1, LEVELS[level].value do
                access = Tracker:FindObjectForCode(LEVELS[level].code .. "/Puzzle Piece " .. pp).AccessibilityLevel
                if (access == 6) then
                    accessiblePP = true
                elseif (access == 7) then
                    countdown = countdown - 1
                end
            end
        end

        if (countdown == 0) then
            if ENABLE_WORLDCHECK_LOG then
                print(string.format("WorldCheck [SUCCESS+]: WorldCheck complete. Every Puzzle Piece in World %s is collected.", world))
            end
            Tracker:FindObjectForCode("@World Progress/Accessible " .. WORLDS[world] .. " Collectibles/Puzzle Pieces Accessible").AvailableChestCount = 0
            return true
        elseif accessiblePP then
            if ENABLE_WORLDCHECK_LOG then
                print(string.format("WorldCheck [SUCCESS]: WorldCheck complete. Puzzle Pieces are available in World %s.", world))
            end
            Tracker:FindObjectForCode("@World Progress/Accessible " .. WORLDS[world] .. " Collectibles/Puzzle Pieces Accessible").AvailableChestCount = 1
            return true
        else
            if ENABLE_WORLDCHECK_LOG then
                print(string.format("WorldCheck [FAIL]: WorldCheck complete. Puzzle Pieces are NOT available in World %s.", world))
            end
            Tracker:FindObjectForCode("@World Progress/Accessible " .. WORLDS[world] .. " Collectibles/Puzzle Pieces Accessible").AvailableChestCount = 1
            return false
        end
        return false
    end

    if (checkType == 3 or checkType == 4) then -- LEVEL/MIRROR COMPLETIONS
        if (checkType == 4 and Tracker:FindObjectForCode("mirror_mode_setting").CurrentStage == 0) then
            if ENABLE_WORLDCHECK_LOG then
                print("WorldCheck: Ending early as Mirror Mode is not enabled.")
            end
            return false
        end
    
        local accessibleGoals = false
        local countdown = totalLevelsPerWorld[world]
        if (world == 7) then
            countdown = countdown + 1
        end
        for lvlCount = (numberedLevelsPerWorld[world]), (numberedLevelsPerWorld[world + 1] - 1) do
            local access
            if (checkType == 3 and not (lvlCount == (numberedLevelsPerWorld[world + 1] - 1))) then
                access = Tracker:FindObjectForCode(LEVELS[lvlCount].code .. "/Complete Level").AccessibilityLevel
            elseif (checkType == 3 and (lvlCount == (numberedLevelsPerWorld[world + 1] - 1))) then
                access = Tracker:FindObjectForCode(LEVELS[lvlCount].code .. "/Boss Clear").AccessibilityLevel
            elseif (checkType == 4) then
                access = Tracker:FindObjectForCode(LEVELS[lvlCount].code .. "/Beat in Mirror Mode").AccessibilityLevel
            end

            if (access == 6) then
                accessibleGoals = true
            elseif (access == 7) then
                countdown = countdown - 1
            end
            if ENABLE_WORLDCHECK_LOG and ENABLE_DETAILED_DEBUG_LOG then
                print(string.format("WorldCheck: %s - AccLevel = %s, accessibleGoals = %s, countdown = %s", LEVELS[lvlCount].code, access, accessibleGoals, countdown))
            end
        end

        if (world == 7) then -- specific handle for 7-R since it's a weird one that would make the other checks difficult
            if (Tracker:FindObjectForCode("@Factory/7-R Lift-off Launch/Complete Level").AccessibilityLevel == 6) then
                accessibleGoals = true
            elseif (Tracker:FindObjectForCode("@Factory/7-R Lift-off Launch/Complete Level").AccessibilityLevel == 7) then
                countdown = countdown - 1
            end
        end

        if (countdown == 0) then
            if checkType == 3 then
                if ENABLE_WORLDCHECK_LOG then
                    print(string.format("WorldCheck [SUCCESS+]: WorldCheck complete. All levels are completed in World %s.", world))
                end
                Tracker:FindObjectForCode("@World Progress/Accessible " .. WORLDS[world] .. " Level Completions/Level Completions Available").AvailableChestCount = 0
            elseif checkType == 4 then
                if ENABLE_WORLDCHECK_LOG then
                    print(string.format("WorldCheck [SUCCESS+]: WorldCheck complete. All Mirror Mode checks are completed in World %s.", world))
                end
                Tracker:FindObjectForCode("@World Progress/Accessible " .. WORLDS[world] .. " Level Completions/Mirror Mode Completions Available").AvailableChestCount = 0
            end
            return true
        elseif accessibleGoals then
            if checkType == 3 then
                if ENABLE_WORLDCHECK_LOG then
                    print(string.format("WorldCheck [SUCCESS]: WorldCheck complete. Level Completion checks are available in World %s.", world))
                end
                Tracker:FindObjectForCode("@World Progress/Accessible " .. WORLDS[world] .. " Level Completions/Level Completions Available").AvailableChestCount = 1
            elseif checkType == 4 then
                if ENABLE_WORLDCHECK_LOG then
                    print(string.format("WorldCheck [SUCCESS]: WorldCheck complete. Mirror Mode checks are available in World %s.", world))
                end
                Tracker:FindObjectForCode("@World Progress/Accessible " .. WORLDS[world] .. " Level Completions/Mirror Mode Completions Available").AvailableChestCount = 1
            end
            return true
        else
            if checkType == 3 then
                if ENABLE_WORLDCHECK_LOG then
                    print(string.format("WorldCheck [FAIL]: WorldCheck complete. Level Completion checks are NOT available in World %s.", world))
                end
                Tracker:FindObjectForCode("@World Progress/Accessible " .. WORLDS[world] .. " Level Completions/Level Completions Available").AvailableChestCount = 1
            elseif checkType == 4 then
                if ENABLE_WORLDCHECK_LOG then
                    print(string.format("WorldCheck [FAIL]: WorldCheck complete. Mirror Mode checks are NOT available in World %s.", world))
                end
                Tracker:FindObjectForCode("@World Progress/Accessible " .. WORLDS[world] .. " Level Completions/Mirror Mode Completions Available").AvailableChestCount = 1
            end
            return false
        end
    end

    if (checkType == 5) then -- TIME ATTACK MEDALS
        local randomizedMedals = 0
        local medalCodes = {}
        if (Tracker:FindObjectForCode("ta_bronze_setting").CurrentStage == 1) then
            randomizedMedals = randomizedMedals + 1
            medalCodes[randomizedMedals] = "/Time Attack: Bronze"
        end
        if (Tracker:FindObjectForCode("ta_silver_setting").CurrentStage == 1) then
            randomizedMedals = randomizedMedals + 1
            medalCodes[randomizedMedals] = "/Time Attack: Silver"
        end
        if (Tracker:FindObjectForCode("ta_gold_setting").CurrentStage == 1) then
            randomizedMedals = randomizedMedals + 1
            medalCodes[randomizedMedals] = "/Time Attack: Gold"
        end
        if (Tracker:FindObjectForCode("ta_shiny_gold_setting").CurrentStage == 1) then
            randomizedMedals = randomizedMedals + 1
            medalCodes[randomizedMedals] = "/Time Attack: Shiny Gold"
        end

        if (randomizedMedals == 0) then
            if ENABLE_WORLDCHECK_LOG then
                print("WorldCheck: Ending early as no Time Attack settings are enabled.")
            end
            return false
        end

        local access
        local accessibleMedals = false
        local countdown = ((totalLevelsPerWorld[world]) * randomizedMedals)
        for level = numberedLevelsPerWorld[world], (numberedLevelsPerWorld[world + 1] - 1) do -- Loops through all levels in the world
            for medal = 1, randomizedMedals do
                access = Tracker:FindObjectForCode(LEVELS[level].code .. medalCodes[medal]).AccessibilityLevel
                -- Check if the location is Accessible (6) or Cleared (7)
                if (access == 6) then
                    accessibleMedals = true
                elseif (access == 7) then
                    countdown = countdown - 1
                end
                if ENABLE_WORLDCHECK_LOG and ENABLE_DETAILED_DEBUG_LOG then
                    print(string.format("WorldCheck: %s has access = %s, accessibleMedals = %s, countdown = %s", (LEVELS[level].code .. ":" .. medal), access, accessibleMedals, countdown))
                end
            end
        end

        if (countdown == 0) then
            if ENABLE_WORLDCHECK_LOG then
                print(string.format("WorldCheck [SUCCESS+]: WorldCheck complete. Every Time Attack medal in World %s is collected.", world))
            end
            Tracker:FindObjectForCode("@World Progress/Accessible " .. WORLDS[world] .. " Time Attack Medals/Medals Accessible").AvailableChestCount = 0
            return true
        elseif accessibleMedals then
            if ENABLE_WORLDCHECK_LOG then
                print(string.format("WorldCheck [SUCCESS]: WorldCheck complete. Time Attack medals are available in World %s.", world))
            end
            Tracker:FindObjectForCode("@World Progress/Accessible " .. WORLDS[world] .. " Time Attack Medals/Medals Accessible").AvailableChestCount = 1
            return true
        else
            if ENABLE_WORLDCHECK_LOG then
                print(string.format("WorldCheck [FAIL]: WorldCheck complete. Time Attack medals are NOT available in World %s.", world))
            end
            Tracker:FindObjectForCode("@World Progress/Accessible " .. WORLDS[world] .. " Time Attack Medals/Medals Accessible").AvailableChestCount = 1
            return false
        end
    end

    if ENABLE_DEBUG_LOG then
        print(string.format("WARNING: WorldCheck reached end of function without a proper checkType value. checkType was %s", checkType))
    end
    return false
end

-- MARK: BossCheck
function BossCheck(world)
    if ENABLE_BOSSCHECK_LOG then
        print("")
        print(string.format("BossCheck: Called with world = %s", world))
    end
    
    world = tonumber(world)
    local pp = Tracker:FindObjectForCode("puzzle_piece").AcquiredCount
    local bossReqs = {
        Tracker:FindObjectForCode("bossreq1").AcquiredCount,
        Tracker:FindObjectForCode("bossreq2").AcquiredCount,
        Tracker:FindObjectForCode("bossreq3").AcquiredCount,
        Tracker:FindObjectForCode("bossreq4").AcquiredCount,
        Tracker:FindObjectForCode("bossreq5").AcquiredCount,
        Tracker:FindObjectForCode("bossreq6").AcquiredCount,
        Tracker:FindObjectForCode("bossreq7").AcquiredCount,
        Tracker:FindObjectForCode("bossreq8").AcquiredCount
    }
    for i = 1, (world + 1) do
        if (pp < bossReqs[i]) then
            if ENABLE_BOSSCHECK_LOG then
                print(string.format("BossCheck: World %s FAILED on World %s.", world, i))
                print(string.format("BossCheck [FAIL]: Boss requirement NOT satisfied for world %s.", world))
            end
            return false
        elseif (pp >= bossReqs[i]) then
            if ENABLE_DETAILED_DEBUG_LOG and ENABLE_BOSSCHECK_LOG then
                print(string.format("BossCheck: World %s SUCCEEDED on World %s.", world, i))
            end
            if i == world then
                if ENABLE_BOSSCHECK_LOG then
                    print(string.format("BossCheck [SUCCESS]: Boss requirement satisfied for world %s.", world))
                end
                return true
            end
        elseif ENABLE_DEBUG_LOG then
            print(string.format("WARNING: BossCheck reached end of loop. World was %s, i was %s, bossReqs[i] was %s.", world, i, bossReqs[i]))
        end
    end

    if ENABLE_DEBUG_LOG then
        print(string.format("WARNING: BossCheck reached end of function without a proper return. World was %s, pp was %s.", world, pp))
    end
    return false
end

-- MARK: LetterCheck
function LetterCheck(world)
    if ENABLE_LETTERCHECK_LOG then
        print("")
        print(string.format("LetterCheck: Called with world = %s", world))
    end
    
    world = tonumber(world)
    local kReqs = {
        Tracker:FindObjectForCode("kReq1").AcquiredCount,
        Tracker:FindObjectForCode("kReq2").AcquiredCount,
        Tracker:FindObjectForCode("kReq3").AcquiredCount,
        Tracker:FindObjectForCode("kReq4").AcquiredCount,
        Tracker:FindObjectForCode("kReq5").AcquiredCount,
        Tracker:FindObjectForCode("kReq6").AcquiredCount,
        Tracker:FindObjectForCode("kReq7").AcquiredCount,
        Tracker:FindObjectForCode("kReq8").AcquiredCount
    }
    local letters = Tracker:FindObjectForCode("letters_" .. world).AcquiredCount
    if (letters < kReqs[world]) then
        if ENABLE_LETTERCHECK_LOG then
            print(string.format("LetterCheck [FAIL]: Letter requirement NOT satisfied for world %s.", world))
        end
        return false
    end
    if (letters >= kReqs[world]) then
        if ENABLE_LETTERCHECK_LOG then
            print(string.format("LetterCheck [SUCCESS]: Letter requirement satisfied for world %s.", world))
        end
        return true
    end
    
    if ENABLE_DEBUG_LOG then
        print(string.format("WARNING: LetterCheck reached end of function without a proper return. World was %s, letters was %s.", world, letters))
    end
    return false
end

-- MARK: ShardCheck
function ShardCheck()
    if ENABLE_SHARDCHECK_LOG then
        print("")
        print("ShardCheck: Called.")
    end

    if ((Tracker:FindObjectForCode("mirror_mode_setting")).CurrentStage == 0) then
        if ENABLE_SHARDCHECK_LOG then
            print("ShardCheck: Ending early as Mirror Mode is not enabled.")
        end
        return false
    end

    local shardCount = Tracker:FindObjectForCode("mirror_shard").AcquiredCount
    local shardReq = Tracker:FindObjectForCode("mirror_shards_setting").AcquiredCount

    if (shardCount < shardReq) then
        if ENABLE_SHARDCHECK_LOG then
            print(string.format("ShardCheck [FAIL]: Not enough Mirror Shards. Mirror Mode checks are NOT in logic.", shardCount, shardReq))
        end
        return false
    elseif (shardCount >= shardReq) then
        if ENABLE_SHARDCHECK_LOG then
            print(string.format("ShardCheck [SUCCESS]: Mirror Mode checks are in logic.", shardCount, shardReq))
        end
        return true
    elseif ENABLE_DEBUG_LOG then
        print(string.format("WARNING: ShardCheck had an invalid comparison. shardCount was %s, shardReq was %s.", shardCount, shardReq))
        return false
    end

    if ENABLE_DEBUG_LOG then
        print(string.format("WARNING: ShardCheck reached end of function without a proper return. shardCount was %s, shardReq was %s.", shardCount, shardReq))
    end
    return false
end

-- MARK: OrbCheck
function OrbCheck()
    if ENABLE_ORBCHECK_LOG then
        print()
        print("OrbCheck: Called.")
    end

    if ((Tracker:FindObjectForCode("golden_temple_setting")).CurrentStage == 0) then
        if ENABLE_ORBCHECK_LOG then
            print("OrbCheck: Ending early as the Golden Temple is not enabled.")
        end
        return false
    end

    local codes = {
        Tracker:FindObjectForCode("rare_orb_1").Active,
        Tracker:FindObjectForCode("rare_orb_2").Active,
        Tracker:FindObjectForCode("rare_orb_3").Active,
        Tracker:FindObjectForCode("rare_orb_4").Active,
        Tracker:FindObjectForCode("rare_orb_5").Active,
        Tracker:FindObjectForCode("rare_orb_6").Active,
        Tracker:FindObjectForCode("rare_orb_7").Active,
        Tracker:FindObjectForCode("rare_orb_8").Active
    }
    local orbReq = Tracker:FindObjectForCode("orbs_setting").CurrentStage
    local count = 0
    for i = 1, 8 do
        if codes[i] then
            count = count + 1
        end
    end

    if (count < orbReq) then
        if ENABLE_ORBCHECK_LOG then
            print("OrbCheck [FAIL]: Not enough Rare Orbs. The Golden Temple is NOT in logic.")
        end
        return false
    elseif (count >= orbReq) then
        if ENABLE_ORBCHECK_LOG then
            print("OrbCheck [SUCCESS]: The Golden Temple is in logic.")
        end
        return true
    elseif ENABLE_DEBUG_LOG then
        print(string.format("WARNING: OrbCheck had an invalid comparison. Count was %s, orbReq was %s.", count, orbReq))
        return false
    end

    if ENABLE_DEBUG_LOG then
        print(string.format("WARNING: OrbCheck reached end of function without a proper return. orbReq was %s.", orbReq))
    end
    return false
end

-- MARK: SmogCheck
function SmogCheck(smogLog)
    if ENABLE_SMOGCHECK_LOG then
        print()
        print(string.format("SmogCheck: Called for %s.", smogLog))
    end

    if ((Tracker:FindObjectForCode("smog_clear_setting")).CurrentStage == 0) then
        if ENABLE_SMOGCHECK_LOG then
            print("SmogCheck: Ending early as the Smog Clear option is not enabled.")
        end
        return true
    end

    local ffClear = Tracker:FindObjectForCode("@Factory/7-1 Foggy Fumes/Complete Level")
    if ffClear then
        if (ffClear.AccessibilityLevel == 0) then
            if ENABLE_SMOGCHECK_LOG then
                print(string.format("SmogCheck [FAIL]: 7-1 Complete Level is NOT in logic, so all future levels are NOT in logic."))
            end
            return false
        elseif (ffClear.AccessibilityLevel == 6 or ffClear.AccessibilityLevel == 7) then
            if ENABLE_SMOGCHECK_LOG then
                print(string.format("SmogCheck [SUCCESS]: 7-1 Complete Level is in logic, so all future levels are in logic."))
            end
            return true
        else
            if ENABLE_DEBUG_LOG then
                print(string.format("WARNING: SmogCheck had an invalid comparison where ffClear = %s", ffClear))
            end
            return false
        end
    elseif ENABLE_DEBUG_LOG then
        print(string.format("WARNING: SmogCheck could not find object. ffClear = %s", ffClear))
        return false
    end

    if ENABLE_DEBUG_LOG then
        print(string.format("WARNING: SmogCheck reached end of function without a proper return. ffClear was %s", ffClear))
    end
    return false
end

-- MARK: ButtonCheck
function ButtonCheck(buttonLog)
    if ENABLE_BUTTONCHECK_LOG then
        print()
        print(string.format("ButtonCheck: Called for %s.", buttonLog))
    end

    local buttonReq = Tracker:FindObjectForCode("factory_button_setting")
    local buttonAmount = Tracker:FindObjectForCode("factory_button")
    if (buttonReq and buttonAmount) then
        if (buttonReq.AcquiredCount == 0) then
            if ENABLE_BUTTONCHECK_LOG then
                print("ButtonCheck: Ending early as the Required Factory Button option is not enabled.")
            end
            return true
        end

        if (buttonReq.AcquiredCount > buttonAmount.AcquiredCount) then
            if ENABLE_BUTTONCHECK_LOG then
                print("ButtonCheck [FAIL]: Not enough Factory Buttons to access 7-R.")
            end
            return false
        elseif (buttonReq.AcquiredCount <= buttonAmount.AcquiredCount) then
            if ENABLE_BUTTONCHECK_LOG then
                print("ButtonCheck [SUCCESS]: Factory Buttons collected. 7-R is in logic.")
            end
            return true
        elseif ENABLE_DEBUG_LOG then
            print(string.format("WARNING: ButtonCheck had an invalid comparison. buttonReq was %s, buttonAmount was %s", buttonReq, buttonAmount))
            return false
        end
    elseif ENABLE_DEBUG_LOG then
        print(string.format("WARNING: ButtonCheck could not find object. buttonReq = %s, buttonAmount = %s", buttonReq, buttonAmount))
        return false
    end
    
    if ENABLE_DEBUG_LOG then
        print(string.format("WARNING: ButtonCheck reached end of function without a proper return. buttonReq was %s", buttonReq))
    end
    return false
end

-- MARK: LolCheck
function LolCheck(lolLog)
    if ENABLE_LOLCHECK_LOG then
        print()
        print(string.format("LoLCheck: Called for %s.", lolLog))
    end

    if ((Tracker:FindObjectForCode("lolReq_setting")).CurrentStage == 0) then
        if ENABLE_LOLCHECK_LOG then
            print("LolCheck: Ending early as the 7-R Required option is not enabled.")
        end
        return true
    end

    local lolClear = Tracker:FindObjectForCode("@Factory/7-R Lift-off Launch/Complete Level")
    if lolClear then
        if (lolClear.AccessibilityLevel == 0) then
            if ENABLE_LOLCHECK_LOG then
                print(string.format("LolCheck [FAIL]: 7-R Complete Level is NOT in logic, so all future levels are NOT in logic."))
            end
            return false
        elseif (lolClear.AccessibilityLevel == 6 or lolClear.AccessibilityLevel == 7) then
            if ENABLE_LOLCHECK_LOG then
                print(string.format("LolCheck [SUCCESS]: 7-R Complete Level is in logic, so all future levels are in logic."))
            end
            return true
        else
            if ENABLE_DEBUG_LOG then
                print(string.format("WARNING: LolCheck had an invalid comparison where lolClear = %s", lolClear))
            end
            return false
        end
    elseif ENABLE_DEBUG_LOG then
        print(string.format("WARNING: LolCheck could not find object. lolClear = %s", lolClear))
        return false
    end

    if ENABLE_DEBUG_LOG then
        print(string.format("WARNING: LolCheck reached end of function without a proper return. lolClear was %s", lolClear))
    end
    return false
end