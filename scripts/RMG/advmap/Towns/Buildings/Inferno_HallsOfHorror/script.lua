-- @building
-- Дополнительный прирост коней у Инферно
inferno_halls_of_horror =
{
    additional_grow = 1
}

NewDayEvent.AddListener("BTD_RMG_inferno_halls_of_horror_new_day",
function(day)
    if mod(day, 7) == 1 then
        for i, town in GetObjectNamesByType("TOWN") do
            if GetTownRace(town) == TOWN_INFERNO then
                if GetTownBuildingLevel(town, 20) > 0 then
                    local current_grow = GetObjectDwellingCreatures(town, 23) -- dumb consts
                    SetObjectDwellingCreatures(town, 23, current_grow + inferno_halls_of_horror.additional_grow)
                end
            end
        end
    end
end)