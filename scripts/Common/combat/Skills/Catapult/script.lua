catapult_common = 
{
    hp_to_restore = 250,
    [ATTACKER] = {
        -- active = 0,
        -- hp_to_restore = 100
    },
    [DEFENDER] = {
        -- active = 0,
        -- hp_to_restore = 100
    },
    
    hp_per_gremlin = 5,    
}

if GetGameVar(GetHeroName(GetAttackerHero()).."_CATAPULT") == '1' then
    catapult_common[ATTACKER] = {
    }
    AddCombatFunction(CombatFunctions.ATTACKER_WARMACHINE_DEATH, "catapult_common_attacker_machine_death",
    function(machine)
        startThread(CatapultCommon_MachineDeath, machine, ATTACKER)
    end)
end
  
if GetDefenderHero() and (GetGameVar(GetHeroName(GetDefenderHero()).."_CATAPULT") == '1') then
    catapult_common[DEFENDER] = {
    }
    AddCombatFunction(CombatFunctions.DEFENDER_WARMACHINE_DEATH, "catapult_common_defender_machine_death",
    function(machine)
        startThread(CatapultCommon_MachineDeath, machine, DEFENDER)
    end)
end

function CatapultCommon_MachineDeath(machine, side) 
    if not GetWarMachine(side, WAR_MACHINE_AMMO_CART) or GetWarMachineType(machine) == WAR_MACHINE_AMMO_CART then
        return
    end
    local helper = "catapult_common_helper_"..side.."_"..machine
    local x, y = pos(machine)
    if pcall(AddCreature, side, CREATURE_MASTER_GREMLIN, ceil(catapult_common.hp_to_restore / catapult_common.hp_per_gremlin), x, y, nil, helper) then
        while not exist(helper) do
            sleep()
        end
        sleep(100)
        pcall(UnitCastAimedSpell, helper, SPELL_ABILITY_REPAIR, machine)
        --playAnimation(machine, "idle00", ONESHOT_STILL)
        removeUnit(helper)
        while exist(helper) do
            sleep()
        end
    end   
end