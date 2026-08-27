-- Watch scripts for changing various settings outside of what PopTracker normally watches.
-- Currently I use this to dyanmically adjust the text color and max amount of consumables
-- you can have of certain items including Letters, Puzzles, Mirror Shards, and Factory Buttons.
-- Loaded by autotracking.lua.

for world = 1, 8 do
    -- For all 8 worlds, creates a watch which triggers any time the KONG Letter requirement settings are changed.
    ScriptHost:AddWatchForCode("kSettingWatch" .. world, "kReq" .. world, function () SetLetterStatus("kReq" .. world, "letters_" .. world) end)
    ScriptHost:AddWatchForCode("kItemWatch" .. world, "letters_" .. world, function () SetLetterStatus("kReq" .. world, "letters_" .. world) end)
    -- For all 8 worlds, watch the Puzzle Piece boss requirement setting.
    ScriptHost:AddWatchForCode("ppSettingWatch" .. world, "bossReq" .. world, function () SetPuzzleStatus() end)
end
-- Watch Puzzle Piece item.
ScriptHost:AddWatchForCode("ppItemWatch", "puzzle_piece", function () SetPuzzleStatus() end)
-- Watch Factory Button item and settings.
ScriptHost:AddWatchForCode("buttonSettingWatch", "factory_button_setting", function () SetItemStatus("Button") end)
ScriptHost:AddWatchForCode("buttonItemWatch", "factory_button", function () SetItemStatus("Button") end)
-- Watch Mirror Shard amount setting, Mirror Shard item, and Mirror Mode enabled setting.
ScriptHost:AddWatchForCode("shardSettingWatch", "mirror_shards_setting", function () SetItemStatus("Shard") end)
ScriptHost:AddWatchForCode("shardItemWatch", "mirror_shard", function () SetItemStatus("Shard") end)
ScriptHost:AddWatchForCode("mirrorSettingWatch", "mirror_mode_setting", function () SetItemStatus("Shard") end)

-- MARK: Letters
function SetLetterStatus(settingCode, letterCode)
    if ENABLE_LETTERSTATUS_LOG then
        print(string.format("\nSetLetterStatus: Called with settingCode = %s, letterCode = %s", settingCode, letterCode))
    end

    local letterReq = Tracker:FindObjectForCode(settingCode)
	local letterAmount = Tracker:FindObjectForCode(letterCode)
    if letterReq and letterAmount then

        if letterAmount.AcquiredCount >= letterReq.AcquiredCount then
            letterAmount.BadgeTextColor = "#1fff1f"
            if letterAmount.AcquiredCount == 0 then
                letterAmount.BadgeText = "0"
                letterAmount.Active = true
            end
            if ENABLE_LETTERSTATUS_LOG then
                print(string.format("SetLetterStatus [SUCCESS]: %s met. Acquired text now set to green.", settingCode))
            end
        else
            letterAmount.BadgeTextColor = "#FFFFFF"
            if letterAmount.AcquiredCount == 0 then
                letterAmount.BadgeText = "0"
                letterAmount.Active = false
            end
            if ENABLE_LETTERSTATUS_LOG then
                print(string.format("SetLetterStatus [FAIL]: %s not met. Acquired text now set to white.", settingCode))
            end
        end

    elseif ENABLE_DEBUG_LOG then
        print(string.format("\nWARNING: SetLetterStatus failed check nil for letterReq = %s, letterAmount = %s\n", letterReq, letterAmount))
    end
end

-- MARK: Puzzles
function SetPuzzleStatus()
    if ENABLE_PUZZLESTATUS_LOG then
        print(string.format("\nSetPuzzleStatus: Called."))
    end

    local bossReqCode
    local max = 0
    for world = 1, 8 do
        bossReqCode = Tracker:FindObjectForCode("bossReq" .. world)
        if bossReqCode then
            if (bossReqCode.AcquiredCount > max) then
                max = bossReqCode.AcquiredCount
            end
        else
            if ENABLE_DEBUG_LOG then
                print(string.format("\nWARNING: SetPuzzleStatus failed check nil for world = %s, bossReqCode = %s\n", world, bossReqCode))
            end
            return
        end
    end
    if ENABLE_PUZZLESTATUS_LOG then
        print(string.format("SetPuzzleStatus: Max Puzzle Piece requirement is %s.", max))
    end

    local ppAmount = Tracker:FindObjectForCode("puzzle_piece")
    if ppAmount then

        if (ppAmount.AcquiredCount >= max) then
            ppAmount.BadgeTextColor = "#1fff1f"
            if ppAmount.AcquiredCount == 0 then
                ppAmount.BadgeText = "0"
                ppAmount.Active = true
            end
            if ENABLE_PUZZLESTATUS_LOG then
                print(string.format("SetPuzzleStatus [SUCCESS]: Highest Puzzle Piece requirement met. Acquired text now set to green."))
            end
        else
            ppAmount.BadgeTextColor = "#ffffff"
            if ppAmount.AcquiredCount == 0 then
                ppAmount.Active = false
            end
            if ENABLE_PUZZLESTATUS_LOG then
                print(string.format("SetPuzzleStatus [FAIL]: Highest Puzzle Piece requirement not met. Acquired text now set to white."))
            end
        end

    elseif ENABLE_DEBUG_LOG then
        print(string.format("\nWARNING: SetPuzzleStatus failed check nil for ppAmount = %s\n", ppAmount))
    end
end

-- MARK: Other Items
function SetItemStatus(itemType)
    if ENABLE_ITEMSTATUS_LOG then
        print(string.format("\nSetItemStatus: Called for %s.", itemType))
    end

    local itemReq, itemAmount
    if (itemType == "Button") then
        itemReq = Tracker:FindObjectForCode("factory_button_setting")
        itemAmount = Tracker:FindObjectForCode("factory_button")
    elseif (itemType == "Shard") then
        itemReq = Tracker:FindObjectForCode("mirror_shards_setting")
        itemAmount = Tracker:FindObjectForCode("mirror_shard")
    end

    if itemReq and itemAmount then

        if (itemType == "Shard" and itemReq.CurrentStage == 0) then
            if ENABLE_ITEMSTATUS_LOG then
                print(string.format("SetItemStatus: Mirror mode not enabled. Setting shards to 0 and ending early."))
            end
            itemAmount.MaxCount = 0
            itemAmount.BadgeText = "0"
            itemAmount.BadgeTextColor = "#1fff1f"
            itemAmount.Active = true
            return
        end

        itemAmount.MaxCount = itemReq.AcquiredCount
        if itemReq.AcquiredCount == 0 then
            itemAmount.BadgeText = "0"
            itemAmount.BadgeTextColor = "#1fff1f"
            itemAmount.Active = true
        elseif itemAmount.AcquiredCount < itemReq.AcquiredCount then
            itemAmount.BadgeTextColor = "#ffffff"
            if itemAmount.AcquiredCount == 0 then
                itemAmount.Active = false
            end
        else
            itemAmount.BadgeTextColor = "#1fff1f"
        end
        if ENABLE_ITEMSTATUS_LOG then
            print(string.format("SetItemStatus: Set MaxCount for Factory Buttons to %s", itemReq.AcquiredCount))
        end

    elseif ENABLE_DEBUG_LOG then
        print(string.format("\nWARNING: SetItemStatus failed check nil for itemReq = %s, itemAmount = %s\n", itemReq, itemAmount))
    end
end