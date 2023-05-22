biara_spec =
{
  heroes = {"Biara", "Biara1", "Biara2"},
  lvl_divisor = 6,
  atb_return_factor = 0.8,
  [ATTACKER] = {},
  [DEFENDER] = {}
}

if contains(biara_spec.heroes, GetHeroName(GetAttackerHero())) then
  biara_spec[ATTACKER] =
  {
    stacks_count = ceil((GetGameVar(GetHeroName(GetAttackerHero()).."_lvl") + 0) / biara_spec.lvl_divisor)
  }
  AddCombatFunction(CombatFunctions.START, "BTD_biara_spec_start_attacker",
  function()
    startThread(BiaraSpec_SorrowCast, ATTACKER)
  end)
end

if GetDefenderHero() and contains(biara_spec.heroes, GetHeroName(GetDefenderHero())) then
  biara_spec[DEFENDER] =
  {
    stacks_count = ceil((GetGameVar(GetHeroName(GetDefenderHero()).."_lvl") + 0) / biara_spec.lvl_divisor)
  }
  AddCombatFunction(CombatFunctions.START, "BTD_biara_spec_start_defender",
  function()
    startThread(BiaraSpec_SorrowCast, DEFENDER)
  end)
end

function BiaraSpec_SorrowCast(side)
  print('Biara casts sorrow! : ', side, ', ', biara_spec[side].stacks_count)
  local creatures = GetCreatures(1 - side)
  local creatures_to_cast, n = {}, 0
  local cr_count = len(creatures) >= biara_spec[side].stacks_count and biara_spec[side].stacks_count or len(creatures)
  --
  while 1 do
    local chk = random(cr_count) - 1
    local stack = creatures[chk]
    if not contains(creatures_to_cast, stack) then
      print("Stack added: ", stack)
      n = n + 1
      creatures_to_cast[n] = stack
      if n == cr_count then
        break
      end
    end
    sleep()
  end
  --
  local hero = GetHero(side)
  local current_mana = GetUnitManaPoints(hero)
  local mana_to_add = current_mana + 1000
  print(hero, ' will have ', mana_to_add, 'mana')
  --
  SetUnitManaPoints(hero, mana_to_add)
  while GetUnitManaPoints(hero) ~= mana_to_add do
    sleep()
  end
  --
  for i, creature in creatures_to_cast do
    pcall(UnitCastAimedSpell, hero, SPELL_SORROW, creature)
  end
  --
  SetUnitManaPoints(hero, current_mana)
  EndTurn(hero, biara_spec.atb_return_factor)
end