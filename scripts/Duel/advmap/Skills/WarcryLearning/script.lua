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
    errorHook(function ()
        print("<color=red>Error: <color=green> WarcryLearning duel new day.")
    end)
    if day == BTD_duel_day_sequence.prefight_day then
        for hero, alive_status in AdvMapHeroesInfo.alive_heroes do
            if hero and alive_status == HERO_CONDITION_ALIVE and HasHeroSkill(hero, HERO_SKILL_WARCRY_LEARNING) then
                if not KnowHeroSpell(hero, 292) then
                    Hero.SpellInfo.TeachSpell(hero, 292)
                else
                    if not KnowHeroSpell(hero, 293) then
                        Hero.SpellInfo.TeachSpell(hero, 293)
                    end
                end
            end
        end
    end
end)