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
-- Watch Feathery Companion setting.
ScriptHost:AddWatchForCode("fcSettingWatch", "fc_setting", function () SetSquawks() end)
-- Watch Rare Orb item and setting.
ScriptHost:AddWatchForCode("orbItemWatch1", "rare_orb", function () SetItemStatus("Orb") end)
ScriptHost:AddWatchForCode("orbItemWatch2", "rare_orb", function () SetIcon("Orb") end)
ScriptHost:AddWatchForCode("orbSettingWatch1", "orbs_setting", function () SetItemStatus("Orb") end)
ScriptHost:AddWatchForCode("orbSettingWatch2", "orbs_setting", function () SetIcon("Orb") end)
-- Watch Progressive Boss Unlock item.
ScriptHost:AddWatchForCode("bossUnlockWatch", "boss_unlock", function () SetIcon("Boss Unlock") end)

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
        print(string.format("\27[1;31mERROR:\27[0m SetLetterStatus failed check nil for letterReq = %s, letterAmount = %s\n", letterReq, letterAmount))
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
                print(string.format("\27[1;31mERROR:\27[0m SetPuzzleStatus failed check nil for world = %s, bossReqCode = %s\n", world, bossReqCode))
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
        print(string.format("\27[1;31mERROR:\27[0m SetPuzzleStatus failed check nil for ppAmount = %s\n", ppAmount))
    end
end

-- MARK: Squawks
function SetSquawks()
    local settingObj = Tracker:FindObjectForCode("fc_setting")
    local squawksObj = Tracker:FindObjectForCode("squawks")
    if settingObj and squawksObj then

        if (settingObj.CurrentStage == 0) then
            squawksObj.Active = true
        else
            squawksObj.Active = false
        end

    elseif ENABLE_DEBUG_LOG then
        print(string.format("\27[1;31mERROR:\27[0m SetSquawks failed check nil.\n\tsettingObj = %s\n\tsquawksObj = %s", settingObj, squawksObj))
    end
end

-- MARK: Other Items
function SetItemStatus(itemType)
    if ENABLE_ITEMSTATUS_LOG then
        print(string.format("\nSetItemStatus: Called for %s.", itemType))
    end

    local itemReq, itemAmount, mirrorEnabled
    if (itemType == "Button") then
        itemReq = Tracker:FindObjectForCode("factory_button_setting")
        itemAmount = Tracker:FindObjectForCode("factory_button")
        mirrorEnabled = true
    elseif (itemType == "Shard") then
        itemReq = Tracker:FindObjectForCode("mirror_shards_setting")
        itemAmount = Tracker:FindObjectForCode("mirror_shard")
        mirrorEnabled = Tracker:FindObjectForCode("mirror_mode_setting")
    elseif (itemType == "Orb") then
        itemReq = Tracker:FindObjectForCode("orbs_setting")
        itemAmount = Tracker:FindObjectForCode("rare_orb")
        mirrorEnabled = true
    end

    if itemReq and itemAmount and mirrorEnabled then

        -- End early for shards if mm is disabled
        if (itemType == "Shard" and mirrorEnabled.CurrentStage == 0) then
            if ENABLE_ITEMSTATUS_LOG then
                print(string.format("SetItemStatus: Mirror Mode not enabled. Setting shards to 0 and ending early."))
            end
            itemAmount.MaxCount = 0
            itemAmount.BadgeText = "0"
            itemAmount.BadgeTextColor = "#1fff1f"
            itemAmount.Active = true
            return
        end

        local max
        if (itemType == "Button" or itemType == "Shard") then max = itemReq.AcquiredCount
        elseif (itemType == "Orb") then max = itemReq.CurrentStage
        end
        itemAmount.MaxCount = max

        if max == 0 then
            itemAmount.BadgeText = "0"
            itemAmount.BadgeTextColor = "#1fff1f"
            itemAmount.Active = true
        elseif itemAmount.AcquiredCount < max then
            itemAmount.BadgeTextColor = "#ffffff"
            if itemAmount.AcquiredCount == 0 then
                itemAmount.Active = false
            end
        else
            itemAmount.BadgeTextColor = "#1fff1f"
        end
        if ENABLE_ITEMSTATUS_LOG then
            print(string.format("SetItemStatus: Set MaxCount for %s to %s", itemType, max))
        end

    elseif ENABLE_DEBUG_LOG then
        print(string.format("\27[1;31mERROR:\27[0m SetItemStatus failed check nil.\n\titemReq = %s\n\titemAmount = %s", itemReq, itemAmount))
    end
end

function SetIcon(itemType)
    if ENABLE_SETICON_LOG then
        print(string.format("\nSetIcon: Called for %s.", itemType))
    end

    local itemObj
    if (itemType == "Orb") then itemObj = Tracker:FindObjectForCode("rare_orb")
    elseif (itemType == "Boss Unlock") then itemObj = Tracker:FindObjectForCode("boss_unlock")
    end

    if itemObj then

        local quantity
        if (itemType == "Orb") then
            quantity = itemObj.AcquiredCount
            if quantity == 1 then itemObj.Icon = ImageReference:FromPackRelativePath("images/items/item_rare_orb_1.png")
            elseif quantity == 2 then itemObj.Icon = ImageReference:FromPackRelativePath("images/items/item_rare_orb_2.png")
            elseif quantity == 3 then itemObj.Icon = ImageReference:FromPackRelativePath("images/items/item_rare_orb_3.png")
            elseif quantity == 4 then itemObj.Icon = ImageReference:FromPackRelativePath("images/items/item_rare_orb_4.png")
            elseif quantity == 5 then itemObj.Icon = ImageReference:FromPackRelativePath("images/items/item_rare_orb_5.png")
            elseif quantity == 6 then itemObj.Icon = ImageReference:FromPackRelativePath("images/items/item_rare_orb_6.png")
            elseif quantity == 7 then itemObj.Icon = ImageReference:FromPackRelativePath("images/items/item_rare_orb_7.png")
            elseif quantity == 8 then itemObj.Icon = ImageReference:FromPackRelativePath("images/items/item_rare_orb_8.png")
            end
        elseif (itemType == "Boss Unlock") then
            quantity = itemObj.AcquiredCount
            if quantity == 1 then itemObj.Icon = ImageReference:FromPackRelativePath("images/items/item_boss_unlock_1.png")
            elseif quantity == 2 then itemObj.Icon = ImageReference:FromPackRelativePath("images/items/item_boss_unlock_2.png")
            elseif quantity == 3 then itemObj.Icon = ImageReference:FromPackRelativePath("images/items/item_boss_unlock_3.png")
            elseif quantity == 4 then itemObj.Icon = ImageReference:FromPackRelativePath("images/items/item_boss_unlock_4.png")
            elseif quantity == 5 then itemObj.Icon = ImageReference:FromPackRelativePath("images/items/item_boss_unlock_5.png")
            elseif quantity == 6 then itemObj.Icon = ImageReference:FromPackRelativePath("images/items/item_boss_unlock_6.png")
            elseif quantity == 7 then itemObj.Icon = ImageReference:FromPackRelativePath("images/items/item_boss_unlock_7.png")
            elseif quantity == 8 then itemObj.Icon = ImageReference:FromPackRelativePath("images/items/item_boss_unlock_8.png")
            end
        end
        if ENABLE_SETICON_LOG then
            print(string.format("SetIcon: Set icon of %s to %s", itemType, quantity))
        end

    elseif ENABLE_DEBUG_LOG then
        print(string.format("\27[1;31mERROR:\27[0m SetIcon failed check nil.\n\titemObj = %s", itemObj))
    end

    
end