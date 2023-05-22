-- @skill
-- Трофеи
spoils_of_war = 
{}

CombatResultsEvent.AddListener("BTD_RMG_spoils_of_war_combat_result",
function(fight_id)
    local winner = GetSavedCombatArmyHero(fight_id, 1)
    if winner and HasHeroSkill(winner, WIZARD_FEAT_SPOILS_OF_WAR) then
        local max_creature_tier = -1
        local stack_count = GetSavedCombatArmyCreaturesCount(fight_id, 0)
        for stack = 0, stack_count - 1 do
            local creature, count, dead = GetSavedCombatArmyCreatureInfo(fight_id, 0, stack)
            local level = Creature.Params.Level(creature)
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