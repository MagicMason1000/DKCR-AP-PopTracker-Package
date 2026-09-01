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
Tracker:AddLayouts("layouts/settings_layout.jsonc")
if variant == "standard" then
    Tracker:AddLayouts("layouts/standard/layout_standard.jsonc")
    Tracker:AddLayouts("layouts/standard/items_standard.jsonc")
elseif variant == "compact" then
    Tracker:AddLayouts("layouts/compact/layout_compact.jsonc")
    Tracker:AddLayouts("layouts/compact/items_compact.jsonc")
elseif variant == "items_only" then
    Tracker:AddLayouts("layouts/items_only/items_io.jsonc")
    Tracker:AddLayouts("layouts/items_only/layout_io.jsonc")
end

-- AutoTracking for Poptracker
if PopVersion and PopVersion >= "0.18.0" then
    ScriptHost:LoadScript("scripts/autotracking.lua")
end
