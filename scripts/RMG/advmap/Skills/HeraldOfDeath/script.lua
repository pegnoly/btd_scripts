-- @skill
-- вестник смерти
herald_of_death =
{
    level_bottom_limit = 4,
    level_upper_limit = 7
}

CombatResultsEvent.AddListener("BTD_RMG_herald_of_death_combat_result",
function(fight_id)
    local winner = GetSavedCombatArmyHero(fight_id, 1)
    if winner and HasHeroSkill(winner, NECROMANCER_FEAT_HERALD_OF_DEATH) then
        local possible_tiers_to_add, n = {}, 0
        local stack_count = GetSavedCombatArmyCreaturesCount(fight_id, 0)
        for stack = 0, stack_count - 1 do
            local creature, count, dead = GetSavedCombatArmyCreatureInfo(fight_id, 0, stack)
            local level = Creature.Params.Tier(creature)
            if not contains(possible_tiers_to_add, level) and (level >= herald_of_death.level_bottom_limit) and (level <= herald_of_death.level_upper_limit) then
                n = n + 1
                possible_tiers_to_add[n] = level
            end
        end
        if n > 0 then
            Hero.CreatureInfo.AddByTier(winner, TOWN_NECROMANCY, possible_tiers_to_add[random(n) + 1], 1)
        end
    end
end)