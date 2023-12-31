--- 25.05.2023. Improved a little, heaven's additional seraph grow added to main function

diplomacy_duel =
{
    wizard_tier_by_race = 
    {
        [TOWN_HEAVEN] =     5,
        [TOWN_INFERNO] =    6,
        [TOWN_NECROMANCY] = 5,
        [TOWN_PRESERVE] =   4,
        [TOWN_ACADEMY] =    4,
        [TOWN_DUNGEON] =    6,
        [TOWN_FORTRESS] =   5,
        [TOWN_STRONGHOLD] = 4,
    }
}

NewDayEvent.AddListener("BTD_duel_diplomacy_new_day",
function(day)
    errorHook(function ()
        print("<color=red>Error: <color=green> Diplomacy duel new day.")
    end)
    if day == BTD_duel_day_sequence.prefight_day then
        for hero, alive_status in AdvMapHeroesInfo.alive_heroes do
            if hero and alive_status == HERO_CONDITION_ALIVE and HasHeroSkill(hero, PERK_DIPLOMACY) then
                local race = Hero.Params.Town(hero)
                local tiers_used = {}
                local stacks = table.pack(GetHeroCreaturesTypes(hero))
                for _, creature in stacks do
                    local tier = Creature.Params.Tier(creature)
                    local is_caster = Creature.Type.IsCaster(creature)
                    if (not tiers_used[tier]) and 
                        (tier >= diplomacy_duel.wizard_tier_by_race[race]) and is_caster then
                        local grow = Creature.Params.Grow(creature)
                        tiers_used[tier] = 1
                        startThread(Hero.CreatureInfo.Add, hero, creature, grow)
                    end
                end
            end
        end
    end
end)