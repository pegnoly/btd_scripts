-----------------------------------
-- Стандартные функции для дуэли --

function SkipTurnMessage(player)
    startThread(MCCS_MessageBoxForPlayers, player, GetMapDataPath().."Messages/can_skip_turn.txt", function() consoleCmd('advance_time 1 1 2') end)
end