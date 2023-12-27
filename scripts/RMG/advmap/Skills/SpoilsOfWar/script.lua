-- @skill
-- Трофеи
spoils_of_war = 
{
    active_for_hero = {},
    res_to_give = 
    {
        [WOOD] = 5, [ORE] = 5, [MERCURY] = 2, [CRYSTAL] = 2, [SULFUR] = 2, [GEM] = 2, [GOLD] = 2000
    }
}

-- AddHeroEvent.AddListener("BTD_RMG_spoils_of_war_add_hero",
-- function(hero)
--     spoils_of_war.active_for_hero[hero] = nil
--     startThread(
--     function()
--         while 1 do
--             if IsHeroAlive(%hero) then
--                 if not spoils_of_war.active_for_hero[%hero] and HasHeroSkill(%hero, WIZARD_FEAT_SPOILS_OF_WAR) then
--                     spoils_of_war.active_for_hero[%hero] = 1
--                     for res, amount in spoils_of_war.res_to_give do
--                         Resource.Change(%hero, res, amount)
--                     end
--                     return
--                 end
--             end
--             sleep()
--         end
--     end)
-- end)

CombatResultsEvent.AddListener("BTD_RMG_spoils_of_war_combat_result",
function(fight_id)
    local winner = GetSavedCombatArmyHero(fight_id, 1)
    if winner and HasHeroSkill(winner, WIZARD_FEAT_SPOILS_OF_WAR) then
        local max_creature_tier = -1
        local stack_count = GetSavedCombatArmyCreaturesCount(fight_id, 0)
        for stack = 0, stack_count - 1 do
            local creature, count, dead = GetSavedCombatArmyCreatureInfo(fight_id, 0, stack)
            local level = Creature.Params.Tier(creature)
            if level > max_creature_tier then
                max_creature_tier = level
            end
        end
        if max_creature_tier >= 6 then
            if max_creature_tier == 6 then
                Art.Distribution.Give(winner, Art.Distribution.RandomMinor())
            elseif max_creature_tier == 7 then
                Art.Distribution.Give(winner, Art.Distribution.RandomMajor())
            else
                Art.Distribution.Give(winner, Art.Distribution.RandomRelic())
            end
        end
    end
end)