dark_ritual =
{
    know_bonus = 2,
    heroes_active = {}
}

AddHeroEvent.AddListener("dark_ritual_add_hero_event",
function(hero)
    dark_ritual.heroes_active[hero] = nil
    startThread(
    function()
        while 1 do
        if IsHeroAlive(%hero) then
            if not dark_ritual.heroes_active[%hero] then
                if HasHeroSkill(%hero, PERK_DARK_RITUAL) then
                    dark_ritual.heroes_active[%hero] = 1
                    ChangeHeroStat(%hero, STAT_KNOWLEDGE, dark_ritual.know_bonus)
                end
            else
                if not HasHeroSkill(%hero, PERK_DARK_RITUAL) then
                    dark_ritual.heroes_active[%hero] = nil
                    ChangeHeroStat(%hero, STAT_KNOWLEDGE, -dark_ritual.know_bonus)
                end
            end
        end
        sleep()
        end
    end)
end)