preserve_treant_sampling =
{
    initial_grow = 1,
    builded_already_in_town = {}
}

MapLoadingEvent.AddListener("BTD_RMG_treant_sampling_init",
function ()
    startThread(
    function ()
        while 1 do
            for i, town in GetObjectNamesByType("TOWN") do
                if GetTownRace(town) == TOWN_PRESERVE then
                    if not preserve_treant_sampling.builded_already_in_town[town] then
                        if GetTownBuildingLevel(town, TOWN_BUILDING_PRESERVE_TREANT_SAMPLING) > 0 then
                            preserve_treant_sampling.builded_already_in_town[town] = 1
                            local current_grow = GetObjectDwellingCreatures(town, CREATURE_TREANT)
                            SetObjectDwellingCreatures(town, CREATURE_TREANT, current_grow + preserve_treant_sampling.initial_grow)
                        end
                    end
                end
            end
            sleep()
        end
    end)    
end)