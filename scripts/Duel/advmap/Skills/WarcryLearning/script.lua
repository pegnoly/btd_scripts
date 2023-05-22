warcry_learning =
{

    GiveWarcry =
    function(hero)
        local warcries = Hero.SpellInfo.GetLearnableWarcries(hero)
        if len(warcries) > 0 then
            startThread(Hero.SpellInfo.TeachSpell, hero, Random.FromTable(warcries))
        end
    end
}

NewDayEvent.AddListener("warcry_learning_new_day_event",
function(day)
    if day == BTD_FIGHT_DAY then
        for hero, alive in AdvMapHeroesInfo.alive_heroes do
            if hero and alive and HasHeroSkill(hero, HERO_SKILL_WARCRY_LEARNING) then
                startThread(warcry_learning.GiveWarcry, hero)
            end
        end
    end
end)