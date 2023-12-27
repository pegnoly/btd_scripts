no_rest_for_the_wicked_duel =
{
  skeleton_grow = 85,
}

NewDayEvent.AddListener("btd_duel_no_rest_for_the_wicked_new_day_listener",
function(day)
    if day == BTD_duel_day_sequence.prefight_day then
        for hero, alive in AdvMapHeroesInfo.alive_heroes do
            if hero and alive and HasHeroSkill(hero, PERK_NO_REST_FOR_THE_WICKED) then
                startThread(Hero.CreatureInfo.DefaultGrow, hero, TOWN_NECROMANCY, 1, no_rest_for_the_wicked_duel.skeleton_grow)
            end
        end
    end
end)
