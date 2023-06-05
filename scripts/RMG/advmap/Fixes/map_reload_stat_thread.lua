while not MapReloadEvent do
    sleep()
end

print("Map reload event added")

MapReloadEvent.AddListener("BTD_RMG_stat_threads_fix",
function()
    print("Here?")
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
        print("Hero: ", hero)
        for stat, info in stats do
            local curr_val = GetHeroStat(hero, stat)
            consoleCmd("@SetGameVar('"..hero..""..info.name.."', '"..curr_val.."')")
        end
    end
    --
    for i, hero in GetPlayerHeroes(PLAYER_1) do
        print("Hero from player: ", hero)
        for stat, info in stats do
            local curr_val = GetHeroStat(hero, stat)
            consoleCmd("@SetGameVar('"..hero..""..info.name.."', '"..curr_val.."')")
        end
    end
end)