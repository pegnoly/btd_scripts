StatueOfRevelation = 
{
    path = "/scripts/RMG/advmap/Objects/NewObjects/StatueOfRevelation/",
    used_by_hero = {}
}

AddHeroEvent.AddListener("BTD_statue_of_revelation_add_hero_listener",
function(hero)
    StatueOfRevelation.used_by_hero[hero] = nil
end)

CombatResultsEvent.AddListener("BTD_statue_of_revelation_combat_result_listener",
function(fight_id)
    local winner = GetSavedCombatArmyHero(fight_id, 1)
    local loser = GetSavedCombatArmyHero(fight_id, 0)
    if winner and StatueOfRevelation.used_by_hero[winner] then
        StatueOfRevelation.used_by_hero[winner] = nil
    end
    if loser and StatueOfRevelation.used_by_hero[loser] then
        StatueOfRevelation.used_by_hero[loser] = nil
    end
end)