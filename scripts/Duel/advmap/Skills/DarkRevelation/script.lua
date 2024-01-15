dark_revelation_duel = {
    stat_increase = 4,
    stat_decrease = 3,

    path = "/scripts/Duel/advmap/Skills/DarkRevelation/",
    scrf_names = {
        [STAT_ATTACK] = "s_attack.txt",
        [STAT_DEFENCE] = "s_defence.txt",
        [STAT_SPELL_POWER] = "s_spellpower.txt",
        [STAT_KNOWLEDGE] = "s_knowledge.txt",
    },

    used_by_hero = {},
    selected_stat_by_hero = {},
    sacrificed_stat_by_hero = {}
}

CustomAbility.callbacks["dark_revelation_duel"] = {
    question = dark_revelation_duel.path.."wanna_use.txt",
    funct = function(hero)
        errorHook(function ()
            print("<color=red>Error: <color=green> DarkRevelation duel custom ability.")
        end)
        dark_revelation_duel.selected_stat_by_hero[hero] = nil
        dark_revelation_duel.sacrificed_stat_by_hero[hero] = nil
        local player = GetObjectOwner(hero)
        for stat = STAT_ATTACK, STAT_KNOWLEDGE do
            if MCCS_QuestionBoxForPlayers(player, {
                dark_revelation_duel.path.."wanna_select_stat.txt"; name = StatNames[stat]
            }) then
                dark_revelation_duel.selected_stat_by_hero[hero] = stat
                break
            end
        end
        sleep()
        --
        if dark_revelation_duel.selected_stat_by_hero[hero] then
            for stat = STAT_ATTACK, STAT_KNOWLEDGE do
                if stat ~= dark_revelation_duel.selected_stat_by_hero[hero] and GetHeroStat(hero, stat) >= dark_revelation_duel.stat_decrease then
                    if MCCS_QuestionBoxForPlayers(player, {
                        dark_revelation_duel.path.."wanna_sacrifice_stat.txt"; name = dark_revelation_duel.path..dark_revelation_duel.scrf_names[stat]
                    }) then
                        dark_revelation_duel.sacrificed_stat_by_hero[hero] = stat
                        dark_revelation_duel.used_by_hero[hero] = 1
                        startThread(Hero.Stats.Change, hero, dark_revelation_duel.selected_stat_by_hero[hero], dark_revelation_duel.stat_increase)
                        startThread(Hero.Stats.Change, hero, dark_revelation_duel.sacrificed_stat_by_hero[hero], -dark_revelation_duel.stat_decrease)
                        CustomAbility.callbacks_for_hero[CUSTOM_ABILITY_HERO][%hero]["dark_revelation_duel"] = nil
                        break
                    end
                end
            end
        end
    end
}

AddHeroEvent.AddListener("btd_duel_dark_revelation_add_hero_listener",
function(hero)
    errorHook(function ()
        print("<color=red>Error: <color=green> DarkRevelation duel add hero.")
    end)
    startThread(
    function()
        while 1 do
            if IsHeroAlive(%hero) then
                if not dark_revelation_duel.used_by_hero[%hero] then
                    if HasHeroSkill(%hero, WARLOCK_FEAT_DARK_REVELATION) then
                        CustomAbility.callbacks_for_hero[CUSTOM_ABILITY_HERO][%hero]["dark_revelation_duel"] = 1
                    end
                else
                    if not HasHeroSkill(%hero, WARLOCK_FEAT_DARK_REVELATION) then
                        if dark_revelation_duel.selected_stat_by_hero[%hero] then
                            startThread(Hero.Stats.Change, %hero, dark_revelation_duel.selected_stat_by_hero[%hero], -dark_revelation_duel.stat_increase)
                            startThread(Hero.Stats.Change, %hero, dark_revelation_duel.sacrificed_stat_by_hero[%hero], dark_revelation_duel.stat_decrease) 
                            dark_revelation_duel.selected_stat_by_hero[%hero] = nil
                            CustomAbility.callbacks_for_hero[CUSTOM_ABILITY_HERO][%hero]["dark_revelation_duel"] = nil
                        end
                    end
                end
            end
            sleep()
        end   
    end)
end)