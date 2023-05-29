-- @building
-- Дополнительный прирост крестьян в фермах Ордена Порядка
haven_special6 =
{
    additional_grow = 100
}

NewDayEvent.AddListener("BTD_RMG_haven_haven_special6_new_day",
function(day)
    if mod(day, 7) == 1 then
        for i, town in GetObjectNamesByType("TOWN") do
            if GetTownRace(town) == TOWN_HEAVEN then
                if GetTownBuildingLevel(town, 22) > 0 then
                    local current_grow = GetObjectDwellingCreatures(town, CREATURE_PEASANT)
                    SetObjectDwellingCreatures(town, CREATURE_PEASANT, current_grow + haven_special6.additional_grow)
                    --print("<color=red>HavenFarms: <color=green>adding grow in town ", town)
                end
            end
        end
    end
end)