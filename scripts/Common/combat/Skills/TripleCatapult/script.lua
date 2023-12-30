triple_catapult =
{
  double_shot_turn_divisor = 2,
  [ATTACKER] = {
    shooters_state = {}
  },
  [DEFENDER] = {
    shooters_state = {}
  }
}

DOUBLE_SHOT_STATE_NOT_READY = 1
DOUBLE_SHOT_STATE_READY = 2
DOUBLE_SHOT_STATE_IN_PROCESS = 3
DOUBLE_SHOT_STATE_DONE = 4
DOUBLE_SHOT_STATE_BAD = 5

if GetGameVar(GetHeroName(GetAttackerHero()).."_TRIPLE_CATAPULT") == '1' then
  AddCombatFunction(CombatFunctions.ATTACKER_CREATURE_MOVE, "triple_catapult_attacker_creature_move",
  function (creature)
      if (not Creature.Type.IsShooter(creature)) or (not GetWarMachine(ATTACKER, WAR_MACHINE_AMMO_CART)) then
          return 
      end
      --
      if not triple_catapult[ATTACKER].shooters_state[creature] then
          triple_catapult[ATTACKER].shooters_state[creature] = DOUBLE_SHOT_STATE_NOT_READY
          --return
      end
      --
      local state = triple_catapult[ATTACKER].shooters_state[creature]
      if state == DOUBLE_SHOT_STATE_NOT_READY then
          triple_catapult[ATTACKER].shooters_state[creature] = DOUBLE_SHOT_STATE_READY
          return
      elseif state == DOUBLE_SHOT_STATE_READY then
          triple_catapult[ATTACKER].shooters_state[creature] = DOUBLE_SHOT_STATE_IN_PROCESS
          startThread(TripleCatapult_DoubleShot, creature, ATTACKER)
      elseif state == DOUBLE_SHOT_STATE_DONE then
          while combatReadyPerson() do
              sleep()
          end
          triple_catapult[ATTACKER].shooters_state[creature] = DOUBLE_SHOT_STATE_NOT_READY
          return
      end
  end)
end

if GetDefenderHero() and GetGameVar(GetHeroName(GetDefenderHero()).."_TRIPLE_CATAPULT") == '1' then
  AddCombatFunction(CombatFunctions.DEFENDER_CREATURE_MOVE, "triple_catapult_defender_creature_move",
  function (creature)
      if (not Creature.Type.IsShooter(creature)) or (not GetWarMachine(DEFENDER, WAR_MACHINE_AMMO_CART)) then
          return 
      end
      --
      if not triple_catapult[DEFENDER].shooters_state[creature] then
          while combatReadyPerson() do
              sleep()
          end
          triple_catapult[DEFENDER].shooters_state[creature] = DOUBLE_SHOT_STATE_NOT_READY
          --return
      end
      --
      local state = triple_catapult[DEFENDER].shooters_state[creature]
      if state == DOUBLE_SHOT_STATE_NOT_READY then
          while combatReadyPerson() do
              sleep()
          end
          triple_catapult[DEFENDER].shooters_state[creature] = DOUBLE_SHOT_STATE_READY
          return
      elseif state == DOUBLE_SHOT_STATE_READY then
          triple_catapult[DEFENDER].shooters_state[creature] = DOUBLE_SHOT_STATE_IN_PROCESS
          startThread(TripleCatapult_DoubleShot, creature, DEFENDER)
      elseif state == DOUBLE_SHOT_STATE_DONE then
          while combatReadyPerson() do
              sleep()
          end
          triple_catapult[DEFENDER].shooters_state[creature] = DOUBLE_SHOT_STATE_NOT_READY
          return
      end
  end)
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
    if current_closest_target ~= "" and pcall(commandShot, creature, current_closest_target) then
        triple_catapult[side].shooters_state[creature] = DOUBLE_SHOT_STATE_DONE
        combatSetPause(1)
        while combatReadyPerson() do
          sleep()
        end
        setATB(creature, 1)
        combatSetPause(nil)
        return
    else
        triple_catapult[side].shooters_state[creature] = DOUBLE_SHOT_STATE_DONE
        return
    end
end