TOWN_PORTAL_RMG_STATE_WAITING = 1
TOWN_PORTAL_RMG_STATE_ACTIVE = 2
TOWN_PORTAL_RMG_STATE_PERFORMED = 3

RADIAN_TO_DEGREE = 57.296

town_portal_rmg = {
    path = '/scripts/RMG/advmap/Spells/TownPortal/',
    min_hero_level = 20,
    --saved_move_points_for_hero = {},
    saved_mana_points_for_hero = {},
    state_for_hero = {}
}

AddHeroEvent.AddListener("btd_rmg_town_portal_add_hero",
function(hero)
    town_portal_rmg.saved_mana_points_for_hero[hero] = GetHeroStat(hero, STAT_MANA_POINTS)
    town_portal_rmg.state_for_hero[hero] = TOWN_PORTAL_RMG_STATE_WAITING
    startThread(
    function()
        while 1 do
            if IsHeroAlive(%hero) and GetHeroLevel(%hero) >= town_portal_rmg.min_hero_level then
                local current_mana = GetHeroStat(%hero, STAT_MANA_POINTS)
                if GetHeroStat(%hero, STAT_MOVE_POINTS) == 0 then
                    if (current_mana < town_portal_rmg.saved_mana_points_for_hero[%hero]) and 
                        town_portal_rmg.state_for_hero[%hero] == TOWN_PORTAL_RMG_STATE_WAITING then
                        local x, y, f = GetObjectPosition(%hero)
                        for i, town in Player.GetTowns(GetObjectOwner(%hero)) do
                            local town_active_tile = BTD_TownsActiveTiles[town]
                            print("town pos = ", town_active_tile, " hero pos = ", GetObjectPosition(%hero))
                            if town_active_tile.x == x and town_active_tile.y == y then
                                town_portal_rmg.state_for_hero[%hero] = TOWN_PORTAL_RMG_STATE_ACTIVE
                                sleep(20)
                                startThread(TownPortalRMG_TryToTP, %hero, town)
                            end
                        end
                    end
                end
                town_portal_rmg.saved_mana_points_for_hero[%hero] = current_mana
            end
            sleep()
        end
    end)
end)

function TownPortalRMG_TryToTP(hero, occupied_town)
    local player = GetObjectOwner(hero)
    for i, town in Player.GetTowns(player) do
        if town ~= occupied_town then
            if GetTownBuildingLevel(town, TOWN_BUILDING_MAGIC_GUILD) >= 1 or
                (GetTownRace(town) == TOWN_STRONGHOLD and GetTownBuildingLevel(town, TOWN_BUILDING_STRONGHOLD_TRAVELLERS_SHELTER) > 0) then
                local active_tile = BTD_TownsActiveTiles[town]
                if IsTilePassable(active_tile.x, active_tile.y, GROUND) then
                    MoveCameraForPlayers(player, active_tile.x, active_tile.y, GROUND, 50, 0, 0, 0, 1)
                    sleep(15)
                    if MCCS_QuestionBoxForPlayers(player, town_portal_rmg.path.."tp_question_box.txt") then
                        SetObjectRotation(hero, BTD_TownsActiveTiles[town].rot * RADIAN_TO_DEGREE)
                        sleep()
                        SetObjectPosition(hero, active_tile.x, active_tile.y, GROUND, 4)
                        town_portal_rmg.state_for_hero[hero] = TOWN_PORTAL_RMG_STATE_PERFORMED
                        break
                    end
                end
            end
        end
    end
end

NewDayEvent.AddListener("btd_rmg_town_portal_new_day",
function(day)
    for hero, alive in AdvMapHeroesInfo.alive_heroes do
        if hero and alive then
            if town_portal_rmg.state_for_hero[hero] ~= TOWN_PORTAL_RMG_STATE_WAITING then
                town_portal_rmg.state_for_hero[hero] = TOWN_PORTAL_RMG_STATE_WAITING
            end
        end
    end
end)