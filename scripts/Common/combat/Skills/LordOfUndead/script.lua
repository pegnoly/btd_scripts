CREATURE_LORD_OF_UNDEAD_CASTER_L1 = 213
CREATURE_LORD_OF_UNDEAD_CASTER_L2 = 214
CREATURE_LORD_OF_UNDEAD_CASTER_L3 = 215
CREATURE_LORD_OF_UNDEAD_CASTER_L4 = 216

lord_of_undead_common = {
    [ATTACKER] = {
        necromancy_level = -1,
        resurrected_stacks = {}
    },
    [DEFENDER] = {
        necromancy_level = -1,
        resurrected_stacks = {}
    }
}

if GetGameVar(GetHeroName(GetAttackerHero()).."_LORD_OF_UNDEAD") == '1' then
    lord_of_undead_common[ATTACKER] = {
        necromancy_level = ceil(GetGameVar(GetHeroName(GetAttackerHero()).."_NECROMANCY_LEVEL") + 0),
        resurrected_stacks = {},
        state = COMBAT_CAST_STATE_INACTIVE
    }
    AddCombatFunction(CombatFunctions.ATTACKER_HERO_MOVE, "lord_of_undead_common_attacker_hero_move",
    function(hero)
        if lord_of_undead_common[ATTACKER].state == COMBAT_CAST_STATE_POST_CAST then
            lord_of_undead_common[ATTACKER].state = COMBAT_CAST_STATE_INACTIVE
            return
        end
        startThread(LordOfUndead_HeroMove, hero, ATTACKER)
        while combatReadyPerson() ~= nil do
            sleep()
        end
        if lord_of_undead_common[ATTACKER].state == COMBAT_CAST_STATE_ACTIVE then
            lord_of_undead_common[ATTACKER].state = COMBAT_CAST_STATE_POST_CAST
        end
    end)
end

if GetDefenderHero() and GetGameVar(GetHeroName(GetDefenderHero()).."_LORD_OF_UNDEAD") == '1' then
    lord_of_undead_common[DEFENDER] = {
        necromancy_level = ceil(GetGameVar(GetHeroName(GetDefenderHero()).."_NECROMANCY_LEVEL") + 0),
        resurrected_stacks = {},
        state = COMBAT_CAST_STATE_INACTIVE
    }
    AddCombatFunction(CombatFunctions.DEFENDER_HERO_MOVE, "lord_of_undead_common_attacker_hero_move",
    function(hero)
        if lord_of_undead_common[DEFENDER].state == COMBAT_CAST_STATE_POST_CAST then
            lord_of_undead_common[DEFENDER].state = COMBAT_CAST_STATE_INACTIVE
            return
        end
        startThread(LordOfUndead_HeroMove, hero, DEFENDER)
        while combatReadyPerson() ~= nil do
            sleep()
        end
        if lord_of_undead_common[DEFENDER].state == COMBAT_CAST_STATE_ACTIVE then
            lord_of_undead_common[DEFENDER].state = COMBAT_CAST_STATE_POST_CAST
        end
    end)
end

function LordOfUndead_HeroMove(hero, side) 
    if lord_of_undead_common[side].state == COMBAT_CAST_STATE_ACTIVE then
        return 1
    end
    lord_of_undead_common[side].state = COMBAT_CAST_STATE_ACTIVE
    local army = side == ATTACKER and attacker_real_army or defender_real_army
    local possible_stacks, n = {}, 0
    for creature, count in army do
        if exist(creature) and 
            (not lord_of_undead_common[side].resurrected_stacks[creature]) and
            (GetCreatureNumber(creature) == 0) then
            n = n + 1
            possible_stacks[n] = creature
        end
    end
    if n > 0 then
        local stack_to_resurrect = Random.FromTable(possible_stacks)
        if stack_to_resurrect then
            local helper = "lord_of_undead_helper_"..side
            if pcall(AddCreature, side, lord_of_undead_common[side].necromancy_level + 212, 1, -1, -1, nil, helper) then
                while not exist(helper) do
                    sleep()
                end
                startThread(playAnimation, hero, "cast", ONESHOT)
                pcall(UnitCastAimedSpell, helper, SPELL_ANIMATE_DEAD, stack_to_resurrect)
                sleep(10)
                removeUnit(helper)
                while exist(helper) do
                    sleep()
                end
            end
        end
    end
end