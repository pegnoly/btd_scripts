elleshar_spec_duel =
{
    heroes = {"Elleshar1", "Elleshar2"},
    additional_levels = 2
}

NewDayEvent.AddListener('NHF_elleshar_new_day_event',
function(day)
    if day == BTD_duel_day_sequence.freeroam_day then
        for hero, alive_status in AdvMapHeroesInfo.alive_heroes do
            if hero and alive_status == HERO_CONDITION_ALIVE and contains(elleshar_spec_duel.heroes, hero) then
                for i = 1, elleshar_spec_duel.additional_levels do
                    local new_level = GetHeroLevel(hero) + 1
                    LevelUpHero(hero)
                    while GetHeroLevel(hero) ~= new_level do
                        sleep()
                    end
                end
            end
        end
    end
end)