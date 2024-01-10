while not MCCS_GAME_MODES and GAME_MODE_OUTCAST do
    sleep()
end

MapLoadingEvent.AddListener("BTD_rmg_outcast_mode_quest_init",
function()
    if MCCS_GAME_MODES[GAME_MODE_OUTCAST] then
        for player = PLAYER_1, PLAYER_8 do
            if GetPlayerState(player) == PLAYER_ACTIVE then
                Quest.Start("GAME_MODE_OUTCAST", nil, player)
            end
        end
    end
end)