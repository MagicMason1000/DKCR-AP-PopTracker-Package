ENABLE_DEBUG_LOG = true
ENABLE_DETAILED_DEBUG_LOG = false
IS_ITEMS_ONLY = false
local variant
if Tracker.ActiveVariantUID == "1" then
    variant = "standard"
elseif Tracker.ActiveVariantUID == "2" then
    variant = "compact"
else
    variant = "items_only"
    IS_ITEMS_ONLY = true
end

print("")
print("-- Donkey Kong Country Returns — Archipelago PopTracker Package --")
print("Created by MagicMason1000")
print("Github Repo: https://github.com/MagicMason1000/DKCR-AP-PopTracker-Package")
print("")
if ENABLE_DEBUG_LOG then
    print("Debug Logging is enabled! You can change this in init.lua.")
end
if ENABLE_DETAILED_DEBUG_LOG then
    print("Detailed debug logging is enabled! This has more in-depth logs, but may be pretty spammy. You can change this in init.lua.")
end
print(string.format("Loaded variant: %s", variant))
print("")

-- Utility Script for helper functions etc.
ScriptHost:LoadScript("scripts/utils.lua")

-- Items
Tracker:AddItems("items/items.jsonc")
Tracker:AddItems("items/settings_items.jsonc")

if not IS_ITEMS_ONLY then -- optimize loading
    -- Maps
    Tracker:AddMaps("maps/maps.jsonc")
    -- Locations
    Tracker:AddLocations("locations/jungle.jsonc")
    Tracker:AddLocations("locations/beach.jsonc")
    Tracker:AddLocations("locations/ruins.jsonc")
    Tracker:AddLocations("locations/cave.jsonc")
    Tracker:AddLocations("locations/forest.jsonc")
    Tracker:AddLocations("locations/cliff.jsonc")
    Tracker:AddLocations("locations/factory.jsonc")
    Tracker:AddLocations("locations/volcano.jsonc")
    Tracker:AddLocations("locations/golden_temple.jsonc")
    if variant == "standard" then
        Tracker:AddLocations("locations/world_progress.jsonc")
    else
        Tracker:AddLocations("locations/world_progress_compact.jsonc")
    end
end

-- Layouts
Tracker:AddLayouts("layouts/world_map_tabs.jsonc")
Tracker:AddLayouts("layouts/broadcast.jsonc")
Tracker:AddLayouts("layouts/settings.jsonc")

function TogglePuzzleView(togglevariant) -- Switches what item appears in the Puzzle Piece slot based on tracker settings.
    local settingState = Tracker:FindObjectForCode("pp_setting").CurrentStage
    local paths = {
        "layouts/standard/itemtoggle_boss.jsonc",
        "layouts/standard/itemtoggle_pp.jsonc",
        "layouts/compact/itemtoggle_boss.jsonc",
        "layouts/compact/itemtoggle_pp.jsonc",
        "layouts/io/itemtoggle_boss.jsonc",
        "layouts/io/itemtoggle_pp.jsonc"
    }
    if settingState == 0 then -- Boss Unlocks
        Tracker:AddLayouts(paths[togglevariant])
    else -- Puzzle Pieces
        Tracker:AddLayouts(paths[togglevariant + 1])
    end
end

if variant == "standard" then
    Tracker:AddLayouts("layouts/standard/layout.jsonc")
    Tracker:AddLayouts("layouts/standard/items.jsonc")
    ScriptHost:AddWatchForCode("itemtoggle_pp_boss_standard", "pp_setting", function () TogglePuzzleView(1) end)
    TogglePuzzleView(1)
elseif variant == "compact" then
    Tracker:AddLayouts("layouts/compact/layout.jsonc")
    Tracker:AddLayouts("layouts/compact/items.jsonc")
    ScriptHost:AddWatchForCode("itemtoggle_pp_boss_compact", "pp_setting", function () TogglePuzzleView(3) end)
    TogglePuzzleView(3)
elseif variant == "items_only" then
    Tracker:AddLayouts("layouts/items_only/items.jsonc")
    Tracker:AddLayouts("layouts/items_only/layout.jsonc")
    ScriptHost:AddWatchForCode("itemtoggle_pp_boss_io", "pp_setting", function () TogglePuzzleView(5) end)
    TogglePuzzleView(5)
end

-- AutoTracking for Poptracker
if PopVersion and PopVersion >= "0.18.0" then
    ScriptHost:LoadScript("scripts/autotracking.lua")
end
