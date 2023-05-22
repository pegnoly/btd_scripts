-- @building
-- жертвенная яма Инферно - бонусная экспа при постройке, +20% экспы при убийстве добрых существ
inferno_sacrificial_pit =
{
    path = "/scripts/RMG/advmap/Towns/Buildings/Inferno_SacrificialPit/",
    exp_bonus = 3000,
    good_exp_coef = 0.2,
    builded_in_town = {}
}

MapLoadingEvent.AddListener("inferno_sacrificial_pit_init",
function()
    errorHook(
    function()
        print("<color=red>Error: <color=green>Inferno_SacrificialPit.MapLoadingEvent") 
    end)
    startThread(
    function()
        while 1 do
            for i, town in GetObjectNamesByType("TOWN") do
                if GetTownRace(town) == TOWN_INFERNO then
                    if not inferno_sacrificial_pit.builded_in_town[town] then
                        if GetTownBuildingLevel(town, TOWN_BUILDING_INFERNO_SACRIFICIAL_PIT) > 0 then
                            inferno_sacrificial_pit.builded_in_town[town] = 1
                            for _, hero in GetPlayerHeroes(GetObjectOwner(town)) do
                                GiveExp(hero, inferno_sacrificial_pit.exp_bonus)
                            end
                        end
                    end
                end
            end
            sleep()
        end
    end)
end)

CombatResultsEvent.AddListener("inferno_sacrificial_pit_combat_result",
function(fight_id)
    errorHook(
    function()
       print("<color=red>Error: <color=green>Inferno_SacrificialPit.CombatResultsEvent") 
    end)
    local winner = GetSavedCombatArmyHero(fight_id, 1)
    if not winner then
        return
    end
    local towns = Player.GetTowns(GetObjectOwner(winner))
    local bonus = 0
    for i, town in towns do
        if inferno_sacrificial_pit.builded_in_town[town] then
            bonus = bonus + inferno_sacrificial_pit.good_exp_coef
        end
    end
    if bonus == 0 then
        return
    else
        local count = GetSavedCombatArmyCreaturesCount(fight_id, 0)
        local possible_creatures = {}
        for stack = 0, count - 1 do
            local creature, all_count, died = GetSavedCombatArmyCreatureInfo(fight_id, 0, stack)
            local frac = Creature.Params.Fraction(creature)
            if frac == CREATURE_FRAC_KIND then
                local exp = ceil(Creature.Params.Exp(creature) * died * diffExpCoeffs[defaultDifficulty] * bonus)
                if not possible_creatures[creature] then
                    possible_creatures[creature] = exp
                else
                    possible_creatures[creature] = possible_creatures[creature] + exp
                end
            end
        end
        for creature, exp in possible_creatures do
            if exp > 0 then
                GiveExp(winner, exp)
                local town = Creature.Params.Town(creature)
                MessageQueue.AddMessage(GetObjectOwner(winner), 
                                        {inferno_sacrificial_pit.path.."bonus_exp.txt";  exp = exp, race_color = RACE_COLORS[town], creature = Creature.Params.Name(creature)},
                                        winner, 7.0)
            end
        end
    end
end)