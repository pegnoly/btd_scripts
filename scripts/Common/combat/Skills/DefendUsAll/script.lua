defend_us_all =
{
    [ATTACKER] = {},
    [DEFENDER] = {}
}

if GetGameVar(GetHeroName(GetAttackerHero()).."_DEFEND_US_ALL") == '1' then
    defend_us_all[ATTACKER] =
    {
        trapper_cast_used = nil,
        defiler_cast_used = nil
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
               local defilers_count = 0
               for _, cr in GetCreatures(side) do
                   if GetCreatureType(cr) == CREATURE_GOBLIN_DEFILER then
                       defilers_count = defilers_count + GetCreatureNumber(cr)
                   end
               end
               if defilers_count > 0 then
                  for _, enemy_creature in (side == ATTACKER and keys(defender_real_army) or keys(attacker_real_army)) do
                      if Creature.Type.IsCaster(enemy_creature) then
                          local curr_mp = GetUnitManaPoints(enemy_creature)
                          local result_mp = curr_mp <= defilers_count and 0 or (curr_mp - defilers_count)

                          SetUnitManaPoints(enemy_creature, result_mp)
                      end
                  end
               end
            end
            --
            defend_us_all[side].defiler_cast_used = 1
        end
    end
end