kigan_spec =
{
    heroes = {"Hero9", "Hero91", "Hero92"},
    goblins = {CREATURE_GOBLIN, CREATURE_GOBLIN_TRAPPER, CREATURE_GOBLIN_DEFILER},
    [ATTACKER] = 
    {
        atb_return_position = -1
    },
    [DEFENDER] = 
    {
        atb_return_position = -1
    }
}

if contains(kigan_spec.heroes, GetHeroName(GetAttackerHero())) then
    local hero = GetHeroName(GetAttackerHero())
    local voice_mastery = ceil(GetGameVar(hero.."_VOICE_MASTERY") + 0)
    kigan_spec[ATTACKER] =
    {
        atb_return_position = 0.1 * voice_mastery
    }
    AddCombatFunction(CombatFunctions.ATTACKER_HERO_MOVE, "kigan_spec_attacker_hero_move",
    function()
        startThread(KiganSpec_WarcryCast, ATTACKER)
    end)
end

if GetDefenderHero() and contains(kigan_spec.heroes, GetHeroName(GetDefenderHero())) then
    local hero = GetHeroName(GetDefenderHero())
    local voice_mastery = ceil(GetGameVar(hero.."_VOICE_MASTERY") + 0)
    kigan_spec[DEFENDER] =
    {
        atb_return_position = 0.1 * voice_mastery
    }
    AddCombatFunction(CombatFunctions.DEFENDER_HERO_MOVE, "kigan_spec_defender_hero_move",
    function()
        startThread(KiganSpec_WarcryCast, DEFENDER)
    end)
end

function KiganSpec_WarcryCast(side)
    local hero = GetHero(side)
    local current_mana = GetUnitManaPoints(hero)
    while combatReadyPerson() do 
        sleep()
    end
    while not combatReadyPerson() do
        sleep()
    end
    local new_mana = GetUnitManaPoints(hero) 
    if new_mana < current_mana then
        print("Kigan casted smth")
        local mana_to_add = new_mana + 1000
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
        SetUnitManaPoints(hero, new_mana)
        EndTurn(hero, kigan_spec[side].atb_return_position)
    end
end