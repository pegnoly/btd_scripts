logistics_spec_duel =
{
    heroes = {"Grok1", "Heam1", "Hero21", "Brem1", "Grok2", "Heam2", "Hero22", "Brem2"},
    gold_bonus = 8500
}

NewDayEvent.AddListener("btd_logistics_new_day_event",
function(day)
    if day == BTD_duel_day_sequence.freeroam_day then
        for hero, alive in AdvMapHeroesInfo.alive_heroes do
            if hero and alive and contains(logistics_spec_duel.heroes, hero) then
                Resource.Change(hero, GOLD, logistics_spec_duel.gold_bonus)
            end
        end
    end
end)