diplomacy =
{
  wizard_by_race = {
    [TOWN_HEAVEN] =     { tier = 5, grades = { nil, not nil, not nil }},
    [TOWN_INFERNO] =    { tier = 6, grades = { not nil, not nil, nil }},
    [TOWN_NECROMANCY] = { tier = 5, grades = { nil, not nil, not nil }},
    [TOWN_PRESERVE] =   { tier = 4, grades = { not nil, not nil, not nil }},
    [TOWN_ACADEMY] =    { tier = 4, grades = { nil, not nil, not nil }},
    [TOWN_DUNGEON] =    { tier = 6, grades = { nil, not nil, not nil }},
    [TOWN_FORTRESS] =   { tier = 5, grades = { nil, not nil, not nil }},
    [TOWN_STRONGHOLD] = { tier = 4, grades = { nil, not nil, not nil }}
  }
}

NewDayEvent.AddListener("diplomacy_new_day",
function(day)
    if day == BTD_FIGHT_DAY then
        for hero, alive in AdvMapHeroesInfo.alive_heroes do
            if hero and alive and HasHeroSkill(hero, PERK_DIPLOMACY) then
                local race = Hero.Params.Town(hero)               
                for gradeIndex = 3, 1, -1 do
                    local creatureId = TIER_TABLES[race][diplomacy.wizard_by_race[race].tier][gradeIndex];                   
                    if diplomacy.wizard_by_race[race].grades[gradeIndex] and GetHeroCreatures(hero, creatureId) > 0 then
                        local grow = Creature.Params.Grow(creatureId);
                        startThread(Hero.CreatureInfo.Add, hero, creatureId, grow);                
                        gradeIndex = 1;
                    end
                end
            end
        end
    end
end)