resource_silo_rmg = {
    res_by_race = {
        [TOWN_HEAVEN] = CRYSTAL,
        [TOWN_INFERNO] = SULFUR,
        [TOWN_NECROMANCY] = MERCURY,
        [TOWN_PRESERVE] = GEM,
        [TOWN_DUNGEON] = SULFUR,
        [TOWN_ACADEMY] = GEM,
        [TOWN_FORTRESS] = CRYSTAL,
        [TOWN_STRONGHOLD] = MERCURY
    },
    res_amount = 6,
    given_for_town = {},
}

MapLoadingEvent.AddListener("BTD_RMG_resource_silo_init",
function()
    for i, town in GetObjectNamesByType("TOWN") do
        resource_silo_rmg.given_for_town[town] = nil
        startThread(RMGResourceSilo_CheckBuild, town)
    end
end)

function RMGResourceSilo_CheckBuild(town) 
    while 1 do
        if not resource_silo_rmg.given_for_town[town] then
            if GetTownBuildingLevel(town, TOWN_BUILDING_MARKETPLACE) == 2 then
                local race = GetTownRace(town)
                local player = GetObjectOwner(town)
                if player ~= PLAYER_NONE then
                    SetPlayerResource(
                        player, 
                        resource_silo_rmg.res_by_race[race], 
                        GetPlayerResource(player, resource_silo_rmg.res_by_race[race]) + resource_silo_rmg.res_amount
                    )
                end
                resource_silo_rmg.given_for_town[town] = 1
                break
            end
        end
        sleep()
    end
end