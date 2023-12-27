artificier_duel = {
    path = "/scripts/Duel/advmap/Skills/Artificier/",
    -- ресы для артов, которые даются базово всем героям
    BaseDistribution = 
    function(hero)
        for res, count in {[0] = 30; 30, 20, 20, 20, 20} do
            Resource.Change(hero, res, count)
        end
    end,

    -- здесь можно назначить функцию выдачи ресов конкретному герою(Маахир в данный момент)
    CustomDistribution = {}
}

MapLoadingEvent.AddListener("btd_duel_artificier_helper_init",
function()
    for player = PLAYER_1, PLAYER_2 do
        if GetPlayerRace(player) == TOWN_ACADEMY then
            local x, y, f = RegionToPoint("p"..player.."_helper_spawn_point")
            local helper = "artificier_duel_"..player.."_helper"
            CreateMonster(helper, CREATURE_ARCH_MAGI, 1, x, y, f, MONSTER_MOOD_FRIENDLY, MONSTER_COURAGE_ALWAYS_JOIN, 180, 1)
            while not IsObjectExists(helper) do
                sleep()
            end
            Touch.DisableMonster(helper, DISABLED_INTERACT, 0, artificier_duel.path.."helper.txt")
            Touch.SetFunction(helper, "_touch_artificier_helper", ArtificierDuel_Init)
        end
    end
end)

function ArtificierDuel_Init(hero, object)
    local player = GetObjectOwner(hero)
    if MCCS_QuestionBoxForPlayers(player, artificier_duel.path.."wanna_create_arts.txt") then
        local town = Player.GetTowns(player)[1]
        UpgradeTownBuilding(town, TOWN_BUILDING_ACADEMY_ARCANE_FORGE)
        btd_duel_free_roam.free_roam_active_for_hero[hero] = nil
        ChangeHeroStat(hero, STAT_MOVE_POINTS, -10000)
        if artificier_duel.CustomDistribution[hero] then
            startThread(artificier_duel.CustomDistribution[hero], hero)
        else
            startThread(artificier_duel.BaseDistribution, hero)
        end
        sleep(20)
        local x, y, f = GetObjectPosition(town)
        SetObjectPosition(hero, x, y, f)
    end
end