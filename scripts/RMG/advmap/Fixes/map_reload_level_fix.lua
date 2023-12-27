-- [#3 fix] Restores heroes levels global vars after reload.
function HeroLevelReloadFix()
    for i, hero in GetObjectNamesByType("HERO") do
        local lvl = GetHeroLevel(hero)
        consoleCmd("@SetGameVar('"..hero.."_lvl', "..lvl..")")
    end     
end

consoleCmd("@MapReloadEvent.AddListener('BTD_RMG_reload_hero_levels', HeroLevelReloadFix)")