while not MCCS_GAME_MODES do
    sleep()
end

wc_final_battle = {
    spawn_positions = {
        [PLAYER_1] = {x = 5, y = 12},
        [PLAYER_2] = {x = 9, y = 12},
        [PLAYER_3] = {x = 12, y = 12},
        [PLAYER_4] = {x = 5, y = 9},
        [PLAYER_5] = {x = 12, y = 9},
        [PLAYER_6] = {x = 5, y = 5},
        [PLAYER_7] = {x = 9, y = 5},
        [PLAYER_8] = {x = 12, y = 5}
    },
    date = {},
    path = "/scripts/RMG/advmap/Features/WinConditions/FinalBattle/"
}


MapLoadingEvent.AddListener("BTD_RMG_win_condition_final_battle_init",
function()
    if MCCS_GAME_MODES[GAME_MODE_FINAL_BATTLE] then
        for player = PLAYER_1, PLAYER_8 do
            if Player.IsActive(player) then
                Quest.Start("WIN_CONDITION_FINAL_BATTLE", nil, player)
            end
        end
        wc_final_battle.date = MCCS_GAME_MODES[GAME_MODE_FINAL_BATTLE]
        NewDayEvent.AddListener("BTD_RMG_win_condition_final_battle_new_day", WC_FinalBattle_StartDay)
    end
end)

function WC_FinalBattle_StartDay(day) 
    local curr_month = GetDate(MONTH)
    local curr_week = GetDate(WEEK)
    local dow = GetDate(DAY_OF_WEEK)
    if curr_month == wc_final_battle.date.month and 
        curr_week == wc_final_battle.date.week and 
        dow == wc_final_battle.date.day then
        startThread(WC_FinalBattle_InitFight)
    end
end

function WC_FinalBattle_InitFight()
    for i, town in GetObjectNamesByType("TOWN") do
        DestroyTownBuildingToLevel(town, TOWN_BUILDING_TAVERN, 0, 0)
    end
    for player = PLAYER_1, PLAYER_8 do 
        if Player.IsActive(player) then
            local hero = WC_FinalBattle_GetStrongestPlayerHero(player)
            if hero then
                startThread(WC_FinalBattle_TransferHero, hero, player)
            end
        end
    end
    CombatResultsEvent.AddListener("BTD_RMG_win_condition_final_battle_combat_results",
    function(fight_id)
        local loser = GetSavedCombatArmyPlayer(fight_id, 0)
        if loser then
            Loose(loser)
        end
    end) 
end

function WC_FinalBattle_GetStrongestPlayerHero(player) 
    local curr_hero, curr_max_exp = "", -1
    for i, hero in GetPlayerHeroes(player) do
        local exp = GetHeroStat(hero, STAT_EXPERIENCE)
        if exp > curr_max_exp then
            curr_hero = hero
            curr_max_exp = exp     
        end
    end
    if curr_hero ~= "" then
        for i, hero in GetPlayerHeroes(player) do 
            local object
            local town = GetHeroTown(hero)
            if town then
                object = GetTownHero(town)
            else
                object = hero
            end
            if hero ~= curr_hero then
                RemoveObject(hero)
            end
        end 
        return curr_hero
    end
    return nil
end

function WC_FinalBattle_TransferHero(hero, player) 
    local town = GetHeroTown(hero)
    if town then
        hero = GetTownHero(town)
    end
    local pos = wc_final_battle.spawn_positions[player]
    SetObjectPosition(hero, pos.x, pos.y, UNDERGROUND)
    while not IsInDungeon(hero) do
        sleep()
    end
    startThread(WC_FinalBattle_CheckHeroFloor, hero)
end

function WC_FinalBattle_CheckHeroFloor(hero)
    while IsInDungeon(hero) do
        sleep()
    end
    local owner = GetObjectOwner(hero)
    startThread(MCCS_MessageBoxForPlayers, owner, {
        wc_final_battle.path.."hero_fleed.txt"; hero = Hero.Params.Name(hero), player = owner
    })
    Loose(owner)
end