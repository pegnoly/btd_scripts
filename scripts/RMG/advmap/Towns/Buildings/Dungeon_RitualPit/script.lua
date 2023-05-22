dungeon_ritual_pit =
{
    additional_grow = 2
}

NewDayEvent.AddListener("BTD_RMG_dungeon_ritual_pit_new_day",
function(day)
    if mod(day, 7) == 1 then
        for i, town in GetObjectNamesByType("TOWN") do
            if GetTownRace(town) == TOWN_DUNGEON then
                if GetTownBuildingLevel(town, TOWN_BUILDING_DUNGEON_RITUAL_PIT) > 0 then
                    for i, creature in {CREATURE_SCOUT, CREATURE_WITCH, CREATURE_MINOTAUR} do
                        local current_grow = GetObjectDwellingCreatures(town, creature)
                        SetObjectDwellingCreatures(town, creature, current_grow + dungeon_ritual_pit.additional_grow)
                    end
                end
            end
        end
    end
end)