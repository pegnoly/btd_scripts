guardian_angel_rmg = 
{
    [ATTACKER] = {},
    [DEFENDER] = {},
}

if GetGameVar(GetHeroName(GetAttackerHero()).."_GUARDIAN_ANGEL") == '1' then
    guardian_angel_rmg[ATTACKER] =
    {
        stacks_info = {},
        healers_to_summon = ceil((GetGameVar(GetHeroName(GetAttackerHero()).."_lvl") + 0) / 10)
    }
    AddCombatFunction(CombatFunctions.START, "rmg_guardian_angel_attacker_start",
    function(hero)
        startThread(GuardianAngel_Start, ATTACKER)
    end)
end
  
if GetDefenderHero() and (GetGameVar(GetHeroName(GetDefenderHero()).."_GUARDIAN_ANGEL") == '1') then
    guardian_angel_rmg[DEFENDER] =
    {
        stacks_info = {},
        healers_to_summon = ceil((GetGameVar(GetHeroName(GetDefenderHero()).."_lvl") + 0) / 10)
    }
    AddCombatFunction(CombatFunctions.START, "rmg_guardian_angel_defender_start",
    function(hero)
        startThread(GuardianAngel_Start, DEFENDER)
    end)
end

function GuardianAngel_Start(side)
    EnableAutoFinish(nil)
    for i, creature in GetCreatures(side) do
        guardian_angel_rmg[side].stacks_info[creature] = Creature.Params.Power(creature) * GetCreatureNumber(creature)
    end
    --
    while 1 do
        if not GetRealArmy(side) then
            EnableAutoFinish(1)
        elseif (not GetRealArmy(1 - side)) then
            print("Enemy army is dead")
            DisableCombat()
            local current_stack_to_resurrect = ""
            local current_max_power_diff = 1
            for creature, power in guardian_angel_rmg[side].stacks_info do
                local curr_power = Creature.Params.Power(creature) * GetCreatureNumber(creature)
                local curr_power_diff = curr_power / power
                if exist(creature) and (curr_power_diff < current_max_power_diff) then
                    current_stack_to_resurrect = creature
                    current_max_power_diff = curr_power_diff
                end
            end
            print("Current stack to resurrect: ", current_stack_to_resurrect)
            if current_stack_to_resurrect ~= "" then
                local helper = "guardian_angel_helper_"..side
                if pcall(AddCreature, side, CREATURE_ARCHANGEL, guardian_angel_rmg[side].healers_to_summon, -1, -1, nil, helper) then
                    while not exist(helper) do
                        sleep()
                    end
                    pcall(UnitCastAimedSpell, helper, SPELL_ABILITY_RESURRECT_ALLIES, current_stack_to_resurrect)
                    sleep(200)
                    removeUnit(helper)
                    while exist(helper) do
                        sleep()
                    end
                end
                sleep(200)
                Finish(side)
            else
              Finish(side)
            end
        end
        sleep()
    end
end