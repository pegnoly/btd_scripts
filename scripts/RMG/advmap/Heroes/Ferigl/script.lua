ferigl_spec_rmg = {
    rider_resurrect_base = 2, -- base count of riders to ressurect
    rider_resurrect_by_lvl_divisor = 2, -- riders to ressurect by every lvl divisor
    rider_resurrect_lvl_divisor = 5, -- levels to increase ressurect count 

    rider_grow_per_divisor = 2,
    rider_grow_divisor = 8,

    rider_types = {CREATURE_RIDER, CREATURE_BLACK_RIDER, CREATURE_RAVAGER},
    heroes = {"Ferigl"}
}

CombatResultsEvent.AddListener("BTD_RMG_ferigl_spec_combat_result",
function(fight_id)
    local winner = GetSavedCombatArmyHero(fight_id, 1)
    if winner and contains(ferigl_spec_rmg.heroes, winner) then
        local resurrect_total_count = (
            ferigl_spec_rmg.rider_resurrect_base + 
            (floor(GetHeroLevel(winner) / ferigl_spec_rmg.rider_resurrect_lvl_divisor) * ferigl_spec_rmg.rider_resurrect_by_lvl_divisor)
        )
        --print("Ferigl spec: resurrect count - ", resurrect_total_count)
        local stack_count = GetSavedCombatArmyCreaturesCount(fight_id, 1)
        local riders_died = {}
        for i = 0, stack_count - 1 do
            local creature, count, died = GetSavedCombatArmyCreatureInfo(fight_id, 1, i)
            if contains(ferigl_spec_rmg.rider_types, creature) and died > 0 then
                if not riders_died[creature] then
                    riders_died[creature] = died
                else
                    riders_died[creature] = riders_died[creature] + died
                end
            end
        end
        if len(riders_died) == 0 then
            return
        end
        --
        local dead_count = 0
        for creature, died in riders_died do
            dead_count = dead_count + died
        end
        if dead_count < resurrect_total_count then
            resurrect_total_count = dead_count
        end
        --
        local current_max_count = -1
        local remaining_count = resurrect_total_count
        local resurrect_queue, n = {}, 0
        repeat
            --print("remainging count: ", remaining_count)
            --print("current_max_count: ", current_max_count)
            local temp = -1
            local cr = -1
            for creature, died in riders_died do
                if creature and died then
                    if died > temp then
                        temp = died 
                        cr = creature
                    end
                end
            end
            --print("temp: ", temp, " creature: ", cr)
            if temp >= remaining_count then
                current_max_count = resurrect_total_count
            else
                current_max_count = current_max_count + temp
                remaining_count = remaining_count - temp
                riders_died[cr] = nil
            end
            n = n + 1
            resurrect_queue[n] = {creature = cr, count = temp}
            sleep()
        until current_max_count == resurrect_total_count
        --print("Ferigl spec: resurrect resurrect_queue - ", resurrect_queue)
        for _, queue_item in resurrect_queue do
            Hero.CreatureInfo.Add(winner, queue_item.creature, queue_item.count)
        end
    end
end)

LevelUpEvent.AddListener("BTD_RMG_ferigl_spec_lvl_up",
function(hero)
    if contains(ferigl_spec_rmg.heroes, hero) and (mod(GetHeroLevel(hero), ferigl_spec_rmg.rider_grow_divisor) == 0) then
        startThread(Hero.CreatureInfo.DefaultGrow, hero, TOWN_DUNGEON, 4, ferigl_spec_rmg.rider_grow_per_divisor)
    end
end)