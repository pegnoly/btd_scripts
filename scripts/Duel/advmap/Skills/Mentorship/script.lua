mentorship =
{
  level_count = 1,
  heroes_active = {}
}

AddHeroEvent.AddListener("mentorship_add_hero_event",
function(hero)
    mentorship.heroes_active[hero] = nil
    startThread(
    function()
        while 1 do
        if IsHeroAlive(%hero) then
            if not mentorship.heroes_active[%hero] then
                if HasHeroSkill(%hero, HERO_SKILL_MENTORING) then
                    mentorship.heroes_active[%hero] = 1
                    local xp = GetHeroStat(%hero, STAT_EXPERIENCE)
                    local level_to_up = -1
                    for level, xp_to_level in Levels do
                        if xp < xp_to_level then
                            level_to_up = level
                            break
                        end
                    end
                    local xp_to_add = Levels[level_to_up] - xp + 1
                    startThread(GiveExp, %hero, xp_to_add)
                end
            else
                if not HasHeroSkill(%hero, HERO_SKILL_MENTORING) then
                    mentorship.heroes_active[%hero] = nil
                end
            end
        end
        sleep()
        end
    end)
end)