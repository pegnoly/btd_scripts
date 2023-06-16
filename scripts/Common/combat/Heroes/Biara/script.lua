HELPER_DARK_MASTERY_NONE = 200
HELPER_DARK_MASTERY_BASIC = 201
HELPER_DARK_MASTERY_ADVANCED = 202
HELPER_DARK_MASTERY_EXPERT = 203

biara_spec =
{
    heroes = {"Biara", "Biara1", "Biara2"},
    lvl_divisor = 6,
    caster_count = 2,
    creature_type_by_dark_level = 
    {
        [MASTERY_NONE] = HELPER_DARK_MASTERY_NONE,
        [MASTERY_BASIC] = HELPER_DARK_MASTERY_BASIC,
        [MASTERY_ADVANCED] = HELPER_DARK_MASTERY_ADVANCED,
        [MASTERY_EXPERT] = HELPER_DARK_MASTERY_EXPERT
    },

    [ATTACKER] = 
    {
        stacks_count = 0,
        caster_type = -1
    },

    [DEFENDER] = 
    {
        stacks_count = 0,
        caster_type = -1
    }
  }

if contains(biara_spec.heroes, GetHeroName(GetAttackerHero())) then
    local hero = GetHeroName(GetAttackerHero())
    local dark_mastery = ceil(GetGameVar(hero.."_DARK_MAGIC_MASTERY") + 0)
    biara_spec[ATTACKER] =
    {
        stacks_count = ceil((GetGameVar(hero.."_lvl") + 0) / biara_spec.lvl_divisor),
        caster_type = biara_spec.creature_type_by_dark_level[dark_mastery]
    }
    AddCombatFunction(CombatFunctions.START, "BTD_biara_spec_start_attacker",
    function()
        startThread(BiaraSpec_SorrowCast, ATTACKER)
    end)
end

if GetDefenderHero() and contains(biara_spec.heroes, GetHeroName(GetDefenderHero())) then
  local hero = GetHeroName(GetDefenderHero())
  local dark_mastery = ceil(GetGameVar(hero.."_DARK_MAGIC_MASTERY") + 0)
  biara_spec[DEFENDER] =
  {
      stacks_count = ceil((GetGameVar(hero.."_lvl") + 0) / biara_spec.lvl_divisor),
      caster_type = biara_spec.creature_type_by_dark_level[dark_mastery]
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
    local helper = "biara_spec_helper_"..side
    if pcall(AddCreature, side, biara_spec[side].caster_type, biara_spec.caster_count, -1, -1, nil, helper) then
        while not exist(helper) do
            sleep()
        end
        for i, creature in creatures_to_cast do
            pcall(UnitCastAimedSpell, helper, SPELL_SORROW, creature)
        end
        sleep()
        removeUnit(helper)
        while exist(helper) do
            sleep()
        end
    end
end