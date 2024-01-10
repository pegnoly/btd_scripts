while not MCCS_GAME_MODES and GAME_MODE_KRYPT do
    sleep()
end

MapLoadingEvent.AddListener("BTD_rmg_krypt_mode_init", 
function()
    if MCCS_GAME_MODES[GAME_MODE_KRYPT] then
        for i, town in GetObjectNamesByType("TOWN") do
            if GetObjectOwner(town) == PLAYER_NONE then
                for slot = 0, 6 do
                    local creature, count = GetObjectArmySlotCreature(town, slot)
                    if not (creature == 0 or count == 0) then
                        if Creature.Params.Tier(creature) >= 6 then
                            print("KRYPT town detected: ", town)
                            startThread(BuildTownToLimit, town)
                        end
                    end
                end
            end
        end
    end
end)

function BuildTownToLimit(town)
    for i = 1, 4 do
        pcall(UpgradeTownBuilding, town, TOWN_BUILDING_TOWN_HALL)
    end
    for i = 1, 3 do
        pcall(UpgradeTownBuilding, town, TOWN_BUILDING_FORT)
    end
    for i = 1, 2 do
        pcall(UpgradeTownBuilding, town, TOWN_BUILDING_MARKETPLACE)
    end
    pcall(UpgradeTownBuilding, town, TOWN_BUILDING_TAVERN)
    pcall(UpgradeTownBuilding, town, TOWN_BUILDING_BLACKSMITH)
    for i = 1, 5 do
        pcall(UpgradeTownBuilding, town, TOWN_BUILDING_MAGIC_GUILD)
    end
    for dwell = TOWN_BUILDING_DWELLING_1, TOWN_BUILDING_DWELLING_7 do
        for i = 1, 2 do
            pcall(UpgradeTownBuilding, town, dwell)
        end
    end
    pcall(UpgradeTownBuilding, town, TOWN_BUILDING_GRAIL)
    for special = TOWN_BUILDING_SPECIAL_0, TOWN_BUILDING_SPECIAL_9 do
        for i = 1, 3 do
            pcall(UpgradeTownBuilding, town, special)
        end
    end
end
