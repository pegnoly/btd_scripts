kigan_spec =
{
    heroes = {"Hero9", "Hero91", "Hero92"},
    goblins = {CREATURE_GOBLIN, CREATURE_GOBLIN_TRAPPER, CREATURE_GOBLIN_DEFILER},
    casts_by_levels = {4, 9, 14, 19, 24, 29, 34, 39},
    [ATTACKER] = {},
    [DEFENDER] = {}
}

if contains(kigan_spec.heroes, GetHeroName(GetAttackerHero())) then
    local lvl = GetGameVar(GetHeroName(GetAttackerHero()).."_lvl") + 0
    print("lvl: ", lvl)
    local cast_lvl = -1
    for i, _lvl in kigan_spec.casts_by_levels do
        if lvl <= _lvl then
            cast_lvl = _lvl
            break
        end
    end
    kigan_spec[ATTACKER] = {
        active = 0
    }
    AddCombatFunction(CombatFunctions.START, "kigan_spec_start_attacker",
    function(hero)
        if %cast_lvl == 4 then
            --startThread(KiganSpec_CallOfBloodCast, {204}, 1, ATTACKER, 1) -- 4
        elseif %cast_lvl == 9 then
            startThread(KiganSpec_CallOfBloodCast, ATTACKER, 218) -- 6
        elseif %cast_lvl == 14 then
            startThread(KiganSpec_CallOfBloodCast, ATTACKER, 219) -- 8
        elseif %cast_lvl == 19 then
            startThread(KiganSpec_CallOfBloodCast, ATTACKER, 220) -- 10
        elseif %cast_lvl == 24 then
            startThread(KiganSpec_CallOfBloodCast, ATTACKER, 221) -- 12
        elseif %cast_lvl == 29 then
            startThread(KiganSpec_CallOfBloodCast, ATTACKER, 222) -- 14
        elseif %cast_lvl == 34 then
            startThread(KiganSpec_CallOfBloodCast, ATTACKER, 223) -- 16
        elseif %cast_lvl == 39 then
            startThread(KiganSpec_CallOfBloodCast, ATTACKER, 224)-- 18
        end
        while combatReadyPerson() do
            sleep()
        end
        kigan_spec[ATTACKER].active = 0
    end)
end

if GetDefenderHero() and contains(kigan_spec.heroes, GetHeroName(GetDefenderHero())) then
    local lvl = GetGameVar(GetHeroName(GetDefenderHero()).."_lvl") + 0
    print("lvl: ", lvl)
    local cast_lvl = -1
    for i, _lvl in kigan_spec.casts_by_levels do
        if lvl <= _lvl then
            cast_lvl = _lvl
            break
        end
    end
    kigan_spec[DEFENDER] = {
        active = 0
    }
    AddCombatFunction(CombatFunctions.START, "kigan_spec_start_defender",
    function(hero)
        if %cast_lvl == 4 then
            --startThread(KiganSpec_CallOfBloodCast, {204}, 1, ATTACKER, 1) -- 4
        elseif %cast_lvl == 9 then
            startThread(KiganSpec_CallOfBloodCast, DEFENDER, 218) -- 6
        elseif %cast_lvl == 14 then
            startThread(KiganSpec_CallOfBloodCast, DEFENDER, 219) -- 8
        elseif %cast_lvl == 19 then
            startThread(KiganSpec_CallOfBloodCast, DEFENDER, 220) -- 10
        elseif %cast_lvl == 24 then
            startThread(KiganSpec_CallOfBloodCast, DEFENDER, 221) -- 12
        elseif %cast_lvl == 29 then
            startThread(KiganSpec_CallOfBloodCast, DEFENDER, 222) -- 14
        elseif %cast_lvl == 34 then
            startThread(KiganSpec_CallOfBloodCast, DEFENDER, 223) -- 16
        elseif %cast_lvl == 39 then
            startThread(KiganSpec_CallOfBloodCast, DEFENDER, 224)-- 18
        end
        while combatReadyPerson() do
            sleep()
        end
        kigan_spec[DEFENDER].active = 0
    end)
end

function KiganSpec_CallOfBloodCast(side, caster_id)
    local helper = "kigan_spec_"..side.."_"..caster_id
    if pcall(AddCreature, side, caster_id, 1, -1, -1, nil, helper) then
        while not exist(helper) do
            sleep()
        end
        startThread(playAnimation, GetHero(side), "buff", ONESHOT)
        local army = side == ATTACKER and keys(attacker_real_army) or keys(defender_real_army)
        for i, creature in army do
            if contains(kigan_spec.goblins, GetCreatureType(creature)) then
                pcall(UnitCastAimedSpell, helper, SPELL_WARCRY_CALL_OF_BLOOD, creature)
            end
        end
        sleep()
        removeUnit(helper)
        while exist(helper) do
            sleep()
        end
    end
end