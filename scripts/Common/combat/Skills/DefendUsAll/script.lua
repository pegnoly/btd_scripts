CREATURE_TRAPPERS_LOT = 225
CREATURE_DEFILERS_LOT = 226

defend_us_all =
{
    [ATTACKER] = {},
    [DEFENDER] = {},
    trappers_max_moves = 2,
    defilers_max_moves = 1
}

if GetGameVar(GetHeroName(GetAttackerHero()).."_DEFEND_US_ALL") == '1' then
    defend_us_all[ATTACKER] =
    {
        trapper_cast_used = nil,
        defiler_cast_used = nil,
        trappers_lot_moves = 0,
        defilers_lot_moves = 0,
        mana_steal_iteration = 1,
        enemy_casters_info = {}
    }
    AddCombatFunction(CombatFunctions.START, "BTD_defend_us_all_start_attacker",
    function()
        startThread(DefendUsAll_Start, ATTACKER)
    end)
    AddCombatFunction(CombatFunctions.ATTACKER_CREATURE_MOVE, "BTD_defend_us_all_attacker_creature_move",
    function(creature)
        DefendUsAll_CreatureMove(creature, ATTACKER)
    end)
end
  
if GetDefenderHero() and (GetGameVar(GetHeroName(GetDefenderHero()).."_DEFEND_US_ALL") == '1') then
    defend_us_all[DEFENDER] =
    {
        trapper_cast_used = nil,
        defiler_cast_used = nil,
        trappers_lot_moves = 0,
        defilers_lot_moves = 0
    }
    AddCombatFunction(CombatFunctions.START, "BTD_defend_us_all_start_defender",
    function()
        startThread(DefendUsAll_Start, DEFENDER)
    end)
    AddCombatFunction(CombatFunctions.DEFENDER_CREATURE_MOVE, "BTD_defend_us_all_defender_creature_move",
    function(creature)
        DefendUsAll_CreatureMove(creature, DEFENDER)
    end)
end

function DefendUsAll_CreatureMove(creature, side)
    local _type = GetCreatureType(creature)
    if _type == CREATURE_TRAPPERS_LOT then
        defend_us_all[side].trappers_lot_moves = defend_us_all[side].trappers_lot_moves + 1
        if defend_us_all[side].trappers_lot_moves == defend_us_all.trappers_max_moves then
            removeUnit(creature)
            return
        end
    end
    --
    if _type == CREATURE_DEFILERS_LOT then
        defend_us_all[side].defilers_lot_moves = defend_us_all[side].defilers_lot_moves + 1
        if defend_us_all[side].defilers_lot_moves == defend_us_all.defilers_max_moves then
            removeUnit(creature)
            return
        end
    end
end

function DefendUsAll_Start(side)
    for i, creature in GetCreatures(side) do
        local type = GetCreatureType(creature)
        if type == CREATURE_GOBLIN_TRAPPER and (not defend_us_all[side].trapper_cast_used) then
            local trappers_lot_helper = "defend_us_all_"..side.."_trappers_lot"
            if pcall(AddCreature, side, CREATURE_TRAPPERS_LOT, 10000, -1, -1, 1, trappers_lot_helper) then
                while not exist(trappers_lot_helper) do
                    sleep()
                end
                displace(trappers_lot_helper, 8 + side, 51 + side)
                setATB(trappers_lot_helper, 1)
            end
            defend_us_all[side].trapper_cast_used = 1
        end
        --
        if type == CREATURE_GOBLIN_DEFILER and (not defend_us_all[side].defiler_cast_used) then
            local enemy_casters_flag
            for _, cr in GetCreatures(1 - side) do
                if Creature.Type.IsCaster(cr) then
                    enemy_casters_flag = 1
                    break
                end
            end
            if enemy_casters_flag then
                local defilers_lot_helper = "defend_us_all_"..side.."_defilers_lot"
                --
                if pcall(AddCreature, side, CREATURE_DEFILERS_LOT, 10000, -1, -1, 1, defilers_lot_helper) then
                    while not exist(defilers_lot_helper) do
                        sleep()
                    end
                    displace(defilers_lot_helper, 8 + side, 52 + side)
                end
                defend_us_all[side].defiler_cast_used = 1
                --
                if side == ATTACKER and (not GetDefenderHero()) then
                    for _, enemy_creature in (side == ATTACKER and keys(defender_real_army) or keys(attacker_real_army)) do
                        if Creature.Type.IsCaster(enemy_creature) then
                            defend_us_all[side].enemy_casters_info[enemy_creature] = {
                                iteration = 0,
                                current_mana = GetUnitManaPoints(enemy_creature)
                            }
                        end
                    end
                    --
                    for _, cr in GetCreatures(side) do
                        if GetCreatureType(cr) == CREATURE_GOBLIN_DEFILER then
                            DefendUsAll_StealMana(cr, side)
                            --sleep(20)
                        end
                    end
                end
            end
            --
            defend_us_all[side].defiler_cast_used = 1
        end
    end
end

function DefendUsAll_StealMana(defiler, side) 
    local count = GetCreatureNumber(defiler)
    for creature, info in defend_us_all[side].enemy_casters_info do
        if creature and info then
            if info.current_mana > 0 and info.iteration < defend_us_all[side].mana_steal_iteration then
                local new_mana = info.current_mana - count
                new_mana = new_mana < 0 and 0 or new_mana
                SetUnitManaPoints(creature, new_mana)
                startThread(playAnimation, defiler, "specability", ONESHOT)
                startThread(CombatFlyingSign, {
                    "/scripts/Common/combat/Skills/DefendUsAll/mana_stolen.txt"; amount = info.current_mana - new_mana
                }, creature, 6.0)
                sleep()
                if new_mana <= 0 then
                    defend_us_all[side].enemy_casters_info[creature] = nil
                    sleep()
                    -- while defend_us_all[side].enemy_casters_info[creature] do
                    --     sleep()
                    -- end
                else 
                    defend_us_all[side].enemy_casters_info[creature].current_mana = new_mana
                    local new_iteration = defend_us_all[side].enemy_casters_info[creature].iteration + 1
                    defend_us_all[side].enemy_casters_info[creature].iteration = new_iteration
                    -- while defend_us_all[side].enemy_casters_info[creature].iteration ~= new_iteration do
                    --     sleep()
                    -- end
                    sleep()
                end
                break
            end
        end
    end
    --
    local next_iteration_flag = 1
    for _, info in defend_us_all[side].enemy_casters_info do
        if info then
            if info.iteration < defend_us_all[side].mana_steal_iteration then
                next_iteration_flag = nil
                break
            end
        end
    end
    if next_iteration_flag then
        defend_us_all[side].mana_steal_iteration = defend_us_all[side].mana_steal_iteration + 1
    end
end