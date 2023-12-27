fortuitous_sanctuary_rmg =
{
    path = "/scripts/RMG/advmap/Objects/Default/FortuitousSanctuary/",
    used_by_hero = {},
    bonuses = 
    {
        [1] = {[HERO_BATTLE_BONUS_ATTACK] = 3},
        [2] = {[HERO_BATTLE_BONUS_MORALE] = 1},
        [3] = {[HERO_BATTLE_BONUS_DEFENCE] = 3},
        [4] = {[HERO_BATTLE_BONUS_LUCK] = 1},
        [5] = {[HERO_BATTLE_BONUS_INITIATIVE] = 10},
        [6] = {[HERO_BATTLE_BONUS_ATTACK] = 2, [HERO_BATTLE_BONUS_DEFENCE] = 2},
        [7] = {[HERO_BATTLE_BONUS_SPEED] = 1}
    }
}

MapLoadingEvent.AddListener("BTD_RMG_fortuitous_sanctuary_init",
function()
    for i, object in GetObjectNamesByType("BUILDING_FORTUITOUS_SANCTUARY") do
        Touch.DisableObject(object)
        Touch.SetFunction(object, "_touch", BTD_FortuitousSanctuaryTouch)
    end
end)

AddHeroEvent.AddListener("BTD_RMG_fortuitous_sanctuary_add_hero",
function(hero)
    fortuitous_sanctuary_rmg.used_by_hero[hero] = nil
end)

CombatResultsEvent.AddListener("BTD_RMG_fortuitous_sanctuary_combat_result",
function(fight_id)
    local winner = GetSavedCombatArmyHero(fight_id, 1)
    local loser = GetSavedCombatArmyHero(fight_id, 0)
    if winner and fortuitous_sanctuary_rmg.used_by_hero[winner] then
        fortuitous_sanctuary_rmg.used_by_hero[winner] = nil
    end
    if loser and fortuitous_sanctuary_rmg.used_by_hero[loser] then
        fortuitous_sanctuary_rmg.used_by_hero[loser] = nil
    end
end)

function BTD_FortuitousSanctuaryTouch(hero, object)
    if fortuitous_sanctuary_rmg.used_by_hero[hero] then
        ShowFlyingSign(fortuitous_sanctuary_rmg.path.."already_used.txt", object, GetObjectOwner(hero), 6.0)
        return
    end
    --
    fortuitous_sanctuary_rmg.used_by_hero[hero] = 1
    local date = GetDate(DAY_OF_WEEK)
    for bonus, amount in fortuitous_sanctuary_rmg.bonuses[date] do
        GiveHeroBattleBonus(hero, bonus, amount)
        if (date == 2 or date == 4) and not preserve_sparkling_fountain.buildings_used_for_hero[hero][object] then
            startThread(SparklingFountain_TryGiveMP, hero, object)
        end
    end
end