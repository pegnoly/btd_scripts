forest_leader_duel =
{
  dancer_grow = 15, 
}

NewDayEvent.AddListener("btd_duel_forest_leader_new_day_event",
function(day)
    if day == BTD_duel_day_sequence.prefight_day then
        for hero, alive_status in AdvMapHeroesInfo.alive_heroes do
            if hero and alive_status == HERO_CONDITION_ALIVE and HasHeroSkill(hero, RANGER_FEAT_FOREST_GUARD_EMBLEM) then
                startThread(Hero.CreatureInfo.DefaultGrow, hero, TOWN_PRESERVE, 2, forest_leader_duel.dancer_grow)
            end
        end
    end
end)