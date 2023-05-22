economy =
{
    multiplier = {[1] = 0.1, [2] = 0.15, [3] = 0.2},
    gold_economed_by_hero = {},
    
    GetCostWithEconomy =
    function(hero, cost)
        local economy_mastery = GetHeroSkillMastery(hero, SKILL_LOGISTICS)
        if economy_mastery == 0 then
            return cost
        else
            local actual_cost = ceil(cost - (cost * economy.multiplier[economy_mastery]))
            return actual_cost
        end
    end,
    
    EconomGold =
    function(hero, gold)
        economy.gold_economed_by_hero[hero] = economy.gold_economed_by_hero[hero] + gold
    end
}

AddHeroEvent.AddListener("btd_duel_economy_init_for_hero",
function(hero)
    economy.gold_economed_by_hero[hero] = 0
end)