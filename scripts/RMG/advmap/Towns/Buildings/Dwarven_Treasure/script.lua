TOWN_BUILDING_DWARVEN_TREASURE = 23

dwarven_treasure =
{
    path = "/scripts/RMG/advmap/Towns/Buildings/Dwarven_Treasure/",
    additional_gold_percent = 0.2
}

NewDayEvent.AddListener("BTD_RMG_dwarven_treasure_new_day",
function(day)
    if mod(day, 7) == 1 then
        local towns_with_treasure_for_player = {}
        for i, town in GetObjectNamesByType("TOWN") do
            if GetTownRace(town) == TOWN_FORTRESS then
                if GetTownBuildingLevel(town, TOWN_BUILDING_DWARVEN_TREASURE) > 0 then
                    local player = GetObjectOwner(town)
                    if not towns_with_treasure_for_player[player] then
                        towns_with_treasure_for_player[player] = 1
                    else
                        towns_with_treasure_for_player[player] = towns_with_treasure_for_player[player] + 1
                    end
                end
            end
        end
        for player, towns_count in towns_with_treasure_for_player do
            startThread(DwarvenTreasure_GiveGold, player, towns_count)
        end
    end
end)

function DwarvenTreasure_GiveGold(player, towns_count)
    local current_gold = GetPlayerResource(player, GOLD)
    local gold_to_add = ceil(current_gold * towns_count * dwarven_treasure.additional_gold_percent)
    SetPlayerResource(player, GOLD, current_gold + gold_to_add)
    startThread(MCCS_MessageBoxForPlayers, player, {dwarven_treasure.path.."additional_gold_grow.txt"; amount = gold_to_add})
end