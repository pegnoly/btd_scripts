ROLF_HELPER_MASTERY_NONE = 204
ROLF_HELPER_MASTERY_BASIC = 205
ROLF_HELPER_MASTERY_ADVANCED = 206
ROLF_HELPER_MASTERY_EXPERT = 207
ROLF_HELPER_MASTERY_EXTRA_EXPERT = 208

rolf_spec = {
    heroes = {"Rolf"},
    casts_by_levels = {5, 11, 17, 23, 28},
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
    AddCombatFunction(CombatFunctions.ATTACKER_HERO_MOVE, "rolf_spec_attacker_hero_move",
    function(hero)
        if %cast_lvl == 5 then
            startThread(Rolf_MinesCast, 204, 1, ATTACKER)
        elseif %cast_lvl == 11 then
            startThread(Rolf_MinesCast, 206, 1, ATTACKER)
        elseif %cast_lvl == 17 then
            startThread(Rolf_MinesCast, 207, 1, ATTACKER)
        elseif %cast_lvl == 23 then
            startThread(Rolf_MinesCast, 208, 1, ATTACKER)
        elseif %cast_lvl == 28 then
            startThread(Rolf_MinesCast, 206, 2, ATTACKER)
        end
        while combatReadyPerson() do
            sleep()
        end
        rolf_spec[ATTACKER].active = 0
    end)
end

function Rolf_MinesCast(creature_type, casts_count, side)
    if rolf_spec[side].active == 1 then
        return
    end
    rolf_spec[side].active = 1
    local helper = "rolf_spec_helper_"..side.."_"..creature_type
    if pcall(AddCreature, side, creature_type, 1, -1, -1, nil, helper) then
        while not exist(helper) do
            sleep()
        end
        local current_target = ""
        local current_max_power = -1
        for i, creature in GetCreatures(side) do
            if creature ~= helper then
                local power = Creature.Params.Power(creature) * GetCreatureNumber(creature)
                if power > current_max_power then
                    current_max_power = power
                    current_target = creature
                end
            end
        end
        if current_target ~= "" then
            local x, y = pos(current_target)
            for i = 1, casts_count do
                pcall(UnitCastAreaSpell, helper, SPELL_LAND_MINE, x, y)
            end
        end
        removeUnit(helper)
    end
end

function TryCallOfBlood() 
    if pcall(AddCreature, ATTACKER, 208, 1, -1, -1, nil, "test") then
        while not exist("test") do
            sleep()
        end
        for i, creature in GetAttackerCreatures() do
            UnitCastAimedSpell("test", SPELL_WARCRY_CALL_OF_BLOOD, creature)
        end
        removeUnit("test")
    end
end