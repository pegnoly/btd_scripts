SunRiderMonument = 
{
    path = "/scripts/RMG/advmap/Objects/NewObjects/SunRiderMonument/",
    used_by_hero = {}
}

AddHeroEvent.AddListener("BTD_sun_rider_monument_add_hero_listener",
function(hero)
    SunRiderMonument.used_by_hero[hero] = nil
end)

CombatResultsEvent.AddListener("BTD_sun_rider_monument_combat_result_listener",
function(fight_id)
    local winner = GetSavedCombatArmyHero(fight_id, 1)
    local loser = GetSavedCombatArmyHero(fight_id, 0)
    if winner and SunRiderMonument.used_by_hero[winner] then
        SunRiderMonument.used_by_hero[winner] = nil
    end
    if loser and SunRiderMonument.used_by_hero[loser] then
        SunRiderMonument.used_by_hero[loser] = nil
    end
end)