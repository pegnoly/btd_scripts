krag_spec =
{
  heroes = {"Hero1", "Hero11", "Hero12"},
  atb_return_factor = 0.8,
  [ATTACKER] = {},
  [DEFENDER] = {}
}

if contains(krag_spec.heroes, GetHeroName(GetAttackerHero())) then
  krag_spec[ATTACKER] =
  {
      first_turn = 0
  }
  AddCombatFunction(CombatFunctions.ATTACKER_HERO_MOVE, "krag_spec_attacker_hero_move",
  function(hero)
    startThread(KragSpec_HeroMove, hero, ATTACKER)
  end)
end

if GetDefenderHero() and contains(krag_spec.heroes, GetHeroName(GetDefenderHero())) then
  krag_spec[DEFENDER] =
  {
      first_turn = 0
  }
  AddCombatFunction(CombatFunctions.DEFENDER_HERO_MOVE, "krag_spec_defender_hero_move",
  function(hero)
    startThread(KragSpec_HeroMove, hero, DEFENDER)
  end)
end

function KragSpec_HeroMove(hero, side)
    if krag_spec[side].first_turn == 1 then
        return
    end
    if krag_spec[side].first_turn == 0 then
        print("Krag's first move")
        krag_spec[side].first_turn = 1
        EndTurn(hero, 0)
    end
end