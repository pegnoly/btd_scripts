preserve_blooming_grove =
{
    additional_grow = 4
}

NewDayEvent.AddListener("BTD_RMG_preserve_blooming_grove_new_day",
function(day)
    if mod(day, 7) == 1 then
        for i, town in GetObjectNamesByType("TOWN") do
            if GetTownRace(town) == TOWN_PRESERVE then
                if GetTownBuildingLevel(town, TOWN_BUILDING_PRESERVE_BLOOMING_GROVE) > 0 then
                    local current_grow = GetObjectDwellingCreatures(town, CREATURE_PIXIE)
                    SetObjectDwellingCreatures(town, CREATURE_PIXIE, current_grow + preserve_blooming_grove.additional_grow)
                end
            end
        end
    end
end)