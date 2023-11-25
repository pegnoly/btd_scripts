while not MCCS_MapWinConditions do
    sleep()
end

Gold = 0
RareResource = 1

wc_economic = {
    path = "/scripts/RMG/advmap/Features/WinConditions/Economic/",
    current_res_type = -1,
    current_res_count = -1
}

MapLoadingEvent.AddListener("BTD_RMG_win_condition_economic_init",
function()
    if MCCS_MapWinConditions["economic"] then
        wc_economic.current_res_type = MCCS_MapWinConditions["economic"].res_type
        wc_economic.current_res_count = MCCS_MapWinConditions["economic"].count
        for player = PLAYER_1, PLAYER_8 do
            if Player.IsActive(player) then
                Quest.Start("WIN_CONDITION_ECONOMIC", nil, player)
                startThread(WC_Economic_WinThread, player)
            end
        end
    end
end)

function WC_Economic_WinThread(player)
    while 1 do
        if wc_economic.current_res_type == Gold then
            if GetPlayerResource(player, GOLD) >= wc_economic.current_res_count then
                startThread(WC_EconomicWin, player)
            end
        else
            if Resource.IsEnoughT(player, {
                [0] = wc_economic.current_res_count;
                wc_economic.current_res_count,
                wc_economic.current_res_count,
                wc_economic.current_res_count,
                wc_economic.current_res_count,
                wc_economic.current_res_count
            }) then
                startThread(WC_EconomicWin, player)
            end
        end
        sleep()
    end
end

function WC_EconomicWin(winner)
    for player = PLAYER_1, PLAYER_8 do
        if Player.IsActive(player) then
            startThread(MCCS_MessageBoxForPlayers, player, {
                wc_economic.path.."player_won.txt"; player_id = player
            })
        end
    end
    sleep(10)
    Win(winner)
end