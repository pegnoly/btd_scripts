catapult_rmg = 
{
    [ATTACKER] = {},
    [DEFENDER] = {},
    
    hp_per_gremlin = 5,
    hp_to_restore = 100
}

if GetGameVar(GetHeroName(GetAttackerHero()).."_CATAPULT") == '1' then
    catapult_rmg[ATTACKER] =
    {
      active = 0,
    }
    AddCombatFunction(CombatFunctions.ATTACKER_HERO_MOVE, "catapult_rmg_attacker_hero_move",
    function(hero)
      CatapultRMG_HeroMove(hero, ATTACKER)
    end)
end
  
if GetDefenderHero() and (GetGameVar(GetHeroName(GetDefenderHero()).."_CATAPULT") == '1') then
    catapult_rmg[DEFENDER] =
    {
      active = 0,
    }
    AddCombatFunction(CombatFunctions.DEFENDER_HERO_MOVE, "catapult_rmg_defender_hero_move",
    function(hero)
      CatapultRMG_HeroMove(hero, DEFENDER)
    end)
end

function CatapultRMG_HeroMove(hero, side)
    if catapult_rmg[side].active == 1 then
        return 1
    end
    catapult_rmg[side].active = 1
    local ammo_cart = GetWarMachine(side, WAR_MACHINE_AMMO_CART)
    if ammo_cart then
        for i, machine in GetWarMachines(side) do
            local helper = "catapult_rmg_helper_"..side.."_"..machine
            pcall(AddCreature, side, CREATURE_MASTER_GREMLIN, ceil(catapult_rmg.hp_to_restore / catapult_rmg.hp_per_gremlin), -1, -1, nil, helper)
            while not exist(helper) do
                sleep()
            end
            pcall(UnitCastAimedSpell, helper, SPELL_ABILITY_REPAIR, machine)
            sleep(10)
            removeUnit(helper)
            while exist(helper) do
                sleep()
            end
        end
    end
    while combatReadyPerson() do
        sleep()
    end
    if not combatReadyPerson() then
        catapult_rmg[side].active = 0
    end
end