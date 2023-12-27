-- @skill
-- Удача в пути(рмг) + 2 удачи за поднятие сокровища, восстановление мувпоинтов единовременно.
fortunate_adventurer_rmg =
{
    luck_active_for_hero = {},
    mp_restored_for_hero = {},
    luck_bonus = 2
}

MapLoadingEvent.AddListener("BTD_RMG_fortunate_adventurer_init", 
function()
    while not TREASURES do
        sleep()
    end
    for i, treasure in TREASURES do
        Touch.SetTrigger(treasure)
        Touch.SetFunction(treasure, "_collect",
        function(hero, object)
            if HasHeroSkill(hero, PERK_FORTUNATE_ADVENTURER) then
                if not fortunate_adventurer_rmg.luck_active_for_hero[hero] then
                    fortunate_adventurer_rmg.luck_active_for_hero[hero] = 1
                    GiveHeroBattleBonus(hero, HERO_BATTLE_BONUS_LUCK, fortunate_adventurer_rmg.luck_bonus)
                end
            end
        end)
    end
end)

CombatResultsEvent.AddListener("BTD_RMG_fortunate_adventurer_combat_result",
function(fight_id)
    local winner = GetSavedCombatArmyHero(fight_id, 1)
    local loser = GetSavedCombatArmyHero(fight_id, 0)
    if winner and fortunate_adventurer_rmg.luck_active_for_hero[winner] then
        fortunate_adventurer_rmg.luck_active_for_hero[winner] = nil
    end
    if loser and fortunate_adventurer_rmg.luck_active_for_hero[loser] then
        fortunate_adventurer_rmg.luck_active_for_hero[loser] = nil
    end
end)

AddHeroEvent.AddListener("BTD_RMG_fortunate_adventurer_add_hero",
function(hero)
    startThread(
    function ()
        while 1 do
            if IsHeroAlive(%hero) then
                if HasHeroSkill(%hero, PERK_FORTUNATE_ADVENTURER) and (not fortunate_adventurer_rmg.mp_restored_for_hero[%hero]) then
                    fortunate_adventurer_rmg.mp_restored_for_hero[%hero] = 1
                    ChangeHeroStat(%hero, STAT_MOVE_POINTS, 10000)
                    -- dark ritual fix
                    MapSpellsCheckers.tHeroStorage[%hero].maxMovePoints = GetHeroStat(%hero, STAT_MOVE_POINTS)
                end
            end
            sleep()
        end
    end)
end)