mysticism =
{
    know_bonus = 2, 
}

AddHeroEvent.AddListener("mysticism_add_hero_event",
function(hero)
    mysticism.heroes_active[hero] = nil
    startThread(
    function()
        while 1 do
            if IsHeroAlive(%hero) then
                if not mysticism.heroes_active[%hero] then
                    if HasHeroSkill(%hero, PERK_MYSTICISM) then
                        mysticism.heroes_active[%hero] = 1
                        ChangeHeroStat(%hero, STAT_KNOWLEDGE, mysticism.know_bonus)
                    end
                else
                    if not HasHeroSkill(%hero, PERK_MYSTICISM) then
                        mysticism.heroes_active[%hero] = nil
                        ChangeHeroStat(%hero, STAT_KNOWLEDGE, -mysticism.know_bonus)
                    end
                end
            end
            sleep()
        end
    end)
end)