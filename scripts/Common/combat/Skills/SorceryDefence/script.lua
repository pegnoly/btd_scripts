sorcery_defence =
{
  [ATTACKER] = {},
  [DEFENDER] = {}
}

if GetGameVar(GetHeroName(GetAttackerHero()).."MAG_DEF") == '1' then
  AddCombatFunction(CombatFunctions.START, "BTD_sorcery_def_start_attacker",
  function()
    startThread(SorceryDefence_Start, ATTACKER)
  end)
end

if GetDefenderHero() and (GetGameVar(GetHeroName(GetDefenderHero()).."MAG_DEF") == '1') then
  AddCombatFunction(CombatFunctions.START, "BTD_sorcery_def_start_defender",
  function()
    startThread(SorceryDefence_Start, DEFENDER)
  end)
end

function SorceryDefence_Start(side)
  if pcall(AddCreature, side, 979, 2, -1, -1, nil, "sorcery_def_"..side.."_helper") then
    while not exist("sorcery_def_"..side.."_helper") do
      sleep()
    end
    --
    if pcall(UnitCastGlobalSpell, "sorcery_def_"..side.."_helper", SPELL_MASS_STONESKIN) and
       pcall(UnitCastGlobalSpell, "sorcery_def_"..side.."_helper", SPELL_MASS_DEFLECT_ARROWS) then
    end
    --
    removeUnit("sorcery_def_"..side.."_helper")
    while exist("sorcery_def_"..side.."_helper") do
      sleep()
    end
  end
end