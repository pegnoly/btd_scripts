while not MCCS_GAME_MODES and GAME_MODE_BLITZ do
    sleep()
end

MapLoadingEvent.AddListener("BTD_rmg_blitz_mode_quest_init",
function()
    if MCCS_GAME_MODES[GAME_MODE_BLITZ] then
        for player = PLAYER_1, PLAYER_8 do
            if GetPlayerState(player) == PLAYER_ACTIVE then
                Quest.Start("GAME_MODE_BLITZ", nil, player)
            end
        end
    end
end)