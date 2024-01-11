ARTIFACT_BLUEPRINT_DWELL_13 = 117
ARTIFACT_BLUEPRINT_DWELL_47 = 118
ARTIFACT_BLUEPRINT_MGUILD = 119
ARTIFACT_BLUEPRINT_SPECIAL = 120

function Blueprints_GetTownLevel(town)
    local level = 0
    for building = TOWN_BUILDING_TOWN_HALL, TOWN_BUILDING_SPECIAL_9 do
        local is_ok, value = pcall(GetTownBuildingLevel, town, building)
        if is_ok then
            level = level + value
        end
    end
    return level
end