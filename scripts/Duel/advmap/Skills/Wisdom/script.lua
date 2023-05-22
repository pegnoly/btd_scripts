wisdom =
{
    know_bonus = 1, 
}

AddHeroEvent.AddListener("wisdom_add_hero_event",
function(hero)
    wisdom.heroes_active[hero] = nil
    startThread(
    function()
        while 1 do
            if IsHeroAlive(%hero) then
                if not wisdom.heroes_active[%hero] then
                    if HasHeroSkill(%hero, PERK_WISDOM) then
                        wisdom.heroes_active[%hero] = 1
                        ChangeHeroStat(%hero, STAT_KNOWLEDGE, wisdom.know_bonus)
                    end
                else
                    if not HasHeroSkill(%hero, PERK_WISDOM) then
                        wisdom.heroes_active[%hero] = nil
                        ChangeHeroStat(%hero, STAT_KNOWLEDGE, -wisdom.know_bonus)
                    end
                end
            end
            sleep()
        end
    end)
end)
