wisdom_duel =
{
    know_bonus = 1,
    heroes_active = {}
}

AddHeroEvent.AddListener("btd_duel_wisdom_add_hero_listener",
function(hero)
    errorHook(function ()
        print("<color=red>Error: <color=green> Wisdom duel add hero.")
    end)
    wisdom_duel.heroes_active[hero] = nil
    startThread(
    function()
        while 1 do
            if IsHeroAlive(%hero) then
                if not wisdom_duel.heroes_active[%hero] then
                    if HasHeroSkill(%hero, PERK_WISDOM) then
                        wisdom_duel.heroes_active[%hero] = 1
                        ChangeHeroStat(%hero, STAT_KNOWLEDGE, wisdom_duel.know_bonus)
                    end
                else
                    if not HasHeroSkill(%hero, PERK_WISDOM) then
                        wisdom_duel.heroes_active[%hero] = nil
                        ChangeHeroStat(%hero, STAT_KNOWLEDGE, -wisdom_duel.know_bonus)
                    end
                end
            end
            sleep()
        end
    end)
end)
