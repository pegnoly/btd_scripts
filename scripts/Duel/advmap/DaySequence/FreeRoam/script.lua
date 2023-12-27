btd_duel_free_roam = {
    deploy_points = {
        [PLAYER_1] = {132, 56, 0},
        [PLAYER_2] = {21, 44, 0},
    },
    free_roam_active_for_hero = {},
    race_gold_bonus = 5000
}

NewDayEvent.AddListener('btd_duel_free_roam_init_listener',
function(day)
    if day == BTD_duel_day_sequence.freeroam_day then
        for player = PLAYER_1, PLAYER_2 do
            local hero = GetPlayerHeroes(player)[0]
            SetObjectPosition(
                hero, 
                btd_duel_free_roam.deploy_points[player][1], 
                btd_duel_free_roam.deploy_points[player][2], 
                btd_duel_free_roam.deploy_points[player][3], 
                0
            )
            for n, town in GetObjectNamesByType('TOWN') do
                if GetObjectOwner(town) == GetObjectOwner(hero) then
                    MakeHeroInteractWithObject(hero, town)
                end
            end
        end
    end
end)

NewDayEvent.AddListener("btd_duel_free_roam_bonuses_listener",
function(day)
    if day == BTD_duel_day_sequence.freeroam_day then
        for player = PLAYER_1, PLAYER_2 do
            local race = GetPlayerRace(player)
            if race == TOWN_ACADEMY or race == TOWN_DUNGEON then
                Resource.Change(GetPlayerHeroes(player)[0], GOLD, btd_duel_free_roam.race_gold_bonus)
            end
        end
    end
end)