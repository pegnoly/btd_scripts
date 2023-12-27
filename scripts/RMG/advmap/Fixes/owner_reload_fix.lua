function OwnerReloadFix()
    local saved_mp = {}
    for i, hero in GetObjectNamesByType("HERO") do
        saved_mp[hero] = GetHeroStat(hero, STAT_MOVE_POINTS)
        ChangeHeroStat(hero, STAT_MOVE_POINTS, -99999)
        local owner = GetObjectOwner(hero)..""
        consoleCmd("@SetGameVar('"..hero.."_owner', "..owner..")")
    end
    sleep()
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
    sleep()
    for i, hero in GetObjectNamesByType("HERO") do
        ChangeHeroStat(hero, STAT_MOVE_POINTS, saved_mp[hero])
    end
end

consoleCmd("@MapReloadEvent.AddListener('BTD_RMG_reload_hero_owners', OwnerReloadFix)")