necropolis_unearhed_graves =
{
    additional_skeleton_grow = 6,
    additional_zombie_grow = 6
}

NewDayEvent.AddListener("BTD_RMG_inferno_necropolis_unearhed_graves_new_day",
function(day)
    if mod(day, 7) == 1 then
        for i, town in GetObjectNamesByType("TOWN") do
            if GetTownRace(town) == TOWN_NECROPOLIS then
                if GetTownBuildingLevel(town, TOWN_BUILDING_NECROMANCY_UNEARHED_GRAVES) > 0 then
                    local skeleton_current_grow = GetObjectDwellingCreatures(town, CREATURE_SKELETON)
                    SetObjectDwellingCreatures(town, CREATURE_SKELETON, skeleton_current_grow + necropolis_unearhed_graves.additional_skeleton_grow)
                    --
                    local zombie_current_grow = GetObjectDwellingCreatures(town, CREATURE_WALKING_DEAD)
                    SetObjectDwellingCreatures(town, CREATURE_WALKING_DEAD, zombie_current_grow + necropolis_unearhed_graves.additional_zombie_grow)
                end
            end
        end
    end
end)