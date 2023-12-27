--- 26.05.2023. Improved.

mentorship_duel =
{
    bonus_lvl = 8,
    active_for_hero = {}
}

NewDayEvent.AddListener("BTD_duel_mentorship_new_day_listener",
function(day)
    errorHook(function ()
        print("<color=red>Error: <color=green> Mentorship duel new day.")
    end)
    if day == BTD_duel_day_sequence.prefight_day then
        for hero, alive in AdvMapHeroesInfo.alive_heroes do
            if hero and alive and HasHeroSkill(hero, HERO_SKILL_MENTORING) then
                local heroLevel = GetHeroLevel(hero);
                local needExp = Levels[heroLevel + mentorship_duel.bonus_lvl] - Levels[heroLevel];
                WarpHeroExp(hero, GetHeroStat(hero, STAT_EXPERIENCE) + needExp);
            end
        end
    end
end)