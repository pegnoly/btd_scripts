shake_ground =
{
  [ATTACKER] = {},
  [DEFENDER] = {}
}

if GetGameVar(GetHeroName(GetAttackerHero()).."_SHAKE_GROUND") == '1' then
  AddCombatFunction(CombatFunctions.START, "BTD_shake_ground_start_attacker",
  function()
    startThread(ShakeGround_Start, ATTACKER)
  end)
end

if GetDefenderHero() and GetGameVar(GetHeroName(GetDefenderHero()).."_SHAKE_GROUND") == '1' then
  AddCombatFunction(CombatFunctions.START, "BTD_shake_ground_start_defender",
  function()
    startThread(ShakeGround_Start, DEFENDER)
  end)
end


function ShakeGround_Start(side)
  for i, machine in GetWarMachines(1 - side) do
    startThread(
    function()
      local helper = "shake_ground_"..%side.."_"..%machine.."_helper"
      if pcall(AddCreature, %side, CREATURE_GREMLIN_SABOTEUR, 100, -1, -1, nil, helper) then
        while not exist(helper) do
          sleep()
        end
        pcall(UnitCastAimedSpell, helper, SPELL_ABILITY_SABOTAGE, %machine)
        removeUnit(helper)
        while exist(helper) do
          sleep()
        end
      end
    end)
  end
end