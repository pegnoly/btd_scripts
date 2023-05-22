-- @building
-- Дополнительный прирост джинов у Академии
academy_treasure_cave =
{
    additional_grow = 4
}

NewDayEvent.AddListener("BTD_RMG_academy_treasure_cave_new_day",
function(day)
    if mod(day, 7) == 1 then
        for i, town in GetObjectNamesByType("TOWN") do
            if GetTownRace(town) == TOWN_ACADEMY then
                if GetTownBuildingLevel(town, TOWN_BUILDING_ACADEMY_TREASURE_CAVE) > 0 then
                    local current_grow = GetObjectDwellingCreatures(town, CREATURE_GENIE)
                    SetObjectDwellingCreatures(town, CREATURE_GENIE, current_grow + academy_treasure_cave.additional_grow)
                end
            end
        end
    end
end)