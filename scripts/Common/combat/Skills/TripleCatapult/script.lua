triple_catapult =
{
  [ATTACKER] = {},
  [DEFENDER] = {}
}

if GetGameVar(GetHeroName(GetAttackerHero()).."_TRIPLE_CATAPULT") == '1' then
  triple_catapult[ATTACKER] =
  {
    [WAR_MACHINE_BALLISTA] = nil,
    [WAR_MACHINE_CATAPULT] = nil,
    [WAR_MACHINE_FIRST_AID_TENT] = nil,
    [WAR_MACHINE_AMMO_CART] = nil
  }
  AddCombatFunction(CombatFunctions.ATTACKER_WARMACHINE_DEATH, "BTD_triple_catapult_attacker_machine_death",
  function(machine)
    startThread(TripleCatapult_Repair, machine, ATTACKER)
  end)
end

if GetDefenderHero() and GetGameVar(GetHeroName(GetDefenderHero()).."_TRIPLE_CATAPULT") == '1' then
  triple_catapult[DEFENDER] =
  {
    [WAR_MACHINE_BALLISTA] = nil,
    [WAR_MACHINE_CATAPULT] = nil,
    [WAR_MACHINE_FIRST_AID_TENT] = nil,
    [WAR_MACHINE_AMMO_CART] = nil
  }
  AddCombatFunction(CombatFunctions.DEFENDER_WARMACHINE_DEATH, "BTD_triple_catapult_attacker_machine_death",
  function(machine)
    startThread(TripleCatapult_Repair, machine, DEFENDER)
  end)
end

function TripleCatapult_Repair(machine, side)
  local machine_type = GetWarMachineType(machine)
  if triple_catapult[side][machine_type] then
    return
  end
  --
  sleep(10)
  local helper = "triple_catapult_"..side.."_"..machine_type.."_helper"
  if pcall(AddCreature, side, CREATURE_MASTER_GREMLIN, 1, -1, -1, nil, helper) then
    while not exist(helper) do
      sleep()
    end
    --
    if pcall(UnitCastAimedSpell, helper, SPELL_ABILITY_REPAIR, machine) then
      triple_catapult[side][machine_type] = 1
    end
    --
    sleep()
    removeUnit(helper)
--    while exist(helper) do
--      sleep()
--    end
  end
end