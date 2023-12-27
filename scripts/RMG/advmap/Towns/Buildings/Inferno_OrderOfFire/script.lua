-- @building
-- Дополнительный прирост демонов у Инферно
inferno_order_of_fire =
{
    additional_grow = 8
}

NewDayEvent.AddListener("BTD_RMG_inferno_order_of_fire_new_day",
function(day)
    if mod(day, 7) == 1 then
        for i, town in GetObjectNamesByType("TOWN") do
            if GetTownRace(town) == TOWN_INFERNO then
                if GetTownBuildingLevel(town, 18) > 0 then
                    local current_grow = GetObjectDwellingCreatures(town, CREATURE_DEMON)
                    SetObjectDwellingCreatures(town, CREATURE_DEMON, current_grow + inferno_order_of_fire.additional_grow)
                end
            end
        end
    end
end)