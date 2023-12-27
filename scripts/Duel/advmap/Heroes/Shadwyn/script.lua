shadwyn_spec_duel = {
    heroes = {"Shadwyn1", "Shadwyn2"}
}

NewDayEvent.AddListener("shadwyn_spec_duel_new_day_listener",
function(day)
    if day == BTD_duel_day_sequence.fight_day then
        for hero, alive in AdvMapHeroesInfo.alive_heroes do
            if hero and IsHeroAlive(hero) and contains(shadwyn_spec_duel.heroes, hero) then
                for i = 1, 2 do
                    SetObjectOwner("ela"..i, GetObjectOwner(hero))
                end
            end
        end
    end
end)