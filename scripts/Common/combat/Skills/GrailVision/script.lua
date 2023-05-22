grail_vision =
{
  stacks_count = 3,
  [ATTACKER] = {},
  [DEFENDER] = {}
}

if GetGameVar(GetHeroName(GetAttackerHero()).."_GRAIL_VISION") == '1' then
  AddCombatFunction(CombatFunctions.START, "BTD_grail_vision_start_attacker",
  function()
    startThread(GrailVision_Start, ATTACKER)
  end)
end

if GetDefenderHero() and (GetGameVar(GetHeroName(GetDefenderHero()).."_GRAIL_VISION") == '1') then
  AddCombatFunction(CombatFunctions.START, "BTD_grail_vision_start_defender",
  function()
    startThread(GrailVision_Start, DEFENDER)
  end)
end

function GrailVision_Start(side)
  local stacks_to_cast, n = {}, 0
  local creatures = GetCreatures(side)
  local curr_count = len(creatures) > 2 and grail_vision.stacks_count or len(creatures)
  print("Curr count: ", curr_count)
  --
  while 1 do
    local chk = random(curr_count) - 1
    local stack = creatures[chk]
    if not contains(stacks_to_cast, stack) then
      print("Stack added: ", stack)
      n = n + 1
      stacks_to_cast[n] = stack
      if n == curr_count then
        break
      end
    end
    sleep()
  end
  --
  local enemy_stacks_to_cast, e_n = {}, 0
  local enemy_creatures = GetCreatures(1 - side)
  local enemy_curr_count = len(enemy_creatures) > 2 and grail_vision.stacks_count or len(enemy_creatures)
  print("Enemy curr count: ", enemy_curr_count)
  --
  while 1 do
    local chk = random(enemy_curr_count) - 1
    local stack = enemy_creatures[chk]
    if not contains(enemy_stacks_to_cast, stack) then
      print("Stack added: ", stack)
      e_n = e_n + 1
      enemy_stacks_to_cast[e_n] = stack
      if e_n == enemy_curr_count then
        break
      end
    end
    sleep()
  end
  --
  local helper = "grail_vision_"..side.."_helper"
  if pcall(AddCreature, side, 979, 10, -1, -1, nil, helper) then
    while not exist(helper) do
      sleep()
    end
    for i, stack in stacks_to_cast do
      pcall(UnitCastAimedSpell, helper, SPELL_ABILITY_LUCK_GAMBLER, stack)
    end
    for i, stack in enemy_stacks_to_cast do
      pcall(UnitCastAimedSpell, helper, SPELL_ABILITY_LUCK_GAMBLER, stack)
    end
    sleep(10)
    removeUnit(helper)
    while exist(helper) do
      sleep()
    end
  end
end