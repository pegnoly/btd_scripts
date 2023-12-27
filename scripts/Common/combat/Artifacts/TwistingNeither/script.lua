twisting_neither = {
    mana_divisor = 2,
    [ATTACKER] = {},
    [DEFENDER] = {}
}

if GetGameVar(GetHeroName(GetAttackerHero()).."_TWISTING_NEITHER") == 'active' then
    twisting_neither[ATTACKER] = {
    }
    AddCombatFunction(CombatFunctions.DEFENDER_CREATURE_MOVE, "twisting_neither_common_defender_creature_move", 
    function(creature)
        TwistingNeitherCreatureMove(creature, ATTACKER)
    end)
end

if GetDefenderHero() and GetGameVar(GetHeroName(GetDefenderHero()).."_TWISTING_NEITHER") == 'active' then
    twisting_neither[DEFENDER] = {
    }
    AddCombatFunction(CombatFunctions.ATTACKER_CREATURE_MOVE, "twisting_neither_common_defender_creature_move", 
    function(creature)
        TwistingNeitherCreatureMove(creature, DEFENDER)
    end)
end

function TwistingNeitherCreatureMove(creature, side)
    local current_mana = GetUnitManaPoints(creature)
    if current_mana > 0 then
        print("twisting_neither current mana: ", current_mana)
        startThread(
        function()
            while combatReadyPerson() do
                sleep()
            end
            while not combatReadyPerson() do
                sleep()
            end
            local new_mana = GetUnitManaPoints(%creature)
            print("twisting_neither new mana: ", new_mana)
            local mana_to_add = floor((%current_mana - new_mana) / twisting_neither.mana_divisor)
            if mana_to_add > 0 then
                local hero = GetHero(%side)
                local hero_current_mana = GetUnitManaPoints(hero)
                SetUnitManaPoints(hero, hero_current_mana + mana_to_add)
            end
        end)
    else
        return
    end
end