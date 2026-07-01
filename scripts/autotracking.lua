-- Configuration --------------------------------------
AUTOTRACKER_ENABLE_ITEM_TRACKING = true
AUTOTRACKER_ENABLE_LOCATION_TRACKING = true and not IS_ITEMS_ONLY
AUTOTRACKER_ENABLE_DEBUG_LOGGING = true and ENABLE_DEBUG_LOG
AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP = true and AUTOTRACKER_ENABLE_DEBUG_LOGGING
-------------------------------------------------------
print("")
print("Active Auto-Tracker Configuration")
print("---------------------------------------------------------------------")
print("Enable Item Tracking:        ", AUTOTRACKER_ENABLE_ITEM_TRACKING)
print("Enable Location Tracking:    ", AUTOTRACKER_ENABLE_LOCATION_TRACKING)
if AUTOTRACKER_ENABLE_DEBUG_LOGGING then
    print("Enable Debug Logging:        ", AUTOTRACKER_ENABLE_DEBUG_LOGGING)
    print("Enable AP Debug Logging:        ", AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP)
end
print("---------------------------------------------------------------------")
print("")

-- uncomment this to use `Tracker.AllowDeferredLogicUpdate` to defer logic updates, which might be needed if you touch A LOT of items/locations at once.
-- if Tracker.AllowDeferredLogicUpdate == false then Tracker.AllowDeferredLogicUpdate = true end

-- loads the AP autotracking code
ScriptHost:LoadScript("scripts/autotracking/archipelago.lua")

WORLD_LEVEL_AMOUNT = { 7, 8, 7, 6, 9, 9, 9, 8 }
WORLD_LEVEL_OFFSET = { 1, 8, 16, 23, 29, 38, 47, 55, 63, 64 }

