mysticism_duel =
{
    know_bonus = 2,
    active_for_hero = {}
}

AddHeroEvent.AddListener("btd_duel_mysticism_add_hero_listener",
function(hero)
    errorHook(function ()
        print("<color=red>Error: <color=green> Mysticism duel add hero.")
    end)
    mysticism_duel.active_for_hero[hero] = nil
    startThread(
    function()
        while 1 do
            if IsHeroAlive(%hero) then
                if not mysticism_duel.active_for_hero[%hero] then
                    if HasHeroSkill(%hero, PERK_MYSTICISM) or HasHeroSkill(%hero, HERO_SKILL_BARBARIAN_MYSTICISM) then
                        mysticism_duel.active_for_hero[%hero] = 1
                        ChangeHeroStat(%hero, STAT_KNOWLEDGE, mysticism_duel.know_bonus)
                        consoleCmd("@SetGameVar('"..%hero.."_MYSTICISM', 'active')")
                    end
                else
                    if not (HasHeroSkill(%hero, PERK_MYSTICISM) or HasHeroSkill(%hero, HERO_SKILL_BARBARIAN_MYSTICISM)) then
                        mysticism_duel.active_for_hero[%hero] = nil
                        ChangeHeroStat(%hero, STAT_KNOWLEDGE, -mysticism_duel.know_bonus)
                        consoleCmd("@SetGameVar('"..%hero.."_MYSTICISM', 'active')")
                    end
                end
            end
            sleep()
        end
    end)
end)