-- Watch scripts for changing various settings outside of what PopTracker normally watches. Loaded by autotracking.lua.
ENABLE_LETTERSTATUS_LOG = ENABLE_DEBUG_LOG and true

for world = 1, 8 do
    -- For all 8 worlds, creates a watch which triggers any time the KONG Letter requirement settings are changed.
    ScriptHost:AddWatchForCode("kSettingWatch" .. world, "kReq" .. world, function () SetLetterStatus("kReq" .. world, "letters_" .. world) end)
    ScriptHost:AddWatchForCode("kItemWatch" .. world, "letters_" .. world, function () SetLetterStatus("kReq" .. world, "letters_" .. world) end)
end

function SetLetterStatus(settingCode, letterCode)
    if ENABLE_LETTERSTATUS_LOG then
        print(string.format("SetLetterStatus: Called with settingCode = %s, letterCode = %s", settingCode, letterCode))
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
    elseif ENABLE_LETTERSTATUS_LOG then
        print(string.format("WARNING: SetLetterStatus failed check nil. letterReq was %s, letterAmount was", letterReq, letterAmount))
    end
end