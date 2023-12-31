disguise_and_reckon_duel = 
{
    [ATTACKER] = {},
    [DEFENDER] = {},

    default_invisers = {CREATURE_STALKER, CREATURE_SHADOW_MISTRESS}
}

if GetGameVar(GetHeroName(GetAttackerHero()).."_DISGUISE_AND_RECKON") == 'active' then
    AddCombatFunction(CombatFunctions.START, "disguise_and_reckon_duel_start_attacker",
    function()
        DisguiseAndReckon_Start(ATTACKER)
    end)
end
  
if GetDefenderHero() and (GetGameVar(GetHeroName(GetDefenderHero()).."_DISGUISE_AND_RECKON") == 'active') then
    AddCombatFunction(CombatFunctions.START, "disguise_and_reckon_duel_start_defender",
    function()
        DisguiseAndReckon_Start(DEFENDER)
    end)
end

function DisguiseAndReckon_Start(side)
    for i, creature in GetCreatures(side) do
        if Creature.Component.HasAbility(creature, ABILITY_INVISIBILITY) and
            (not contains(disguise_and_reckon_duel.default_invisers, GetCreatureType(creature))) then
            pcall(commandDoSpecial, creature, SPELL_ABILITY_INVISIBILITY, pos(creature))
        end
    end
end