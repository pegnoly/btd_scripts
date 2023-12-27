-- 4.0 reworked. Now gives #gold_amount# gold for every upgraded stack.
estates_duel =
{
    levels_received_gold_for_hero = {},
    gold_amount = 850,
    total_gold_for_hero = {}
}

AddHeroEvent.AddListener("BTD_duel_estates_add_hero",
function(hero)
    errorHook(function ()
        print("<color=red>Error: <color=green> Estates duel add hero.")
    end)
    estates_duel.levels_received_gold_for_hero[hero] = {}
    estates_duel.total_gold_for_hero[hero] = 0
    local town = Hero.Params.Town(hero)
    startThread(
    function()
        while 1 do
            if IsHeroAlive(%hero) then
                if HasHeroSkill(%hero, PERK_ESTATES) then
                    for slot = 0, 6 do
                        local creature, count = GetObjectArmySlotCreature(%hero, slot)
                        if not (creature == 0 or count == 0) then
                            local level = Creature.Params.Tier(creature)
                            if not contains(TOWN_DWELLS[%town], creature) and 
                              not estates_duel.levels_received_gold_for_hero[%hero][level] and
                              Creature.Params.Town(creature) == %town then
                                estates_duel.levels_received_gold_for_hero[%hero][level] = 1
                                Resource.Change(%hero, GOLD, estates_duel.gold_amount)
                                estates_duel.total_gold_for_hero[%hero] = estates_duel.total_gold_for_hero[%hero] + estates_duel.gold_amount
                            end
                        end
                    end
                end
            end
            sleep()
        end
    end)
end)