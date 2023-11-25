--- 26.05.2023. Improved.

mentorship_duel =
{
    bonus_lvl = 8,
    active_for_hero = {}
}

NewDayEvent.AddListener("BTD_duel_mentorship_new_day",
function(day)
    if day == BTD_FIGHT_DAY then
        for hero, alive in AdvMapHeroesInfo.alive_heroes do
            if hero and alive and HasHeroSkill(hero, HERO_SKILL_MENTORING) then
                local heroLevel = GetHeroLevel(hero);
                local needExp = Levels[heroLevel + mentorship_duel.bonus_lvl] - Levels[heroLevel];
                WarpHeroExp(hero, GetHeroStat(hero, STAT_EXPERIENCE) + needExp);
            end
        end
    end
end)