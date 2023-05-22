WarmenHouse = 
{
    path = "/scripts/RMG/advmap/Objects/NewObjects/WarmenHouse/",
    used_by_orc_hero = {},
    used_by_other_hero = {},

    exp_amount = 3000
}

AddHeroEvent.AddListener("BTD_warmen_house_add_hero_listener",
function(hero)
    local race = Hero.Params.Town(hero)
    if race == TOWN_STRONGHOLD then
        WarmenHouse.used_by_orc_hero[hero] = nil
    else
        WarmenHouse.used_by_other_hero[hero] = nil
    end
end)

CombatResultsEvent.AddListener("BTD_warmen_house_combat_result_listener",
function(fight_id)
    local winner = GetSavedCombatArmyHero(fight_id, 1)
    local loser = GetSavedCombatArmyHero(fight_id, 0)
    if winner and WarmenHouse.used_by_orc_hero[winner] then
        WarmenHouse.used_by_orc_hero[winner] = nil
        consoleCmd("@SetGameVar('"..winner.."_warmen_house_bonus', '')")
    end
    if loser and WarmenHouse.used_by_orc_hero[loser] then
        WarmenHouse.used_by_orc_hero[loser] = nil
        consoleCmd("@SetGameVar('"..loser.."_warmen_house_bonus', '')")
    end
end)