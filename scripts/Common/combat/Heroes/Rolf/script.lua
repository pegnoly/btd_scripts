ROLF_HELPER_MASTERY_NONE = 204
ROLF_HELPER_MASTERY_BASIC = 205
ROLF_HELPER_MASTERY_ADVANCED = 206
ROLF_HELPER_MASTERY_EXPERT = 207
ROLF_HELPER_MASTERY_EXTRA_EXPERT = 208

rolf_spec = {
    heroes = {"Rolf", "Rolf1", "Rolf2"},
    casts_by_levels = {5, 11, 17, 23, 28, 32, 37, 40},
    [ATTACKER] = {},
    [DEFENDER] = {}
}

if contains(rolf_spec.heroes, GetHeroName(GetAttackerHero())) then
    local lvl = GetGameVar(GetHeroName(GetAttackerHero()).."_lvl") + 0
    print("lvl: ", lvl)
    local cast_lvl = -1
    for i, _lvl in rolf_spec.casts_by_levels do
        if lvl <= _lvl then
            cast_lvl = _lvl
            break
        end
    end
    print("rolf cast lvl: ", cast_lvl)
    rolf_spec[ATTACKER] = {
        active = 0
    }
    AddCombatFunction(CombatFunctions.START, "rolf_spec_start_attacker",
    function(hero)
        if %cast_lvl == 5 then
            startThread(Rolf_MinesCast, {204}, 1, ATTACKER, 1) -- 4
        elseif %cast_lvl == 11 then
            startThread(Rolf_MinesCast, {205}, 1, ATTACKER, 15) -- 6
        elseif %cast_lvl == 17 then
            startThread(Rolf_MinesCast, {206}, 1, ATTACKER, 40) -- 8
        elseif %cast_lvl == 23 then
            startThread(Rolf_MinesCast, {207}, 1, ATTACKER, 80) -- 10
        elseif %cast_lvl == 28 then
            startThread(Rolf_MinesCast, {205, 205}, 2, ATTACKER, 170) -- 12
        elseif %cast_lvl == 32 then
            startThread(Rolf_MinesCast, {205, 206}, 2, ATTACKER, 340) -- 14
        elseif %cast_lvl == 37 then
            startThread(Rolf_MinesCast, {206, 206}, 2, ATTACKER, 640) -- 16
        elseif %cast_lvl == 40 then
            startThread(Rolf_MinesCast, {206, 207}, 2, ATTACKER, 1350) -- 18
        end
        while combatReadyPerson() do
            sleep()
        end
        rolf_spec[ATTACKER].active = 0
    end)
end

if GetDefenderHero() and contains(rolf_spec.heroes, GetHeroName(GetDefenderHero())) then
    local lvl = GetGameVar(GetHeroName(GetDefenderHero()).."_lvl") + 0
    print("lvl: ", lvl)
    local cast_lvl = -1
    for i, _lvl in rolf_spec.casts_by_levels do
        if lvl <= _lvl then
            cast_lvl = _lvl
            break
        end
    end
    print("rolf cast lvl: ", cast_lvl)
    rolf_spec[DEFENDER] = {
        active = 0
    }
    AddCombatFunction(CombatFunctions.START, "rolf_spec_start_defender",
    function(hero)
        if %cast_lvl == 5 then
            startThread(Rolf_MinesCast, {204}, 1, DEFENDER, 1) -- 4
        elseif %cast_lvl == 11 then
            startThread(Rolf_MinesCast, {205}, 1, DEFENDER, 15) -- 6
        elseif %cast_lvl == 17 then
            startThread(Rolf_MinesCast, {206}, 1, DEFENDER, 40) -- 8
        elseif %cast_lvl == 23 then
            startThread(Rolf_MinesCast, {207}, 1, DEFENDER, 80) -- 10
        elseif %cast_lvl == 28 then
            startThread(Rolf_MinesCast, {205, 205}, 2, DEFENDER, 170) -- 12
        elseif %cast_lvl == 32 then
            startThread(Rolf_MinesCast, {205, 206}, 2, DEFENDER, 340) -- 14
        elseif %cast_lvl == 37 then
            startThread(Rolf_MinesCast, {206, 206}, 2, DEFENDER, 640) -- 16
        elseif %cast_lvl == 40 then
            startThread(Rolf_MinesCast, {206, 207}, 2, DEFENDER, 1350) -- 18
        end
        while combatReadyPerson() do
            sleep()
        end
        rolf_spec[DEFENDER].active = 0
    end)
end

function Rolf_MinesCast(casters_types, casts_count, side, casters_count)
    if rolf_spec[side].active == 1 then
        return
    end
    rolf_spec[side].active = 1
    local current_target = ""
    local current_max_power = -1
    for i, creature in GetCreatures(side) do
        local power = Creature.Params.Power(creature) * GetCreatureNumber(creature)
        if power > current_max_power then
            current_max_power = power
            current_target = creature
        end
    end
    if current_target ~= "" then
        print("Casters, ", casters_types, ", count, ", casts_count)
        for i = 1, casts_count do
            local helper = "rolf_spec_helper_"..side.."_"..casters_types[i]
            if pcall(AddCreature, side, casters_types[i], casters_count, -1, -1, nil, helper) then
                while not exist(helper) do
                    sleep()
                end
                local x, y = pos(current_target)
                startThread(playAnimation, GetHero(side), "cast", ONESHOT)
                pcall(UnitCastAreaSpell, helper, SPELL_LAND_MINE, x, y)
                removeUnit(helper)
                while exist(helper) do
                    sleep()
                end
            end
        end
    end
end