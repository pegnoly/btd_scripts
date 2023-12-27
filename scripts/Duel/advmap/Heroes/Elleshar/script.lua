elleshar_spec_duel =
{
    heroes = {"Elleshar1", "Elleshar2"},
    additional_levels = 2
}

NewDayEvent.AddListener('NHF_elleshar_new_day_event',
function(day)
    if day == BTD_duel_day_sequence.freeroam_day then
        for hero, alive in AdvMapHeroesInfo.alive_heroes do
            if hero and alive and contains(elleshar_spec_duel.heroes, hero) then
                for i = 0, elleshar_spec_duel.additional_levels do
                    LevelUpHero(hero)
                end
            end
        end
    end
end)