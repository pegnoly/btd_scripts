quroq_spec_duel = {
    heroes = {"Quroq1", "Quroq2"}
}

NewDayEvent.AddListener("quroq_spec_duel_new_day_listener",
function(day)
    if day == BTD_duel_day_sequence.fight_day then
        for hero, alive_status in AdvMapHeroesInfo.alive_heroes do
            if hero and alive_status == HERO_CONDITION_ALIVE and contains(quroq_spec_duel.heroes, hero) then
                for i = 1, 2 do
                    SetObjectOwner("qura"..i, GetObjectOwner(hero))
                end
            end
        end
    end
end)