LEVELS = {
    "@Jungle/1-1 Jungle Hijinxs",
    "@Jungle/1-2 King of Cling",
    "@Jungle/1-3 Tree Top Bop",
    "@Jungle/1-4 Sunset Shore",
    "@Jungle/1-5 Canopy Cannons",
    "@Jungle/1-6 Crazy Cart",
    "@Jungle/1-K Platform Panic",

    "@Beach/2-1 Poppin' Planks",
    "@Beach/2-2 Sloppy Sands",
    "@Beach/2-3 Peaceful Pier",
    "@Beach/2-4 Cannon Cluster",
    "@Beach/2-5 Stormy Shore",
    "@Beach/2-6 Blowhole Bound",
    "@Beach/2-7 Tidal Terror",
    "@Beach/2-K Tumblin' Temple",

    "@Ruins/3-1 Wonky Waterway",
    "@Ruins/3-2 Button Bash",
    "@Ruins/3-3 Mast Blast",
    "@Ruins/3-4 Damp Dungeon",
    "@Ruins/3-5 Itty Bitty Biters",
    "@Ruins/3-6 Temple Topple",
    "@Ruins/3-K Shifty Smashers",

    "@Cave/4-1 Rickety Rails",
    "@Cave/4-2 Grip & Trip",
    "@Cave/4-3 Bombs Away",
    "@Cave/4-4 Mole Patrol",
    "@Cave/4-5 Crowded Cavern",
    "@Cave/4-K Jagged Jewels",

    "@Forest/5-1 Vine Valley",
    "@Forest/5-2 Clingy Swingy",
    "@Forest/5-3 Flutter Flyaway",
    "@Forest/5-4 Tippin' Totems",
    "@Forest/5-5 Longshot Launch",
    "@Forest/5-6 Springy Spores",
    "@Forest/5-7 Wigglevine Wonders",
    "@Forest/5-8 Muncher Marathon",
    "@Forest/5-K Blast & Bounce",

    "@Cliff/6-1 Sticky Situation",
    "@Cliff/6-2 Prehistoric Path",
    "@Cliff/6-3 Weighty Way",
    "@Cliff/6-4 Boulder Roller",
    "@Cliff/6-5 Precarious Plateau",
    "@Cliff/6-6 Crumble Canyon",
    "@Cliff/6-7 Tippy Shippy",
    "@Cliff/6-8 Clifftop Climb",
    "@Cliff/6-K Perilous Passage",

    "@Factory/7-1 Foggy Fumes",
    "@Factory/7-2 Slammin' Steel",
    "@Factory/7-3 Handy Hazards",
    "@Factory/7-4 Gear Getaway",
    "@Factory/7-5 Cog Jog",
    "@Factory/7-6 Switcheroo",
    "@Factory/7-7 Music Madness",
    "@Factory/7-K Treacherous Track",

    "@Volcano/8-1 Furious Fire",
    "@Volcano/8-2 Hot Rocket",
    "@Volcano/8-3 Roasting Rails",
    "@Volcano/8-4 Smokey Peak",
    "@Volcano/8-5 Bobbing Basalt",
    "@Volcano/8-6 Moving Melters",
    "@Volcano/8-7 Red Red Rising",
    "@Volcano/8-K Five Monkey Trial",

    "@Golden Temple/9-1 Golden Temple"
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

-- MARK: WorldCheck
-- checkType 1 = KONG Letters
-- checkType 2 = Puzzle Pieces
-- checkType 3 = Level Completions
-- checkType 4 = Mirror Mode Completions
-- checkType 5 = Time Attack Medals

function WorldCheck(world, checkType)
    world = tonumber(world)
    checkType = tonumber(checkType)
    local count = 0
    local levelAmount = WORLD_LEVEL_AMOUNT[world]

    if ENABLE_DEBUG_LOG then
        print("")
        print(string.format("DEBUG: Called WorldCheck. WORLD = %s, checkType = %s", world, checkType))
    end

    if (checkType == 1) then -- KONG LETTERS
        local completionCountdown = ((WORLD_LEVEL_AMOUNT[world] - 1) * 4)
        for lvlCount = (WORLD_LEVEL_OFFSET[world]), (WORLD_LEVEL_OFFSET[world + 1] - 2) do
            for kongCount = 1, 4 do
                local access = Tracker:FindObjectForCode(LEVELS[lvlCount] .. LETTERS[kongCount]).AccessibilityLevel
                if (access == 6) then
                    count = count + 1
                end
                if (access == 7) then
                    completionCountdown = completionCountdown - 1
                end
                if ENABLE_DETAILED_DEBUG_LOG then
                    print(string.format("DEBUG: %s - AccLvl = %s, Count = %s, comCntdwn = %s", LEVELS[lvlCount] .. ":" .. kongCount, access, count, completionCountdown))
                end
            end
        end

        if (completionCountdown == 0) then
            -- code goes here to set the Accessible section to Cleared. Maybe use AccessibilityLevel to set it to state 7?
            if ENABLE_DEBUG_LOG then
                print(string.format("DEBUG [SUCCESS+]: WorldCheck complete. Every KONG Letter in World %s is collected.", world))
            end
            return true
        end
        if (count ~= 0) then
            if ENABLE_DEBUG_LOG then
                print(string.format("DEBUG [SUCCESS]: WorldCheck complete. KONG Letters are available to collect in World %s.", world))
            end
            return true
        else
            if ENABLE_DEBUG_LOG then
                print(string.format("DEBUG [FAIL]: WorldCheck complete. KONG Letters are NOT available to collect in World %s.", world))
            end
            return false
        end
    end

    if (checkType == 2) then -- PUZZLE PIECES (WIP)
        return false
    end

    if (checkType == 3 or checkType == 4) then -- LEVEL/MIRROR COMPLETIONS
        for lvlCount = (WORLD_LEVEL_OFFSET[world]), (WORLD_LEVEL_OFFSET[world + 1] - 1) do
            local access
            if (checkType == 3) then
                access = Tracker:FindObjectForCode(LEVELS[lvlCount] .. "/Complete Level").AccessibilityLevel
            end
            if (checkType == 4) then
                access = Tracker:FindObjectForCode(LEVELS[lvlCount] .. "/Beat in Mirror Mode").AccessibilityLevel
            end
            if (access == 6) then
                count = count + 1
            end
            if ENABLE_DETAILED_DEBUG_LOG then
                print(string.format("DEBUG: %s - AccLevel = %s, Count = %s", LEVELS[lvlCount], access, count))
            end
        end

        if (count ~= 0) then
            if ENABLE_DEBUG_LOG and checkType == 3 then
                print(string.format("DEBUG [SUCCESS]: WorldCheck complete. Level Completion checks are available in World %s.", world))
            elseif ENABLE_DEBUG_LOG and checkType == 4 then
                print(string.format("DEBUG [SUCCESS]: WorldCheck complete. Mirror Mode checks are available in World %s.", world))
            end
            return true
        else
            if ENABLE_DEBUG_LOG and checkType == 3 then
                print(string.format("DEBUG [FAIL]: WorldCheck complete. Level Completion checks are NOT available in World %s.", world))
            elseif ENABLE_DEBUG_LOG and checkType == 4 then
                print(string.format("DEBUG [SUCCESS]: WorldCheck complete. Mirror Mode checks are NOT available in World %s.", world))
            end
            return false
        end
    end

    if (checkType == 5) then -- TIME ATTACK MEDALS (WIP)
        return false
    end

    if ENABLE_DEBUG_LOG then
        print(string.format("WARNING: WorldCheck reached end of function without a proper checkType value. checkType value was %s", checkType))
    end
    return false
end

-- MARK: BossCheck
function BossCheck(world)
    if ENABLE_DEBUG_LOG then
        print("")
        print(string.format("DEBUG: Called BossCheck. World = %s", world))
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
            if ENABLE_DEBUG_LOG then
                print(string.format("DEBUG: BossCheck for World %s FAILED on World %s.", world, i))
                print(string.format("DEBUG [FAIL]: BossCheck finished. Boss requirement NOT satisfied for world %s.", world))
            end
            return false
        elseif (pp >= bossReqs[i]) then
            if ENABLE_DETAILED_DEBUG_LOG then
                print(string.format("DEBUG: BossCheck for World %s SUCCEEDED on World %s.", world, i))
            end
            if i == world then
                if ENABLE_DEBUG_LOG then
                    print(string.format("DEBUG [SUCCESS]: BossCheck finished. Boss requirement satisfied for world %s.", world))
                end
                return true
            end
        elseif ENABLE_DEBUG_LOG then
            print(string.format("DEBUG: BossCheck reached end of loop. World was %s, i was %s, bossReqs[i] was %s.", world, i, bossReqs[i]))
        end
    end

    if ENABLE_DEBUG_LOG then
        print(string.format("WARNING: BossCheck reached end of function without a proper return. World was %s, pp was %s.", world, pp))
    end
    return false
end

-- MARK: LetterCheck
function LetterCheck(world)
    if ENABLE_DEBUG_LOG then
        print("")
        print(string.format("DEBUG: Called LetterCheck. World = %s", world))
    end
    
    world = tonumber(world)
    local kReqs = { 24, 28, 24, 20, 32, 32, 28, 28 }
    local worldStrings = { "jungle", "beach", "ruins", "cave", "forest", "cliff", "factory", "volcano"}
    local letters = Tracker:FindObjectForCode("letters_" .. worldStrings[world]).AcquiredCount
    if (letters < kReqs[world]) then
        if ENABLE_DEBUG_LOG then
            print(string.format("DEBUG [FAIL]: LetterCheck finished. Letter requirement NOT satisfied for world %s.", world))
        end
        return false
    end
    if (letters >= kReqs[world]) then
        if ENABLE_DEBUG_LOG then
            print(string.format("DEBUG [SUCCESS]: LetterCheck finished. Letter requirement satisfied for world %s.", world))
        end
        return true
    end
    
    if ENABLE_DEBUG_LOG then
        print(string.format("WARNING: LetterCheck reached end of function without a proper return. World was %s, letters was %s.", world, letters))
    end
    return false
end