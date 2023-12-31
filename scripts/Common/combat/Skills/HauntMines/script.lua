haunt_mines_common = {
    ghosts_types = {CREATURE_GHOST, CREATURE_POLTERGEIST},
    [ATTACKER] = {
        count = -1
    },
    [DEFENDER] = {
        count = -1
    }
}

if Hero.Params.Class(GetHeroName(GetAttackerHero())) == HERO_CLASS_NECROMANCER and
    GetGameVar(GetHeroName(GetAttackerHero()).."_HAUNT_MINES_GHOSTS_COUNT") ~= '' then
        haunt_mines_common[ATTACKER] = {
        count = (GetGameVar(GetHeroName(GetAttackerHero()).."_HAUNT_MINES_GHOSTS_COUNT") + 0)
    }
    AddCombatFunction(CombatFunctions.START, "rmg_haunt_mines_start_attacker",
    function()
        startThread(HauntMinesRMG_SummonGhosts, ATTACKER)
    end)
end

if GetDefenderHero() and Hero.Params.Class(GetHeroName(GetDefenderHero())) == HERO_CLASS_NECROMANCER and
    GetGameVar(GetHeroName(GetDefenderHero()).."_HAUNT_MINES_GHOSTS_COUNT") ~= '' then
        haunt_mines_common[DEFENDER] = {
        count = (GetGameVar(GetHeroName(GetDefenderHero()).."_HAUNT_MINES_GHOSTS_COUNT") + 0)
    }
    AddCombatFunction(CombatFunctions.START, "rmg_haunt_mines_start_defender",
    function()
        startThread(HauntMinesRMG_SummonGhosts, DEFENDER)
    end)
end

function HauntMinesRMG_SummonGhosts(side)
    local actual_count = haunt_mines_common[side].count
    if actual_count <= 0 then
        return
    end
    local actual_ghosts_types = {[CREATURE_GHOST] = nil, [CREATURE_POLTERGEIST] = nil}
    for i, creature in GetCreatures(side) do
        local type = GetCreatureType(creature)
        if contains(haunt_mines_common.ghosts_types, GetCreatureType(creature)) then
            actual_ghosts_types[type] = 1
        end
    end
    --
    local l = len(actual_ghosts_types)
    local x, y = pos(GetCreatures(side)[0])
    if l == 0 then
        for i = 1, 2 do
            pcall(SummonCreature, side, CREATURE_MANES, floor(actual_count / 2), x, y)
        end
    elseif l == 1 then
        pcall(SummonCreature, side, CREATURE_MANES, floor(actual_count / 2), x, y)
        for ghost_type, presented in actual_ghosts_types do
            if presented then
                pcall(SummonCreature, side, ghost_type, floor(actual_count / 2), x, y)
                break
            end
        end
    else
        pcall(SummonCreature, side, CREATURE_GHOST, ceil(actual_count / 2), x, y)
        pcall(SummonCreature, side, CREATURE_POLTERGEIST, ceil(actual_count / 2), x, y)
    end
end