jazaz_spec = {
    path = "/scripts/RMG/combat/Heroes/Jazaz/",
    heroes = {"Jazaz"},
    creatures = {CREATURE_FAMILIAR, CREATURE_IMP, CREATURE_QUASIT},
    mana_steal_per_creature = {
        [CREATURE_FAMILIAR] = 0.25,
        [CREATURE_IMP] = 0.25,
        [CREATURE_QUASIT] = 0.125
    },
    [ATTACKER] = {},
    [DEFENDER] = {}
}

if contains(jazaz_spec.heroes, GetHeroName(GetAttackerHero())) and (not GetDefenderHero()) then
    jazaz_spec[ATTACKER] = {
        mana_drain_used_by_stack = {},
        state = COMBAT_CAST_STATE_INACTIVE
    }
    AddCombatFunction(CombatFunctions.ATTACKER_CREATURE_MOVE, "jazaz_attacker_creature_move",
    function(creature)
        if jazaz_spec[ATTACKER].state == COMBAT_CAST_STATE_POST_CAST then
            jazaz_spec[ATTACKER].state = COMBAT_CAST_STATE_INACTIVE
            return
        end
        JazazCreatureMove(creature, ATTACKER)
        while combatReadyPerson() ~= nil do
            sleep()
        end
        if jazaz_spec[ATTACKER].state == COMBAT_CAST_STATE_ACTIVE then
            jazaz_spec[ATTACKER].state = COMBAT_CAST_STATE_POST_CAST
        end
    end)
    AddCombatFunction(CombatFunctions.START, "jazaz_spec_start",
    function()
        for i, creature in GetCreatures(ATTACKER) do
            jazaz_spec[ATTACKER].mana_drain_used_by_stack[creature] = nil
        end
    end)    
end

function JazazCreatureMove(creature, side) 
    if jazaz_spec[side].mana_drain_used_by_stack[creature] then
        return
    end
    local type = GetCreatureType(creature)
    if type == CREATURE_QUASIT then
        jazaz_spec[side].state = COMBAT_CAST_STATE_ACTIVE 
    else
        jazaz_spec[side].mana_drain_used_by_stack[creature] = 1
    end
    if contains(jazaz_spec.creatures, type) then
        local possible_mana_to_steal = ceil(GetCreatureNumber(creature) * jazaz_spec.mana_steal_per_creature[type])
        if possible_mana_to_steal > 0 then
            local current_max_target_mana = 0
            local current_target = ""
            for i, target in GetCreatures(1 - side) do
                local mana_points = GetUnitManaPoints(target)
                if mana_points > 0 then
                    if mana_points > current_max_target_mana then
                        current_max_target_mana = mana_points
                        current_target = target
                    end
                end
            end
            if current_target ~= "" then
                local actual_mana_to_steal = 0
                if current_max_target_mana >= possible_mana_to_steal then
                    actual_mana_to_steal = possible_mana_to_steal
                else
                    actual_mana_to_steal = current_max_target_mana
                end
                JazazCreatureManaDrain(creature, type, side, current_target, actual_mana_to_steal)
            end
        end
    end
end

function JazazCreatureManaDrain(creature, type, side, target, amount)
    playAnimation(creature, "specability", ONESHOT)
    local current_mana = GetUnitManaPoints(target)
    SetUnitManaPoints(target, current_mana - amount)
    startThread(CombatFlyingSign, {
        jazaz_spec.path.."mana_drained.txt"; mana = amount
    }, target, 6.0)
    if type == CREATURE_IMP then
        local hero = GetHero(side)
        local current_hero_mana = GetUnitManaPoints(hero)
        -- local hero_missing_mana = GetUnitMaxManaPoints(hero) - current_hero_mana
        -- local mana_to_add = hero_missing_mana >= amount and amount or hero_missing_mana
        SetUnitManaPoints(hero, current_hero_mana + amount)
        startThread(CombatFlyingSign, {
            jazaz_spec.path.."mana_transfered.txt"; mana = mana_to_add
        }, hero, 6.0)
    elseif type == CREATURE_QUASIT then
        local ally_casters, n = {}, 0
        for i, cr in GetCreatures(side) do
            if Creature.Type.IsCaster(cr) then 
                n = n + 1
                ally_casters[n] = cr
            end
        end
        if n > 0 then
            local mana_to_syphon_on_single = ceil(amount / n)
            if mana_to_syphon_on_single > 0 then
                for i, caster in ally_casters do
                    SetUnitManaPoints(caster, GetUnitManaPoints(caster) + mana_to_syphon_on_single)
                    startThread(CombatFlyingSign, {
                        jazaz_spec.path.."mana_transfered.txt"; mana = mana_to_syphon_on_single
                    }, caster, 6.0)
                end
            end
        end
    end
end