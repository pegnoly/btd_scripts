-- @skill
-- вечное рабство
no_rest_for_the_wicked =
{
    level_bottom_limit = 1,
    level_upper_limit = 3
}

CombatResultsEvent.AddListener("BTD_RMG_no_rest_for_the_wicked_combat_result",
function(fight_id)
    print('fight_id ', fight_id)
    local winner = GetSavedCombatArmyHero(fight_id, 1)
    
    print('winner ', winner)
    if winner and HasHeroSkill(winner, PERK_NO_REST_FOR_THE_WICKED) then
        print('16 ')
        local possible_tiers_to_add, n = {}, 0
        local stack_count = GetSavedCombatArmyCreaturesCount(fight_id, 0)
        print('19 ')
        for stack = 0, stack_count - 1 do
            local creature, count, dead = GetSavedCombatArmyCreatureInfo(fight_id, 0, stack)
            local level = Creature.Params.Tier(creature)
            print('23 ')
            if not contains(possible_tiers_to_add, level) and (level >= no_rest_for_the_wicked.level_bottom_limit) and (level <= no_rest_for_the_wicked.level_upper_limit) then
                n = n + 1
                possible_tiers_to_add[n] = level
            end
        end
        
        print('n ', n)
        
        if n > 0 then
            Hero.CreatureInfo.AddByTier(winner, TOWN_NECROMANCY, random(n) + 1, 1)
        end
    end
end)