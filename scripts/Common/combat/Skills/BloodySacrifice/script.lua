CREATURE_BLOODY_SACRIFICE_BASE = 209
CREATURE_BLOODY_SACRIFICE_50_BUFF = 210
CREATURE_BLOODY_SACRIFICE_100_BUFF = 211

bloody_sacrifice = {
    shamans = {CREATURE_SHAMAN, CREATURE_SHAMAN_HAG, CREATURE_SHAMAN_WITCH},
    goblins = {CREATURE_GOBLIN, CREATURE_GOBLIN_DEFILER, CREATURE_GOBLIN_TRAPPER},
    [ATTACKER] = {},
    [DEFENDER] = {}
}

if GetGameVar(GetHeroName(GetAttackerHero()).."_BLOODY_SACRIFICE") == '1' then
    bloody_sacrifice[ATTACKER] = {
        voice_of_rage = GetGameVar(GetHeroName(GetAttackerHero()).."_VOICE_OF_RAGE") == '1' and 1 or nil,
        power_of_blood = GetGameVar(GetHeroName(GetAttackerHero()).."_POWER_OF_BLOOD") == '1' and 1 or nil,
        charges = ceil(GetGameVar(GetHeroName(GetAttackerHero()).."_Luck") + 0),
        last_target = ""
    }
    AddCombatFunction(CombatFunctions.ATTACKER_CREATURE_MOVE, "bloody_sacrifice_attacker_creature_move",
    function(creature)
        BloodySacrifice_CheckSacrifice(creature, ATTACKER)
    end)
end

if GetDefenderHero() and GetGameVar(GetHeroName(GetDefenderHero()).."_BLOODY_SACRIFICE") == '1' then
    bloody_sacrifice[DEFENDER] = {
        voice_of_rage = GetGameVar(GetHeroName(GetDefenderHero()).."_VOICE_OF_RAGE") == '1' and 1 or nil,
        power_of_blood = GetGameVar(GetHeroName(GetDefenderHero()).."_POWER_OF_BLOOD") == '1' and 1 or nil,
        charges = ceil(GetGameVar(GetHeroName(GetDefenderHero()).."_Luck") + 0),
        last_target = ""
    }
    AddCombatFunction(CombatFunctions.DEFENDER_CREATURE_MOVE, "bloody_sacrifice_defender_creature_move",
    function(creature)
        BloodySacrifice_CheckSacrifice(creature, DEFENDER)
    end)
end

function BloodySacrifice_CheckSacrifice(creature, side)
    if not contains(bloody_sacrifice.shamans, GetCreatureType(creature)) or 
        bloody_sacrifice[side].charges < 1 then
        return
    end
    --
    local curr_mana = GetUnitManaPoints(creature)
    local goblins_near = {}
    for i, _creature in GetCreatures(side) do
        if contains(bloody_sacrifice.goblins, GetCreatureType(_creature)) then
            local dist = CheckDist(creature, _creature)
            print("dist: ", dist)
            if dist <= 1 then
                goblins_near[_creature] = GetCreatureNumber(_creature)
            end
        end
    end
    --
    while combatReadyPerson() do
        sleep()
    end
    --
    local new_mana = GetUnitManaPoints(creature)
    print("new mana: ", new_mana)
    local flag = 1
    if new_mana > curr_mana then
        for goblin, count in goblins_near do
            print("prev count: ", count)
            print("curr count: ", GetCreatureNumber(goblin))
            if GetCreatureNumber(goblin) < count then
                flag = 1
            end
        end
        if flag then
            local helper = side.."_bloody_sacrifice_helper"
            local helper_type = 209
            if (bloody_sacrifice[side].power_of_blood and bloody_sacrifice[side].voice_of_rage) then
                helper_type = 211
            elseif (bloody_sacrifice[side].power_of_blood or bloody_sacrifice[side].voice_of_rage) then
                helper_type = 210
            end
            local possible_targets, p_n = {}, 0
            for i, _creature in GetCreatures(side) do
                if not contains(bloody_sacrifice.goblins, GetCreatureType(_creature)) then
                    p_n = p_n + 1
                    possible_targets[p_n] = _creature
                end
            end
            if p_n > 0 then
                local actual_target = ""
                if p_n == 1 then
                    actual_target = possible_targets[1]
                else
                    while 1 do
                        local temp_target = possible_targets[random(p_n)]
                        if temp_target ~= bloody_sacrifice[side].last_target then
                            actual_target = temp_target
                            break
                        end
                        sleep()
                    end
                end
                local helper = side.."_bloody_sacrifice_helper"
                if pcall(AddCreature, side, helper_type, 1, -1, -1, nil, helper) then
                    while not exist(helper) do
                        sleep()
                    end
                    pcall(UnitCastAimedSpell, helper, SPELL_WARCRY_CALL_OF_BLOOD, actual_target)
                    bloody_sacrifice[side].last_target = actual_target
                    bloody_sacrifice[side].charges = bloody_sacrifice[side].charges - 1
                    removeUnit(helper)
                end
            end
        end
    end
end