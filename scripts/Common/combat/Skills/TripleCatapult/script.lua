triple_catapult =
{
  double_shot_turn_divisor = 2,
  [ATTACKER] = {
    shooters_turn_count = {}
  },
  [DEFENDER] = {
    shooters_turn_count = {}
  }
}

if GetGameVar(GetHeroName(GetAttackerHero()).."_TRIPLE_CATAPULT") == '1' then
  AddCombatFunction(CombatFunctions.ATTACKER_CREATURE_MOVE, "triple_catapult_attacker_creature_move",
  function (creature)
    startThread(TripleCatapult_DoubleShot, creature, ATTACKER)
  end)
  -- triple_catapult[ATTACKER] =
  -- {
  --   [WAR_MACHINE_BALLISTA] = nil,
  --   [WAR_MACHINE_CATAPULT] = nil,
  --   [WAR_MACHINE_FIRST_AID_TENT] = nil,
  --   [WAR_MACHINE_AMMO_CART] = nil
  -- }
  -- AddCombatFunction(CombatFunctions.ATTACKER_WARMACHINE_DEATH, "BTD_triple_catapult_attacker_machine_death",
  -- function(machine)
  --   startThread(TripleCatapult_Repair, machine, ATTACKER)
  -- end)
end

if GetDefenderHero() and GetGameVar(GetHeroName(GetDefenderHero()).."_TRIPLE_CATAPULT") == '1' then
  AddCombatFunction(CombatFunctions.DEFENDER_CREATURE_MOVE, "triple_catapult_defender_creature_move",
  function (creature)
    startThread(TripleCatapult_DoubleShot, creature, DEFENDER)
  end)
  -- triple_catapult[DEFENDER] =
  -- {
  --   [WAR_MACHINE_BALLISTA] = nil,
  --   [WAR_MACHINE_CATAPULT] = nil,
  --   [WAR_MACHINE_FIRST_AID_TENT] = nil,
  --   [WAR_MACHINE_AMMO_CART] = nil
  -- }
  -- AddCombatFunction(CombatFunctions.DEFENDER_WARMACHINE_DEATH, "BTD_triple_catapult_attacker_machine_death",
  -- function(machine)
  --   startThread(TripleCatapult_Repair, machine, DEFENDER)
  -- end)
end

---@deprecated
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

function TripleCatapult_DoubleShot(creature, side) 
  if not GetWarMachine(side, WAR_MACHINE_AMMO_CART) then
    return
  end
  --
  if Creature.Type.IsShooter(creature) then
    -- turns count increase
    if not triple_catapult[side].shooters_turn_count[creature] then
      triple_catapult[side].shooters_turn_count[creature] = 1
      return
    else
      triple_catapult[side].shooters_turn_count[creature] = triple_catapult[side].shooters_turn_count[creature] + 1
    end
    --
    print("creature: ", creature, ", shots: ", triple_catapult[side].shooters_turn_count[creature])
    --
    if triple_catapult[side].shooters_turn_count[creature] == triple_catapult.double_shot_turn_divisor then
      triple_catapult[side].shooters_turn_count[creature] = -1
      local current_closest_target = ""
      local current_closest_distance = math.huge
      for i, stack in GetCreatures(1 - side) do
        local dist = CheckDist(creature, stack)
        if dist < current_closest_distance then
          current_closest_distance = dist
          current_closest_target = stack
        end
      end
      --
      if current_closest_target ~= "" and
          pcall(commandShot, creature, current_closest_target) then
        combatSetPause(1)
        while combatReadyPerson() do
          sleep()
        end
        setATB(creature, 1)
        combatSetPause(nil)
      end
    else
      return
    end
  end
end