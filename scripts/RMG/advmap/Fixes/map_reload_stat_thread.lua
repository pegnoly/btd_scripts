-- [#3 fix] Restores heroes stats global vars after reload.
function StatThreadReloadFix()
    local stats =
    {
        [STAT_ATTACK] = {name = '_Attack'},
        [STAT_DEFENCE] = {name = '_Defence'},
        [STAT_SPELL_POWER] = {name = '_Spellpower'},
        [STAT_KNOWLEDGE] = {name = '_Knowledge'},
        [STAT_MORALE] = {name = '_Morale'},
        [STAT_LUCK] = {name = '_Luck'},
    }
    for i, hero in GetObjectNamesByType("HERO") do
        for stat, info in stats do
            local curr_val = GetHeroStat(hero, stat)
            consoleCmd("@SetGameVar('"..hero..""..info.name.."', '"..curr_val.."')")
        end
    end     
end

consoleCmd("@MapReloadEvent.AddListener('BTD_RMG_reload_stat_threads', StatThreadReloadFix)")