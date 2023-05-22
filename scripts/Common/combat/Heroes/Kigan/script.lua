kigan_spec =
{
  heroes = {"Hero9", "Hero91", "Hero92"},
  goblins = {CREATURE_GOBLIN, CREATURE_GOBLIN_TRAPPER, CREATURE_GOBLIN_DEFILER},
  atb_return_factor = 0.8,
  [ATTACKER] = {},
  [DEFENDER] = {}
}

if contains(kigan_spec.heroes, GetHeroName(GetAttackerHero())) then
  kigan_spec[ATTACKER] =
  {}
  AddCombatFunction(CombatFunctions.START, "kigan_spec_start_attacker",
  function()
    startThread(KiganSpec_WarcryCast, ATTACKER)
  end)
end

if GetDefenderHero() and contains(kigan_spec.heroes, GetHeroName(GetDefenderHero())) then
  kigan_spec[DEFENDER] =
  {}
  AddCombatFunction(CombatFunctions.START, "kigan_spec_start_defender",
  function()
    startThread(KiganSpec_WarcryCast, DEFENDER)
  end)
end

function KiganSpec_WarcryCast(side)
  local hero = GetHero(side)
  local current_mana = GetUnitManaPoints(hero)
  local mana_to_add = current_mana + 1000
  --
  SetUnitManaPoints(hero, mana_to_add)
  while GetUnitManaPoints(hero) ~= mana_to_add do
    sleep()
  end
  --
  for i, creature in GetCreatures(side) do
    local type = GetCreatureType(creature)
    if contains(kigan_spec.goblins, type) and pcall(UnitCastAimedSpell, hero, SPELL_WARCRY_CALL_OF_BLOOD, creature) then
    end
  end
  --
  SetUnitManaPoints(hero, current_mana)
  EndTurn(hero, kigan_spec.atb_return_factor)
end