function CombatThreadsReload()
    for player = PLAYER_1, PLAYER_8 do
        if GetPlayerState(player) == PLAYER_ACTIVE then
            if IsAIPlayer(player) == 0 then
                local hero = GetPlayerHeroes(player)[0]
                if hero then
                    StartCombat(hero, nil, 1, 1, 1, "/CombatThreadReloadScript.xdb#xpointer(/Script)")
                end
            end
        end
    end
end

-- consoleCmd("@MapReloadEvent.AddListener('BTD_RMG_reload_combat_threads', CombatThreadsReload)")