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
    },
    casters_info = {
        [1] = {id = CREATURE_LORD_OF_UNDEAD_CASTER_L1, count = 1},
        [2] = {id = CREATURE_LORD_OF_UNDEAD_CASTER_L1, count = 5},
        [3] = {id = CREATURE_LORD_OF_UNDEAD_CASTER_L2, count = 6},
        [4] = {id = CREATURE_LORD_OF_UNDEAD_CASTER_L2, count = 8}
    }
}

if GetGameVar(GetHeroName(GetAttackerHero()).."_LORD_OF_UNDEAD") == '1' then
    lord_of_undead_common[ATTACKER] = {
        necromancy_level = ceil(GetGameVar(GetHeroName(GetAttackerHero()).."_NECROMANCY_LEVEL") + 0),
        possible_stacks = {},
        resurrected_stacks = {},
        state = COMBAT_CAST_STATE_INACTIVE
    }
    print("Necromancy level: ", lord_of_undead_common[ATTACKER].necromancy_level)
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
    AddCombatFunction(CombatFunctions.ATTACKER_CREATURE_DEATH, "lord_of_undead_common_attacker_creature_death",
    function(creature)
        LordOfUndead_CreatureDeath(creature, ATTACKER)
    end)
end

if GetDefenderHero() and GetGameVar(GetHeroName(GetDefenderHero()).."_LORD_OF_UNDEAD") == '1' then
    lord_of_undead_common[DEFENDER] = {
        necromancy_level = ceil(GetGameVar(GetHeroName(GetDefenderHero()).."_NECROMANCY_LEVEL") + 0),
        possible_stacks = {},
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
    AddCombatFunction(CombatFunctions.DEFENDER_CREATURE_DEATH, "lord_of_undead_common_defender_creature_death",
    function(creature)
        LordOfUndead_CreatureDeath(creature, DEFENDER)
    end)
end

function LordOfUndead_CreatureDeath(creature, side)
    if lord_of_undead_common[side].resurrected_stacks[creature] or Creature.Params.Town(creature) ~= TOWN_NECROMANCY then
        return
    end
    local army = side == ATTACKER and attacker_real_army or defender_real_army
    if army[creature] then
        lord_of_undead_common[side].possible_stacks[creature] = 1
    end
end

function LordOfUndead_HeroMove(hero, side) 
    if lord_of_undead_common[side].state == COMBAT_CAST_STATE_ACTIVE then
        return 1
    end
    lord_of_undead_common[side].state = COMBAT_CAST_STATE_ACTIVE
    local possible_stacks, n = {}, 0
    for creature, _ in lord_of_undead_common[side].possible_stacks do
        if exist(creature) and GetCreatureNumber(creature) == 0 and (not lord_of_undead_common[side].resurrected_stacks[creature]) then
            n = n + 1
            possible_stacks[n] = creature
        else 
            lord_of_undead_common[side].possible_stacks[creature] = nil
        end
    end
    print("lord of undead: ", possible_stacks)
    if n > 0 then
        local stack_to_resurrect = Random.FromTable(possible_stacks)
        if stack_to_resurrect then
            lord_of_undead_common[side].resurrected_stacks[stack_to_resurrect] = 1
            local helper = "lord_of_undead_helper_"..side
            --lord_of_undead_common[side].necromancy_level + 212
            local caster_id = lord_of_undead_common.casters_info[lord_of_undead_common[side].necromancy_level].id
            local casters_count = lord_of_undead_common.casters_info[lord_of_undead_common[side].necromancy_level].count
            if pcall(AddCreature, side, caster_id, casters_count, -1, -1, nil, helper) then
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
    else 
        lord_of_undead_common[side].state = COMBAT_CAST_STATE_INACTIVE
    end
end