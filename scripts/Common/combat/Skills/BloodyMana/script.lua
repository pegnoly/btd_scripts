bloody_mana = {
    lvl_multiplier = 2,
    [ATTACKER] = {
        possible_stacks = {}
    },
    [DEFENDER] = {
        possible_stacks = {}
    }
}

if GetGameVar(GetHeroName(GetAttackerHero()).."_BLOODY_MANA") == '1' then
    bloody_mana[ATTACKER] = {
        possible_stacks = {},
        used_stacks = {}
    }
    AddCombatFunction(CombatFunctions.START, "bloody_mana_attacker_start",
    function()
        --consoleCmd("@SetGameVar()")
        BloodyMana_Start(ATTACKER)
    end)
    AddCombatFunction(CombatFunctions.DEFENDER_CREATURE_DEATH, "bloody_mana_defender_creature_death",
    function(creature)
        BloodyMana_CreatureDeath(creature, ATTACKER) 
    end)
end

if GetDefenderHero() and GetGameVar(GetHeroName(GetDefenderHero()).."_BLOODY_MANA") == '1' then
    bloody_mana[DEFENDER] = {
        possible_stacks = {}
    }
    AddCombatFunction(CombatFunctions.START, "bloody_mana_defender_start",
    function()
        BloodyMana_Start(DEFENDER)
    end)
    AddCombatFunction(CombatFunctions.ATTACKER_CREATURE_DEATH, "bloody_mana_attacker_creature_death",
    function(creature)
        BloodyMana_CreatureDeath(creature, DEFENDER) 
    end)
end

function BloodyMana_Start(side)
    bloody_mana[side].possible_stacks = side == ATTACKER and defender_real_army or attacker_real_army
end

function BloodyMana_CreatureDeath(creature, side) 
    if bloody_mana[side].used_stacks[creature] or not bloody_mana[side].possible_stacks[creature] then
        return
    end
    local tier = Creature.Params.Tier(creature)
    local hero = GetHero(side)
    local current_mana = GetUnitManaPoints(hero)
    bloody_mana[side].used_stacks[creature] = 1
    SetUnitManaPoints(hero, current_mana + tier * bloody_mana.lvl_multiplier)
    CombatFlyingSign({
        "/scripts/Common/combat/Skills/BloodyMana/mana_added.txt"; amount = tier * bloody_mana.lvl_multiplier
    }, hero, 10.0)
end