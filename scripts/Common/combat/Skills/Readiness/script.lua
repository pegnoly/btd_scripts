readiness =
{
  [ATTACKER] = {},
  [DEFENDER] = {}
}

if GetGameVar(GetHeroName(GetAttackerHero()).."_MASTERY_READY") == '1' then
  AddCombatFunction(CombatFunctions.START, "BTD_readiness_start_attacker",
  function()
    startThread(Readiness_Start, ATTACKER)
  end)
end

if GetDefenderHero() and (GetGameVar(GetHeroName(GetDefenderHero()).."_MASTERY_READY") == '1') then
  AddCombatFunction(CombatFunctions.START, "BTD_readiness_start_defender",
  function()
    startThread(Readiness_Start, DEFENDER)
  end)
end

function Readiness_Start(side)
  for i, creature in GetCreatures(side) do
    if (not Creature.Type.IsCaster(creature)) and (not Creature.Type.IsShooter(creature)) then
      pcall(commandDefend, creature)
    end
  end
end