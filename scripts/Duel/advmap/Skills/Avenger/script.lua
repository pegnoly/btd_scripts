avenger_duel = {
    path = "/scripts/Duel/advmap/Skills/Avenger/"
}

MapLoadingEvent.AddListener("btd_duel_avenger_helper_init",
function()
    for player = PLAYER_1, PLAYER_2 do
        if GetPlayerRace(player) == TOWN_PRESERVE then
            local x, y, f = RegionToPoint("p"..player.."_helper_spawn_point")
            local helper = "avenger_duel_"..player.."_helper"
            CreateMonster(helper, CREATURE_GRAND_ELF, 1, x, y, f, MONSTER_MOOD_FRIENDLY, MONSTER_COURAGE_ALWAYS_JOIN, 180, 1)
            while not IsObjectExists(helper) do
                sleep()
            end
            Touch.DisableMonster(helper, DISABLED_INTERACT, 0, avenger_duel.path.."helper.txt")
            Touch.SetFunction(helper, "_touch_avenger_helper", AvengerDuel_Init)
        end
    end
end)

function AvengerDuel_Init(hero)
    local player = GetObjectOwner(hero)
    if MCCS_QuestionBoxForPlayers(player, avenger_duel.path.."wanna_set_enemies.txt") then
        local town = Player.GetTowns(player)[1]
        UpgradeTownBuilding(town, TOWN_BUILDING_PRESERVE_AVENGERS_BROTHERHOOD)
        btd_duel_free_roam.free_roam_active_for_hero[hero] = nil
        ChangeHeroStat(hero, STAT_MOVE_POINTS, -10000)
        sleep(5)
        local x, y, f = GetObjectPosition(town)
        SetObjectPosition(hero, x, y, f)
    end
end