-- [#3 fix] Restores heroes levels global vars after reload.
function HeroLevelReloadFix()
    for hero, alive in AdvMapHeroesInfo.alive_heroes do
        if hero and alive then
            local lvl = GetHeroLevel(hero)
            consoleCmd("@SetGameVar('"..hero.."_lvl', '"..lvl.."')")
        end
    end     
end

consoleCmd("@MapReloadEvent.AddListener('BTD_RMG_reload_hero_levels', HeroLevelReloadFix)")