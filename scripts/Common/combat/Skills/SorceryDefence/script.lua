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
    local helper = "sorcery_def_"..side.."_helper"
    --local count = GetHeroName(GetHero(side)) == "Dalom" and 4 or 2
    errorHook(
    function()
      removeUnit(%helper)
    end)
    -- while not combatReadyPerson() do
    --   sleep()
    -- end
    if pcall(AddCreature, side, 979, 2, -1, -1, nil, helper) then
        while not exist(helper) do
            sleep()
        end
        --
        pcall(UnitCastGlobalSpell, helper, SPELL_MASS_STONESKIN)
        pcall(UnitCastGlobalSpell, helper, SPELL_MASS_DEFLECT_ARROWS) 
		sleep(10)
		pcall(removeUnit, helper)
        repeat
            pcall(removeUnit, helper)
            sleep()
        until not exist(helper)
    end
end