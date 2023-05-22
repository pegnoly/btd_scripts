navigation =
{
  know_bonus = 2,
  heroes_active = {}
}

NewDayEvent.AddListener("navigation_add_hero_event",
function(hero)
    navigation.heroes_active[hero] = nil
    startThread(
    function()
        while 1 do
            if IsHeroAlive(%hero) then
                if not navigation.heroes_active[%hero] then
                    if HasHeroSkill(%hero, PERK_NAVIGATION) then
                        navigation.heroes_active[%hero] = 1
                        ChangeHeroStat(%hero, STAT_KNOWLEDGE, navigation.know_bonus)
                    end
                        else
                    if not HasHeroSkill(%hero, PERK_NAVIGATION) then
                        navigation.heroes_active[%hero] = nil
                        ChangeHeroStat(%hero, STAT_KNOWLEDGE, -navigation.know_bonus)
                    end
                end
            end
            sleep()
        end
    end)
end