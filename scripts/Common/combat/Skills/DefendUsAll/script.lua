defend_us_all =
{
    [ATTACKER] = {},
    [DEFENDER] = {}
}

if GetGameVar(GetHeroName(GetAttackerHero()).."_DEFEND_US_ALL") == '1' then
    defend_us_all[ATTACKER] =
    {
        trapper_cast_used = nil,
        defiler_cast_used = nil,
        mana_steal_iteration = 1,
        enemy_casters_info = {}
    }
    AddCombatFunction(CombatFunctions.START, "BTD_defend_us_all_start_attacker",
    function()
        startThread(DefendUsAll_Start, ATTACKER)
    end)
end
  
if GetDefenderHero() and (GetGameVar(GetHeroName(GetDefenderHero()).."_DEFEND_US_ALL") == '1') then
    defend_us_all[DEFENDER] =
    {
        trapper_cast_used = nil,
        defiler_cast_used = nil
    }
    AddCombatFunction(CombatFunctions.START, "BTD_defend_us_all_start_defender",
    function()
        startThread(DefendUsAll_Start, DEFENDER)
    end)
end

function DefendUsAll_SetSnare(side, key, x, y)
    local uniq_key = 'set_snare_'..side..'_'..key;
    
    if pcall(AddCreature, side, CREATURE_GOBLIN_TRAPPER, 10000, -1, -1, nil, uniq_key) then
        while not exist(uniq_key) do
            sleep()
        end

        if x ~= nil and y ~= nil then
            pcall(commandDoSpecial, uniq_key, SPELL_ABILITY_SET_SNARES, x, y)
            
        else
            local MARGIN_X = 4;
            local random_x, random_y
            
            repeat
              random_x, random_y = random(6) + MARGIN_X, random(10);
            until pcall(commandDoSpecial, uniq_key, SPELL_ABILITY_SET_SNARES, random_x, random_y)
        end;
    end;
	sleep(10)
	removeUnit(uniq_key)
    repeat
        pcall(removeUnit, uniq_key)
        sleep()
    until not exist(uniq_key)
end;

function DefendUsAll_Start(side)
    for i, creature in GetCreatures(side) do
        local type = GetCreatureType(creature)
        if type == CREATURE_GOBLIN_TRAPPER and (not defend_us_all[side].trapper_cast_used) then
            local possible_stacks_to_cast, n = {}, 0
            
            for _, enemy_creature in (side == ATTACKER and keys(defender_real_army) or keys(attacker_real_army)) do
                if not Creature.Component.HasAbility(enemy_creature, ABILITY_FLYER) and
                   not Creature.Type.IsShooter(enemy_creature) and
                   not Creature.Type.IsCaster(enemy_creature) then
                    n = n + 1
                    possible_stacks_to_cast[n] = enemy_creature
                end
            end

            if n > 0 then
                for _, target in possible_stacks_to_cast do
                    local x, y = pos(target)

                    if side == ATTACKER then
                        x = x - (Creature.Type.IsBig(target) and 2 or 1)
                    else
                        x = x + 1
                    end

                    startThread(DefendUsAll_SetSnare, side, 'defend_us_all_trap_under_creature_', x, y);
                    
                    break;
                end
            end
            
            local RANDOM_COUNT_MIDDLE_TRAP = 2;
            
            for index = 1, RANDOM_COUNT_MIDDLE_TRAP do
                startThread(DefendUsAll_SetSnare, side, 'defend_us_all_middle_trap_'..index);
            end;
        
            defend_us_all[side].trapper_cast_used = 1
        end;
        if type == CREATURE_GOBLIN_DEFILER and (not defend_us_all[side].defiler_cast_used) then
            local helper = "defend_us_all_defiler_"..side

            local possible_stacks_to_cast, n = {}, 0
            --
            if GetHero(1 - side) then
                n = n + 1
                possible_stacks_to_cast[n] = GetHero(1 - side)
            end
            --
            for _, enemy_creature in (side == ATTACKER and keys(defender_real_army) or keys(attacker_real_army)) do
                if Creature.Type.IsCaster(enemy_creature) then
                    n = n + 1
                    possible_stacks_to_cast[n] = enemy_creature
                end
            end
            if n > 0 then
			    if pcall(AddCreature, side, CREATURE_GOBLIN_DEFILER, 10000, -1, -1, nil, helper) then
					while not exist(helper) do
						sleep()
					end
					for i, _unit in possible_stacks_to_cast do 
						pcall(UnitCastAimedSpell, helper, SPELL_ABILITY_DEFILE_MAGIC, _unit)
					end
					sleep(10)
					removeUnit(helper)
					repeat
						pcall(removeUnit, helper)
						sleep()
					until not exist(helper)
				end
            end
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