diplomacy_rmg =
{
    path = "/scripts/RMG/advmap/Skills/Diplomacy/",
    level_count_divisor = 10,
    joins_count_for_hero = {},

    join_percent_per_creature_level = 
    {
        0.2, 0.15, 0.15, 0.1, 0.1, 0.1, 0.1
    },

    join_cost_per_creature_level =
    {
        2, 1.8, 1.6, 1.4, 1.3, 1.2, 1
    }
}

AddHeroEvent.AddListener("BTD_RMG_diplomacy_add_hero",
function(hero)
    startThread(
    function()
        while 1 do
            if IsHeroAlive(%hero) then
                if not diplomacy_rmg.joins_count_for_hero[%hero] and HasHeroSkill(%hero, PERK_DIPLOMACY) then
                    diplomacy_rmg.joins_count_for_hero[%hero] = ceil(GetHeroLevel(%hero) / diplomacy_rmg.level_count_divisor)
                end
            end
            sleep()
        end
    end)
end)

NewDayEvent.AddListener("BTD_RMG_diplomacy_new_day",
function(day)
    if mod(day, 7) == 1 then
        for hero, alive in AdvMapHeroesInfo.alive_heroes do
            diplomacy_rmg.joins_count_for_hero[hero] = ceil(GetHeroLevel(hero) / diplomacy_rmg.level_count_divisor)
            print("Hero ", hero, " has join count ", diplomacy_rmg.joins_count_for_hero[hero])
        end
    end
end)

LevelUpEvent.AddListener("BTD_RMG_diplomacy_level_up",
function(hero)
    local level = GetHeroLevel(hero)
    if mod(level, 10) == 0 then
        diplomacy_rmg.joins_count_for_hero[hero] = diplomacy_rmg.joins_count_for_hero[hero] + 1
    end
end)

CombatResultsEvent.AddListener("BTD_RMG_diplomacy_combat_result",
function(fight_id)
    local winner = GetSavedCombatArmyHero(fight_id, 1)
    if winner and HasHeroSkill(winner, PERK_DIPLOMACY) and diplomacy_rmg.joins_count_for_hero[winner] >= 1 then
        print("<color=red>Diplomacy.CombatResult: <color=green> joins count for ", winner, " - ", diplomacy_rmg.joins_count_for_hero[winner])
        local enemy_stacks_count = GetSavedCombatArmyCreaturesCount(fight_id, 0)
        -- [#5 fix]
        local hero_creatures_types, h_n = {}, 0
        local types = table.pack(GetHeroCreaturesTypes(winner))
        for i = 0, 7 do
            if types[i] == 0 then
                break
            end
            hero_creatures_types[h_n] = types[i]
            h_n = h_n + 1
        end
        --
        print("<color=red>Diplomacy.CombatResult: <color=green> winner's creatures types - ", hero_creatures_types)
        local creatures_to_join = {}
        for stack = 0, enemy_stacks_count - 1 do
            local creature, count, died = GetSavedCombatArmyCreatureInfo(fight_id, 0, stack)
            if contains(hero_creatures_types, creature) then
                if not creatures_to_join[creature] then
                    creatures_to_join[creature] = died
                else
                    creatures_to_join[creature] = creatures_to_join[creature] + died
                end
            end
        end
        print("<color=red>Diplomacy.CombatResult: <color=green> creatures to join found - ", creatures_to_join)
        if len(creatures_to_join) > 0 then
            print("<color=red>Diplomacy.CombatResult: <color=green> trying to add creatures")
            for creature, count in creatures_to_join do
                if diplomacy_rmg.joins_count_for_hero[winner] == 0 then
                  return
                end
                print("<color=red>Diplomacy.CombatResult: <color=green> checking creature ", creature, " in count ", count)
                local level = Creature.Params.Tier(creature)
                print("<color=red>Diplomacy.CombatResult: <color=green>creature level - ", level)
                local cost = Creature.Params.Cost(creature)
                print("<color=red>Diplomacy.CombatResult: <color=green>creature cost - ", cost)
                local actual_join_count = ceil(count * diplomacy_rmg.join_percent_per_creature_level[level])
                local actual_join_cost = ceil(actual_join_count * cost * diplomacy_rmg.join_cost_per_creature_level[level])
                -- корона
                if HasArtefact(winner, ARTIFACT_CROWN_OF_LEADER, 1) then
                    actual_join_cost = ceil(actual_join_cost / 2)
                end
                --
                if actual_join_count >= 1 and actual_join_cost >= 1 then
                    local gold = GetPlayerResource(GetObjectOwner(winner), GOLD)
                    if gold > actual_join_cost then
                        if MCCS_QuestionBoxForPlayers(GetObjectOwner(winner), {diplomacy_rmg.path.."join_message.txt"; 
                                                                                creature = Creature.Params.Name(creature),
                                                                                count = actual_join_count,
                                                                                cost = actual_join_cost}) then
                            Hero.CreatureInfo.Add(winner, creature, actual_join_count)
                            SetPlayerResource(GetObjectOwner(winner), GOLD, gold - actual_join_cost)
                            local new_join_count = diplomacy_rmg.joins_count_for_hero[winner] - 1
                            diplomacy_rmg.joins_count_for_hero[winner] = new_join_count
                            while diplomacy_rmg.joins_count_for_hero[winner] ~= new_join_count do
                              sleep()
                            end
                        end
                    end
                end
            end
        end
    end
end)