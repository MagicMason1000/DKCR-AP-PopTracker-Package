ENABLE_DEBUG_LOG = false
local variant = Tracker.ActiveVariantUID
IS_ITEMS_ONLY = variant:find("itemsonly")

print("")
print("-- Donkey Kong Country Returns — Archipelago PopTracker Package --")
print(string.format("Loaded variant: %s", variant))
if ENABLE_DEBUG_LOG then
    print("DEBUG: Logging is enabled! You can change this in init.lua.")
end

-- Utility Script for helper functions etc.
ScriptHost:LoadScript("scripts/utils.lua")

-- Items
Tracker:AddItems("items/items.jsonc")
Tracker:AddItems("items/settings_items.jsonc")

if not IS_ITEMS_ONLY then -- <--- use variant info to optimize loading
    -- Maps
    Tracker:AddMaps("maps/maps.jsonc")
    -- Locations
    Tracker:AddLocations("locations/world_progress.jsonc")
    Tracker:AddLocations("locations/jungle.jsonc")
    Tracker:AddLocations("locations/beach.jsonc")
    Tracker:AddLocations("locations/ruins.jsonc")
    Tracker:AddLocations("locations/cave.jsonc")
    Tracker:AddLocations("locations/forest.jsonc")
    Tracker:AddLocations("locations/cliff.jsonc")
    Tracker:AddLocations("locations/factory.jsonc")
    Tracker:AddLocations("locations/volcano.jsonc")
    Tracker:AddLocations("locations/golden_temple.jsonc")
end

-- Layout
Tracker:AddLayouts("layouts/items.jsonc")
Tracker:AddLayouts("layouts/world_map_tabs.jsonc")
Tracker:AddLayouts("layouts/tracker.jsonc")
Tracker:AddLayouts("layouts/broadcast.jsonc")
Tracker:AddLayouts("layouts/settings_layout.jsonc")

-- AutoTracking for Poptracker
if PopVersion and PopVersion >= "0.18.0" then
    ScriptHost:LoadScript("scripts/autotracking.lua")
end
